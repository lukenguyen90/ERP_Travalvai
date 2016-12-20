(function(){
  angular.module('typeCustomer', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http, $filter,$compile, DTOptionsBuilder, DTColumnBuilder)
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
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/basicdata/gettype_customer')
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
          DTColumnBuilder.newColumn('id_type_Customer').withTitle('ID').withClass('text-center'),
          DTColumnBuilder.newColumn('tc_code').withTitle('CODE'),
          DTColumnBuilder.newColumn('tc_description').withTitle('DESCRIPTION'),
          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable()
              .renderWith(actionsHtml)
      ];


      var tempCode = "";

      $('#addNew').on('hidden.bs.modal', function () {
          $(".highlight").removeClass("highlight");
           $("#mytable td").filter(function() { return $.text([this]) == tempCode; })
                .parent()
                .addClass("highlight");
        });
      function edit(person) {
          $('#addNew').modal('show');
          $('#btnRefresh').css('display','none');
          //highlight row
          $(".highlight").removeClass("highlight");
          $("#mytable td").filter(function() { return $.text([this]) == person.tc_code; })
            .parent()
            .addClass("highlight");
          vm.user.code=person.tc_code;
          vm.user.description=person.tc_description;
          $('#id_Stt').val(person.id_type_Customer);
          document.getElementById("titleID").innerHTML="Edit";
      }

      function showAddNew (argument) {
        // body...
          refresh();
          document.getElementById("titleID").innerHTML="Create";
          $(".highlight").removeClass("highlight");
          $('#btnRefresh').css('display','inline-block');
          $('#addNew').modal('show');
//          vm.user.title_formtypeOfCust = "Create new Type of Customer";
          $(document).ready(function(){
            $("#addNew").on('shown.bs.modal', function(){
            $(this).find('#code').focus();
            });
          });
        }

    function deleteRow(person) {
          vm.did = person.id_type_Customer;
          // console.log(vm.did);
          $('#showDelete').modal('show');
      }

      function deleteUser(person) {
        $('#showDelete').modal('hide');
          $.ajax({
               type: "POST",
               url: "/index.cfm/customer/deleteTcustomer",
               async: false,
               data: {'id' : vm.did
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
          
          // Delete some data and call server to make changes...
          // Then reload the data so that DT is refreshed
      }

      function addRow() {
        $.ajax({
                 type: "POST",
                 url: "/index.cfm/customer/addNewTcustomer",
                 async: false,
                 data: {'code' : vm.user.code,
                        'description' : vm.user.description,
                        'id':$('#id_Stt').val()
              },
               success: function( data ) {
                if(data.success){
                  noticeSuccess(data.message);
                  vm.dtInstance.reloadData();
                  tempCode = data.typeCustCode;
                  setTimeout(function() {
                      $('#addNew').modal('hide');
                    }, 1000);
                } 
                else
                {
                  noticeFailed("Please try again!");
                }

                refresh();
              }
           });
      }

       function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
       }
      function actionsHtml(data, type, full, meta) {
          vm.persons[data.id_type_Customer] = data;
          return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.persons[' + data.id_type_Customer + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.persons[' + data.id_type_Customer + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
      }

      function refresh () {
          $('#id_Stt').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
          $("#code").val('');
      }

  };

})();
