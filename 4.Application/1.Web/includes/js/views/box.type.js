(function(){
  angular.module('box.type', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm = this;
      vm.message = '';
      vm.edit = edit;
      vm.delete = deleteRow;
      vm.deleteUser = deleteUser;
      vm.addRow = addRow;
      vm.showAddNew   = showAddNew;
      vm.refresh = refresh;
      vm.dtInstance = {};
      vm.boxs = {};
      vm.user=[];
      vm.regex = "[a-z A-Z 0-9-\_\.]+";
      vm.regexNumber = /^[0-9]+([\.][0-9]+)?$/;
      var original = vm.user;
      vm.userInfo     = {};

      $.ajax({
        async: false,
        type: 'GET',
        url: '/index.cfm/basicdata/getUserLevel',
        success: function(data) {
          vm.userInfo = data;
          if( vm.userInfo.TYPEUSER == 1 ){
            $('#btnAddNew').show();
          }
        }
      });

      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/basicdata/gettype_of_box')
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
            },
            '3' : {
                   type : 'text'
            }
          })
          .withOption('createdRow', createdRow);
      vm.dtColumns = [
          DTColumnBuilder.newColumn('tb_description').withTitle('CODE'),
          DTColumnBuilder.newColumn('tb_depth').withTitle('DEPTH').withClass('text-right'),
          DTColumnBuilder.newColumn('tb_length').withTitle('LENGTH').withClass('text-right'),
          DTColumnBuilder.newColumn('tb_width').withTitle('WIDTH').withClass('text-right'),
          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable()
              .renderWith(actionsHtml)
      ];

      $http.get("/index.cfm/basicdata/getlanguage").success(function(dataResponse){
        vm.languages = dataResponse;
      });

      $http.get("/index.cfm/basicdata/getcurrency").success(function(dataResponse){
        vm.currencys = dataResponse;
      });

      $http.get("/index.cfm/contact/getcontacts").success(function(dataResponse){
        vm.contacts = dataResponse;
      });

      function showAddNew(){
        refresh();
        document.getElementById("titleID").innerHTML="Create";
        $('#btnRefresh').css('display','inline-block');
        $('#addNew').modal('show');
      }

      function edit(box) {
        $("#addNew").modal('show');
        $("#btnRefresh").css('display','none');
        document.getElementById("titleID").innerHTML = "Edit";
        var arr_description = box.tb_description.split(' (');
        vm.user.tb_description = arr_description[0];
        vm.user.tb_depth  = box.tb_depth;
        vm.user.tb_length = box.tb_length;
        vm.user.tb_width  = box.tb_width;
        $("#id_type_box").val(box.id_type_box);    
      }

      function deleteRow(box) {
        vm.did = box.id_type_box;
        $('#showDelete').modal('show');
      }

      function addRow() {
        $.ajax({
               type: "POST",
               url: "/index.cfm/type_of_box/addNew",
               async: false,
               data: {'description' : vm.user.tb_description,
                      'depth' : vm.user.tb_depth,
                      'length': vm.user.tb_length,
                      'width' : vm.user.tb_width, 
                      'id_type_box' : $('#id_type_box').val()
                },
                success: function( data ) {
                  if(data.success){
                    noticeSuccess(data.message);
                    vm.dtInstance.reloadData();
                    setTimeout(function() {
                      $('#addNew').modal('hide');
                    }, 1000);
                  }
                  else
                  {
                    noticeFailed("Please try again!");
                  }
                }
         });
      }

      function deleteUser(){
        $("#showDelete").modal('hide');
        $.ajax({
               type: "POST",
               url: "/index.cfm/type_of_box/delete",
               async: false,
               data: {'id_type_box' : vm.did
              },
              success: function( data ) {
                if(data.success)
                {
                    noticeSuccess(data.message);
                    vm.dtInstance.reloadData();
                }else{
                    noticeFailed("Can not delete this type");
                }
            }
         });
      }

       function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
       }
      function actionsHtml(data, type, full, meta) {
          vm.boxs[data.id_type_box] = data;
          return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.boxs[' + data.id_type_box + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.boxs[' + data.id_type_box + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
      }

      function refresh () {
          $('#id_type_box').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
      }

  };

})();
