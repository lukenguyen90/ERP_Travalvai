(function() {
    'use strict';

    angular
        .module("shipment.ctrls")
        .controller('sizeQuantityDetail', sizeQuantityDetail);

    function sizeQuantityDetail($scope, $filter, $http, $compile, $window, $timeout, $controller, models, productService) {
        var vm = this;

        //Sync data between Product Factory component and add Size component

        //Export function
        vm.saveSizeQuantity = saveSizeQuantity;
        vm.init = init;


        //function
        function init() {
            angular.extend(vm, $controller('ProductCtrl', { $scope: $scope }));
            vm.shipment = $scope.$parent.vmproduct.shipment;
            vm.product = $scope.$parent.vmproduct.product;
            vm.sizeDetailList = angular.copy(vm.product.sizesDetail);
            changeQuantity();
        }

        function changeQuantity() {
            var units = 0;
            for (var sizeDetail in vm.product.sizesDetail) {
                var quantity = parseInt(vm.product.sizesDetail[sizeDetail].quantity);
                if (!isNaN(quantity)) {
                    units += quantity;
                }
            }
            vm.product.units = formatNumberThousand(units);
            vm.product.price.grandTotal = $scope.$parent.calculateGrandTotal(units);
        }

        function saveSizeQuantity() {
            vm.shipment.product.sizesDetail = angular.copy(vm.sizeDetailList);
            vm.product.sizesDetail = angular.copy(vm.sizeDetailList);
            changeQuantity();
        }


    }
})();