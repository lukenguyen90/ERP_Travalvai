(function() {
    'use strict'
    angular
        .module('shipment.ctrls')
        .controller("BoxListCtrl", BoxListCtrl);

    function BoxListCtrl($state, $q,
        $scope, $filter, $http,
        $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout,
        $controller, $resource, BoxListService, DatatableBoxCtrl, models) {
        
        var vm = this;
        vm.filter = {};
        $scope.dtInstance = vm.dtInstance = {};
        $scope.dtOptions = vm.dtOptions = {};
        $scope.dtColumns = vm.dtColumns = [];


        var templates = {
            addBox: "../../views/shipment/client/box-list/add-box/views/add-box.view.html",
            editBox: "../../views/shipment/client/box-list/edit-box/views/edit-box.view.html"
        };

        $scope.userId = 0;
        $scope.userTypeId = "";

        vm.init = init;
        vm.box = angular.copy(models.box); ;

        vm.showAddBoxPopup = $scope.showAddBoxPopup = showAddBoxPopup;
        vm.loadBox = loadBox;
        vm.editBox = editBox;
        vm.deleteBox = deleteBox;

        $scope.reloadBoxList = reloadBoxList;

        function init(userType, userTypeId) {
            if (userType.length === 0) {
                window.location.href = window.location.href;
            } else {
                initVariable(userType, userTypeId);
                loadBox();
            }
        }

        function initVariable(userType, userTypeId) {
            $scope.userTypeId = userTypeId;
            $scope.userType = userType;
        }

        function loadDefaultTab(userType) {
            vm.tplTab = getTemplate(templates.tab, userType);
        }

        function loadBox() {
            vm.dtOptions = DatatableBoxCtrl.getOptions(DTOptionsBuilder, $scope);
            vm.dtColumns = DatatableBoxCtrl.getColumnsDef(DTColumnBuilder);
        }

        function reloadBoxList(){           
            $scope.vm.dtInstance.reloadData();
        }

        function showAddBoxPopup(userType) {
            vm.tplAddBox = getTemplate(templates.addBox, userType);
            $('#modalAddBox').modal('show');
        }

        function getTemplate(url, userType) {
            var version = "?v=" + Math.random() + "&userId=" + 1;
            return url.format(userType) + version;
        }
        function editBox(data){
            vm.box.id_box = data.id_box;
            vm.box.type_box.id_type_box = data.id_type_box;
            vm.box.type_box.tb_description = data.tb_description;
            vm.box.bx_weight = data.bx_weight;
            vm.tplEditBox = getTemplate(templates.editBox, $scope.userType);
            $('#modalEditBox').modal('show');
        }

        function deleteBox(id_box){
            var check = confirm("Are you sure want to delete?");
            if(check){
                BoxListService.deleteBox(id_box).then(function(result) {
                    if (result.isDeleted === true) {
                        utils().notification().showSuccess("Delete box success!");
                        reloadBoxList();
                    }else{
                        utils().notification().showFail("Delete box failed!")
                    }
                });
            }
        }

    }

})();