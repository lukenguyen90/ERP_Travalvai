(function(){
  angular.module('product_group.List', ['datatables', 'datatables.light-columnfilter']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm         = this;
      vm.message    = '';
      vm.edit       = edit;
      vm.delete     = deleteRow;
      vm.deleteUser = deleteUser;
      vm.addRow     = addRow;
      vm.refresh    = refresh;
      vm.showAddNew = showAddNew;
      vm.dtInstance = {};
      vm.persons    = {};
      vm.user       = {};
      vm.regex      = "[a-z A-Z 0-9-\_\.]+";
      var original  = angular.copy(vm.user);

      vm.dtColumns = [
            DTColumnBuilder.newColumn('CODE').withTitle('CODE').withClass("text-center  th-text-left"),
            DTColumnBuilder.newColumn('DES').withTitle('DESCRIPTION'),
            DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable().renderWith(actionsHtml)
      ];

      $.ajax({
          async: false,
          type: 'GET',
          url: '/index.cfm/basicdata/getUserLevel',
          success: function(data) {
               //callback
                 vm.userInfo = data;
                 if( vm.userInfo.TYPEUSER != 1){
                  $("#btnCreate").hide();
                }else if(vm.userInfo.TYPEUSER == 4){
                  $("#btnCreate").hide();
                  vm.dtColumns.splice(2,1);
                }else{
                  $("#btnCreate").show();
                }
            }
      });

      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/product/getproductgroup')
          .withPaginationType('full_numbers')
          .withLightColumnFilter({
            '0' : {
                type : 'text'
            },
            '1' : {
                type : 'text'
            }
          })
          .withOption('createdRow', createdRow)
          .withOption('select', { style: 'single' });

      var tempCode = "";
      $('#addNew').on('hidden.bs.modal', function () {
          $(".highlight").removeClass("highlight");
      });

      $.ajax({
        async: false,
        type: 'POST',
        url: '/index.cfm/basicdata/getStructlanguage',
        success: function(data) {
             //callback
               vm.newDes = data;
          }
      });

      function edit(person){
        refresh();
        $('#addNew').modal('show');
        $('#btnRefresh').css('display','none');
          //highlight row being edit
        $(".highlight").removeClass("highlight");
        $("#mytable td").filter(function() { return $.text([this]) == person.CODE; })
          .parent()
          .addClass("highlight");
        document.getElementById("titleID").innerHTML="Edit";

        vm.user.code        = person.CODE;
        vm.newDes = angular.fromJson(person.FULL_LANGUAGE);

        $('#id_Group').val(person.ID);
      }

      function deleteRow(person) {
        vm.did = person.ID;
        $('#showDelete').modal('show');
      }

      function deleteUser() {
        $('#showDelete').modal('hide');
        $.ajax({
             type: "POST",
             url: "/index.cfm/product/deleteProductGroup",
             async: false,
             data: {'gid' : vm.did
          },
          success: function( data ) {
              if(data.success)
              {
                noticeSuccess(data.message);
                vm.dtInstance.reloadData();
              }else{
                noticeFailed(data.message);
                vm.dtInstance.reloadData();
              }
          }
        });
      }

      function showAddNew (argument) {
          refresh();
          document.getElementById("titleID").innerHTML="Create";
          $(".highlight").removeClass("highlight");
          $('#btnRefresh').css('display','inline-block');
        // body...
          $('#addNew').modal('show');
          vm.user.title_formlanguage = "Create new Language";
          $(document).ready(function(){
            $("#addNew").on('shown.bs.modal', function(){
            $(this).find('#code').focus();
          });
        });
      }

      function addRow() {
       var flag = false;
       //set description is english
       if ($('#checkboxdes').is(":checked")){
          var desDefaut = "";
          for(var item in vm.newDes){
            if(vm.newDes[item].lg_code == "ENG"){
              desDefaut = vm.newDes[item].description;
            }else{
              if(vm.newDes[item].description == ''){
                vm.newDes[item].description = desDefaut;
              }           
            }
          }
        }
      //end set description english
      $.ajax({
             type: "POST",
             url: "/index.cfm/product/checkExistCodeGP",
             async: false,
             data: {
                'code' : vm.user.code,
                'id' : $("#id_Group").val()
            },
            success: function( data ) {
                flag = data.success;
                if(!flag){
                  $.ajax({
                       type: "POST",
                       url: "/index.cfm/product/addNewGroup",
                       async: false,
                       data: {
                            'code'        : (vm.user.code == null) ? "" : vm.user.code,
                            'des'         : JSON.stringify(vm.newDes),
                            'id_Group'    : $('#id_Group').val()
                    },
                    success: function( idata ) {
                      if(idata.success){
                        noticeSuccess(idata.message);
                        vm.dtInstance.reloadData();
                      }
                      else
                      {
                        noticeFailed("Please try again!");
                      }
                      refresh();
                    }
                });
              }
              else
              {
                $scope.userForm.code.$invalid=true;
                $scope.userForm.$invalid=true;
                 $(".noti_code").remove();
                $("#code").after('<p class="help-block noti_code">Code is exist in systems!</p>');
              }
            }
          });
        }

       function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
      }

      function actionsHtml(data, type, full, meta) {
        if( vm.userInfo.TYPEUSER == 4){
          return "";
        }else{
          vm.persons[data.ID] = data;
          return '<span class="txt-color-green btnedit padding-right-30" title="Edit" ng-click="showCase.edit(showCase.persons[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;'+
                '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.persons[' + data.ID + '])">' +
                '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
                '</span>';
          };
      }

      function refreshNewDes(){
        for(var i in vm.newDes){
          vm.newDes[i].description="";// = "";
        }
      }

      $("#code").keyup(function(){
        $(".noti_code").remove();
      });

      function refresh () {
          $('#id_Group').val(0);
          $(".noti_code").remove();
          refreshNewDes();
          $("#addNew").modal("hide");
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
          $('#description').val('');
          $('#checkboxdes').prop('checked', true);
      }

  };

})();
