(function() {
    'use strict'
    angular
        .module('shipment.ctrls')
        .controller("EditBoxCtrl", addBoxCtrl);

    function addBoxCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, models, EditBoxService, DatatableBoxCtrl) {
        var vm = this;
        angular.extend(vm, $controller('BoxListCtrl', { $scope: $scope }));

        //expose function to view
        vm.init = init;
        vm.showAddBox   = showAddBox;
        vm.editBox      = editBox;


        //Initiate controller
        function init() {
            getTypePox();
        }

       
        function showAddBox(){
            if(vm.box.type_box === null || vm.box.bx_weight === null || vm.box.bx_weight === ""){
                return true;
            }else{
                var leng_box = vm.box.bx_weight.toString().length;
                var lastChar = vm.box.bx_weight.toString().substr(vm.box.bx_weight.length - 1);
                if($.isNumeric(lastChar) == false && leng_box == 1){
                    return true;
                }
            }
            return false;
        }

        function getTypePox() {
            EditBoxService.getTypeBox().then(function(data) {
                vm.type_box = data;                
                vm.box = $scope.$parent.vm.box;
            });
        }


        function editBox() {
            EditBoxService.editBox(vm.box).then(function(result) {
                $('#modalEditBox').modal('hide');
                if (result.isEdit == true){
                    utils().notification().showSuccess("Edit box success!");
                    $scope.$parent.reloadBoxList();
                }else{
                    utils().notification().showFail("Edit box failed!");
                }
            });
        }


    };
})();