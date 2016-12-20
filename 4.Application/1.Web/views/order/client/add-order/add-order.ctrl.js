(function() {
    'use strict'
    angular
        .module('order.ctrls')
        .controller("AddOrderCtrl", addOrderCtrl);

    function addOrderCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, models, addOrderService) {
        var vm = this;
        angular.extend(vm, $controller('OrderListCtrl', { $scope: $scope }));
        //Define properties
        vm.order = models.order;
        vm.DisplaySizeDetail = models.DisplaySizeDetail;
        vm.conditions = null;
        vm.types = null;
        vm.statusList = null;
        vm.payments = null;
        vm.zones = null;
        vm.agents = null;
        vm.customers = null;
        vm.userType = '';

        //expose function to view
        vm.init = init;
        vm.getAgents = getAgents;
        vm.getCustomers = getCustomers;
        vm.showAddProduct = showAddProduct;
        vm.createOrderInfo = createOrderInfo;


        //Initiate controller
        //Define functions
        function init() {
            resetOrder();
            initDatePicker();
            getConditions();
            getTypes();
            getPayments();
            //vm.order = models.order;
            vm.userType = $scope.$parent.userType;

            initCustomer($scope.$parent.userType, $scope.$parent.userTypeId);
        }

        function initCustomer(userType, userTypeId) {
            switch (userType) {
                case utils().user().userType.factory:
                    getZones();
                    break;
                case utils().user().userType.zone:
                    getAgents(userTypeId)
                    break;
                case utils().user().userType.agent:
                    vm.order.zone = {};
                    getCustomers(userTypeId)
                    break;
                case utils().user().userType.customer:
                    vm.order.zone = {};
                    vm.order.agent = {};
                    vm.order.customer = {};
                    vm.order.customer.ID = userTypeId;

                    break;
                default:
                    break;
            }

        }

        function resetOrder() {
            vm.order.condition = null;
            vm.order.type = null;
            vm.order.payment = null;
            vm.order.zone = null;
            vm.order.agent = null;
            vm.order.customer = null;
        }

        function initDatePicker() {
            $("#orderDate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true
            });
            $("#orderDate").css({"background-color":"#FFFFFF"})
        }

        function showAddProduct() {
            if (null === vm.order.condition ||
                null === vm.order.type ||
                null === vm.order.payment)
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

        function getConditions() {
            addOrderService.getConditions().then(function(data) {
                vm.conditions = data;
            });
        }

        function getTypes() {
            addOrderService.getTypes().then(function(data) {
                vm.types = data;
            });
        }

        function getPayments() {
            addOrderService.getPayments().then(function(data) {
                vm.payments = data;
            });
        }

        function getZones() {
            addOrderService.getZones().then(function(data) {
                vm.zones = data;
            });
        }

        function getAgents(zoneId) {
            addOrderService.getAgents(parseInt(zoneId)).then(function(data) {
                vm.agents = data;
            });
        }

        function getCustomers(agentId) {
            addOrderService.getCustomers(parseInt(agentId)).then(function(data) {
                vm.customers = data;
            });
        }
        function createOrderInfo() {
            addOrderService.createOrderInfo(vm.order).then(function(result) {
                
                if (typeof(result.id) !== "undefined")
                    window.location.href = "/index.cfm/order.order-detail.cfm?orderId=" + result.id;
                else {

                    utils().notification().showFail("Error: " + result);
                    $('#modalAddProduct').modal('hide');
                }

            });
        }


    };
})();