(function() {
    'use strict';

    angular.module('order.services').factory('productService', productService);

    function productService($q, baseService) {

        return {
            getProjects: getProjects,
            getProducts: getProducts,
            createOrder: createOrder,
            editOrder : editOrder
        };


        function getProjects(customerId) {
            var params = {customerId: customerId};            
            return baseService.makeRequest("getProject", params);
        }

        function getProducts(projectID) {
            var params = {projectID: projectID};            
            return baseService.makeRequest("getProduct", params);
        }

        function createOrder(order){
            return baseService.makeRequest("createOrder", order);
        }
        function editOrder(order){
            return baseService.makeRequest("editOrder", order);
        }


    }
})();