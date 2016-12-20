(function() {
    'use strict';

    angular.module('shipment.services').factory('productService', productService);

    function productService($q, baseService) {

        return {
            getProjects: getProjects,
            getProducts: getProducts,
            createshipment: createshipment
        };


        function getProjects(customerId) {
            var params = {customerId: customerId};            
            return baseService.makeRequest("getProject", params);
        }

        function getProducts(projectID) {
            var params = {projectID: projectID};            
            return baseService.makeRequest("getProduct", params);
        }

        function createshipment(shipment){
            return baseService.makeRequest("createshipment", shipment);
        }


    }
})();