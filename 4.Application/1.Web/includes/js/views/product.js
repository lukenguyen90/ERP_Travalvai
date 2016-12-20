(function() {
    angular.module('product.List', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl", BindAngularDirectiveCtrl)

    function BindAngularDirectiveCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window) {
        var vm = this;
        vm.message = '';
        vm.addNewProduct = addNewProduct;
        vm.deleteProduct = deleteProduct;
        vm.deleteRow = deleteRow;
        vm.doubleclickHandler = doubleclickHandler;
        vm.showModalAddNew = showModalAddNew;
        vm.showModalEditProduct = showModalEditProduct;
        vm.saveUpdateProduct = saveUpdateProduct;
        vm.goToDetail = goToDetail;
        vm.refresh = refresh;
        vm.dtInstance1 = {};
        vm.dtInstance2 = {};
        vm.dtInstance3 = {};
        vm.regex = "[a-z A-Z 0-9-\_\.]+";
        vm.isDisabledVer = true;
        vm.isDisabledPatVar = true;
        vm.changecost_season = changecost_season;
        vm.changepattern = changepattern;
        vm.getPrdType = getPrdType;
        // vm.changePriceListZone 	 = changePriceListZone;
        vm.changeZone = changeZone;
        vm.changeAgent = changeAgent;
        vm.changeCustomer = changeCustomer;
        vm.user = [];
        vm.zoneRequired = true;
        vm.agentRequired = true;
        var original = angular.copy(vm.user);
        vm.plz = { 'des': 'None' };
        vm.isFullEdit = false;
        vm.prd = {};

        $.ajax({
            async: false,
            type: 'GET',
            url: '/index.cfm/basicdata/getUserLevel',
            success: function(data) {
                //callback
                vm.userInfo = data;
                if (vm.userInfo.TYPEUSER == 1) {
                    $('#divTagZone').removeClass('display-none');
                    $('#divTagAgent').removeClass('display-none');
                    $http.get("/index.cfm/product/getZone").success(function(dataResponse) {
                        vm.zone = dataResponse;
                    });
                } else if (vm.userInfo.TYPEUSER == 2) {
                    vm.zoneRequired = false;
                    $('#divTagAgent').removeClass('display-none');
                    $http.get("/index.cfm/product/getAgent").success(function(dataResponse) {
                        vm.agent = dataResponse;
                    });
                } else if (vm.userInfo.TYPEUSER == 3) {
                    vm.zoneRequired = false;
                    vm.agentRequired = false;
                    $http.get("/index.cfm/product/getplz_id").success(function(dataResponse) {
                        vm.plz = dataResponse.priceList;
                        vm.projects = dataResponse.project;
                    });
                }
            }
        });

        getPatterns().then(function(dataResponse) {
            vm.patterns = dataResponse;
        });
        getSizes().then(function(dataResponse) {
            vm.sizes = dataResponse;
        });
        //get pattern list

        function getPatterns() {
            return new Promise(function(resolve, reject) {
                $http.get("/index.cfm/product/getPattern").success(function(dataResponse) {
                    resolve(dataResponse);
                });
            });
        }

        function getSizes() {
            return new Promise(function(resolve, reject) {
                $http.get("/index.cfm/product/getSizes").success(function(dataResponse) {
                    resolve(dataResponse);
                });
            });
        }

        vm.dtOptionsTextViewTable = DTOptionsBuilder.fromSource('/index.cfm/product/getProduct')
            .withPaginationType('full_numbers')
            .withLightColumnFilter({
                '0': {
                    type: 'text'
                },
                '1': {
                    type: 'text'
                },
                '2': {
                    type: 'text'
                },
                '3': {
                    type: 'text'
                },
                '4': {
                    type: 'text'
                },
                '5': {
                    type: 'text'
                },
                '6': {
                    type: 'text'
                },
                '7': {
                    type: 'text'
                },
                '8': {
                    type: 'text'
                },
                '9': {
                    type: 'text'
                },
                '10': {
                    type: 'text'
                },
                '11': {
                    type: 'text'
                },
                '12': {
                    type: 'text'
                },
                '13': {
                    type: 'text'
                },
                '14': {
                    type: 'text'
                },
                '15': {
                    type: 'text'
                }
            })
            .withOption('createdRow', createdRow)
            .withOption('select', { style: 'single' });

        vm.dtColumnsTextViewTable = [
            DTColumnBuilder.newColumn('IDPRODUCT').withTitle('PRODUCT'),
            DTColumnBuilder.newColumn('GARMENTCODE').withTitle('GARMENT').renderWith(GarmentDisplay),
            DTColumnBuilder.newColumn('COST_CODE').withTitle('COSTING').renderWith(CostingverDisplay),
            DTColumnBuilder.newColumn('DESCRIPTION').withTitle('DESCRIPTION'),
            DTColumnBuilder.newColumn('SIZES').withTitle('SIZES'),
            DTColumnBuilder.newColumn('ZONE').withTitle('ZONE'),
            DTColumnBuilder.newColumn('AGENT').withTitle('AGENT'),
            DTColumnBuilder.newColumn('CUSTOMER').withTitle('CUSTOMER'),
            DTColumnBuilder.newColumn('SECTION').withTitle('SECTION'),
            DTColumnBuilder.newColumn('STATUS').withTitle('STATUS'),
            DTColumnBuilder.newColumn('PR_WEB').withTitle('WEB'),
            DTColumnBuilder.newColumn(null).withTitle('CONTRACT').renderWith(renderContract).withOption('width', "4%").withClass("text-center").notSortable(),
            DTColumnBuilder.newColumn(null).withTitle('DETAIL').renderWith(actionsHtmlDetail).withOption('width', "4%").withClass("text-center").notSortable(),
            DTColumnBuilder.newColumn(null).withTitle('ACTIONS').renderWith(actionsHtml).notSortable()
        ];
        function renderContract(data, type, full, meta) {
            return '<span style="color: '+full.CONTRACTSTATUSCOLOR+';">' +full.CONTRACTDATE+full.CONTRACTYEAR+ '</span>';
        }
        if (vm.userInfo.TYPEUSER == 4) {
            vm.dtColumnsTextViewTable[12].visible = false;
            vm.dtColumnsTextViewTable[13].visible = false;
            //delete last column when hidden ID column by add filter
            window.setTimeout(function() {
                $("#textviewTable thead tr:last-child th:last-child").remove();
            }, 200);
            window.setTimeout(function() {
                $("#textviewTable thead tr:last-child th:last-child").remove();
            }, 200);
        }
        vm.dtColumnsTextImagesViewTable = [
            DTColumnBuilder.newColumn('IDPRODUCT').withTitle('PRODUCT'),
            DTColumnBuilder.newColumn('GARMENTCODE').withTitle('GARMENT').renderWith(GarmentDisplay),
            DTColumnBuilder.newColumn('COST_CODE').withTitle('COSTING').renderWith(CostingverDisplay),
            DTColumnBuilder.newColumn('DESCRIPTION').withTitle('DESCRIPTION'),
            DTColumnBuilder.newColumn('SIZES').withTitle('SIZES'),
            DTColumnBuilder.newColumn('ZONE').withTitle('ZONE'),
            DTColumnBuilder.newColumn('AGENT').withTitle('AGENT'),
            DTColumnBuilder.newColumn('CUSTOMER').withTitle('CUSTOMER'),
            DTColumnBuilder.newColumn('SECTION').withTitle('SECTION'),
            DTColumnBuilder.newColumn('STATUS').withTitle('STATUS'),
            DTColumnBuilder.newColumn('PR_WEB').withTitle('WEB'),
            DTColumnBuilder.newColumn('SKETCH').withTitle('SKETCH').renderWith(sketchDisplayTextImages),
            DTColumnBuilder.newColumn('PICTURE').withTitle('PICTURE').renderWith(sketchPictureTextImages),
            DTColumnBuilder.newColumn(null).withTitle('CONTRACT').renderWith(renderContract).withOption('width', "4%").withClass("text-center").notSortable(),
            DTColumnBuilder.newColumn(null).withTitle('DETAIL').renderWith(actionsHtmlDetail).withOption('width', "4%").withClass("text-center").notSortable(),
            DTColumnBuilder.newColumn(null).withTitle('ACTIONS').renderWith(actionsHtml).notSortable()
        ];
        if (vm.userInfo.TYPEUSER == 4) {
            vm.dtColumnsTextImagesViewTable[14].visible = false;
            vm.dtColumnsTextImagesViewTable[15].visible = false;
            //delete last column when hidden ID column by add filter
            window.setTimeout(function() {
                $("#textimagesviewTable thead tr:last-child th:last-child").remove();
            }, 200);
            window.setTimeout(function() {
                $("#textimagesviewTable thead tr:last-child th:last-child").remove();
            }, 200);
        }
        
        vm.dtColumnsTextPricesViewTable = [
            DTColumnBuilder.newColumn('IDPRODUCT').withTitle('PRODUCT'),
            DTColumnBuilder.newColumn('GARMENTCODE').withTitle('GARMENT').renderWith(GarmentDisplay),
            DTColumnBuilder.newColumn('COST_CODE').withTitle('COSTING').renderWith(CostingverDisplay),
            DTColumnBuilder.newColumn('DESCRIPTION').withTitle('DESCRIPTION'),
            DTColumnBuilder.newColumn('CUSTOMER').withTitle('CUSTOMER'),
            DTColumnBuilder.newColumn('STATUS').withTitle('STATUS'),
            DTColumnBuilder.newColumn('PR_WEB').withTitle('WEB'),
            DTColumnBuilder.newColumn('PRICE').withTitle('PRICE LIST').renderWith(priceDisplay).withClass('text-right  th-align-left'),
            DTColumnBuilder.newColumn('MANUAL').withTitle('MANUAL').renderWith(manualDisplay).withClass('text-right  th-align-left'),
            DTColumnBuilder.newColumn('CUSTOMIZE').withTitle('CUSTOM').renderWith(customizeDisplay).withClass('text-right  th-align-left'),
            DTColumnBuilder.newColumn('VALID').withTitle('FINAL').renderWith(validDisplay).withClass('text-right  th-align-left'),
            DTColumnBuilder.newColumn('CLUB_12').withTitle('PRICE CLUB').renderWith(priceClubDisplay).withClass('text-right  th-align-left'),
            DTColumnBuilder.newColumn('WEB_13').withTitle('PRICE WEB').renderWith(priceWebDisplay).withClass('text-right  th-align-left'),
            DTColumnBuilder.newColumn('SKETCH').withTitle('SKETCH').renderWith(sketchDisplayPriceView),
            DTColumnBuilder.newColumn('PICTURE').withTitle('PICTURE').renderWith(sketchPicturePriceView),
            DTColumnBuilder.newColumn(null).withTitle('CONTRACT').renderWith(renderContract).withOption('width', "4%").withClass("text-center").notSortable(),
            DTColumnBuilder.newColumn(null).withTitle('DETAIL').renderWith(actionsHtmlDetail).withOption('width', "4%").withClass("text-center").notSortable(),
            DTColumnBuilder.newColumn(null).withTitle('ACTIONS').renderWith(actionsHtmlFull).notSortable()
        ];
        if (vm.userInfo.TYPEUSER == 4) {
            vm.dtColumnsTextPricesViewTable[16].visible = false;
            vm.dtColumnsTextPricesViewTable[17].visible = false;
            //delete last column when hidden ID column by add filter
            window.setTimeout(function() {
                $("#pricesviewTable thead tr:last-child th:last-child").remove();
            }, 200);
            window.setTimeout(function() {
                $("#pricesviewTable thead tr:last-child th:last-child").remove();
            }, 200);
        }

        function CostingverDisplay(data, type, full, meta) {
            return full.COST_CODE + " - " + full.COST_CODE_VERS;
        }

        function GarmentDisplay(data, type, full, meta) {
            return full.GARMENTCODE + " - v" + full.VERSION;
        }

        function sketchDisplayTextImages(data, type, full, meta) {
            return '<a rel="lightbox-mygallery-textimages-sketch' + full.IDPRODUCT + '" href="/includes/img/ao/' + data + '" title="' + full.IDPRODUCT + '">\
                           <img src="/includes/img/ao/' + data + '" alt="' + full.IDPRODUCT + '" height="auto" width="80px">\
                    </a>';
        }

        function sketchPictureTextImages(data, type, full, meta) {
            return '<a rel="lightbox-mygallery-textimages-picture' + full.IDPRODUCT + '" href="/includes/img/ao/' + data + '" title="' + full.IDPRODUCT + '">\
                           <img src="/includes/img/ao/' + data + '" alt="' + full.IDPRODUCT + '" height="auto" width="80px">\
                    </a>';
        }

        function sketchPicturePriceView(data, type, full, meta) {
            return '<a rel="lightbox-mygallery-priceview-picture' + full.IDPRODUCT + '" href="/includes/img/ao/' + data + '" title="' + full.IDPRODUCT + '">\
                           <img src="/includes/img/ao/' + data + '" alt="' + full.IDPRODUCT + '" height="auto" width="80px">\
                    </a>';
        }

        function sketchDisplayPriceView(data, type, full, meta) {
            return '<a rel="lightbox-mygallery-priceview-sketch' + full.IDPRODUCT + '" href="/includes/img/ao/' + data + '" title="' + full.IDPRODUCT + '">\
                           <img src="/includes/img/ao/' + data + '" alt="' + full.IDPRODUCT + '" height="auto" width="80px">\
                    </a>';
        }

        function goToDetail(productID) {
            window.location.href = "/index.cfm/product.edit?id=" + productID;
        }

        function actionsHtmlDetail(data, type, full, meta) {
            return '<span class="txt-color-green btngotodetail" title="Go to product detail" ng-click="showCase.goToDetail(' + data.IDPRODUCT + ')">' +
                '<i class="ace-icon bigger-130 fa fa-sign-out"></i></span>';
        }

        function priceDisplay(data, type, full, meta) {
            if (vm.userInfo.TYPEUSER == 1 || vm.userInfo.TYPEUSER == 0 || vm.userInfo.TYPEUSER == 2) {
                return '<span style="minheight:50px;">' + $filter("number")(data.sell_4, 2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.sell_6, 2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.pvpr_8, 2) + '</span>';
            } else if (vm.userInfo.TYPEUSER == 3) {
                return '</span><span style="minheight:50px;">' + $filter("number")(data.sell_6, 2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.pvpr_8, 2) + '</span>';
            } else {
                return '<span style="minheight:50px;">' + $filter("number")(data.pvpr_8, 2) + '</span>';
            }
        }

        function priceClubDisplay(data, type, full, meta) {
            return '<span style="minheight:50px;">' + $filter("number")(data, 2) + '</span>';
        }

        function priceWebDisplay(data, type, full, meta) {
            return '<span style="minheight:50px;">' + $filter("number")(data, 2) + '</span>';
        }

        function customizeDisplay(data, type, full, meta) {
            if (vm.userInfo.TYPEUSER == 1 || vm.userInfo.TYPEUSER == 0 || vm.userInfo.TYPEUSER == 2) {
                return '<span style="minheight:50px;">' + $filter("number")(data.cst_fty, 2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.cst_zone, 2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.cst_cs, 2) + '</span>';
            } else if (vm.userInfo.TYPEUSER == 3) {
                return '</span><span style="minheight:50px;">' + $filter("number")(data.cst_zone, 2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.cst_cs, 2) + '</span>';
            } else {
                return '<span style="minheight:50px;">' + $filter("number")(data.cst_cs, 2) + '</span>';
            }

        }

        function manualDisplay(data, type, full, meta) {
            if (vm.userInfo.TYPEUSER == 1 || vm.userInfo.TYPEUSER == 0 || vm.userInfo.TYPEUSER == 2) {
                return '<span style="minheight:50px;">' + $filter("number")(data.sell_9, 2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.sell_10, 2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.pvpr_11, 2) + '</span>';
            } else if (vm.userInfo.TYPEUSER == 3) {
                return '</span><span style="minheight:50px;">' + $filter("number")(data.sell_10, 2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.pvpr_11, 2) + '</span>';
            } else {
                return '<span style="minheight:50px;">' + $filter("number")(data.pvpr_11, 2) + '</span>';
            }
        }

        function validDisplay(data, type, full, meta) {
            if (vm.userInfo.TYPEUSER == 1 || vm.userInfo.TYPEUSER == 0 || vm.userInfo.TYPEUSER == 2) {
                return '<span style="minheight:50px;">' + $filter("number")(data.valid9, 2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.valid10, 2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.valid11, 2) + '</span>';
            } else if (vm.userInfo.TYPEUSER == 3) {
                return '</span><span style="minheight:50px;">' + $filter("number")(data.valid10, 2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.valid11, 2) + '</span>';
            } else {
                return '<span style="minheight:50px;">' + $filter("number")(data.valid11, 2) + '</span>';
            }
        }

        function actionsHtml(data, type, full, meta) {
            if (vm.userInfo.TYPEUSER != 4) {
                return '<span class="txt-color-red btndelete" title="Delete product" ng-click="showCase.deleteRow(' + full.IDPRODUCT + ')">' +
                    '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
            } else {
                return '';
            }
            // '<span class="txt-color-green btnedit" title="Edit product" ng-click="showCase.showModalEditProduct(' + full.IDPRODUCT + ', false)">' +
            //           '<i class="ace-icon bigger-130 fa fa-pencil"></i></span>' +
        }

        function actionsHtmlFull(data, type, full, meta) {
            return '<span class="txt-color-red btndelete" title="Delete product" ng-click="showCase.deleteRow(' + full.IDPRODUCT + ')">' +
                '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
            // '<span class="txt-color-green btnedit" title="Edit product" ng-click="showCase.showModalEditProduct(' + full.IDPRODUCT + ', true)">' +
            //           '<i class="ace-icon bigger-130 fa fa-pencil"></i></span>' +
        }

        function showModalEditProduct(id, isfull) {
            $http.get("/index.cfm/product/getInfoToEditById/?id_product=" + id).success(function(dataResponse) {
                if (dataResponse.success == true) {
                    vm.user.pr_version = dataResponse.data.PRVERSION;
                    vm.user.pr_des = dataResponse.data.PRDES;
                    vm.user.pricefty = dataResponse.data.SELL_9;
                    vm.user.pricezone = dataResponse.data.SELL_10;
                    vm.user.pricecustomer = dataResponse.data.PVPR_11;
                    vm.user.priceclub = dataResponse.data.CLUB_12;
                    vm.user.priceweb = dataResponse.data.WEB_13;
                    vm.user.prId = dataResponse.data.PRID;
                    vm.isFullEdit = isfull;
                    $('#editProduct').modal("show");
                } else {
                    noticeFailed(data.message);
                }
            });
        }

        vm.fd = new FormData();
        $scope.uploadFile = function(files) {
            //Take the first selected file
            vm.fd.append("image", files[0]);
        };

        $scope.uploadPicture = function(files) {
            //Take the first selected file
            vm.fd.append("picture", files[0]);
        };

        function showModalAddNew() {
            vm.fd = null;
            vm.fd = new FormData();
            vm.plz = { 'des': 'None' };
            refresh();
            if (vm.userInfo.TYPEUSER == 3 && vm.userInfo.TYPEUSER != 4) {
                var check = changeAgent();
                if (check.priceListExist == false || check.projectIsExist == false) {
                    $('#addNew').modal("hide");
                } else {
                    $('#addNew').modal("show");
                }
            } else {
                $('#addNew').modal("show");
            }

        }

        function addNewProduct() {
            vm.fd.append('pr_version', vm.user.pr_version);
            vm.fd.append('id_project', vm.user.project);
            vm.fd.append('id_cost', vm.user.cost_code);
            vm.fd.append('id_cost_version', vm.user.cost_version);
            vm.fd.append('id_tp_code', vm.user.tp_id);
            vm.fd.append('id_pattern', vm.user.pattern);
            vm.fd.append('id_pattern_var', vm.user.pattern_var);
            vm.fd.append('id_size', vm.user.size);
            vm.fd.append('section', typeof(vm.user.section) === "undefined" ? "" : vm.user.section);
            vm.fd.append('pr_des', typeof(vm.user.pr_des) === "undefined" ? "" : vm.user.pr_des);
            vm.fd.append('id_plz_id', vm.user.plz_id);
            $.ajax({
                type: "POST",
                url: "/index.cfm/product/addNewProduct",
                async: false,
                data: vm.fd,
                processData: false,
                contentType: false,
                success: function(data) {
                    if (data.success) {
                        noticeSuccess(data.message);
                        vm.dtInstance1.reloadData();
                        vm.dtInstance2.reloadData();
                        window.location.href = "/index.cfm/product.edit?id=" + data.id_product;
                    } else {
                        noticeFailed(data.message);
                    }
                    $("addNew").modal('hide');

                    vm.fd = null;
                    vm.fd = new FormData();
                }
            });
        }

        function doubleclickHandler(info) {
            window.location.href = "/index.cfm/product.edit?id=" + info.IDPRODUCT;
        }

        function createdRow(row, data, dataIndex) {
            // Recompiling so we can bind Angular directive to the DT
            $('td', row).unbind('dblclick');
            $('td', row).bind('dblclick', function() {
                $scope.$apply(function() {
                    vm.doubleclickHandler(data);
                });
            });
            $compile(angular.element(row).contents())($scope);
        }


        function refresh() {
            $('#cost_sketch').val('');
            $('#cost_picture').val('');            
            vm.user = angular.copy(original);
            vm.fd = new FormData();
            $scope.userForm.$setPristine();
            if (vm.userInfo.TYPEUSER != 2) {
                vm.agent = [];
            }

            if (vm.userInfo.TYPEUSER != 3) {
                vm.custs = [];
                vm.projects = [];
                vm.plz = {};
                vm.versions = [];
                vm.cost_codes = [];
            }
        }

        function changeZone() {
            vm.agent = [];
            vm.projects = [];
            vm.custs = [];
            vm.plz = {};
            vm.versions = [];
            vm.cost_codes = [];
            vm.user.cost_code = "";
            vm.user.agentID = "";
            vm.user.customerid = "";
            vm.user.cost_version = "";
            $.ajax({
                async: false,
                type: 'POST',
                url: '/index.cfm/product/getAgent',
                data: {
                    id_zone: vm.user.zoneID
                },
                success: function(data) {
                    if (data.length > 0) {
                        vm.agent = data;
                    } else {

                    }
                }
            });
        }

        function changeAgent() {
            vm.custs = [];
            vm.projects = [];
            vm.versions = [];
            vm.plz = {};
            vm.user.cost_code = "";
            vm.user.cost_version = "";
            projectIsExist = true;
            priceListExist = true;
            $.ajax({
                async: false,
                type: 'POST',
                url: '/index.cfm/product/getCustomer',
                data: {
                    id_agent: $("#agentID").val()
                },
                success: function(data) {
                    vm.custs = data.custs;
                    projectIsExist = data.projectIsExist;
                    priceListExist = data.priceListExist;
                    if (priceListExist) {
                        if (projectIsExist) {
                            vm.plz = data.priceList;
                            vm.user.plz_id = vm.plz.id_plz;
                            changePriceListZone();
                        } else {
                            alert("Customer doesn't have any Project!!");
                        }
                    } else {
                        alert("Agent doesn't have any Price List!!");
                    }
                }
            });
            var content = { 'priceListExist': priceListExist, 'projectIsExist': projectIsExist };
            return content;
        }

        function changeCustomer() {
            vm.projects = [];
            $.ajax({
                async: false,
                type: 'POST',
                url: '/index.cfm/product/getplz_id',
                data: {
                    id_agent: vm.user.agentID,
                    id_zone: vm.user.zoneID,
                    id_customer: $("#customerid").val()
                },
                success: function(data) {
                    vm.projects = data.project;
                }
            });
        }

        function changecost_season() {
            if (vm.user.cost_code > 0) {
                $.ajax({
                    async: false,
                    type: 'POST',
                    url: '/index.cfm/product/getcost_version',
                    data: {
                        id_cost: vm.user.cost_code
                    },
                    success: function(data) {
                        if (data.length > 0) {
                            vm.versions = data;
                            vm.isDisabledVer = false;
                            getPrdType();
                            vm.user.cost_version = "";
                        } else {
                            noticeFailed("No cost version for this cost code!");
                            refreshValue();
                        }
                    }
                });
            }
        }

        function refreshValue() {
            vm.versions = "";
            vm.tpList = "";
        }

        function changePriceListZone() {
            $.ajax({
                async: false,
                type: 'POST',
                url: '/index.cfm/product/getcost_code',
                data: {
                    plz_id: vm.user.plz_id
                },
                success: function(data) {
                    if (data.length > 0) {
                        refreshValue();
                        vm.cost_codes = data;
                        vm.versions = "";
                    } else {
                        var message = "No cost for this price list!";
                        if (data.message != null) {
                            message = data.message;
                        }
                        noticeFailed(message);
                        refreshValue();
                        vm.versions = "";
                        vm.cost_codes = "";
                    }
                }
            });

        }

        function getPrdType() {
            $.ajax({
                async: false,
                type: 'POST',
                url: '/index.cfm/product/getPrdTypeByCost',
                data: {
                    id_cost: vm.user.cost_code
                },
                success: function(data) {
                    if (data.length > 0) {
                        vm.tpList = data;
                        vm.user.tp_id = data[0].tp_id;
                    } else {
                        noticeFailed("No product type for this cost code!");
                    }
                }
            });
        }

        function changepattern() {
            if ($("#pattern").val() != "") {
                $.ajax({
                    async: false,
                    type: 'POST',
                    url: '/index.cfm/product/getPatternVar',
                    data: {
                        id_pattern: vm.user.pattern
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

        function deleteRow(productID) {
            vm.delProductId = productID;
            $('#showDelete').modal('show');
        }

        function deleteProduct() {
            $('#showDelete').modal('hide');
            $.ajax({
                async: false,
                type: 'POST',
                url: '/index.cfm/product/deleteProduct',
                data: {
                    id_product: vm.delProductId
                },
                success: function(data) {
                    if (data.success) {
                        noticeSuccess(data.message);
                        vm.dtInstance1.reloadData();
                        vm.dtInstance2.reloadData();
                    } else {
                        noticeFailed(data.message);
                    }
                }
            });
        }

        function saveUpdateProduct() {
            $.ajax({
                async: false,
                type: 'POST',
                url: '/index.cfm/product/updateInfoProduct',
                data: {
                    prversion: vm.user.pr_version,
                    prdes: vm.user.pr_des,
                    pricefty: vm.user.pricefty,
                    pricezone: vm.user.pricezone,
                    pricecustomer: vm.user.pricecustomer,
                    priceclub: vm.user.priceclub,
                    priceweb: vm.user.priceweb,
                    prId: vm.user.prId,
                    isFullEdit: vm.isFullEdit
                },
                success: function(data) {
                    if (data.success) {
                        noticeSuccess(data.message);
                        vm.dtInstance1.reloadData();
                        vm.dtInstance2.reloadData();
                        vm.dtInstance3.reloadData();
                        $('#editProduct').modal("hide");
                    } else {
                        noticeFailed(data.message);
                    }
                }
            });
        }
    };

})();