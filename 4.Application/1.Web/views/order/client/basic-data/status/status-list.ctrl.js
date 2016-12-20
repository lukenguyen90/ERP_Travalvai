(function() {
    'use strict'
    angular
        .module('order.ctrls')
        .controller("StatusListCtrl", statusListCtrl);

    function statusListCtrl($state, $q,
        $scope, $filter, $http,
        $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout,
        $controller, $resource, statusService) {


        var vm = this;
        vm.instance = {};
        vm.options = {};
        vm.columns = [];

        $scope.userId = 0;
        $scope.userTypeId = "";

        vm.init = init;
        vm.initStatus = initStatus;
        vm.status = null;

        function init(userType, userTypeId) {
            if (userType.length === 0) {
                window.location.href = window.location.href;
            } else {
                initVariable(userType, userTypeId);
                showStatusList();
            }
        }

        function initVariable(userType, userTypeId) {
            $scope.userTypeId = userTypeId;
            $scope.userType = userType;
            vm.tplStatusList = "";
        }

        function initStatus() {
            loadDatatable();

        }

          function loadDatatable() {

            vm.options = DTOptionsBuilder.fromFnPromise(function() {

                    return statusService.getListStatus();

                    //return orderListService.getListOrders();
                    // return $resource('../../../../views/order/client/order-list/data.json').query().$promise;
                })
                .withPaginationType('full_numbers')
                .withLightColumnFilter({
                    '0': {
                        type: 'text'
                    },
                    '1': {
                        type: 'text'
                    }
                })
                .withOption('createdRow', createdRow)
                .withOption('stateSave', true)
                .withOption('select', { style: 'single' })

            vm.columns = [

                DTColumnBuilder.newColumn('id_order_status').withTitle('ID').withClass("text-center"), //0
                DTColumnBuilder.newColumn('os_description').withTitle('DESCRIPTION'), //1
                DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable().renderWith(actionsHtml) //2
            ];

        }

        function createdRow(row, data, dataIndex) {
            $compile(angular.element(row).contents())($scope);
        }

        function showAddOrderPopup(userType) {
            vm.tplAddOrder = getTemplate(templates.addOrder, userType);
            $('#modalAddOrder').modal('show');
        }

        function showAddProductPopup(userType) {
            vm.tplAddProduct = getTemplate(templates.addProduct, userType);
            $('#modalAddOrder').modal('hide');
            $('#modalAddProduct').modal('show');
        }


        /**
         * generate template according to user type
         * 
         * @param {any} userType: 'factory', 'zone', 'agent', 'customer'
         */
        function showStatusList() {
            // var template = getTemplate(templates.line, userType);
            vm.tplStatusList = "../../views/order/client/basic-data/status/views/status-list.view.html";
        }

        function showOrderListResume(userType) {
            var template = getTemplate(templates.resume, userType);
            vm.tplOrderList = template;
        }

        function getTemplate(url, userType) {
            var version = "?v=" + Math.random() + "&userId=" + 1;
            return url.format(userType) + version;
        }

        function actionsHtml(data, type, full, meta) {
          // vm.shipments[data.id_shipment_type] = data;
          return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.shipments[' + data.id_shipment_type + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.shipments[' + data.id_shipment_type + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
        }

    };

})();