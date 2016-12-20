(function() {
    'use strict'
    angular
        .module('shipment.ctrls')
        .controller("ShipmentDetailCtrl", shipmentDetailCtrl);

    function shipmentDetailCtrl($state, $q,
        $scope, $filter, $http,
        $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout,
        $controller, $resource, shipmentDetailService, datatableCtrl) {
        var vm = this;
        vm.filter = {};

        var templates = {
            shipmentInfo: "../../views/shipment/client/shipment-detail/views/shipment-info.view.html",
            addBox: "../../views/shipment/client/shipment-detail/add-box/views/add-box.view.html"
        };

        vm.init = init;
        vm.showAddBoxPopup = $scope.showAddBoxPopup = showAddBoxPopup;
        vm.loadShipments = loadShipments;
        vm.getAgents = getAgents;
        vm.getCustomers = getCustomers;
        vm.loadedShippingInfo = loadedShippingInfo;


        function init(userType, userTypeId) {
            if (userType.length === 0) {
                window.location.href = window.location.href;
            } else {
                initVariable(userType, userTypeId);
                loadShipments();
            }
        }

        function initVariable(userType, userTypeId) {
            $scope.userId = 0;
            $scope.userTypeId = userTypeId;
            $scope.userType = userType;
            vm.dtInstance = {};
            vm.dtOptions = {};
            vm.dtColumns = [];
            vm.shipment = null;
            vm.tplShipmentInfo = templates.shipmentInfo;

            vm.fromList = shipmentDetailService.getFromList();
            vm.toList = shipmentDetailService.getToList();
            vm.filter.from = vm.fromList[0];
            vm.filter.to = vm.toList[0];

            getForwarders();
            getFreights();
            getIncoterms();
            getZones();
            getShipmentTypes($scope.userType);

        }

        function loadShipments() {
            vm.dtOptions = datatableCtrl.getOptions(DTOptionsBuilder, vm.filter.from, vm.filter.to);
            vm.dtColumns = datatableCtrl.getColumnsDef(DTColumnBuilder);
        }

        function loadedShippingInfo() {
            initDatePicker();
        }

        function showAddBoxPopup() {
            vm.tplAddBox = getTemplate(templates.addBox);
            $('#modalAddBox').modal('show');
        }

        function getShippingInfo() {
            //call service to get Shipping's Information and assign values to vm.shipment
        }


        function getZones() {
            shipmentDetailService.getZones().then(function(data) {
                vm.zones = data;
            });
        }

        function getAgents(zoneId) {
            shipmentDetailService.getAgents(parseInt(zoneId)).then(function(data) {
                vm.agents = data;
            });
        }

        function getCustomers(agentId) {
            shipmentDetailService.getCustomers(parseInt(agentId)).then(function(data) {
                vm.customers = data;
            });
        }

        function getForwarders() {
            shipmentDetailService.getForwarders().then(function(data) {
                vm.forwarders = data;
            });
        }

        function getFreights() {
            shipmentDetailService.getFreights().then(function(data) {
                vm.freights = data;
            });
        }

        function getIncoterms() {
            shipmentDetailService.getIncoterms().then(function(data) {
                vm.incoterms = data;
            });
        }

        function getShipmentTypes(userType) {
            shipmentDetailService.getShipmentTypes(userType).then(function(data) {
                vm.shipmentTypes = data;
            });
        }

        function initDatePicker() {
            $("#dateOpen").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true
            });
            $("#dateOpen").css({ "background-color": "#FFF" });

            $("#dateEstimateDelivery").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true
            });
            $("#dateEstimateDelivery").css({ "background-color": "#FFFFFF" });

            $("#dateDelivery").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true
            });
            $("#dateDelivery").css({ "background-color": "#FFFFFF" });

            $("#dateEstimatedArival").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true
            });
            $("#dateEstimatedArival").css({ "background-color": "#FFFFFF" });

            $("#dateArival").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true
            });
            $("#dateArival").css({ "background-color": "#FFFFFF" });

        }

        /**
         * generate template according to user type
         * 
         * @param {any} userType: 'factory', 'zone', 'agent', 'customer'
         */
        function getTemplate(url) {
            var version = "?v=" + Math.random() + "&userId=" + 1;
            return url + version;
        }

    }

})();