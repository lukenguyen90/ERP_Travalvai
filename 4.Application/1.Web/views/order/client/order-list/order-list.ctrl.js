(function() {
    'use strict'
    angular
        .module('order.ctrls')
        .controller("OrderListCtrl", orderLisCtrl);

    function orderLisCtrl($state, $q,
        $scope, $filter, $http,
        $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout,
        $controller, $resource, orderListService) {

        var vm = this;
        var templates = {
            line:       "../../views/order/client/order-list/line/views/{0}.view.html",
            resume:     "../../views/order/client/order-list/resume/views/{0}.view.html",
            addOrder:   "../../views/order/client/add-order/views/add-order-{0}.view.html",
            addProduct: "../../views/order/client/product/views/product-{0}.view.html"
        }

        $scope.userId = 0;
        $scope.userTypeId = "";

        vm.init = init;
        vm.order = null;

        vm.showAddOrderPopup = $scope.showAddOrderPopup = showAddOrderPopup;
        vm.showAddProductPopup = $scope.showAddProductPopup = showAddProductPopup;
        vm.showOrderListLines = $scope.showOrderListLines = showOrderListLines;
        vm.showOrderListResume = $scope.showOrderListResume = showOrderListResume;

        function init(userType, userTypeId) {
            if (userType.length === 0) {
                window.location.href = window.location.href;
            } else {
                initVariable(userType, userTypeId);
                showOrderListLines(userType);
            }
        }

        function initVariable(userType, userTypeId) {
            $scope.userTypeId = userTypeId;
            $scope.userType = userType;
            vm.tplOrderList = "";
        }


        function showAddOrderPopup(userType) {
            vm.tplAddOrder = getTemplate(templates.addOrder, userType);
            $('#modalAddOrder').modal('show');
        }

        function showAddProductPopup(userType) {
            vm.tplAddProduct = getTemplate(templates.addProduct, userType);
            $('#modalAddOrder').modal('hide');
            $('#modalAddProduct').modal('show');
        }


        /**
         * generate template according to user type
         * 
         * @param {any} userType: 'factory', 'zone', 'agent', 'customer'
         */
        function showOrderListLines(userType) {
            var template = getTemplate(templates.line, userType);
            vm.tplOrderList = template;
        }

        function showOrderListResume(userType) {
            var template = getTemplate(templates.resume, userType);
            vm.tplOrderList = template;
        }

        function getTemplate(url, userType) {
            var version = "?v=" + Math.random() + "&userId=" + 1;
            return url.format(userType) + version;
        }

    };

})();