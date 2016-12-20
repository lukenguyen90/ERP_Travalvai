(function() {
    'use strict'
    angular
        .module('order.ctrls')
        .controller("LineCtrl", lineCtrl);

    function lineCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, $resource, orderDetailService) {
        var vm = this;
        angular.extend(vm, $controller('ProductCtrl', { $scope: $scope }));
        angular.extend(vm, $controller('OrderDetailCtrl', { $scope: $scope }));

        vm.removeInVisibleHeader = removeInVisibleHeader;
        vm.renderActions = renderActions;
        vm.isUpdate = false;

        function removeInVisibleHeader() {

            window.setTimeout(function() {
                $('#tbl-product-list-line thead tr:last').children('th').each(function() {
                    if ($(this).is(':empty')) {
                        $(this).remove();
                    }
                });
            }, 100);

        }

        $scope.deleteProduct = function(orderId) {
            orderDetailService.deleteOrder(orderId).then(function(result) {
                if (result.isDeleted === true) {
                    utils().notification().showSuccess("Delete product success!");
                    $scope.vmLine.instance.reloadData();
                } else {
                    utils().notification().showFail("Delete product failed!");
                }
            });
        }

        function renderActions(data, type, full, meta) {
            var objData = JSON.stringify(data).toString();
            var orderStatus = utils().getOrderStatus(data.fty_confirm, data.zone_confirm);
            var userType = $scope.$parent.userType;
            vm.isUpdate = utils().allowUpdateProduct(orderStatus, userType);
            if(vm.isUpdate == false){
                return "-";
            }else{
                return "<span class='txt-color-green btnedit' title='Edit' ng-click='editProduct(" +objData +")'>" +
                    "   <i class='ace-icon bigger-130 fa fa-pencil'></i></span>"
                    + "<span class='txt-color-red btnDelete' title='Delete' ng-click='deleteProduct(" + data.id_order_detail + ")' ng-confirm-message>" +
                    "   <i class='ace-icon bigger-130 fa fa-trash-o'></i>" +
                    "</span>";
            }
        }

    };
})();