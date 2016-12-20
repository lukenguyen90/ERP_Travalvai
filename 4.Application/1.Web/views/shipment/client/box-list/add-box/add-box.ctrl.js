(function() {
    'use strict'
    angular
        .module('shipment.ctrls')
        .controller("AddBoxCtrl", addBoxCtrl);

    function addBoxCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, models, AddBoxService, DatatableBoxCtrl) {
        var vm = this;
        angular.extend(vm, $controller('BoxListCtrl', { $scope: $scope }));

        //expose function to view
        vm.init = init;
        vm.showAddBox = showAddBox;
        vm.createBox  = createBox;


        //Initiate controller
        //Define functions
        function init() {
            initVariable(); 
            getTypePox();
        }

        function initVariable() {
            vm.box = angular.copy(models.box);           
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
            AddBoxService.getTypeBox().then(function(data) {
                vm.type_box = data;
            });
        }


        
        function createBox() {
            AddBoxService.createBox(vm.box).then(function(result) {
                $('#modalAddBox').modal('hide');
                if (result.success == true){
                    utils().notification().showSuccess("Add box success!");
                    $scope.$parent.reloadBoxList();
                }else{
                    utils().notification().showFail("Add box failed!");
                }

            });
        }


    };
})();