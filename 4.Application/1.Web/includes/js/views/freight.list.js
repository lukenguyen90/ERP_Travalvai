(function(){
  angular.module('freight.list', ['datatables','datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope, $http, $filter, $compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm         = this;
      vm.message    = '';
      vm.edit       = editrow;
      vm.delete     = deleteRow;
      vm.deleteUser = deleteUser;
      vm.addRow     = addRow;
      vm.showAddNew = showAddNew;
      vm.refresh    = refresh;
      vm.dtInstance = {};
      vm.freights   = {};
      vm.user       =[];
      vm.regex      = "[a-z A-Z 0-9-\_\.]+";
      var original  = angular.copy(vm.user);
      vm.userInfo   = {};

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

      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getFreight')
          .withPaginationType('full_numbers')
          .withLightColumnFilter({
            '0' : {
                type : 'text'
            }
          })
          .withOption('createdRow', createdRow)
          .withOption('select', { style: 'single' });
      vm.dtColumns = [
          DTColumnBuilder.newColumn('fr_description').withTitle('FREIGHT'),
          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable()
              .renderWith(actionsHtml)
      ];


      $http.get("/index.cfm/basicdata/getFreight").success(function(dataResponse){
          vm.freights = dataResponse;
      });

      function showAddNew(){
        refresh();
        document.getElementById("titleID").innerHTML="Create";
        $('#btnRefresh').css('display','inline-block');
        $('#addNew').modal('show');
      }

      function editrow(fdata) {
        $("#addNew").modal('show');
        $("#btnRefresh").css('display','none');
        document.getElementById("titleID").innerHTML="Edit";
        vm.user.fr_description= fdata.fr_description;
        $('#id_freight').val(fdata.id_freight);
      }

      function deleteRow(freight) {
          vm.did = freight.id_freight;
          $('#showDelete').modal('show');
      }

      function deleteUser(m) {
        $('#showDelete').modal('hide');
        $.ajax({
               type: "POST",
               url: "/index.cfm/freight/delete",
               async: false,
               data: {'id_freight' : vm.did
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
        $.ajax({
               type: "POST",
               url: "/index.cfm/freight/addNew",
               async: false,
               data: {
                'description' : vm.user.fr_description,
                'id_freight' : $('#id_freight').val()
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

              refresh();
            }
         });
      }

       function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
       }
      function actionsHtml(data, type, full, meta) {
          vm.freights[data.id_freight] = data;
          return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.freights[' + data.id_freight + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.freights[' + data.id_freight + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
      }

      function refresh () {
          $('#id_freight').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
      }

  };

})();
