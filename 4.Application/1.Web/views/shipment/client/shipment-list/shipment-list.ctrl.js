(function() {
    'use strict'
    angular
        .module('shipment.ctrls')
        .controller("ShipmentListCtrl", shipmentListCtrl);

    function shipmentListCtrl($state, $q,
        $scope, $filter, $http,
        $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout,
        $controller, $resource, shipmentListService, datatableCtrl) {
        var vm = this;
        vm.filter = {};
        vm.dtInstance = {};
        vm.dtOptions = {};
        vm.dtColumns = [];


        var templates = {
            tab: "../../views/shipment/client/shipment-list/views/{0}.view.html",
            addShipment: "../../views/shipment/client/shipment-list/add-shipment/views/add-shipment.view.html"
        };

        $scope.userId = 0;
        $scope.userTypeId = "";

        vm.init = init;
        vm.shipment = null;

        vm.showAddShipmentPopup = $scope.showAddShipmentPopup = showAddShipmentPopup;
        vm.loadShipments = loadShipments;

        function init(userType, userTypeId) {
            if (userType.length === 0) {
                window.location.href = window.location.href;
            } else {
                initVariable(userType, userTypeId);
                loadDefaultTab(userType);
                loadShipments();
            }
        }

        function initVariable(userType, userTypeId) {
            $scope.userTypeId = userTypeId;
            $scope.userType = userType;
            vm.fromList = shipmentListService.getFromList();
            vm.toList = shipmentListService.getToList();
            vm.filter.from = vm.fromList[0];
            vm.filter.to = vm.toList[0];
            //vm.tplshipmentList = "";
        }

        function loadDefaultTab(userType) {
            vm.tplTab = getTemplate(templates.tab, userType);
        }

        function loadShipments() {
            vm.dtOptions = datatableCtrl.getOptions(DTOptionsBuilder, vm.filter.from, vm.filter.to);
            vm.dtColumns = datatableCtrl.getColumnsDef(DTColumnBuilder);
        }

        function showAddShipmentPopup(userType) {
            vm.tplAddShipment = getTemplate(templates.addShipment, userType);
            $('#modalAddShipment').modal('show');
        }

       

        /**
         * generate template according to user type
         * 
         * @param {any} userType: 'factory', 'zone', 'agent', 'customer'
         */

        function getTemplate(url, userType) {
            var version = "?v=" + Math.random() + "&userId=" + 1;
            return url.format(userType) + version;
        }

    }

})();