(function() {
    'use strict'
    var app = angular
        .module('shipment.ctrls')
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
        vm.createshipment = createshipment;
        vm.init = init;
        vm.showAddProductButton = showAddProductButton;
        $scope.calculateGrandTotal = calculateGrandTotal;
        vm.resetSizeDetail = $scope.resetSizeDetail = resetSizeDetail;
        $scope.resetPrice = resetPrice;

        vm.sizeDetails = {};

        var tplSizeView = {
            quantity: "../../views/shipment/client/product/views/edit/size.view.html",
            detail: "../../views/shipment/client/product/views/edit/name-number.view.html"
        };

        //Private functions section
        function init() {
            angular.extend(vm, $controller('shipmentDetailCtrl', { $scope: $scope }));

            vm.shipment = $scope.$parent.shipment;
            vm.activeTab = vm.shipment.sizeType;
            vm.product = angular.copy(vm.shipment.product);
            updateTotalUnits();
            changeSizeType(vm.activeTab);
            //getProjects(vm.shipment.customer.ID);
        }

        function changeSizeType(type) {
            var template = (type === vm.sizeTypes.quantity) ? tplSizeView.quantity : tplSizeView.detail;
            vm.tplAddSize = getTemplate(template);
        }

        function createshipment() {
            productService.createshipment(vm.shipment).then(function(result) {
                if (typeof(result.id) !== "undefined") {
                    $scope.$parent.vmshipmentDetail.initshipmentInfo();
                    changeProduct(vm.products[0]);
                    $scope.$parent.vmshipmentDetail.reloadProductList($scope.$parent.userType);
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