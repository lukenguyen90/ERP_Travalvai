(function() {
    'use strict';

    angular.module('shipment.services').factory('shipmentListService', shipmentListService);

    function shipmentListService($q, baseService) {

        return {
            getShipments: getShipments, 
            getFromList: getFromList,
            getToList: getToList,
            getShipmentType: getShipmentType
        };

        function getShipments(filter_string) {
            return new Promise(function(resolve, reject) {
                var param = { filter: filter_string};
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

        function getShipmentType(from, to){
            var firstCharFrom   = from.value;
            var firstCharTo     = to.value;

            var shipmentType = firstCharFrom + 'T' + firstCharTo;



            return shipmentType.toUpperCase();
        }
    }
})();