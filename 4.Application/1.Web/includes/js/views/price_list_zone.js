(function() {
    angular.module('price.List.zone', ['datatables', 'ui.select2', 'datatables.light-columnfilter']).controller("BindAngularDirectiveCtrl", BindAngularDirectiveCtrl)

    function BindAngularDirectiveCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $q) {
        var vm = this;
        vm.message = '';
        vm.addRow = addRow;
        vm.refresh = refresh;
        vm.showAddNew = showAddNew;
        vm.clickItem = clickItem;
        vm.showCopyData = showCopyData;
        vm.CopyData = CopyData;
        vm.deletePLZ = deletePLZ;
        vm.PLZ_Table = [];
        vm.agents = [];
        vm.plzSourceSeasons = [];
        vm.plzs = [];
        vm.plzsCopy = [];
        vm.formLoad = formLoad;
        vm.isFirstload = true;
        vm.currency_freight = "";
        vm.formatNumberThousand = formatNumberThousand;
        vm.currency_freight_copy = "";
        vm.dtInstance = {};
        vm.persons = {};
        vm.user = {};
        vm.regex = "[a-z A-Z 0-9-\_\.]+";
        vm.regexNumber = /^[0-9]+([\.][0-9]+)?$/;
        vm.changeSourceSeasonCopy = changeSourceSeasonCopy;
        vm.changeSourceSeasonAddNew = changeSourceSeasonAddNew;
        vm.changePLC = changePLC;
        vm.calculateExRate = calculateExRate;
        vm.changeManualExRate = changeManualExRate;
        vm.getftycurrency = getftycurrency;
        vm.CodeExist = false;
        vm.DetailLink = "";

        $.ajax({
            async: false,
            type: 'GET',
            url: '/index.cfm/basicdata/getUserLevel',
            success: function(data) {
                //callback
                vm.userInfo = data;
                if(vm.userInfo.TYPEUSER == 1){
                    vm.DetailLink = "/index.cfm/basicdata.plz_detail_factory.cfm?id=";
                }
                else if(vm.userInfo.TYPEUSER == 2){
                    vm.DetailLink = "/index.cfm/basicdata.plz_detail_zone.cfm?id=";
                }
                else if (vm.userInfo.TYPEUSER == 3) {
                    vm.DetailLink = "/index.cfm/basicdata.plz_detail_agent.cfm?id=";
                    userForm.$invalid = true;
                    $("#btnAddNew").hide();
                    $("#btnCopyData").hide();
                } else {
                    userForm.$invalid = true;
                    // vm.dtColumns_detail.splice(0,18);
                    sumColumnFilter = {};
                }
            }
        });

        $("#codeCopy").keydown(function(){
            vm.CodeExist = false;
        });

        $("#sourceplz").change(function() {
            var idplz = $(this).val();
            if (idplz != "") {
                vm.user.codeCopy = vm.plzsCopy[idplz].plz_code;
                vm.user.descriptionCopy = vm.plzsCopy[idplz].plz_description;
                vm.CodeExist = true;
                $scope.copyForm.codeCopy.$setDirty();
                $scope.copyForm.codeCopy.$invalid = true;
            }
        });

        function reCalFormatCurrency(){
            if(vm.user.plfEx_Rate != '' && vm.user.plfEx_Rate !== undefined)
                vm.user.plfEx_RateShow = formatNumberThousand(vm.user.plfEx_Rate,2);

            if(vm.currency_convert.cc_value != '' && vm.currency_convert.cc_value !== undefined)
                vm.currency_convert.cc_valueShow = formatNumberThousand(vm.currency_convert.cc_value,2);

           
            if(vm.user.convertCc_ex_rate != '' && vm.user.convertCc_ex_rate !== undefined)
                vm.user.convertCc_ex_rateShow = formatNumberThousand(vm.user.convertCc_ex_rate,2);

            if(vm.user.convertplz_ex_rate != '' && vm.user.convertplz_ex_rate !== undefined) {
                vm.user.convertplz_ex_rateShow = formatNumberThousand(vm.user.convertplz_ex_rate,2);
                vm.user.plz_ex_rateShow = formatNumberThousand(vm.user.plz_ex_rate,2);
            }
        }

        function changeManualExRate() {
            if (vm.user.ex_rate === undefined || vm.user.ex_rate == 0 || vm.user.ex_rate == "") {
                vm.user.convertplz_ex_rate = "";
                return "";
            } else {
                vm.user.convertplz_ex_rate = roundDecimalPlaces(1 / vm.user.ex_rate, 2);
                vm.user.convertplz_ex_rateShow = formatNumberThousand(vm.user.convertplz_ex_rate,2);
            }
        }

        function calculateExRate() {
            if (vm.currency_convert.cc_value === undefined || vm.user.plfEx_Rate === undefined) {
                reCalFormatCurrency();
                return "";
            } else {
                var c_ex_rate = vm.user.plfEx_Rate / vm.currency_convert.cc_value;
                c_ex_rate = roundDecimalPlaces(c_ex_rate, 2);
                vm.user.plz_ex_rate = c_ex_rate;
                vm.user.ex_rate = c_ex_rate;

                vm.user.convertCc_ex_rate = roundDecimalPlaces(1 / c_ex_rate, 2);
                vm.user.convertplz_ex_rate = roundDecimalPlaces(1 / c_ex_rate, 2);

                reCalFormatCurrency();
            }
        }

        function formLoad() {
            if (vm.isFirstload) {
                $http.get("/index.cfm/basicdata/getlanguage").success(function(dataResponse) {
                    vm.languages = dataResponse;
                });

                $http.get("/index.cfm/price_list_zone/getSeason").success(function(dataResponse) {
                    vm.plzSourceSeasons = dataResponse;
                });

                $http.get("/index.cfm/basicdata/getcurrency").success(function(dataResponse) {
                    vm.currencylist = dataResponse;
                });
                $.ajax({
                    async: false,
                    type: 'GET',
                    url: '/index.cfm/price_list_factory/getNewSeason',
                    success: function(data) {
                        vm.newseasons = data.arrnewseason;
                    }
                });
                vm.isFirstload = false;
            }
        }

        vm.arrPlist = [];

        function changeSourceSeasonAddNew() {
            $.ajax({
                async: false,
                type: 'POST',
                data: {
                    'season': $('#add_sourceseason').val()
                },
                url: '/index.cfm/price_list_zone/getPLFactoryBySeason',
                success: function(data) {
                    vm.plfs = data.arrPlist;
                }
            });
        }

        function changeSourceSeasonCopy(){
            $.ajax({
                async: false,
                type: 'POST',
                data: {
                    'season': $('#plzSourceseason').val()
                },
                url: '/index.cfm/price_list_zone/getPLZoneBySeason',
                success: function(data) {
                    vm.plzsCopy = data.arrPlist;
                }
            });
        }

        var original = angular.copy(vm.user);

        vm.dtOptions = DTOptionsBuilder.fromFnPromise(function() {
                var defer = $q.defer();
                $http.get('/index.cfm/price_list_zone/getprice_list_zones').then(function(result) {
                    defer.resolve(result.data);
                    vm.plzs = result.data;
                });
                return defer.promise;
            })
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
                }
            })
            .withPaginationType('full_numbers')
            .withOption('createdRow', createdRow)
            .withOption('stateSave', true)
            .withOption('select', { style: 'single' });

        vm.dtColumns = [
            DTColumnBuilder.newColumn('CODE').withTitle('CODE'),
            DTColumnBuilder.newColumn('DESCRIPTION').withTitle('DESCRIPTION'),
            DTColumnBuilder.newColumn('SEASON').withTitle('SEASON').withClass("text-right  th-text-left"),
            DTColumnBuilder.newColumn('PLF_CODE').withTitle('CODE').withClass("text-right  th-text-left"),
            DTColumnBuilder.newColumn('PLF_CURR').withTitle('CURRENCY'),
            DTColumnBuilder.newColumn('PLCURRENCY').withTitle('P.L. CURRENCY'),
            DTColumnBuilder.newColumn('EX_RATE').withTitle('EX. RATE').renderWith(formatNumber).withClass("text-right th-text-left"),
            DTColumnBuilder.newColumn('DATE').withTitle('DATE'),
            DTColumnBuilder.newColumn('UPDATE').withTitle('UPDATE'),
            DTColumnBuilder.newColumn('COMMISSION').withTitle('COMMISSION').renderWith(formatNumber).withClass("text-right  th-text-left"),
            DTColumnBuilder.newColumn('FREIGHT').withTitle('FREIGHT').renderWith(formatNumber).withClass("text-right  th-text-left"),
            DTColumnBuilder.newColumn('TAXES').withTitle('TAXES').renderWith(formatNumber).withClass("text-right  th-text-left"),
            DTColumnBuilder.newColumn('MARGIN').withTitle('MARGIN').renderWith(formatNumber).withClass("text-right  th-text-left"),
            DTColumnBuilder.newColumn('LANGUAGE').withTitle('LANGUAGE'),
            DTColumnBuilder.newColumn(null).withTitle('DETAIL').withClass("text-center").renderWith(renderLinkDetail).notSortable(),
            DTColumnBuilder.newColumn(null).withTitle('ACTIONS').renderWith(actionsHtml).withOption('width', "2%").notSortable()
        ];

        function formatNumber (data, type, full, meta) {
          return formatNumberThousand(data, 2);
        }

        
        function renderLinkDetail(data, type, full, meta) {
            return '<a class="txt-color-green btngotoplfdetail" title="Go to price list factory detail" ng-click="showCase.clickItem(' + full.ID + ')">' +
                '<i class="ace-icon bigger-130 fa fa-sign-out"></i></a>';
        }



        //remove action without factory admin
        if ((vm.userInfo.TYPEUSER == 3) || (vm.userInfo.TYPEUSER == 4)) {
            vm.dtColumns[15].visible = false;
            $(document).ready(function() {
                $("#datatable_fixed_column_1 tr.fix_header+tr th:last").remove();
            });
        }

        function actionsHtml(data, type, full, meta) {
            vm.PLZ_Table[data.ID] = data;
            if ((vm.userInfo.TYPEUSER == 1) || (vm.userInfo.TYPEUSER == 2)) {
                return '<span class="txt-color-red btndelete" title="Delete price list zone" ng-click="showCase.deletePLZ(' + data.ID + ')">' +
                    '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
            } else {
                return "";
            }
        }

        var keyURL = 'DataTables_datatable_fixed_column_1_/index.cfm/basicdata.price_list_zone';
        var perform = performance.navigation.type;
        if (perform === 0 || perform === 1) {
            $window.localStorage.removeItem(keyURL);
        }
        (function() {
            $(document).ready(function() {
                var stateColumns = JSON.parse($window.localStorage.getItem(keyURL));

                if (stateColumns) {
                    window.setTimeout(function() {
                        $("#datatable_fixed_column_1 thead tr:last-child").children('th').each(function(index) {
                            if (!$(this).is(':empty')) {
                                $(this).children().val(stateColumns.columns[index].search.search);
                            }
                        });
                    }, 100);
                }
            })
        })();

        function deletePLZ(plzid) {
            var result = confirm('Do you want to delete this Price List Zone?');
            if(result){
                $.ajax({
                    type: "POST",
                    url: "/index.cfm/price_list_zone/deletePLZ",
                    async: false,
                    data: {
                        'id_plz': plzid
                    },
                    success: function(data) {
                        if (data.success) {
                            noticeSuccess(data.message);
                            vm.dtInstance.reloadData();
                        } else {
                            noticeFailed(data.message);
                        }
                    }
                });
            }
        }

        function clickItem(param) {
            var path = vm.DetailLink + param;
            $window.location.href = path;
        }

        function showAddNew() {
            // body...
            refresh();
            vm.formLoad();
            document.getElementById("titleID").innerHTML = "Create";
            $(".highlight").removeClass("highlight");
            $('#btnRefresh').css('display', 'inline-block');
            $('#close').css('display', 'block');

            $('#addNew').modal('show');
            $(document).ready(function() {
                $("#addNew").on('shown.bs.modal', function() {
                    $(this).find('#code').focus();
                });
            });
        }

        function showCopyData() {
            vm.formLoad();
            refresh();
            $scope.copyForm.$setPristine();
            $('#copydata').modal('show');
        }

        function CopyData() {
            $.ajax({
                 type: "POST",
                 url: "/index.cfm/basicdata/checkExistCode",
                 async: false,
                 data: {'code' : vm.user.codeCopy,
                        'table':'price_list_zone',
                        'nameCol':'plz_code',
                        'id':0,
                        'idfield':'id_plz'
                },
                success: function( data ) {
                            flag = data.isExist;
                            if(!flag)
                            {
                                $.ajax({
                                    type: "POST",
                                    url: "/index.cfm/price_list_zone/CopyData",
                                    async: false,
                                    data: {
                                        'code': vm.user.codeCopy,
                                        'description': vm.user.descriptionCopy,
                                        "plzSource": vm.user.sourceplz
                                    },
                                    success: function(data) {
                                        if (data.success == true) {
                                            noticeSuccess(data.message);
                                            window.location.href = '/index.cfm/basicdata.price_list_zone_detail?id=' + data.plzid;
                                        } else {
                                            noticeFailed(data.message);
                                        }
                                        vm.dtInstance.reloadData();
                                        $('#copydata').modal('hide');
                                    }
                                });
                            }else{
                                $scope.copyForm.codeCopy.invalid = true;
                                vm.CodeExist = true;
                                $("codeCopy").focus();
                            }
                        }
                });
        }

        function addRow() {
            $.ajax({
                type: "POST",
                url: "/index.cfm/price_list_zone/addNew",
                async: false,
                data: {
                    'code': vm.user.code,
                    'description': vm.user.description,
                    'season': vm.user.season,
                    'plf': vm.user.plf,
                    'currency': vm.user.currency,
                    'ex_rate': vm.user.ex_rate,
                    // 'correction': vm.user.correction,
                    'commission': vm.user.commission,
                    'freight': vm.user.freight,
                    'taxes': vm.user.taxes,
                    'margin': vm.user.margin,
                    'language': vm.user.language,
                    'id_plz': $("#id_plz").val()
                },
                success: function(data) {
                    if (data.success) {
                        noticeSuccess(data.message);
                        window.location.href = '/index.cfm/basicdata.price_list_zone_detail?id=' + data.plzid;
                    } else {
                        noticeFailed(data.message);
                        refresh();
                    }
                }
            });
        }

        // $('#addNew').on('show.bs.modal', function () {
        //   vm.formLoad();
        // });

        // $('#copydata').on('show.bs.modal', function () {
        //   vm.formLoad();
        // });

        function createdRow(row, data, dataIndex) {
            $('td', row).unbind('dblclick');
            $('td', row).bind('dblclick', function() {
                $scope.$apply(function() {
                    vm.clickItem(data.ID);
                });
            });
            // Recompiling so we can bind Angular directive to the DT
            $compile(angular.element(row).contents())($scope);
        }

        function refresh() {
            $('#id_plz').val(0);
            vm.currency_convert = {};
            vm.plfs = [];
            vm.user = angular.copy(original);
            $scope.userForm.$setPristine();
        }

        function changePLC() {
            $.ajax({
                async: false,
                type: 'POST',
                url: '/index.cfm/price_list_zone/getCurr_convert',
                data: { currency: vm.user.currency },
                success: function(data) {
                    vm.currency_convert = data.currency_convert;
                    var plzcurrencytext = $("#currency option:selected").text();
                    vm.currency_freight = plzcurrencytext;
                    vm.currency_freight_copy = plzcurrencytext;
                    vm.user.plzcurrencytext = plzcurrencytext;
                    vm.calculateExRate();
                }
            });
        }

        function getftycurrency() {
            if (vm.user.plf != undefined && vm.user.plf != "") {
                $.ajax({
                    async: false,
                    type: 'POST',
                    url: '/index.cfm/price_list_zone/getftycurrency',
                    data: {
                        'plf_id': vm.user.plf
                    },
                    success: function(data) {
                        if (data.success) {
                            vm.user.ftycurrency = data.currency;
                            vm.user.plfEx_Rate = data.plf_ex_rate;
                            vm.user.plzCurrencyID = data.curID;
                            vm.calculateExRate();
                        } else {
                            noticeFailed(data.message);
                        }
                    }
                });
            }
        }
    };

})();