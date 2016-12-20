(function(){
  angular.module('box.list', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

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
      vm.shipments = {};
      vm.user=[];
      vm.regex = "[a-z A-Z 0-9-\_\.]+";
      var original = vm.user;
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getShipment')
          .withPaginationType('full_numbers')
          .withOption('createdRow', createdRow);
      vm.dtColumns = [
          DTColumnBuilder.newColumn('st_code').withTitle('Shipment Code'),
          DTColumnBuilder.newColumn('st_description').withTitle('Shipment Type'),
          DTColumnBuilder.newColumn(null).withTitle('Actions').notSortable()
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

      function edit(shipment) {
        $("#addNew").modal('show');
        $("#btnRefresh").css('display','none');
        document.getElementById("titleID").innerHTML = "Edit";
        vm.user.st_code = shipment.st_code;
        vm.user.st_description = shipment.st_description;
        $("#id_shipment_type").val(shipment.id_shipment_type);    
      }

      function deleteRow(shipment) {
        vm.did = shipment.id_shipment_type;
        $('#showDelete').modal('show');
      }
      function addRow() {
        $.ajax({
               type: "POST",
               url: "/index.cfm/shipment_type/addNew",
               async: false,
               data: {'code' : vm.user.st_code,
                      'description' : vm.user.st_description,
                      'id_shipment_type' : $('#id_shipment_type').val()
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
               url: "/index.cfm/shipment_type/delete",
               async: false,
               data: {'id_shipment_type' : vm.did
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
          vm.shipments[data.id_shipment_type] = data;
          return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.shipments[' + data.id_shipment_type + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.shipments[' + data.id_shipment_type + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
      }

      function refresh () {
          $('#id_Zone').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
      }

  };

})();
