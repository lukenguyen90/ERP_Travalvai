(function() {
    'use strict'
    var app = angular
        .module('order.ctrls')
        .controller("ProductCtrl", productCtrl);

    function productCtrl($scope, $location, $filter, $http, $compile, $window, $timeout, $controller, models, productService) {
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
        vm.createOrder = createOrder;
        vm.getProjects = getProjects;
        vm.getProducts = getProducts;
        vm.changeProduct = changeProduct;
        vm.init = init;
        vm.showAddProductButton = showAddProductButton;
        $scope.calculateGrandTotal = calculateGrandTotal;
        $scope.resetSizeDetail = resetSizeDetail;
        $scope.resetPrice = resetPrice;
        vm.resetSizeDetail = resetSizeDetail;

        vm.sizeDetails = {};

        var tplSizeView = {
            quantity: "../../views/order/client/product/views/add-size-quantity.view.html",
            detail: "../../views/order/client/product/views/add-size-detail.view.html",
            blank: "../../views/order/client/product/views/blank.view.html"
        };



        //Private functions section
        function init() {

            angular.extend(vm, $controller('OrderDetailCtrl', { $scope: $scope }));
            vm.order = $scope.$parent.vmOrderDetail.order;
            initVariable();
            getProjects(vm.order.customer.ID);
        }

        function getTemplate(name) {
            var version = "?v=" + Math.random();
            return name + version;

        }

        function initVariable() {
            vm.order.product = {};
            vm.order.sizeType = 0;
            vm.product = angular.copy(vm.order.product);
            originProduct = angular.copy(vm.order.product);           
        }

        function changeSizeType(type) {
            //vm.sizeType = type;            
            vm.order.sizeType = type;

            resetSizeDetail();
            resetPrice();
            var template = (type === vm.sizeTypes.quantity) ? tplSizeView.quantity : tplSizeView.detail;
            vm.tplAddSize = getTemplate(template);
        }

        function createOrder() {
            productService.createOrder(vm.order).then(function(result) {
                if (typeof(result.id) !== "undefined") {
                    $scope.$parent.vmOrderDetail.initOrderInfo();
                    changeProduct(vm.products[0]);
                    $scope.$parent.vmOrderDetail.reloadProductList($scope.$parent.userType);
                } else {
                    utils().notification().showFail("Error: " + result);
                    $('#modalAddProduct').modal('hide');
                }
            });
        }

        function showAddProductButton() {
            if (typeof(vm.product.units) === 'undefined' || vm.product.units === 0)
                return false;
            return true;
        }

        function getProjects(customerId) {
            productService.getProjects(parseInt(customerId)).then(function(data) {
                vm.projects = data;
            });
        }

        function getProducts(projectID) {
            productService.getProducts(parseInt(projectID)).then(function(data) {
                vm.products = data;
                if (data.length > 0) {
                    changeProduct(vm.products[0]);

                }
            });
        }

        function changeProduct(newProduct) {
            resetProduct(newProduct);
            resetSizeType();
            resetSizeDetail();
        }

        function resetSizeType() {
            vm.activeTab = 0;
            vm.sizeQuantity = true;
            vm.order.sizeType = 0;
            vm.tplAddSize = getTemplate(tplSizeView.quantity);

        }

        function resetSizeDetail() {
            angular.forEach(vm.product.sizesDetail, function(size, key) {
                size.quantity = "";
            });
        }

        function resetProduct(newProduct) {
            vm.order.product = angular.copy(newProduct);
            vm.product = angular.copy(newProduct);
            originProduct = angular.copy(newProduct);
            resetPrice();
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



    };
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