(function() {
    'use strict'
    var app = angular
        .module('order.ctrls')
        .controller("ProductEditCtrl", productEditCtrl);

    function productEditCtrl($scope, $location, $filter, $http, $compile, $window, $timeout, $controller, models, productService) {
        var vm = this;
        var originProduct = {};
        vm.project = null;
        vm.sizeQuantity = false;

        vm.product = null;
        vm.activeTab = 0;

        vm.sizeTypes = {
            quantity: 0,
            detail: 1
        };

        //Export functions
        vm.changeSizeType = changeSizeType;
        vm.editOrder = editOrder;
        vm.init = init;
        vm.showAddProductButton = showAddProductButton;
        $scope.calculateGrandTotal = calculateGrandTotal;
        vm.resetSizeDetail = $scope.resetSizeDetail = resetSizeDetail;
        $scope.resetPrice = resetPrice;

        vm.sizeDetails = {};

        var tplSizeView = {
            quantity: "../../views/order/client/product/views/edit/size.view.html",
            detail: "../../views/order/client/product/views/edit/name-number.view.html"
        };

        //Private functions section
        function init() {
            angular.extend(vm, $controller('OrderDetailCtrl', { $scope: $scope }));

            vm.order = $scope.$parent.order;
            vm.activeTab = vm.order.sizeType;
            vm.product = angular.copy(vm.order.product);
            updateTotalUnits();
            changeSizeType(vm.activeTab);
            //getProjects(vm.order.customer.ID);
        }

        function changeSizeType(type) {
            var template = (type === vm.sizeTypes.quantity) ? tplSizeView.quantity : tplSizeView.detail;
            vm.tplAddSize = getTemplate(template);
        }

        function editOrder() {
            productService.editOrder(vm.order).then(function(result) {
                if (typeof(result.success) == false) {
                    $scope.$parent.vmOrderDetail.initOrderInfo();
                    changeProduct(vm.products[0]);
                    utils().notification().showFailed("Edit product failed!");
                } else {
                    utils().notification().showSuccess("Edit product success!");
                    $scope.$parent.vmOrderDetail.reloadProductList($scope.$parent.userType);
                    $('#modalAddProduct').modal('hide');
                }
            });
        }

        function showAddProductButton() {
            if (typeof(vm.product.units) === 'undefined' || vm.product.units === 0)
                return false;
            return true;
        }

        function updateTotalUnits() {
            var units = 0;
            for (var sizeDetail in vm.product.sizesDetail) {
                var quantity = parseInt(vm.product.sizesDetail[sizeDetail].quantity);
                if (!isNaN(quantity)) {
                    units += quantity;
                }
            }
            vm.product.units = formatNumberThousand(units);
        }

        function resetSizeDetail() {
            angular.forEach(vm.product.sizesDetail, function(size, key) {
                size.quantity = "";
            });
        }


        function resetPrice() {
            vm.product.units = 0;
            vm.product.price.grandTotal = {};
        }



        function calculateGrandTotal(units) {
            var grandTotal = { factory: 0, zone: 0, agent: 0 };
            grandTotal.factory = formatNumberThousand(vm.product.price.total.factory * units, 2);
            grandTotal.zone = formatNumberThousand(vm.product.price.total.zone * units, 2);
            grandTotal.agent = formatNumberThousand(vm.product.price.total.agent * units, 2);
            return grandTotal;
        }

        function getTemplate(name) {
            var version = "?v=" + Math.random();
            return name + version;

        }

    }
    app.directive('onlyNumber', function() {
        return {
            require: 'ngModel',
            link: function(scope, element, attr, ngModelCtrl) {
                function fromUser(text) {
                    if (text) {
                        var transformedInput = text.replace(/[^0-9]/g, '');

                        if (transformedInput !== text) {
                            ngModelCtrl.$setViewValue(transformedInput);
                            ngModelCtrl.$render();
                        }
                        return transformedInput;
                    }
                    return undefined;
                }
                ngModelCtrl.$parsers.push(fromUser);
            }
        }
    });
    //ngReallyClick
    app.directive('ngConfirmMessage', [function() {
        return {
            restrict: 'A',
            link: function(scope, element, attrs) {
                element.on('click', function(e) {
                    var message = attrs.ngConfirmMessage || "Are you sure want to delete?";
                    if (!confirm(message)) {
                        e.stopImmediatePropagation();
                    }
                });
            }
        }
    }]);




})();