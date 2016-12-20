(function(){
  angular.module('contract.List', ['datatables','datatables.light-columnfilter', "ui.select2"]).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http , $filter, $compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm             = this;
     vm.deleteContract  = deleteContract;
     vm.delete          = deleteRow;
     vm.addEditContract = addEditContract;
     vm.showAddNew      = showAddNew;
     vm.editContract    = editContract;
     vm.refresh         = refresh;
     vm.firstload       = false;
     vm.dtInstance      = {};
     vm.contracts       = [];
     vm.regex           = "[a-z A-Z 0-9-\_\.]+";
     vm.regexNumber     = /^[0-9]+([\.][0-9]+)?$/;
     vm.user            = [];
     var original       = angular.copy(vm.user);

     vm.dtOptions  = DTOptionsBuilder.fromSource('/index.cfm/contract/getContracts')
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
            },
            '4' : {
                type : 'text'
            },
            '5' : {
                type : 'text'
            },
            '6' : {
                type : 'text'
            }
          })
          .withOption('createdRow', createdRow)
          .withOption('select', { style: 'single' });
     vm.dtColumns  = [
          DTColumnBuilder.newColumn('id_Contract').withTitle('CODE').withOption('width', '10%').withClass('text-center'),
          DTColumnBuilder.newColumn('description').withTitle('DESCRIPTION').withOption('width','10%'),
          DTColumnBuilder.newColumn(null).withTitle('CUSTOMER').withOption('width','12%').renderWith(renderCustomer),
          DTColumnBuilder.newColumn(null).withTitle('AGENT').withOption('width','12%').renderWith(renderAgent),
          DTColumnBuilder.newColumn(null).withTitle('ZONE').withOption('width','12%').renderWith(renderZone),
          DTColumnBuilder.newColumn('startDate').withTitle('START DATE').withOption('width','12%').withClass('text-right'),
          DTColumnBuilder.newColumn('noofyear').withTitle('NO OF YEARS').withClass('text-right'),
          DTColumnBuilder.newColumn('increaseYear').withTitle('INCREASE EACH YEAR').withClass('text-right'),
          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').withOption('width','9%').notSortable()
              .renderWith(actionsHtml)
      ];

      $.ajax({
        async: false,
        type: 'GET',
        url: '/index.cfm/basicdata/getUserLevel',
        success: function(data) {
          vm.userInfo = data;
          if(vm.userInfo.TYPEUSER == 1){
            $http.get("/index.cfm/basicdata/getzone").success(function(dataResponse){
              vm.zones = dataResponse;
            });
          }
          else if( vm.userInfo.TYPEUSER == 2 ){
            $("#zone").closest(".form-group").addClass("display-none");
            $http.get("/index.cfm/basicdata/getagent").success(function(dataResponse){
              vm.agents = dataResponse;
            });
          }
          else if(vm.userInfo.TYPEUSER == 3){
            $("#zone").closest(".form-group").addClass("display-none");
            $("#agent").closest(".form-group").addClass("display-none");
            $http.get("/index.cfm/basicdata/getcustomer").success(function(dataResponse){
              vm.customers = dataResponse;
            });
          }
        }
      });

      $("#zone").change(function(){
        if($(this).val()){
          $.ajax({
            async: false,
            type: 'POST',
            data: {
              "idzone": $(this).val()
            },
            url: '/index.cfm/basicdata/getagent',
            success: function(data) {
              vm.agents = data
            }
          });
          vm.customers = [];
        }
      });

      $("#agent").change(function(){
        if($(this).val()){
          $.ajax({
            async: false,
            type: 'POST',
            data: {
              "idagent": $(this).val()
            },
            url: '/index.cfm/basicdata/getCustomer',
            success: function(data) {
              vm.customers = data
            }
          });
        }
      });

      $('#addNewContract').on('show.bs.modal', function () {
          // $http.get("/index.cfm/basicdata/getzone").success(function(dataResponse){
          //   vm.zones = dataResponse;
          // });
      });

      $('#addNewContract').on('hide.bs.modal', function () {
        refresh();
      });

      function showAddNew(){
        $("#addNewContract").modal('show');
      }

      function addEditContract(){
        $scope.userForm.$invalid=true;
        $.ajax({
                 type: "POST",
                 url: "/index.cfm/contract/addEditContract",
                 async: false,
                 data: {
                      'startDate'    : vm.user.startDate,
                      'noofyear'     : vm.user.noofyear,
                      'increaseYear' : vm.user.increaseYear,
                      'customer'     : vm.user.customer,
                      'agent'        : vm.user.agent,
                      'zone'         : vm.user.zone,
                      'description'  : vm.user.description,
                      'id_Contract': $('#id_Contract').val()
              },
              success: function( data ) {
                if(data.success)
                {
                  noticeSuccess(data.message);
                  vm.dtInstance.reloadData();
                  setTimeout(function() {
                    $('#addNewContract').modal('hide');
                  }, 1000);
                 }
                 else
                 {
                     noticeFailed(data.message);
                 }
                // $('#addNewContract').modal('hide');
                // refresh();
              }
           });
      }

      function editContract(item){
        $.ajax({
          async: false,
          type: 'POST',
          data: {
            "idzone": item.id_Zone
          },
          url: '/index.cfm/basicdata/getagent',
          success: function(data) {
             window.setTimeout(function() {
              vm.agents = data;
              $scope.$applyAsync();
            }, 200);
          }
        });

        $.ajax({
          async: false,
          type: 'POST',
          data: {
            "idagent": item.id_Agent
          },
          url: '/index.cfm/basicdata/getCustomer',
          success: function(data) {
            window.setTimeout(function() {
              vm.customers = data;
              $scope.$applyAsync();
            }, 200);
          }
        });
        vm.user.description  = item.description;
        vm.user.startDate    = item.startDate;
        vm.user.noofyear     = item.noofyear;
        vm.user.increaseYear = item.increaseYear;
        vm.user.customer     = item.id_Customer;
        vm.user.agent        = item.id_Agent;
        vm.user.zone         = item.id_Zone;
        $("#id_Contract").val(item.id_Contract)
        $('#btnRefresh').css('display','none');
        $("#addNewContract").modal('show');
        $scope.userForm.$invalid=true;
      }

      function deleteRow(ct){
        $('#showDelete').modal('show');
        vm.did=ct.id_Contract;  
      }

      function deleteContract(){
        $('#showDelete').modal('hide');
        $.ajax({
              type: "POST",
              url: "/index.cfm/contract/delete",
              async: false,
              data: {'id_Contract' : vm.did},
              success: function( data ) {
                if(data.success)
                {
                    $('#showDelete').modal('hide');
                    noticeSuccess(data.message);
                    vm.dtInstance.reloadData();
                }else{
                    noticeFailed(data.message);
                }
              }
        });
      }

      function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
      }

      function actionsHtml(data, type, full, meta){
        vm.contracts[data.id_Contract] = data;
        return  '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.editContract(showCase.contracts[' + data.id_Contract + '])">' +
                '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
                '</span>&nbsp;' +
                '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.contracts[' + data.id_Contract + '])">' +
                '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
                '</span>';
      }
      function renderCustomer(data, type, full, meta){
        return data.id_Customer + ' - ' + data.cs_name;
      }
      function renderZone(data, type, full, meta){
        return data.z_code + ' - ' + data.zone_des;
      }
      function renderAgent(data, type, full, meta){
        return data.ag_Code + ' - ' + data.agent_des;
      }

      function refresh(){
        $('#id_Contract').val(0);
        if(vm.userInfo.TYPEUSER == 1){
          vm.agents = [];
          vm.customers = [];
        }
        if(vm.userInfo.TYPEUSER == 2){
          vm.customers = [];    
        }
        // vm.agents = [];
        // vm.customers = [];
        vm.user = angular.copy(original);
        $scope.userForm.$setPristine();
      }

      //--------------------------------End Cpntract---------------------------------------
  };

})();
