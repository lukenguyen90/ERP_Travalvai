(function() {
    'use strict';

    angular
        .module("shipment.ctrls")
        .controller('SizeNameNumberCtrl', sizeNameNumberCtrl);

    function sizeNameNumberCtrl($scope, $filter, $http, $compile, $window, $timeout, $controller, models, productService) {
        var vm = this;
        $scope.formValid = false;
        vm.size = null;
        vm.tplInput = "";
        vm.listSize = [];
        vm.totalSizeQuantity = 0;
        vm.inputType = {
            manual: 0,
            csv: 1
        }

        var templates = {
            manual: "../../views/shipment/client/product/views/size-detail-manual.view.html",
            csv: "../../views/shipment/client/product/views/size-detail-csv.view.html"
        }

        //Export Function
        vm.initSizeNumer = initSizeNumer;
        vm.addSize = addSize;
        vm.upateSizeSummary = upateSizeSummary;
        vm.hasSizeDetail = hasSizeDetail;
        vm.deleteSize = deleteSize;
        vm.changeInputType = changeInputType;

        function initSizeNumer() {
            angular.extend(vm, $controller('ProductCtrl', { $scope: $scope }));
            vm.shipment = $scope.$parent.vmproduct.shipment;
            vm.product = $scope.$parent.vmproduct.product;
            changeInputType(vm.inputType.manual);
            initCsv();
        }

        function initCsv() {
            vm.csv = {

                content: null,

                header: true,

                headerVisible: true,

                separator: ',',

                separatorVisible: true,

                result: null,

                encoding: 'UTF-8',

                encodingVisible: true,
                accept: ".csv",

                callBack: updateSizeFromExcel

            };
        }

        function addSize() {

            var size = {
                id_size: vm.size.code.id_size,
                id_size_det: vm.size.code.id_size_det,
                name: vm.size.name,
                number: vm.size.number,
                quantity: vm.size.quantity,
                szd_position: vm.size.code.szd_position,
                szd_size: vm.size.code.szd_size,
            }
            vm.listSize.push(size);
            updateTotalSizeQuantity(size.quantity);
            upateSizeSummary();
            resetValue();
        }

        function getTemplate(inputType) {
            var template = (inputType === vm.inputType.manual) ? templates.manual : templates.csv;
            var version = "?v=" + Math.random();
            return template + version;

        }


        function changeInputType(inputType) {
            resetSizeDetailList();
            vm.tplInput = getTemplate(inputType);
        }

        function resetUploadedFile() {
            vm.tplInput = getTemplate(vm.inputType.csv);
        }

        function hasSizeDetail() {
            if (vm.size === null || typeof(vm.size.code) === 'undefined' || vm.size.code.length === 0)
                return false;
            return true;
        }

        function resetValue() {
            vm.size = {};
        }

        function resetSizeDetailList() {
            vm.listSize = [];
            vm.totalSizeQuantity = 0;
            $scope.$parent.resetSizeDetail();
            $scope.$parent.resetPrice();
        }

        function updateTotalSizeQuantity(quantity) {
            vm.totalSizeQuantity += parseInt(quantity);
        }

        function upateSizeSummary() {
            var sizeMemo = {
                id_size: 0,
                id_size_det: 0,
                name: "",
                number: "",
                quantity: 0,
                szd_position: 0,
                szd_size: "",
            }
            var units = 0;

            angular.forEach(vm.product.sizesDetail, function(sizeDetail, key) {
                var sizes = _.filter(vm.listSize, { 'id_size_det': sizeDetail.id_size_det });
                if (sizes.length > 0) {
                    sizeDetail.quantity = calcTotalQuantity(sizes);
                    units += sizeDetail.quantity;
                }
            });

            vm.product.units = formatNumberThousand(units);
            vm.product.price.grandTotal = $scope.$parent.calculateGrandTotal(units);
            vm.shipment.product.sizesDetail = angular.copy(vm.listSize);

        }

        function updateSizeFromExcel() {
            if (vm.csv.result !== null && vm.csv.result.length > 0) {
                //read data from csv
                //reset current list 
                resetSizeDetailList();

                var totalItems = vm.csv.result.length;
                var arrayErrImport = [];
                //loop through each item to add additional size's information
                for (var i = 0; i < totalItems; i++) {
                    var sizeDetail = angular.copy(vm.csv.result[i]);
                    var status = true;
                    var k = i+2;
                    var msg ="";
                    var sizep = _.filter(vm.product.sizesDetail, { 'szd_size': sizeDetail.size.toUpperCase()});
                    if(!$.isNumeric(sizeDetail.number) && !$.isNumeric(sizeDetail.quantity)){
                        msg = "Row: "+k+" Columns: Number, Quantity";
                        status = false;
                    }else if(!$.isNumeric(sizeDetail.number)){
                        msg = "Row: "+k+" Columns: Number";
                        status = false;
                    }else if(!$.isNumeric(sizeDetail.quantity)){
                        msg = "Row: "+k+" Columns: Quantity";
                        status = false;
                    }
                    if(sizep.length == 0){
                        status = false;
                        if(msg.length > 0){
                            msg += ", Size ";
                        }else{
                            msg = "Row: "+k+" Columns: Size";
                        }
                    }

                    if(status){
                        //get size's information from vm.product.sizesDetail
                        var productSizes = _.filter(vm.product.sizesDetail, { 'szd_size': sizeDetail.size.toUpperCase()});
                        if (productSizes.length > 0) {
                            var productSize = productSizes[0];
                            sizeDetail.szd_size = sizeDetail.size;
                            sizeDetail.id_size = productSize.id_size;
                            sizeDetail.id_size_det = productSize.id_size_det;
                            sizeDetail.szd_position = productSize.szd_position;

                            //update total quantity
                            updateTotalSizeQuantity(sizeDetail.quantity);

                            //add upadated item to vm.listSize
                            vm.listSize.push(sizeDetail);
                        }
                    }else{
                        msg += " invalid";
                        arrayErrImport.push(msg);
                    }
                    
                }
                $scope.$parent.$parent.vmshipmentDetail.arrErrCSV = arrayErrImport;
                $('#errorImportCSV').modal('show');
                upateSizeSummary();
                //execute updateSizeFromExcel() to update size summary
                resetUploadedFile();
                $scope.$apply();
            }
        }

        function deleteSize(size) {
            //remove item of import excel
            //remove item of munual input
            var index = vm.listSize.indexOf(size);
            vm.listSize.splice(index, 1);
            $scope.$parent.resetSizeDetail();
            upateSizeSummary();
            updateTotalSizeQuantity(-parseInt(size.quantity));
        }

        function updateAfterImport() {
            angular.forEach(vm.listSize, function(sizeDetail, key) {
                var sizes = _.filter(vm.listSize, { 'id_size_det': sizeDetail.id_size_det });
                if (sizes.length > 0) {
                    sizeDetail.quantity = calcTotalQuantity(sizes);
                    units += sizeDetail.quantity;
                }
            });
        }

        function calcTotalQuantity(sizes) {
            var totalQuantity = 0;
            if (sizes.length == 0)
                return totalQuantity;

            angular.forEach(sizes, function(value, key) {
                totalQuantity += parseInt(value.quantity);
            })

            return totalQuantity;
        }

    }

})();