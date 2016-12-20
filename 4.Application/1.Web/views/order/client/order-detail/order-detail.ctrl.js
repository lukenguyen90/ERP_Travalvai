(function() {
    'use strict';
    angular
        .module('order.ctrls')
        .controller("OrderDetailCtrl", orderDetailCtrl);

    function orderDetailCtrl($state, $scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, $resource, orderDetailService, models) {
        var vm = this;
        vm.tplAddProduct = $scope.tplAddProduct = "";
        vm.order = $scope.order = models.order;
        vm.isEditProduct = false;
        vm.init = init;
        vm.showAddProductPopup = $scope.showAddProductPopup = showAddProductPopup;
        vm.editProduct = $scope.editProduct = editProduct;
        vm.showProductsSize = showProductsSize;
        vm.showProductsLine = showProductsLine;
        vm.viewOrderList = viewOrderList;
        vm.updateOrder = updateOrder;
        vm.deleteOrder = deleteOrder;
        vm.initOrderInfo = initOrderInfo;
        vm.reloadProductList = reloadProductList;
        vm.tmpSizeQuantity = {};
        vm.editSizeQuantity = editSizeQuantity;
        vm.updateProduct = updateProduct;
        vm.allowUpdateProduct = allowUpdateProduct;
        vm.isDisable = isDisable;
        $scope.toggle = toggle;
        $scope.userType = '';
        vm.orderStatus = '';
        vm.isAllowUpdateOrder = allowUpdateOrder;

        var templates = {
            orderDetail: '../../views/order/client/order-detail/views/{0}.view.html',
            addProduct: '../../views/order/client/product/views/product-{0}.view.html',
            editProduct: '../../views/order/client/product/views/edit/product-{0}.view.html',
            line: '../../views/order/client/order-detail/line/views/{0}.view.html',
            size: '../../views/order/client/order-detail/size/views/{0}.view.html'

        };

        //angular.extend(vm, $controller('OrderListCtrl', { $scope: $scope }));{}
        initDatePicker();
        //Initiate controller
        function init(userType) {
            if (userType.length === 0) {
                window.location.href = window.location.href;
            } else {
                loadUI(userType);
                initVariable();
                initOrderInfo();
            }
            $scope.userType = userType;
            vm.userType = userType;
            vm.activeTab = 0;
        }

        function updateProduct() {
            // console.log("update product");
        }

        function editSizeQuantity() {
            orderDetailService.editSizeQuantity(vm.tmpSizeQuantity.id_order_det, vm.tmpSizeQuantity.quantity).then(function(result) {
                if (result.isEdit === true) {
                     utils().notification().showSuccess("Edit product success!");
                    vmLine.instance.reloadData();
                } else {
                    utils().notification().showFail("Edit product failed!");
                }
            });
        }

        function allowUpdateOrder(){
            if(vm.orderStatus == "Open"){
                return true;
            }
            if(vm.orderStatus == "To Factory"){
                if(vm.userType == "factory" || vm.userType == "zone"){
                    return true;
                }
            }
            if(vm.orderStatus == "On production"){
                if(vm.userType == "factory" || vm.userType == "zone"){
                    return true;
                }
            }

            return false;
        }
        function allowUpdateProduct(){
            var userType = vm.userType;
            if(userType == "customer"){
                return false;
            }
            if(vm.orderStatus == "To Factory"){
                if(userType == "agent"){
                    return false;
                }
            }
            if(vm.orderStatus == "On production"){
                if(userType == "zone" || userType == "agent"){
                    return false;
                }
            }

            return true;
        }

        function isDisable(){
            var dis = allowUpdateOrder();
            if(dis == false){
                return 1;
            }else{
                return 0;
            }
        }

        function initVariable() {

            vm.conditions = null;
            vm.types = null;
            vm.payments = null;

        }

        function initOrderInfo() {
            getPayments()
                .then(function() {
                    return getConditions();
                })
                .then(function() {
                    return getTypes();
                })
                .then(function() {
                    orderDetailService.getOrderInfo(utils().http().queryString('orderId')).then(function(data) {
                        vm.order = data;
                        vm.orderStatus = utils().getOrderStatus(data.deliveryFactory.confirmationDate, data.deliveryZone.confirmationDate); 
                    });
                })
        }

        function updateOrder() {
            orderDetailService.editOrder(vm.order).then(function(result) {
                if (result.success === true) {
                    initOrderInfo();
                    utils().notification().showSuccess('Update order successfully');
                }
            });
        }

        function reload() {
            window.location.href = "/index.cfm/order.order-detail.cfm?orderId=" + utils().http().queryString('orderId');
        }

        function viewOrderList() {
            history.back();
        }

        function loadUI(userType) {
            showMainPage(userType);
            showProductsLine(userType);
        }

        function showMainPage(userType) {
            vm.mainDetailTpl = getTemplate(templates.orderDetail, userType);
        }

        function showProductsSize(userType) {
            console.log(userType);
            vm.activeTab = 1;
            vm.tplProducts = getTemplate(templates.size, userType);
        }

        function showProductsLine(userType) {
            vm.activeTab = 0;
            vm.tplProducts = getTemplate(templates.line, userType);
        }

        function reloadProductList(userType) {
            if (vm.activeTab === 0) {
                showProductsLine(userType);
            } else {
                showProductsSize(userType);
            }
        }

        function showAddProductPopup(userType) {
            vm.tplAddProduct = getTemplate(templates.addProduct, userType);
            $('#modalAddProduct').modal('show');
        }

        function editProduct(filter) {
            orderDetailService.getProductDetail(filter.id_order, filter.id_product, filter.priceList, filter.group, filter.is_size_custom).then(function(result) {
                if (null !== result) {
                    $scope.$parent.order.sizeType = result.sizeType;
                    $scope.$parent.order.group    = result.group;
                    $scope.$parent.order.id       = result.id;
                    $scope.$parent.order.orderItems  = result.orderItems;
                    $scope.$parent.order.product = result.product;                   
                    $scope.$parent.order.project = result.project;
                    $scope.$parent.vmOrderDetail.tplAddProduct = getTemplate(templates.editProduct, $scope.$parent.userType);
                    $scope.$apply();
                    $('#modalAddProduct').modal('show');
                } else {
                    utils().notification().showFail("Invalid Product");
                }

            });

        }

        function getTemplate(url, userType) {
            var version = "?v=" + Math.random();
            return url.format(userType) + version;
        }

        function toggle($event, targetElementId) {
            $($event.currentTarget).toggleClass("fa-plus fa-minus");
            $('#' + targetElementId).slideToggle(300);
        }

        function initDatePicker() {
            $("#orderDate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true
                    // showOn: 'both',
                    // buttonImageOnly: true, 
                    // buttonImage: 'http://jqueryui.com/resources/demos/datepicker/images/calendar.gif'
            });
            $("#orderDate").css({
                "background-color": "#fff"
            });


            $("#fac_confirmdate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true
            });
            $("#fac_confirmdate").css({
                "background": "url(../includes/img/calendar.gif) #fff",
                "background-position": "right",
                "background-repeat": "no-repeat"
            });

            $("#fac_deliverydate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true
            });
            $("#fac_deliverydate").css({
                "background": "url(../includes/img/calendar.gif) #fff",
                "background-position": "right",
                "background-repeat": "no-repeat"
            });

            $("#zone_confirmdate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true
            });
            $("#zone_confirmdate").css({
                "background": "url(../includes/img/calendar.gif) #fff",
                "background-position": "right",
                "background-repeat": "no-repeat"
            });

            $("#zone_deliverydate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true
            });
            $("#zone_deliverydate").css({
                "background": "url(../includes/img/calendar.gif) #fff",
                "background-position": "right",
                "background-repeat": "no-repeat"
            });

            $("#agent_deliverydate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true
            });
            $("#agent_deliverydate").css({
                "background": "url(../includes/img/calendar.gif) #fff",
                "background-position": "right",
                "background-repeat": "no-repeat"
            });
        }

        function getConditions() {
            return new Promise(function(resolve, reject) {
                orderDetailService.getConditions().then(function(data) {
                    vm.conditions = data;
                    resolve();
                })
            });

        }

        function getTypes() {
            return new Promise(function(resolve, reject) {
                orderDetailService.getTypes().then(function(data) {
                    vm.types = data;
                    resolve();
                });
            });

        }
       
        function getPayments() {
            return new Promise(function(resolve, reject) {
                orderDetailService.getPayments().then(function(data) {
                    vm.payments = data;
                    resolve();
                });
            });

        }

        $scope.formatNumberThousand = function(value, places) {
            return formatNumberThousand(value, places);
        };

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

    };


})();