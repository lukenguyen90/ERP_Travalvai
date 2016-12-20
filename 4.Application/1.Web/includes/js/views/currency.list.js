(function(){
  angular.module('currency', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope , $http ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm = this;
      vm.message = '';
      vm.editRow = editRow;
      vm.delete = deleteRow;
      vm.deleteUser = deleteUser;
      vm.addRow     = addRow;
      vm.refresh    = refresh;
      vm.dtInstance = {};
      vm.persons    = {};
      vm.user       = {};
      vm.showAddNew = showAddNew;
      vm.regex      = "[a-z A-Z 0-9-\_\.]+";
      var original = angular.copy(vm.user);
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getcurrency')
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
      vm.dtColumns = [
          DTColumnBuilder.newColumn('curr_code').withTitle('CODE').withOption('width', '10%'),
          DTColumnBuilder.newColumn('curr_description').withTitle('DESCRIPTION'),
          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable().withOption('width', '80px')
              .renderWith(actionsHtml)
      ];

      // vm.$on('event:dataTableLoaded', function(event, loadedDT) {
      //   // Setup - add a text input to each footer cell
      //   var id = '#' + loadedDT.id;
      //   console.log(id);
      //   $(id + ' tfoot th').each(function() {
      //     var title = $(id + ' thead th').eq($(this).index()).text();
      //     $(this).html('<input type="text" placeholder="Search ' + title + '" />');
      //   });

      //   var table = loadedDT.DataTable;
      //   // Apply the search
      //   table.columns().eq(0).each(function(colIdx) {
      //     $('input', table.column(colIdx).footer()).on('keyup change', function() {
      //       table
      //         .column(colIdx)
      //         .search(this.value)
      //         .draw();
      //     });
      //   });
      // });



      function editRow(person) {
        document.getElementById("titleID").innerHTML="Edit";
        $(document).ready(function(){
          $("#addNew").on('shown.bs.modal', function(){
            $(this).find('#code').focus();
          });
        });
        $('#addNew').modal('show');
        $('#btnRefresh').css('display','none');
        //highlight row being edit
        $(".highlight").removeClass("highlight");
        $("#mytable td").filter(function() { return $.text([this]) == person.curr_code; })
          .parent()
          .addClass("highlight");
        vm.user.code = person.curr_code;
        vm.user.description = person.curr_description;
        $('#id_Stt').val(person.id_currency);
      }
      function deleteRow(person) {
        vm.did = person.id_currency;
        $('#showDelete').modal('show');
      }
      function deleteUser(person) {
        $('#showDelete').modal('hide');
        $.ajax({
             type: "POST",
             url: "/index.cfm/currency/delete",
             async: false,
             data: {'id' : vm.did
          },
          success: function( data ) {
              if(data.success)
              {
                  noticeSuccess(data.message);
                  vm.dtInstance.reloadData();
              }else{
                  noticeFailed("Can not delete this currency");
              }
          }
        });
      }
      function showAddNew (argument) {
        // body...
        refresh();
        document.getElementById("titleID").innerHTML="Create";
        $(".highlight").removeClass("highlight");
        $('#btnRefresh').css('display','inline-block');
        $('#addNew').modal('show');
//        vm.user.title_formcurrency = "Create new Currency";
        $(document).ready(function(){
            $("#addNew").on('shown.bs.modal', function(){
            $(this).find('#code').focus();
          });
        });
      }

      var tempCode = "";

      function addRow() {
        var flag = false;

        $.ajax({
                 type: "POST",
                 url: "/index.cfm/basicdata/checkExistCode",
                 async: false,
                 data: {'code' : vm.user.code,
                        'table':'currency',
                        'nameCol':'curr_code',
                        'id':$('#id_Stt').val(),
                        'idfield':'id_currency'
              },
              success: function( data ) {
                  flag = data.isExist;
                  if(flag == false || $('#id_Stt').val()!="0")
                  {
                          $.ajax({
                             type: "POST",
                             url: "/index.cfm/currency/addNew",
                             async: false,
                             data: {'code' : vm.user.code,
                                  'description' : vm.user.description,
                                  'id':$('#id_Stt').val()
                          },
                          success: function( data ) {
                              if(data.success){
                                noticeSuccess(data.message);
                                vm.dtInstance.reloadData();
                                tempCode = data.code_Curr;
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
                  else
                  {
                    noticeFailed("Code is exist in systems!");
                  }
              }
           });
      }



      $('#addNew').on('hidden.bs.modal', function () {
        $(".highlight").removeClass("highlight");
        $("#mytable td").filter(function() { return $.text([this]) == tempCode; })
          .parent()
          .addClass("highlight");
          console.log(tempCode);
      });

      function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
      }
      function actionsHtml(data, type, full, meta) {
          vm.persons[data.id_currency] = data;
          return '<span class="txt-color-green btnedit padding-right-30" title="Edit" ng-click="showCase.editRow(showCase.persons[' + data.id_currency + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.persons[' + data.id_currency + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
      }

      function refresh () {
          $('#id_Stt').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
          $('#code').val('');
          $('#description').val('');
      }

  };

})();
