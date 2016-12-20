(function() {
    'use strict';

    angular.module('order.services').factory('addPaymentService', addPaymentService);

    function addPaymentService($q, baseService) {


        return {
            getConditions: getConditions,
            getTypes: getTypes,
            getStatusList: getStatusList,
            getPayments: getPayments,
            getZones: getZones,
            getAgents: getAgents,
            getCustomers: getCustomers,
            createPaymentInfo: createPaymentInfo
        };


        function getConditions() {

            return baseService.makeRequest("getOrderCondition");
        }

        function getTypes() {
            return baseService.makeRequest("getOrderTYpe");
        }

        function getStatusList() {
            return baseService.makeRequest("getOrderStatus");
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

        function createPaymentInfo(payment){
            return baseService.makeRequest("createPaymentInfo", payment);
        }

    }
})();