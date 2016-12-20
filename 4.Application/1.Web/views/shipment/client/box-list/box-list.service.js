(function() {
    'use strict';

    angular.module('shipment.services').factory('BoxListService', boxListService);

    function boxListService($q, baseService) {

        return {
            getBoxList: getBoxList,
            deleteBox: deleteBox
        };

        function getBoxList() {
            return new Promise(function(resolve, reject) {
                baseService.makeRequest("getBoxList").then(function(data) {
                    var result = [];
                    if (data !== null && data.length > 0) {
                        result = data;
                    }
                    resolve(result);
                });
            });
        }

        function deleteBox(id_box) {
            return baseService.makeRequest("deleteBox", id_box);
        }
    }
})();