(function() {
    'use strict';

    angular.module('order.services').factory('addOrderService', addOrderService);

    function addOrderService($q, baseService) {


        return {
            getConditions: getConditions,
            getTypes: getTypes,
            getPayments: getPayments,
            getZones: getZones,
            getAgents: getAgents,
            getCustomers: getCustomers,
            createOrderInfo: createOrderInfo
        };


        function getConditions() {

            return baseService.makeRequest("getOrderCondition");
        }

        function getTypes() {
            return baseService.makeRequest("getOrderType");
        }

        function getPayments() {
            return baseService.makeRequest("getPayment");
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

        function createOrderInfo(order){
            return baseService.makeRequest("createOrderInfo", order);
        }

    }
})();