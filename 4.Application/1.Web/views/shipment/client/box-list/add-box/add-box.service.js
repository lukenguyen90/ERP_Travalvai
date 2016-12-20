(function() {
    'use strict';

    angular.module('shipment.services').factory('AddBoxService', addBoxService);

    function addBoxService($q, baseService) {


        return {
            getTypeBox: getTypeBox,
            createBox: createBox
        };      

        function getTypeBox() {
            return baseService.makeRequest("getTypeBox");
        }

        function createBox(box) {
            return baseService.makeRequest("createBox", box);
        }

        

    }
})();