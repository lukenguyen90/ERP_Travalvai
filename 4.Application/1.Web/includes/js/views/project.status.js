(function(){
  angular.module('project.status', ['datatables', 'datatables.light-columnfilter']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm = this;
      vm.message = '';
      vm.edit = edit;
      vm.delete = deleteRow;
      vm.addRow = addRow;
      vm.refresh = refresh;
      vm.dtInstance = {};
      vm.persons = {};
      vm.user=[];
      vm.regex = "[a-z A-Z 0-9-\_\.]+";
      var original = angular.copy(vm.user);
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/project/getstatus')
          .withPaginationType('full_numbers')
          .withLightColumnFilter( {
            '0': {
              type:'text'
            },
            '1': {
              type:'text'
            }
          })
          .withOption('createdRow', createdRow);
      vm.dtColumns = [
          DTColumnBuilder.newColumn('pj_stat_desc').withTitle('PROJECT STATUS'),
          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable()
              .renderWith(actionsHtml)
      ];

      function edit(person) {
        //highlight row being edit
          $(".highlight").removeClass("highlight");
          $("#myTable td").filter(function() { return $.text([this]) == person.pj_stat_desc; })
            .parent()
            .addClass("highlight");

          vm.user.projectStatus = person.pj_stat_desc;
          $('#id_Stt').val(person.id_pj_Status);
      }

      function deleteRow(person) {
        $('#addNew').modal('show');
        $('#butsubmit').click(function(){
            $.ajax({
                 type: "POST",
                 url: "/index.cfm/project/delProjectStt",
                 async: false,
                 data: {'sttId' : person.id_pj_Status
              },
              success: function( data ) {
                  if(data.success)
                  {
                      $('#addNew').modal('hide');
                      noticeSuccess(data.message);
                      vm.dtInstance.reloadData();
                  }else{
                      noticeFailed("Can not delete this type");
                  }
              }
           });
        });
      }

      function addRow(){
        var flag = false;
        $.ajax({
                 type: "POST",
                 url: "/index.cfm/basicdata/checkExistCode",
                 async: false,
                 data: {'code' : vm.user.projectStatus,
                        'table':'project_status',
                        'nameCol':'pj_stat_desc',
                        'id':$('#id_Stt').val(),
                        'idfield':'id_pj_Status'
              },
              success: function( data ) {
                  flag = data.success;
                  if(!flag)
                  {
                    $.ajax({
                             type: "POST",
                             url: "/index.cfm/project/actionStatus",
                             async: false,
                             data: {
                              'stt' : vm.user.projectStatus,
                              'sttId': $('#id_Stt').val()
                          },
                          success: function( data ) {
                            if(data.success){
                              noticeSuccess(data.message);
                              vm.dtInstance.reloadData();
                            }else
                            {
                               noticeFailed("Please try again!");
                            }
                            $(".highlight").removeClass("highlight");
                            refresh();
                          }
                       });
                  }
                  else
                  {
                    noticeFailed("Name is exist in systems!");
                  }
              }
           });
      }

      function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
      }

      function actionsHtml(data, type, full, meta) {
          vm.persons[data.id_pj_Status] = data;
          return  '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.persons[' + data.id_pj_Status + '])">' +
                  '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
                  '</span>&nbsp;' +
                  '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.persons[' + data.id_pj_Status + '])">' +
                  '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
                  '</span>';
      }

      function refresh () {
          $('#id_Stt').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
      }

  };

})();
