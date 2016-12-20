(function(){
  angular.module('language', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm         = this;
      vm.message    = '';
      vm.edit       = edit;
      // vm.delete     = deleteRow;
      // vm.deleteUser = deleteUser;
      vm.addRow     = addRow;
      vm.refresh    = refresh;
      // vm.showAddNew = showAddNew;
      vm.dtInstance = {};
      vm.persons    = {};
      vm.user       = {};
      vm.regex      = "[a-z A-Z 0-9-\_\.]+";
      var original  = angular.copy(vm.user);
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getlanguage')
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
          DTColumnBuilder.newColumn('lg_code').withTitle('CODE'),
          DTColumnBuilder.newColumn('lg_name').withTitle('DESCRIPTION'),
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
            //highlight row being edit
          $(".highlight").removeClass("highlight");
          $("#mytable td").filter(function() { return $.text([this]) == person.lg_code; })
            .parent()
            .addClass("highlight");
          vm.user.code=person.lg_code;
          vm.user.description=person.lg_name;
          $('#id_Stt').val(person.id_language);
          document.getElementById("titleID").innerHTML="Edit";

      }
      // function deleteRow(person) {
      //   vm.did = person.id_language;
      //   $('#showDelete').modal('show');
      // }
      // function deleteUser() {
      //   $('#showDelete').modal('hide');
      //   $.ajax({
      //        type: "POST",
      //        url: "/index.cfm/language/delete",
      //        async: false,
      //        data: {'id' : vm.did
      //     },
      //     success: function( data ) {
      //         if(data.success)
      //         {
      //             noticeSuccess(data.message);
      //             vm.dtInstance.reloadData();
      //         }else{
      //             noticeFailed("Can not delete this language");
      //         }
      //     }
      //   });
      // }

//       function showAddNew (argument) {
//           refresh();
//           document.getElementById("titleID").innerHTML="Create";
//           $(".highlight").removeClass("highlight");
//           $('#btnRefresh').css('display','inline-block');
//         // body...
//           $('#addNew').modal('show');
// //          vm.user.title_formlanguage = "Create new Language";
//           $(document).ready(function(){
//             $("#addNew").on('shown.bs.modal', function(){
//             $(this).find('#code').focus();
//           });
//         });
//       }

      function addRow() {
       var flag = false;

      $.ajax({
               type: "POST",
               url: "/index.cfm/basicdata/checkExistCode",
               async: false,
               data: {'code' : vm.user.code,
                  'table':'languages',
                  'nameCol':'lg_code',
                  'id':$('#id_Stt').val(),
                  'idfield':'id_language'
            },
            success: function( data ) {
                flag = data.isExist;
                if(!flag)
                {
                  $.ajax({
                           type: "POST",
                           url: "/index.cfm/language/addNew",
                           async: false,
                           data: {
                            'code' : vm.user.code,
                            'description' : vm.user.description,
                            'id':$('#id_Stt').val()
                        },
                        success: function( data ) {
                            if(data.success){
                              noticeSuccess(data.message);
                              vm.dtInstance.reloadData();
                              tempCode = data.lang_Code;
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
          vm.persons[data.id_language] = data;
          return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.persons[' + data.id_language + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;';
              // '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.persons[' + data.id_language + '])">' +
              // '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              // '</span>';
      }

      function refresh () {
          $('#id_Stt').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
          // console.log($('#code').val(''));
          // console.log($('#description').val(''));
          // $scope.userForm.$pristine = true;
          $('#code').val('');
          $('#description').val('');
      }

  };

})();
