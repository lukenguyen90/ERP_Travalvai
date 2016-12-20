(function() {
    'use strict'
    angular
        .module('shipment.ctrls')
        .controller("AddShipmentCtrl", addShipmentCtrl);

    function addShipmentCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, models, addshipmentService) {
        var vm = this;
        angular.extend(vm, $controller('ShipmentListCtrl', { $scope: $scope }));
        //Define properties


        //expose function to view
        vm.init = init;
        vm.getAgents            = getAgents;
        vm.getCustomers         = getCustomers;
        vm.createShipment       = createShipment;
        vm.showAddShipment      = showAddShipment;
        vm.getShipmentTypeCurrent = getShipmentTypeCurrent;
        vm.isShowZoneOptions      = isShowZoneOptions;
        vm.isShowAgentOptions     = isShowAgentOptions;
        vm.isShowCustomerOptions  = isShowCustomerOptions;


        //Initiate controller
        //Define functions
        function init() {
            initVariable();
            initDatePicker();
            getForwarders();
            getFreights();
            getIncoterms();
            getShipmentTypes();
            getSender();
            //vm.shipment = models.shipment;
           

            initCustomer($scope.$parent.userType, $scope.$parent.userTypeId);
        }

        function initVariable() {
            vm.shipment = angular.copy(models.shipment);
            vm.shipment.zone       = {};
            vm.shipment.agent      = {};
            vm.shipment.customer   = {};
            vm.shipmentTypeCurrent = {"st_code": ""};
            vm.forwarders = null;
            vm.freights = null;
            vm.incoterms = null;
            vm.shipmentTypes = null;
            vm.zones = null;
            vm.agents = null;
            vm.customers = null;
            vm.userType = $scope.$parent.userType;
            vm.shipment.delivery = "";
            vm.shipment.estimatedArival = "";
            vm.shipment.estimateDelivery = "";
            vm.shipment.openDate = formatDate(new Date());
            vm.shipment.arival = "";
            vm.shipment.freightCost = "";
            vm.shipment.taxes = "";
            vm.shipment.importDuty = "";
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

        function initDatePicker() {
            $("#dateOpen").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true
            });
            $("#dateOpen").css({ "background-color": "#FFFFFF" });

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

        function showAddShipment() {
            var st_code  = vm.shipmentTypeCurrent.st_code;
            
            if (null === vm.shipment.forwarder ||
                null === vm.shipment.freight ||
                null === vm.shipment.incoterm ||
                null === vm.shipment.shipmentType ||
                vm.shipment.openDate.length === 0){
                return false;
            }

            switch (st_code) {
                case "FTZ" :
                    if(typeof(vm.shipment.zone.ID) === "undefined")
                        return false;
                    break;
                case "FTA" :
                    if(typeof(vm.shipment.zone.ID) === "undefined" || typeof(vm.shipment.agent.ID) === "undefined")
                        return false; 
                    break;
                case "FTC" :
                    if(typeof(vm.shipment.zone.ID) === "undefined" || typeof(vm.shipment.agent.ID) === "undefined" || typeof(vm.shipment.customer.ID) === "undefined")
                        return false; 
                    break;
                case "ZTA" :
                    if(typeof(vm.shipment.agent.ID) === "undefined")
                        return false; 
                    break;
                case "ZTC" :
                    if(typeof(vm.shipment.agent.ID) === "undefined" || typeof(vm.shipment.customer.ID) === "undefined")
                        return false; 
                    break;
                case "ATC" :
                    if(typeof(vm.shipment.customer.ID) === "undefined")
                        return false;
                    break;
                default:
                    break;
            }

            return true;
        }

        function getForwarders() {
            addshipmentService.getForwarders().then(function(data) {
                vm.forwarders = data;
            });
        }

        function getFreights() {
            addshipmentService.getFreights().then(function(data) {
                vm.freights = data;
            });
        }

        function getIncoterms() {
            addshipmentService.getIncoterms().then(function(data) {
                vm.incoterms = data;
            });
        }

        function getShipmentTypes() {
            addshipmentService.getShipmentTypes().then(function(data) {
                vm.shipmentTypes = data;
            });
        }

        function getSender() {
            addshipmentService.getSender().then(function(data) {
                vm.shipment.sender = data[0];
            });
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

        function getShipmentTypeCurrent(shipmentType){
            vm.shipmentTypeCurrent = shipmentType;     
            isShowZoneOptions();  
            isShowAgentOptions();   
            isShowCustomerOptions();
        }

        function isShowZoneOptions(){
            var st_code = vm.shipmentTypeCurrent.st_code;
            var first_char = st_code.charAt();
            if(first_char === "F")
                return true;
            return false;
        }

        function isShowAgentOptions(){
            var st_code = vm.shipmentTypeCurrent.st_code;
            if(st_code === "FTA" || st_code === "FTC" || st_code === "ZTA" || st_code === "ZTC")
                return true;
            return false;
        }

        function isShowCustomerOptions(){
            var st_code = vm.shipmentTypeCurrent.st_code;
            if(st_code === "FTC" || st_code === "ZTC" || st_code === "ATC")
                return true;
            return false;
        }

        function createShipment() {
            //fix delivery date
            if(vm.shipment.delivery != ""){
                var deliveryDate     = vm.shipment.delivery.split("/");
                if (deliveryDate[0] < 13) {
                    vm.shipment.delivery = utils().dateTime().formatDate(vm.shipment.delivery);
                }
            }
            //fix estimated arival date
            if(vm.shipment.estimatedArival != ""){
                var estimatedArival     = vm.shipment.estimatedArival.split("/");
                if (estimatedArival[0] < 13) {
                    vm.shipment.estimatedArival = utils().dateTime().formatDate(vm.shipment.estimatedArival);
                }
            }
            // fix estimate delivery date
            if(vm.shipment.estimateDelivery != ""){
                var estimateDelivery     = vm.shipment.estimateDelivery.split("/");
                if (estimateDelivery[0] < 13) {
                    vm.shipment.estimateDelivery = utils().dateTime().formatDate(vm.shipment.estimateDelivery);
                }
            }
            //fix open date
            if(vm.shipment.openDate != ""){
                var openDate     = vm.shipment.openDate.split("/");
                if (openDate[0] < 13) {
                    vm.shipment.openDate = utils().dateTime().formatDate(vm.shipment.openDate);
                }
            }
            //fix arival date
            if(vm.shipment.arival != ""){
                var arival     = vm.shipment.arival.split("/");
                if (arival[0] < 13) {
                    vm.shipment.arival = utils().dateTime().formatDate(vm.shipment.arival);
                }
            }
            //shipment destination
            var st_code = vm.shipmentTypeCurrent.st_code;
            var lastChar = st_code.substr(st_code.length - 1);
            if(lastChar === "Z"){
                vm.shipment.destination = vm.shipment.zone;
            }else if(lastChar === "A"){
                vm.shipment.destination = vm.shipment.agent;   
            }else{
                vm.shipment.destination = vm.shipment.customer; 
            }
            //add shipment
            addshipmentService.createShipment(vm.shipment).then(function(result) {
                if (result.success == true){
                    utils().notification().showSuccess("Add shipment success!");
                    $('#modalAddShipment').modal('hide');
                    $scope.$parent.vm.dtInstance.reloadData();
                    // window.location.href = "/index.cfm/shipment.shipment-detail.cfm?shipmentId=" + result.id;
                }else{
                    $('#modalAddShipment').modal('hide');
                    utils().notification().showFail("Add shipment failed!");
                }

            });
        }


    };
})();