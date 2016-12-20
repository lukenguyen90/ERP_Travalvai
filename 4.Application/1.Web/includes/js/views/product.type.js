(function(){
  angular.module('product_type', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

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
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/product/getproducttype')
          .withPaginationType('full_numbers')
          .withLightColumnFilter({
            '0' : {
                type : 'text'
            },
            '1' : {
                type : 'text'
            },
            '2' : {
                type : 'text'
            }
          })
          .withOption('createdRow', createdRow)
          .withOption('select', { style: 'single' });

        vm.dtColumns = [
            DTColumnBuilder.newColumn('CODE').withTitle('CODE').withClass("text-center  th-text-left"),
            DTColumnBuilder.newColumn('DES').withTitle('DESCRIPTION'),
            DTColumnBuilder.newColumn('CODE_GROUP_PRD_DESCRIPTION').withTitle('GROUP PRODUCT'),
            DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable()
            .renderWith(actionsHtml)
        ];

      $http.get("/index.cfm/product/getproductgroup").success(function(dataResponse){
        vm.groups = dataResponse;
      });

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

      function edit(person) {
          refresh();
          vm.user.code        = person.CODE;
          vm.user.group        = person.GROUPID;
          vm.newDes = angular.fromJson(person.FULL_LANGUAGE);
          $('#addNew').modal('show');
          $('#btnRefresh').css('display','none');
            //highlight row being edit
          $(".highlight").removeClass("highlight");
          $("#mytable td").filter(function() { return $.text([this]) == person.CODE; })
            .parent()
            .addClass("highlight");
          $('#id_Type').val(person.ID);
          document.getElementById("titleID").innerHTML="Edit";
      }

      function deleteRow(person) {
        vm.did = person.ID;
        $('#showDelete').modal('show');
      }

      function deleteUser() {
        $('#showDelete').modal('hide');
        $.ajax({
             type: "POST",
             url: "/index.cfm/product/deleteProductType",
             async: false,
             data: {
              'gid' : vm.did
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
        $('#addNew').modal('show');
        $(document).ready(function(){
          $("#addNew").on('shown.bs.modal', function(){
          $(this).find('#code').focus();
        });
        });
      }

      $("#code").keyup(function(){
        $(".noti_code").remove();
      });

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
               url: "/index.cfm/product/checkExistCodePT",
               async: false,
               data: {
                'code' : vm.user.code,
                'id' : $("#id_Type").val()
              },
                success: function( data ) {
                  flag = data.success;
                  if(!flag){
                      $.ajax({
                           type: "POST",
                           url: "/index.cfm/product/addNewType",
                           async: false,
                           data: {
                                'group'       : vm.user.group,
                                'code'        : vm.user.code,
                                'des'         : JSON.stringify(vm.newDes),
                                'id_Type'     : $('#id_Type').val()
                        },
                        success: function( idata ) {
                          if(idata.success){
                            noticeSuccess(idata.message);
                            vm.dtInstance.reloadData();
                            tempCode = idata.typecode;
                            $('#addNew').modal('hide');
                          }
                          else
                          {
                            noticeFailed(idata.message);
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
        $compile(angular.element(row).contents())($scope);
      }

      function actionsHtml(data, type, full, meta) {
          vm.persons[data.ID] = data;
          return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.persons[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.persons[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
      }

      function refreshNewDes(){
        for(var i in vm.newDes){
          vm.newDes[i].description="";// = "";
        }
      }

      function refresh () {
          $('#id_Type').val(0);
          $(".noti_code").remove();
          refreshNewDes();
          $("#addNew").modal("hide");
          vm.user = angular.copy(original);
          $scope.userForm.$setPristine();
          $('#description').val('');
          $('#checkboxdes').prop('checked', true);
      }

  };

})();
