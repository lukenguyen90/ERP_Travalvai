(function() {
    'use strict'
    angular
        .module('order.ctrls')
        .controller("ResumeCtrl", resumeCtrl);

    function resumeCtrl($q, $scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, $resource, orderListService) {
        var vm = this;
        //angular.extend(vm, $controller('OrderListCtrl', { $scope: $scope }));

        vm.removeVisibleHeader = removeVisibleHeader;
        vm.renderDetail = renderDetail;
        vm.renderActions = renderActions;
        vm.renderCachedFilter = renderCachedFilter;
        vm.getCachedData = getCachedData;

        $scope.viewOrderDetail = function(orderId) {
            window.location.href = "/index.cfm/order.order-detail?orderId=" + orderId;
        }

        $scope.deleteOrderResume = function(orderId) {
           orderListService.deleteOrder(orderId).then(function(result) {
                if (result.isDeleted === true) {
                     utils().notification().showSuccess("Delete order success!");
                    $scope.vmResume.instance.reloadData();
                }else{
                     utils().notification().showFail("Delete order failed!")
                }
            });
        }

        function renderCachedFilter() {
            var cachedData = getCachedData();
            if (cachedData) {
                window.setTimeout(function() {

                    $("#tbl-order-list-line thead tr:last-child").children('th').each(function(index) {
                        if (!$(this).is(':empty')) {
                            $(this).children().val(cachedData.columns[index].search.search);
                        }
                    });
                }, 100);
            }

        }

        function getCachedData() {
            var perform = performance.navigation.type;
            var localStorageKey = 'DataTables_tbl-order-list-resume_/index.cfm/order.order-list.cfm';
            if (perform === 0 || perform === 1) {
                $window.localStorage.removeItem(localStorageKey);
            }

            var cachedData = JSON.parse($window.localStorage.getItem(localStorageKey));

            return cachedData;
        }

        function removeVisibleHeader() {
            window.setTimeout(function() {
                $('#tbl-order-list-resume thead tr:last').children('th').each(function() {
                    if ($(this).is(':empty') && !$(this).hasClass('actions') && !$(this).hasClass('detail')) {
                        $(this).remove();
                    }
                });
            }, 100);

        }

        function renderDetail(data, type, full, meta) {
            return '<span class="txt-color-green btngotoplfdetail" title="Click to view order detail" ng-click="viewOrderDetail(' + data.id_order + ')">' +
                '<i class="ace-icon bigger-130 fa fa-sign-out"></i></span>';
        }

        function renderActions(data, type, full, meta) {
            var objData = JSON.stringify(data).toString();
            var orderStatus = utils().getOrderStatus(data.fty_confirm, data.zone_confirm);
            vm.isUpdate = utils().allowUpdateProduct(orderStatus, $scope.userType);
            if(vm.isUpdate == false)
                return "-";
            else
                return '<span class="txt-color-red btnDelete" title="Delete" ng-click="deleteOrderResume(' + data.id_order + ')" ng-confirm-message>' +
                    '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
                    '</span>';

        }




    };
})();