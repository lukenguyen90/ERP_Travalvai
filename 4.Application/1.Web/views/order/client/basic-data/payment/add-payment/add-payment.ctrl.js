(function() {
    'use strict'
    angular
        .module('order.ctrls')
        .controller("AddPaymentCtrl", addPaymentCtrl);

    function addPaymentCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, models, addPaymentService) {
        var vm = this;
        angular.extend(vm, $controller('PaymentListCtrl', { $scope: $scope }));
        //Define properties

        //expose function to view
        vm.init = init;
        // vm.showAddPayment = showAddPayment;
        vm.createPaymentInfo = createPaymentInfo;
        vm.payment = {};

        //Initiate controller
        //Define functions
        function init() {
            resetPayment();
            vm.userType = $scope.$parent.userType;
        }

        function resetPayment() {
            vm.payment.paymentcode = null;
            vm.payment.description = null;
            vm.payment.downpayment = null;
            vm.payment.ondelivery  = null;
            vm.payment.thirtydays  = null;
            vm.payment.sixtydays   = null;
            vm.payment.other       = null;
            vm.payment.paymentday  = null;
        }

        function showAddProduct() {
            if (null === vm.order.condition ||
                null === vm.order.type ||
                null === vm.order.payment ||
                null === vm.order.status)
                return false;

            switch (vm.userType) {
                case utils().user().userType.factory:
                    return (null !== vm.order.zone) && (null !== vm.order.agent) && (null !== vm.order.customer);
                case utils().user().userType.zone:
                    return (null !== vm.order.agent) && (null !== vm.order.customer);
                case utils().user().userType.agent:
                    return (null !== vm.order.customer);
                default:
                    return true;
            }
        }

        function createPaymentInfo() {
            addPaymentService.createPaymentInfo(vm.payment).then(function(result) {     
                if (typeof(result.id) !== "undefined")
                    $('#modalAddPayment').modal('hide');
                else {

                }
            });
        }


    };
})();