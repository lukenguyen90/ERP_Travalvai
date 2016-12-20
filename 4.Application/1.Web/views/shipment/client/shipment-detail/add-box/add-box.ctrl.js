(function() {
    'use strict'
    angular
        .module('shipment.ctrls')
        .controller("AddBoxCtrl", addBoxCtrl);

    function addBoxCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, models, addBoxService) {
        var vm = this;
        angular.extend(vm, $controller('ShipmentDetailCtrl', { $scope: $scope }));
        //Define properties

        var templates = {
            manipulation: "../../views/shipment/client/shipment-detail/add-box/views/manipulation.view.html",
            barcode: "../../views/shipment/client/shipment-detail/add-box/views/barcode.view.html"
        };
        //expose function to view
        vm.init = init;
        vm.getAgents = getAgents;
        vm.getCustomers = getCustomers;
        vm.createShipment = createShipment;


        //Initiate controller
        //Define functions
        function init() {
            initVariable();

            //vm.shipment = models.shipment;


            initCustomer($scope.$parent.userType, $scope.$parent.userTypeId);
        }

        function initVariable() {
            vm.shipment = angular.copy(models.shipment);
            vm.forwarders = null;
            vm.freights = null;
            vm.incoterms = null;
            vm.shipmentTypes = null;
            vm.zones = null;
            vm.agents = null;
            vm.customers = null;
            vm.userType = $scope.$parent.userType;
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
                    vm.shipment.zone = {};
                    getCustomers(userTypeId)
                    break;
                case utils().user().userType.customer:
                    vm.shipment.zone = {};
                    vm.shipment.agent = {};
                    vm.shipment.customer = {};
                    vm.shipment.customer.ID = userTypeId;

                    break;
                default:
                    break;
            }

        }

        function showAddProduct() {
            if (null === vm.shipment.condition ||
                null === vm.shipment.type ||
                null === vm.shipment.payment ||
                null === vm.shipment.status)
                return false;

            switch (vm.userType) {
                case utils().user().userType.factory:
                    return (null !== vm.shipment.zone) && (null !== vm.shipment.agent) && (null !== vm.shipment.customer);
                case utils().user().userType.zone:
                    return (null !== vm.shipment.agent) && (null !== vm.shipment.customer);
                case utils().user().userType.agent:
                    return (null !== vm.shipment.customer);
                default:
                    return true;
            }
        }

        function getZones() {
            addshipmentService.getZones().then(function(data) {
                vm.zones = data;
            });
        }

        function getAgents(zoneId) {
            addshipmentService.getAgents(parseInt(zoneId)).then(function(data) {
                vm.agents = data;
            });
        }

        function getCustomers(agentId) {
            addshipmentService.getCustomers(parseInt(agentId)).then(function(data) {
                vm.customers = data;
            });
        }

        function createShipment() {
            addshipmentService.createShipment(vm.shipment).then(function(result) {

                if (typeof(result.id) !== "undefined")
                    window.location.href = "/index.cfm/shipment.shipment-detail.cfm?shipmentId=" + result.id;
                else {

                    utils().notification().showFail("Error: " + result);
                    $('#modalAddProduct').modal('hide');
                }

            });
        }


    };
})();