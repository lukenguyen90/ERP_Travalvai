(function() {
    'use strict';

    angular.module('shipment.services').factory('shipmentDetailService', shipmentDetailService);

    function shipmentDetailService($q, baseService) {

        return {
            getForwarders: getForwarders,
            getFreights: getFreights,
            getIncoterms: getIncoterms,
            getShipmentTypes: getShipmentTypes,
            getShipmentType: getShipmentType,
            getFromList: getFromList,
            getToList: getToList,
            getShipments: getShipments,
            getZones: getZones,
            getAgents: getAgents,
            getCustomers: getCustomers,
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
            return baseService.makeRequest("getShipmentTypes", shipmentType);
        }

        function getShipmentType(from, to) {
            var firstCharFrom = from.value;
            var firstCharTo = to.value;

            var shipmentType = firstCharFrom + 'T' + firstCharTo;



            return shipmentType.toUpperCase();
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

        function getShipments(filter_string) {
            return new Promise(function(resolve, reject) {
                var param = { filter: filter_string };
                baseService.makeRequest("getShipmentList", param).then(function(data) {
                    var result = [];
                    if (data !== null && data.length > 0) {
                        result = data;
                    }
                    resolve(result);
                });
            });
        }

        function getFromList() {
            return [{
                    level: 0,
                    name: "All",
                    value: '%'
                }, {
                    level: 1,
                    name: "Factory",
                    value: 'F'
                },
                {
                    level: 2,
                    name: "Zone",
                    value: 'Z'
                }, {
                    level: 3,
                    name: "Agent",
                    value: 'A'
                }, {
                    level: 4,
                    name: "Customer",
                    value: 'C'
                }
            ];
        }

        function getToList() {
            return [{
                    level: 0,
                    name: "All",
                    value: '%'
                }, {
                    level: 1,
                    name: "Factory",
                    value: 'F'
                },
                {
                    level: 2,
                    name: "Zone",
                    value: 'Z'
                }, {
                    level: 3,
                    name: "Agent",
                    value: 'A'
                }, {
                    level: 4,
                    name: "Customer",
                    value: 'C'
                }
            ];
        }
    }
})();