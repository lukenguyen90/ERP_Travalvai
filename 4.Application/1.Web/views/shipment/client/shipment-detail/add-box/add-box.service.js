(function() {
    'use strict';

    angular.module('shipment.services').factory('addBoxService', addBoxService);

    function addBoxService($q, baseService) {


        return {
            getForwarders: getForwarders,
            getFreights: getFreights,
            getIncoterms: getIncoterms,
            getShipmentTypes: getShipmentTypes,
            getZones: getZones,
            getAgents: getAgents,
            getCustomers: getCustomers,
            createShipment: createShipment
        };


        function getForwarders() {
            return baseService.makeRequest("getForwarders");
        }

        function getFreights() {
            return baseService.makeRequest("getFreights");
        }

        function getIncoterms() {
            return baseService.makeRequest("getIncoterms");
        }

        function getShipmentTypes(userType) {
            var shipmentType = userType.charAt(0).toUpperCase();
            return baseService.makeRequest("getShipmentType", shipmentType);
        }

        function getZones() {
            return baseService.makeRequest("getZone");
        }

        function getAgents(id) {
            var params = { zoneId: parseInt(id) };
            return baseService.makeRequest("getAgent", params);
        }

        function getCustomers(id) {
            var params = { agentId: parseInt(id) };
            return baseService.makeRequest("getCustomer", params);
        }

        function createShipment(shipment) {
            return baseService.makeRequest("createshipmentInfo", shipment);
        }

    }
})();