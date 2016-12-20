(function(){
  angular.module('agent.price', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope, $http ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm        = this;
     vm.dtInstance = {};
     vm.dtOptions  = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getAccessPage')
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
     vm.dtColumns  = [
          DTColumnBuilder.newColumn('id').withTitle('ID'),
          DTColumnBuilder.newColumn('name').withTitle('NAME'),
          DTColumnBuilder.newColumn('idPage').withTitle('PAGE ID'),
      ];

    function createdRow(row, data, dataIndex) {
      $compile(angular.element(row).contents())($scope);
     }
  };

})();
