(function() {
    'use strict'
    angular
        .module('order.ctrls')
        .controller("SizeCtrl", sizeCtrl);

    function sizeCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, $resource, orderDetailService) {
        var vm = this;
        //angular.extend(vm, $controller('OrderListCtrl', { $scope: $scope }));
        angular.extend(vm, $controller('ProductCtrl', { $scope: $scope }));
        angular.extend(vm, $controller('OrderDetailCtrl', { $scope: $scope }));

        vm.removeInVisibleHeader = removeInVisibleHeader;
        vm.renderActions = renderActions;

        function removeInVisibleHeader() {

            window.setTimeout(function() {
                $('#tbl-product-list-size thead tr:last').children('th').each(function() {
                    if ($(this).is(':empty')) {
                        $(this).remove();
                    }
                });
            }, 100);

        }
        
        $scope.deleteOrder = function(data) {
            var group_name = data.ordd_cg_name;
            var id_product = data.id_product;
            var id_order = data.id_order;
            var priceList = JSON.stringify(data.price_List);
            var size_custom = data.name_number == "Yes" ? true : false;

            orderDetailService.deleteProductSizeView(id_order, id_product, priceList, group_name, size_custom).then(function(result) {
                if (result.isDeleted === true) {
                    utils().notification().showSuccess("Delete product success!");
                    $scope.vmSize.instance.reloadData();
                } else {
                    utils().notification().showFail("Delete product failed!");
                }
            });
        }

        function renderActions(data, type, full, meta) {
            var strData = JSON.stringify(data).toString();
            var orderStatus = utils().getOrderStatus(data.fty_confirm, data.zone_confirm);
            var userType = $scope.$parent.userType;
            vm.isUpdate = utils().allowUpdateProduct(orderStatus, userType);
            if(vm.isUpdate == false){
                return "-";
            }else{
                return "<span class='txt-color-green btnedit' title='Edit' ng-click='editProduct(" +strData +")'>" +
                    "   <i class='ace-icon bigger-130 fa fa-pencil'></i></span>"+
                "<span class='txt-color-red btnDelete' title='Delete' ng-click='deleteOrder(" + strData + ")' ng-confirm-message>" +
                    "   <i class='ace-icon bigger-130 fa fa-trash-o'></i>" +
                    "</span>";
            }
        }
    };
})();