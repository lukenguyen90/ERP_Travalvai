(function() {
    'use strict';

    angular.module('shipment.services').factory('addshipmentService', addshipmentService);

    function addshipmentService($q, baseService) {


        return {
            getForwarders: getForwarders,
            getFreights: getFreights,
            getIncoterms: getIncoterms,
            getShipmentTypes: getShipmentTypes,
            getZones: getZones,
            getAgents: getAgents,
            getCustomers: getCustomers,
            createShipment: createShipment,
            getSender: getSender
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

        function getShipmentTypes() {
            return baseService.makeRequest("getShipmentTypes");
        }

        function getZones() {
            return baseService.makeRequest("getZone");
        }

        function getSender() {
            return baseService.makeRequest("getSender");
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
            return baseService.makeRequest("createShipmentInfo", shipment);
        }

    }
})();