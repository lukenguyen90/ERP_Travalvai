(function() {
    angular.module('product.edit', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl", BindAngularDirectiveCtrl)

    function BindAngularDirectiveCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window) {
        var vm = this;
        vm.product_custom = {};
        var originalCus = angular.copy(vm.product_custom);
        vm.message = '';
        vm.plz_des = 'None';
        vm.addPrdCus = addPrdCus;
        vm.delete = deleteRow;
        vm.showAddNew = showAddNew;
        vm.refreshCus = refreshCus;
        vm.editProductCus = editProductCus;
        vm.deleteProductCus = deleteProductCus;
        vm.changePattern = changePattern;
        vm.backState = backState;
        vm.dtInstanceCus = {};
        vm.productCus = {};
        vm.refresh = refresh;
        vm.regex = "[a-z A-Z 0-9-\_\.]+";
        vm.regexNumber = /^[0-9]+(\.[0-9]{1,2})?$/;
        vm.prd = {};
        vm.prd.pr_comment = "";
        vm.prd.pr_commission = 0;
        vm.costsVS_CST = {};
        vm.saveProduct = saveProduct;
        vm.changePriceListZone = changePriceListZone;
        vm.changecost_season = changecost_season;
        vm.getCost_code_ajax = getCost_code_ajax;
        vm.getCost_version_ajax = getCost_version_ajax;
        vm.getCost_code_prd_cus = getCost_code_prd_cus;
        vm.onChangeFactoryPriceManual = onChangeFactoryPriceManual;
        vm.onChangeAgentPriceManual = onChangeAgentPriceManual;
        vm.onChangeFinalPriceManual = onChangeFinalPriceManual;
        vm.caculatorPrdCus = caculatorPrdCus;
        vm.onChangeFinalPriceClub = onChangeFinalPriceClub;
        vm.onChangeFinalPriceWeb = onChangeFinalPriceWeb;
        vm.changeCost_prdCus = changeCost_prdCus;
        vm.getFinalPrice = getFinalPrice;
        vm.isDisPriceCus = false;
        vm.isDisPriceQuantity = false;
        vm.isDisDescription = false;

        vm.contract = {};
        vm.plzId = 0;      


        getProductStatus().then(function(dataResponse) {
            vm.PrStts = dataResponse;
        });
        getPatterns().then(function(dataResponse) {
            vm.patterns = dataResponse;
        });

        getSizes().then(function(dataResponse) {
            vm.sizes = dataResponse;
        });

        getUserLevel().then(function(dataResponse) {
            vm.userInfo = dataResponse;
            if (vm.userInfo.TYPEUSER == 2) {
                $('#factoryPriceList').css("display", "none");
                $('#factoryPriceManual_Valid').css("display", "none");
                $("#plz_id_cus").parent().parent().removeClass('display-none');
            } else if (vm.userInfo.TYPEUSER == 3 || vm.userInfo.TYPEUSER == 4) {
                $('#factoryPriceList').css("display", "none");
                $('#agentPriceList').css("display", "none");
                $('#factoryPriceManual_Valid').css("display", "none");
                $('#agentPriceManual_Valid').css("display", "none");
                $("#plz_id_cus").parent().parent().removeClass('display-none');
            }
        });

        $scope.formatNumberThousand = function(value) {
            return formatNumberThousand(value, 2);
        }


        function getQueryVariable(variable) {
            var query = window.location.search.substring(1);
            var vars = query.split('&');
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split('=');
                if (decodeURIComponent(pair[0]) == variable) {
                    return decodeURIComponent(pair[1]);
                }
            }
        }

        //Pattern handler        
        function changePattern() {
            vm.prd.pattern_var = null;
            if ($("#pattern").val() != "") {
                $.ajax({
                    async: false,
                    type: 'POST',
                    url: '/index.cfm/product/getPatternVar',
                    data: {
                        id_pattern: $('#pattern').val()
                    },
                    success: function(data) {
                        if (data.length > 0) {
                            vm.pattern_vars = data;
                            vm.isDisabledPatVar = false;
                        } else {
                            noticeFailed("No pattern variations type for this pattern!");
                            vm.pattern_vars = "";
                        }
                    }

                });
            } else {
                vm.prd.pattern_var = "";
                vm.pattern_vars = [];
            }
        }
        //get pattern list

        function getPatterns() {
            return new Promise(function(resolve, reject) {
                $http.get("/index.cfm/product/getPatternList").success(function(dataResponse) {
                    resolve(dataResponse);
                });
            });
        }

        //get productStatus list
        function getProductStatus() {
            return new Promise(function(resolve, reject) {
                $http.get("/index.cfm/basicdata/getproductstatus").success(function(dataResponse) {
                    resolve(dataResponse);
                });
            });
        }

        //get sizes
        function getSizes() {
            return new Promise(function(resolve, reject) {
                $http.get("/index.cfm/product/getSizes").success(function(dataResponse) {
                    resolve(dataResponse);
                });
            });
        }
        //get user level
        function getUserLevel() {
            return new Promise(function(resolve, reject) {
                $http.get("/index.cfm/basicdata/getUserLevel").success(function(dataResponse) {
                    resolve(dataResponse);
                });
            });
        }


        function addPrdCus() {
            var id_prdcust = $("#id_prdcust").val();
            $.ajax({
                type: "POST",
                url: "/index.cfm/product/checkExistCusCode" + window.location.search,
                async: false,
                data: {
                    'cost_id': vm.product_custom.costsCSTid,
                    'cost_versionID': vm.product_custom.cvCSTid,
                    'id_prdcust': $('#id_prdcust').val()
                },
                success: function(data) {
                    var flag = data.exist;
                    if (!flag) {
                        $.ajax({
                            type: "POST",
                            url: "/index.cfm/product/addProdCus" + window.location.search,
                            async: false,
                            data: {
                                'cost_id': vm.product_custom.costsCSTid,
                                'cost_versionID': vm.product_custom.cvCSTid,
                                'quantity': vm.product_custom.quantity_cus,
                                'des': vm.product_custom.description_cus,
                                'id_prdcust': $('#id_prdcust').val(),
                                'id_plz': vm.plzId
                            },
                            success: function(data) {
                                if (data.success) {
                                    noticeSuccess(data.message);
                                    // vm.costsVS_CST = null;
                                    $scope.$applyAsync();
                                    vm.dtInstanceCus.reloadData();
                                    setTimeout(function() {
                                        $('#addNew').modal('hide');
                                    }, 1000);
                                } else {
                                    noticeFailed("Can not create this product custom");
                                }
                            }
                        });
                    } else {
                        $("#costsCST_Id").before('<p class="help-block noti_code" style="width: 400px !important;"><font color="red">Code, version have existed in systems!</p>');
                    }
                }
            });
            caculatorPrdCus();
        }

        function showAddNew() {
            refreshCus();
            $("p").css('display', 'none');
            getCost_code_prd_cus();
            // if(vm.costsCST.length >0){
            document.getElementById("titleID").innerHTML = "Create";
            $('#addNew').modal('show');
            // }
        }

        function refreshCus() {
            $("p").css('display', 'none');
            $('#plz_id_cus').removeAttr('readonly', true);
            $('#costsCST_Id').removeAttr('readonly', true);
            $('#cv_CST_id').removeAttr('readonly', true);
            $('#id_prdcust').val(0);
            $('#plz_id_cus').val('');
            $('#costsCST_Id').val('');
            $('#cv_CST_id').val('');
            vm.product_custom = angular.copy(originalCus);
            $("#cv_CST_id").parent().parent().addClass('display-none');
            $scope.productCustForm.$setPristine();
        }
        //table product cust
        vm.dtOptionsCus = DTOptionsBuilder.fromSource('/index.cfm/product.getProductCus' + window.location.search)
            .withOption('createdRow', createdRow)
            .withOption('order', [1, 'desc'])
            .withOption('searching', false)
            .withOption('paging', false)
            .withOption('select', { style: 'single' });
        vm.dtColumnsCus = [
            DTColumnBuilder.newColumn('cost_code').withTitle('COST CODE').withOption('width', "15%"),
            DTColumnBuilder.newColumn('id_prd_cust').withTitle('ID'),
            DTColumnBuilder.newColumn('cv_version').withTitle('VERSION').withOption('width', "10%"),
            DTColumnBuilder.newColumn('prd_cust_description').withTitle('DESCRIPTION').withOption('width', "58%"),
            DTColumnBuilder.newColumn('prd_cust_qtty').withTitle('QTTY').withOption('width', "10%"),
            DTColumnBuilder.newColumn(null).renderWith(actionsHtmlCus).notSortable().withOption('width', "7%")
        ];
        vm.dtColumnsCus[1].visible = false;

        loadProduct().then(function(dataResponse) {
            vm.pattern_vars = dataResponse.pattern_vars;
            vm.cost_vs = dataResponse.cvList;
            vm.prd = dataResponse;
            vm.plf_currency = dataResponse.plf_currency;
            vm.plz_currency = dataResponse.plz_currency;
            vm.contract = dataResponse.contract;
            vm.prd.contract = dataResponse.id_contract;
            vm.prd.pattern = dataResponse.pattern;
            vm.prd.plz_id = dataResponse.id_plz;
            vm.plzId = dataResponse.aPriceList[0].id_plz;
            vm.projects = dataResponse.aProject;
            vm.plz_id = dataResponse.aPriceList;
            vm.plz_des = dataResponse.aPriceList[0].des;
            vm.prd.project = dataResponse.project;

            getCost_code_ajax();
            getCost_version_ajax();
            vm.prd.cost = dataResponse.cost;
            vm.prd.cost_version = dataResponse.cost_version;
            caculatorPrdCus();
            vm.product_custom.plz_id = vm.plzId;
            $scope.$apply();
        });

        function loadProduct() {
            return new Promise(function(resolve, reject) {
                $http.get("/index.cfm/product/getProductById?id=" + getQueryVariable("id")).success(function(dataResponse) {
                    resolve(dataResponse);
                });
            });
        }

        function onChangeFactoryPriceManual() {
            getFinalPrice();
        }

        function onChangeAgentPriceManual() {
            getFinalPrice();
        }

        function onChangeFinalPriceManual() {
            getFinalPrice();
        }

        function onChangeFinalPriceClub() {
            getFinalPrice();
        }

        function onChangeFinalPriceWeb() {
            getFinalPrice();
        }

        function caculatorPrdCus() {
            $.ajax({
                url: "/index.cfm/product/caculatorPrdCus" + window.location.search,
                method: "POST",
                success: function(data) {
                    vm.prd.plFactoryCus = data.factoryPriceCus;
                    vm.prd.plZoneCus = data.agentPriceCus;
                    vm.prd.plFinalCus = data.finalPriceCus;
                    getFinalPrice();
                    $scope.$applyAsync();
                }
            });
        }


        function getFinalPrice() {
            $.ajax({
                url: "/index.cfm/product/getFinalPrice" + window.location.search,
                method: "POST",
                data: {
                    id_contract: vm.prd.contract,
                    plFactory: vm.prd.fty_sell_4,
                    plAgent: vm.prd.plzd_zone_sell_6,
                    plFinal: vm.prd.plzd_pvpr_8

                    ,
                    plFactoryManual: vm.prd.pr_fty_sell_9,
                    plAgentManual: vm.prd.pr_zone_sell_10,
                    plFinalManual: vm.prd.pr_pvpr_11

                    ,
                    plFactoryCus: vm.prd.plFactoryCus,
                    plAgentCus: vm.prd.plZoneCus,
                    plFinalCus: vm.prd.plFinalCus

                    ,
                    plClubManual: vm.prd.pr_club_12,
                    plWebManual: vm.prd.pr_web_13
                },
                success: function(data) {
                    vm.prd.pr_9_valid = data.factoryFinalPrice;
                    vm.prd.pr_10_valid = data.agentFinalPrice;
                    vm.prd.pr_11_valid = data.finalFinalPrice;
                    $scope.$applyAsync();
                }
            });
        }



        function getCost_code_ajax() {
            $.ajax({
                async: false,
                type: 'POST',
                url: '/index.cfm/product/getcost_code',
                data: {
                    plz_id: vm.prd.plz_id
                },
                success: function(data) {
                    if (data.length > 0) {
                        vm.costs = data;
                    } else {
                        var message = "No cost for this price list!";
                        if (data.message != null) {
                            message = data.message;
                        }
                        noticeFailed(message);
                    }
                }
            });
        }

        function getCost_version_ajax() {
            if (vm.prd.cost > 0) {
                $.ajax({
                    async: false,
                    type: 'POST',
                    url: '/index.cfm/product/getcost_version',
                    data: {
                        id_cost: vm.prd.cost
                    },
                    success: function(data) {
                        if (data.length > 0) {
                            vm.cost_vs = data;
                        } else {
                            noticeFailed("No cost version for this cost code!");
                        }
                    }
                });
            }
        }

        function changePriceListZone() {
            getCost_code_ajax();
            vm.prd.cost = "";
            vm.cost_vs = "";
        }

        function getCost_code_prd_cus() {
            $.ajax({
                async: false,
                type: 'POST',
                url: '/index.cfm/product/getcost_codePrdCus',
                data: {
                    plz_id: vm.plzId
                },
                success: function(data) {
                    if (data.length > 0) {
                        vm.costsCST = data;
                    } else {
                        $("#s2id_costsCST_Id").html("<label><font color='red'>Price List doesn't have any custom costing (CUS-)!</label>");
                        $("#s2id_plz_id_cus").html("<label class='control-label'>" + vm.plz_des + "</label>");
                        vm.isDisPriceQuantity = true;
                        vm.isDisDescription = true;
                    }
                }
            });
        }

        function changeCost_prdCus() {
            $('.noti_code').remove();
            $.ajax({
                url: "/index.cfm/product/getCostVerForPrdCus",
                method: "POST",
                data: {
                    cost_codeID: vm.product_custom.costsCSTid
                },
                success: function(data) {
                    if (data.length > 0) {
                        vm.costsVS_CST = data;
                        $("#cv_CST_id").parent().parent().removeClass('display-none');
                        $scope.$applyAsync();
                    } else {
                        $("#cv_CST_id").attr("disabled");
                        noticeFailed("No cost version for this cost code!");
                    }
                }
            });
        }

        function changecost_season() {
            vm.prd.cost_version = null;
            getCost_version_ajax();
        }


        $("#cost").change(function() {
            $.ajax({
                url: "/index.cfm/product/getcost_version",
                method: "POST",
                data: {
                    id_cost: $(this).val()
                },
                success: function(data) {
                    vm.cost_vs = data;
                }
            });
        });

        vm.fd = new FormData();

        $scope.uploadFileSketch = function(files) {
            //Take the first selected file
            vm.fd.append("pr_sketch", files[0]);
        };

        $scope.uploadFilePicture = function(files) {
            //Take the first selected file
            vm.fd.append("pr_picture", files[0]);
        };

        function saveProduct() {
            var creationDate = toDate(vm.prd.pr_date, "/");
            var updatedDate = toDate(vm.prd.pr_date_update, "/");
            vm.fd.append("pr_version", vm.prd.pr_version);
            vm.fd.append("pr_description", vm.prd.pr_description);
            vm.fd.append("pr_section", vm.prd.pr_section);
            vm.fd.append("pr_fty_sell_9", vm.prd.pr_fty_sell_9);
            vm.fd.append("pr_zone_sell_10", vm.prd.pr_zone_sell_10);
            vm.fd.append("pr_pvpr_11", vm.prd.pr_pvpr_11);
            vm.fd.append("pr_club_12", vm.prd.pr_club_12);
            vm.fd.append("pr_web_13", vm.prd.pr_web_13);
            vm.fd.append("pr_date", creationDate);
            vm.fd.append("pr_date_update", updatedDate);
            vm.fd.append("pr_web", vm.prd.pr_web);
            vm.fd.append("pr_9_valid", vm.prd.pr_9_valid);
            vm.fd.append("pr_10_valid", vm.prd.pr_10_valid);
            vm.fd.append("pr_11_valid", vm.prd.pr_11_valid);
            vm.fd.append("pr_comment", vm.prd.pr_comment);
            vm.fd.append("pr_commission", vm.prd.pr_commission);

            vm.fd.append("factory", vm.prd.id_Factory);
            vm.fd.append("project", vm.prd.project);
            vm.fd.append("pattern_var", vm.prd.pattern_var);
            vm.fd.append("pattern", vm.prd.pattern);
            vm.fd.append("product_status", vm.prd.product_status);
            vm.fd.append("cost", vm.prd.cost);
            vm.fd.append("cost_version", vm.prd.cost_version);
            vm.fd.append("size", vm.prd.sz);
            vm.fd.append("id_plz", vm.prd.plz_id);
            vm.fd.append("id_contract", vm.prd.contract);
            vm.fd.append('id_product', $('#product').val());

            $.ajax({
                type: "POST",
                url: "/index.cfm/product/editProduct",
                async: false,
                data: vm.fd,
                processData: false,
                contentType: false,
                success: function(data) {
                    if (data.success) {
                        loadProduct().then(function(dataResponse) {
                            vm.prd = dataResponse;
                            vm.prd.contract = dataResponse.id_contract;
                            vm.prd.plz_id = dataResponse.id_plz;
                            caculatorPrdCus();
                            $scope.$apply();
                            noticeSuccess(data.message);
                        });                       
                    } else {
                        noticeFailed(data.message);
                    }
                    vm.fd = null;
                    vm.fd = new FormData();
                }
            });

        }

        function backState() {
            history.back()
        }

        function createdRow(row, data, dataIndex) {
            // Recompiling so we can bind Angular directive to the DT
            $compile(angular.element(row).contents())($scope);
        }

        function editProductCus(array) {
            document.getElementById("titleID").innerHTML = "Edit";
            $("#btnRefresh").css('display', 'none');
            $('#addNew').modal('show');
            refreshCus();
            $('.noti_code').remove();
            $('#costsCST_Id').prop('readonly', true);
            $('#cv_CST_id').prop('readonly', true);
            $('#plz_id_cus').prop('readonly', true);
            $.ajax({
                type: "POST",
                url: "/index.cfm/product/editProductCus" + window.location.search,
                async: false,
                data: { 'id_prd_cust': array.id_prd_cust },
                success: function(data) {
                    $("#cv_CST_id").parent().parent().removeClass('display-none');
                    vm.product_custom.description_cus = data[0].description_cus;
                    vm.product_custom.quantity_cus = data[0].quantity_cus;
                    vm.product_custom.plz_id = data[0].id_plz;
                    tempcvCSTid = data[0].cvCSTid;
                    vm.product_custom.costsCSTid = data[0].costsCSTid;
                    vm.costsVS_CST[0] = { id_cost_version: array.id_cost_version, cv_version: array.cv_version };
                    window.setTimeout(function() {
                        vm.product_custom.cvCSTid = array.id_cost_version;
                        $scope.$applyAsync();
                    }, 200);
                    $('#id_prdcust').val(data[0].idprdcust);
                }
            });
        }

        function deleteRow(array) {
            $('#showDelete').modal('show');
            vm.did = array.id_prd_cust;
        }

        function deleteProductCus() {
            $.ajax({
                type: "POST",
                url: "/index.cfm/product/deleleProdCus" + window.location.search,
                async: false,
                data: { 'id_prdcust': vm.did },
                success: function(data) {
                    if (data.success) {
                        noticeSuccess(data.message);
                        refreshCus();
                        vm.dtInstanceCus.reloadData();
                        setTimeout(function() {
                            $('#showDelete').modal('hide');
                        }, 1000);
                    } else {
                        noticeFailed("Can not delete this product custom");
                    }
                }
            });
            caculatorPrdCus();
        }

        function actionsHtmlCus(data, type, full, meta) {
            vm.productCus[data.id_prd_cust] = data;
            return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.editProductCus(showCase.productCus[' + data.id_prd_cust + '])">' +
                '<i class="ace-icon bigger-130 fa fa-pencil"></i></span></a>' +
                '<span class="txt-color-red btndelete" title="Delete product custom" ng-click="showCase.delete(showCase.productCus[' + data.id_prd_cust + '])">' +
                '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
        }

        function refresh() {
            $('#id_Status').val(0);
            vm.user = angular.copy(original);
            $scope.userForm.$setPristine();
        }

        return vm;

    };

})();