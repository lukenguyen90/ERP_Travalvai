(function(){
  angular.module('product.List', ['datatables', 'datatables.light-columnfilter']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm = this;
      vm.message = '';
      vm.edit = edit;
      vm.delete = deleteRow;
      vm.deleteUser = deleteUser;
      vm.addRow = addRow;
      vm.refresh = refresh;
      vm.dtInstance = {};
      vm.persons = {};
      vm.user=[];
      vm.regex = "[a-z A-Z 0-9-\_\.]+";
      var original = vm.user;
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getproductstatus')
          .withLightColumnFilter({
              '0' : {
                  type : 'text'
              }
            })
          .withPaginationType('full_numbers')
          .withOption('createdRow', createdRow)
          .withOption('select', { style: 'single' });

      vm.dtColumns = [
          // DTColumnBuilder.newColumn('ID').withTitle('No.'),
          DTColumnBuilder.newColumn('DES').withTitle('PRODUCT LINE'),
          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable()
              .renderWith(actionsHtml)
      ];

      // $http.get("/index.cfm/basicdata/getlanguage").success(function(dataResponse){
      //   vm.languages = dataResponse;
      // });

      // $http.get("/index.cfm/basicdata/getcurrency").success(function(dataResponse){
      //   vm.currencys = dataResponse;
      // });

      function edit(person) {
          vm.user.description=person.DES;
          vm.user.id_pr_status = person.ID;

          $('#id_Status').val(person.ID);
      }

      function deleteRow(person) {
        vm.did = person.ID;
        $('#showDelete').modal('show');
      }

      function deleteUser() {
        $('#showDelete').modal('hide');
        $.ajax({
                 type: "POST",
                 url: "/index.cfm/product/deleteProductStatus",
                 async: false,
                 data: {'sId' : vm.did
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

      function addRow() {
        $scope.userForm.$invalid=true;
        $.ajax({
                 type: "POST",
                 url: "/index.cfm/basicdata/checkExistCode",
                 async: false,
                 data: {
                        'code' : vm.user.description,
                        'table':'product_status',
                        'nameCol':'pr_stat_desc',
                        'id':$('#id_Status').val(),
                        'idfield':'id_pj_Status'
              },
              success: function( data ) {
                  flag = data.isExist;
                  if(!flag)
                  {
                    $.ajax({
                             type: "POST",
                             url: "/index.cfm/product/addNewStatus",
                             async: false,
                             data: {
                                  'description' : vm.user.description,
                                  'id_Status':$('#id_Status').val()
                          },
                          success: function( data ) {
                            if(data.success){
                              noticeSuccess(data.message);
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
                    noticeFailed("Code is exist in systems!");
                  }
              }
           });
      }

       function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
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

      function refresh () {
          $('#id_Status').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
      }

  };

})();
