(function() {
    'use strict'
    angular
        .module('order.ctrls')
        .controller("PaymentListCtrl", paymentListCtrl);

    function paymentListCtrl($state, $q,
        $scope, $filter, $http,
        $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout,
        $controller, $resource, paymentService) {


        var vm = this;
        vm.instance = {};
        vm.options = {};
        vm.columns = [];

        $scope.userId = 0;
        $scope.userTypeId = "";

        vm.init = init;
        vm.initPayment = initPayment;
        vm.showAddPaymentPopup = showAddPaymentPopup;

        function init(userType, userTypeId) {
            console.log($scope);
            if (userType.length === 0) {
                window.location.href = window.location.href;
            } else {
                initVariable(userType, userTypeId);
                showPaymentList();
            }
        }

        function initVariable(userType, userTypeId) {
            $scope.userTypeId = userTypeId;
            $scope.userType = userType;
            vm.tplPaymentList = "";
        }

        function initPayment() {
            loadDatatable();

        }

          function loadDatatable() {

            vm.options = DTOptionsBuilder.fromFnPromise(function() {

                    return paymentService.getListPayments();

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
                    },
                    '2': {
                        type: 'text'
                    },
                    '3': {
                        type: 'text'
                    },
                    '4': {
                        type: 'text'
                    },
                    '5': {
                        type: 'text'
                    },
                    '6': {
                        type: 'text'
                    },
                    '7': {
                        type: 'text'
                    }
                })
                .withOption('createdRow', createdRow)
                .withOption('stateSave', true)
                .withOption('select', { style: 'single' })

            vm.columns = [
                // DTColumnBuilder.newColumn('id_payment').withTitle('ID').withClass("text-center"), //0
                DTColumnBuilder.newColumn('pay_code').withTitle('PAYMENT CODE'), //1
                DTColumnBuilder.newColumn('pay_description').withTitle('DESCRIPTION (ML)'),
                DTColumnBuilder.newColumn('pay_dp').withTitle('DOWNPAYMENT'),
                DTColumnBuilder.newColumn('pay_delivery').withTitle('ON DELIVERY'),
                DTColumnBuilder.newColumn('pay_30_days').withTitle('30 DAYS'),
                DTColumnBuilder.newColumn('pay_60_days').withTitle('60 DAYS'),
                DTColumnBuilder.newColumn('pay_other').withTitle('OTHER'),
                DTColumnBuilder.newColumn('pay_day').withTitle('PAYMENT DAY'),
                DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable().renderWith(actionsHtml) //2
            ];

        }

        function createdRow(row, data, dataIndex) {
            $compile(angular.element(row).contents())($scope);
        }

        function showAddPaymentPopup() {
            vm.tplAddPayment = "../../views/order/client/basic-data/payment/add-payment/views/add-payment.view.html";
            $('#modalAddPayment').modal('show');
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
        function showPaymentList() {
            // var template = getTemplate(templates.line, userType);
            vm.tplPaymentList = "../../views/order/client/basic-data/payment/views/payment-list.view.html";
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