(function() {
    'use strict';

    angular.module('shipment.services').factory('EditBoxService', editBoxService);

    function editBoxService($q, baseService) {


        return {
            getTypeBox: getTypeBox,
            editBox: editBox
        };      

        function getTypeBox() {
            return baseService.makeRequest("getTypeBox");
        }

        function editBox(box) {
            return baseService.makeRequest("editBox", box);
        }

        

    }
})();