(function() {
    'use strict';

    angular.module('order.services').factory('paymentService', paymentService);

    function paymentService($q, baseService) {

        var userType = { Employee: 0, Company: 1, Private: 2 };

        return {
            getUserLevel: getUserLevel,
            getListPayments: getListPayments,
            getResumeOrders: getResumeOrders,
            deleteOrder: deleteOrder
        };


        function getUserLevel(userId) {
            return baseService.makeRequest("getUserLevel");
        }

        function getListPayments() {
            return new Promise(function(resolve, reject) {
                baseService.makeRequest("getListPayments").then(function(data) {
                    var result = [];
                    if (data != null && data.length > 0) {
                        result = data;
                    }
                    
                    resolve(result);
                })
            });
        }
        function getResumeOrders(orderId) {
            return new Promise(function(resolve, reject) {
                baseService.makeRequest("getResumeOrders").then(function(data) {
                    resolve(data);
                })
            });
        }
        function deleteOrder(orderId) {
            return new Promise(function(resolve, reject) {
                var param = { orderId: parseInt(orderId) };
                baseService.makeRequest("deleteOrder", param).then(function(data) {
                    if (data === null || data.length === 0)
                        resolve([])
                    else resolve(data);
                });
            })

        }
    }
})();