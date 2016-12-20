(function() {
    'use strict';

    angular.module('order.services').factory('orderDetailService', orderDetailService);

    function orderDetailService($q, baseService) {


        return {
            getConditions: getConditions,
            getTypes: getTypes,
            getPayments: getPayments,
            getProductsLineView: getProductsLineView,
            getOrderDetails_SizeView: getOrderDetails_SizeView,
            getOrderInfo: getOrderInfo,
            editOrder: editOrder,
            deleteOrder: deleteOrder,
            deleteProductSizeView: deleteProductSizeView,
            getProductDetail: getProductDetail
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

        function getProductsLineView(orderId) {
            return new Promise(function(resolve, reject) {
                var param = { orderId: parseInt(orderId) };
                baseService.makeRequest("getOrderDetailsLineView", param).then(function(data) {
                    if (data === null || data.length === 0)
                        resolve([])
                    else resolve(data);
                });
            })

        }

        function getOrderDetails_SizeView(orderId) {
            return new Promise(function(resolve, reject) {
                var param = { orderId: parseInt(orderId) };
                baseService.makeRequest("getOrderDetails_SizeView", param).then(function(data) {
                    if (data === null || data.length === 0)
                        resolve([])
                    else resolve(data);
                });
            })

        }

        function getOrderInfo(orderId) {
            var param = { orderId: parseInt(orderId) };
            return baseService.makeRequest("getOrderInfo", param);
        }

        function editOrder(data) {
            var order       = angular.copy(data);
            /*factory*/
            var arrDateFacConfirm     = order.deliveryFactory.confirmationDate.split("/");
            var arrDateFacDeliver     = order.deliveryFactory.deliveryDate.split("/");
            // factory confirm
            if (arrDateFacConfirm[0] < 13) {
                order.deliveryFactory.confirmationDate = utils().dateTime().formatDate(order.deliveryFactory.confirmationDate);
            } else {
                order.deliveryFactory.confirmationDate = order.deliveryFactory.confirmationDate;
            }
            //factory deliver
            if (arrDateFacDeliver[0] < 13) {
                order.deliveryFactory.deliveryDate = utils().dateTime().formatDate(order.deliveryFactory.deliveryDate);
            } else {
                order.deliveryFactory.deliveryDate = order.deliveryFactory.deliveryDate;
            }
            /*zone */
            var arrDateZoneConfirm = order.deliveryZone.confirmationDate.split("/");
            var arrDateZoneDeliver = order.deliveryZone.deliveryDate.split("/");
            //zone confirm
            if (arrDateZoneConfirm[0] < 13) {
                order.deliveryZone.confirmationDate = utils().dateTime().formatDate(order.deliveryZone.confirmationDate);
            } else {
                order.deliveryZone.confirmationDate    = order.deliveryZone.confirmationDate;
            }
            //zone deliver
            if (arrDateZoneDeliver[0] < 13) {
                order.deliveryZone.deliveryDate = utils().dateTime().formatDate(order.deliveryZone.deliveryDate);
            } else {
                order.deliveryZone.deliveryDate    = order.deliveryZone.deliveryDate;
            }
            /*agent*/
            //agent deliver
            var arrDateAgentDeliver = order.deliveryAgent.deliveryDate.split("/");
            if (arrDateAgentDeliver[0] < 13) {
                order.deliveryAgent.deliveryDate = utils().dateTime().formatDate(order.deliveryAgent.deliveryDate);
            } else {
                order.deliveryAgent.deliveryDate    = order.deliveryAgent.deliveryDate;
            }
            
            return baseService.makeRequest("editOrderInfo", order);
        }

        function deleteOrder(order_detailId) {
            return new Promise(function(resolve, reject) {
                var param = { order_detailId: parseInt(order_detailId) };
                baseService.makeRequest("deleteProduct", param).then(function(data) {
                    if (data === null || data.length === 0)
                        resolve([])
                    else resolve(data);
                });
            })

        }

        function deleteOrderSizeView(order_detailId) {
            return new Promise(function(resolve, reject) {
                var param = { order_detailId: parseInt(order_detailId) };
                baseService.makeRequest("deleteProduct", param).then(function(data) {
                    if (data === null || data.length === 0)
                        resolve([])
                    else resolve(data);
                });
            })

        }

        function deleteProductSizeView(id_order, id_product, priceList, group_name, size_custom) {
            return new Promise(function(resolve, reject) {
                var param = { id_order: parseInt(id_order), id_product: id_product, priceList: priceList, group_name: group_name, size_custom: size_custom };
                baseService.makeRequest("deleteProductSizeView", param).then(function(data) {
                    if (data === null || data.length === 0)
                        resolve([])
                    else resolve(data);
                });
            })

        }

        function getProductDetail(id_order, id_product, priceList, group, size_custom) {
            return new Promise(function(resolve, reject) {
                var param = { id_order: parseInt(id_order), id_product: id_product, priceList: priceList, group: group, size_custom: size_custom};
                baseService.makeRequest("getProductDetail", param).then(function(data) {
                    if (data === null || data.length === 0)
                        resolve([])
                    else resolve(data);
                });
            })

        }
    }
})();