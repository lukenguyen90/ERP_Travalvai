(function() {
    'use strict'
    angular
        .module('order.ctrls')
        .controller("SizeCustomerCtrl", sizeCustomerCtrl);

    function sizeCustomerCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, $resource, orderDetailService) {
        var vm = this;
        angular.extend(vm, $controller('SizeCtrl', { $scope: $scope }));

        vm.options = {};
        vm.columns = [];
        vm.instance = {};

        vm.showAddOrderPopup = showAddOrderPopup;
        vm.showAddProductPopup = showAddProductPopup;

        vm.init = init;

        function init() {
            initDatatable();
        }

        function initDatatable() {
            vm.options = DTOptionsBuilder.fromFnPromise(function() {
                    return orderDetailService.getOrderDetails_SizeView(utils().http().queryString("orderId"));
                    // return $resource('../../../../views/order/client/order-detail/data-size.json').query().$promise;
                })
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
                    },
                    '16': {
                        type: 'text'
                    },
                    '17': {
                        type: 'text'
                    },
                    '18': {
                        type: 'text'
                    },
                    '19': {
                        type: 'text'
                    },
                    '20': {
                        type: 'text'
                    },
                    '21': {
                        type: 'text'
                    },
                    '22': {
                        type: 'text'
                    },
                    '23': {
                        type: 'text'
                    },
                    '24': {
                        type: 'text'
                    },
                    '25': {
                        type: 'text'
                    }
                })
                .withOption('footerCallback', renderFooter)
                .withOption('createdRow', createdRow)
                .withOption('fnInitComplete', function() {
                    vm.removeInVisibleHeader();
                    customButton().updateButtonContainerStyle();
                })
                .withButtons(utils().dataTable().getButtonsConfiguration());

            vm.columns = [

                DTColumnBuilder.newColumn(null).withTitle('SKETCH').renderWith(renderSketch), //0 prd_sketch
                 DTColumnBuilder.newColumn('id_product').withTitle('PRODUCT'),
                DTColumnBuilder.newColumn(null).withTitle('GARMENT').withOption("width", "8.3%").renderWith(renderGarment), //1 pj_display-pattern_code-patt_vari_code - prd_version
                DTColumnBuilder.newColumn(null).withTitle('COSTING').renderWith(renderCosting), //2 cost_code - cv_version
                DTColumnBuilder.newColumn('prd_description').withTitle('DESCRIPTION'), //4 PRODUCT DESCRIPTION
                DTColumnBuilder.newColumn('sz_description').withTitle('SIZES'), //3 SIZE DESCRIPTION
                DTColumnBuilder.newColumn('ordd_cg_name').withTitle('GROUP'), //5
                DTColumnBuilder.newColumn(null).withTitle('6XS').renderWith(render6XS).withClass('text-center'), //6
                DTColumnBuilder.newColumn(null).withTitle('5XS').renderWith(render5XS).withClass('text-center'), //7
                DTColumnBuilder.newColumn(null).withTitle('4XS').renderWith(render4XS).withClass('text-center'), //8
                DTColumnBuilder.newColumn(null).withTitle('3XS').renderWith(render3XS).withClass('text-center'), //9
                DTColumnBuilder.newColumn(null).withTitle('XXS').renderWith(renderXXS).withClass('text-center'), //10
                DTColumnBuilder.newColumn(null).withTitle('XS').renderWith(renderXS).withClass('text-center'), //11
                DTColumnBuilder.newColumn(null).withTitle('S').renderWith(renderS).withClass('text-center'), //12
                DTColumnBuilder.newColumn(null).withTitle('M').renderWith(renderM).withClass('text-center'), //13
                DTColumnBuilder.newColumn(null).withTitle('L').renderWith(renderL).withClass('text-center'), //14
                DTColumnBuilder.newColumn(null).withTitle('XL').renderWith(renderXL).withClass('text-center'), //15
                DTColumnBuilder.newColumn(null).withTitle('XXL').renderWith(renderXXL).withClass('text-center'), //16
                DTColumnBuilder.newColumn(null).withTitle('3XL').renderWith(render3XL).withClass('text-center'), //17
                DTColumnBuilder.newColumn(null).withTitle('4XL').renderWith(render4XL).withClass('text-center'), //18
                DTColumnBuilder.newColumn(null).withTitle('5XL').renderWith(render5XL).withClass('text-center'), //19
                DTColumnBuilder.newColumn(null).withTitle('6XL').renderWith(render6XL).withClass('text-center'), //20
                DTColumnBuilder.newColumn(null).withTitle('UNITS').renderWith(renderUnits).withOption("width", "2%").withClass('text-center'), //21
                DTColumnBuilder.newColumn(null).withTitle('PRICE').renderWith(renderPrice).withClass('text-right').withOption("width", "5%"), //22
                DTColumnBuilder.newColumn(null).withTitle('TOTAL').renderWith(renderTotalPrice).withClass('text-right').withOption("width", "5%"), //23
                DTColumnBuilder.newColumn('name_number').withTitle('NAME & NUMBER').withOption("width", "4%").withClass('text-left'), //24
                DTColumnBuilder.newColumn(null).withTitle('ACTIONS').withOption("width", "4%").renderWith(vm.renderActions).withClass('text-left'), //25   

                //Columns that will be used for summary calculation
                DTColumnBuilder.newColumn('ordd_fty_tot').withTitle('26').withOption("visible", false), //26
                DTColumnBuilder.newColumn('ordd_zone_tot').withTitle('27').withOption("visible", false), //27
                DTColumnBuilder.newColumn('ordd_ag_tot').withTitle('28').withOption("visible", false), //28
                DTColumnBuilder.newColumn('ord_plf_currency').withTitle('29').withOption("visible", false), //29
                DTColumnBuilder.newColumn('ord_plz_currency').withTitle('30').withOption("visible", false), //30
                DTColumnBuilder.newColumn('ordd_units').withTitle('units').withOption("visible", false), //31
                DTColumnBuilder.newColumn('_6XS').withTitle('6XS').withOption("visible", false), //32
                DTColumnBuilder.newColumn('_5XS').withTitle('5XS').withOption("visible", false), //33
                DTColumnBuilder.newColumn('_4XS').withTitle('4XS').withOption("visible", false), //34
                DTColumnBuilder.newColumn('_3XS').withTitle('3XS').withOption("visible", false), //35
                DTColumnBuilder.newColumn('_XXS').withTitle('XXS').withOption("visible", false), //36
                DTColumnBuilder.newColumn('_XS').withTitle('XS').withOption("visible", false), //37
                DTColumnBuilder.newColumn('_S').withTitle('S').withOption("visible", false), //38
                DTColumnBuilder.newColumn('_M').withTitle('M').withOption("visible", false), //39
                DTColumnBuilder.newColumn('_L').withTitle('L').withOption("visible", false), //40
                DTColumnBuilder.newColumn('_XL').withTitle('XL').withOption("visible", false), //41
                DTColumnBuilder.newColumn('_XXL').withTitle('XXL').withOption("visible", false), //42
                DTColumnBuilder.newColumn('_3XL').withTitle('3XL').withOption("visible", false), //43
                DTColumnBuilder.newColumn('_4XL').withTitle('4XL').withOption("visible", false), //44
                DTColumnBuilder.newColumn('_5XL').withTitle('5XL').withOption("visible", false), //45
                DTColumnBuilder.newColumn('_6XL').withTitle('6XL').withOption("visible", false) //46
            ]

        }

        function formatThousand(value, place) {
            if (value === 0)
                return "-";
            if (typeof(place) === 'undefined')
                place = 0;
            return formatNumberThousand(value, place)
        }

        function render6XS(data, type, full, meta) {

            return formatThousand(data._6XS);
        }

        function render5XS(data, type, full, meta) {

            return formatThousand(data._5XS);
        }

        function render4XS(data, type, full, meta) {

            return formatThousand(data._4XS);
        }

        function render3XS(data, type, full, meta) {

            return formatThousand(data._3XS);
        }

        function renderXXS(data, type, full, meta) {

            return formatThousand(data._XXS);
        }

        function renderXS(data, type, full, meta) {

            return formatThousand(data._XS);
        }

        function renderS(data, type, full, meta) {

            return formatThousand(data._S);
        }

        function renderM(data, type, full, meta) {

            return formatThousand(data._M);
        }

        function renderL(data, type, full, meta) {

            return formatThousand(data._L);
        }

        function renderXL(data, type, full, meta) {

            return formatThousand(data._XL);
        }

        function renderXXL(data, type, full, meta) {

            return formatThousand(data._XXL);
        }

        function render3XL(data, type, full, meta) {

            return formatThousand(data._3XL);
        }

        function render4XL(data, type, full, meta) {

            return formatThousand(data._4XL);
        }

        function render5XL(data, type, full, meta) {

            return formatThousand(data._5XL);
        }

        function render6XL(data, type, full, meta) {

            return formatThousand(data._6XL);
        }


        function renderFooter(tfoot, row, data, start, end, display) {
            var api = this.api();
            var sum6XS = utils().dataTable().getColumnSummary(api, 33);
            var sum5XS = utils().dataTable().getColumnSummary(api, 34);
            var sum4XS = utils().dataTable().getColumnSummary(api, 35);
            var sum3XS = utils().dataTable().getColumnSummary(api, 36);
            var sumXXS = utils().dataTable().getColumnSummary(api, 37);
            var sumXS = utils().dataTable().getColumnSummary(api, 38);
            var sumS = utils().dataTable().getColumnSummary(api, 39);
            var sumM = utils().dataTable().getColumnSummary(api, 40);
            var sumL = utils().dataTable().getColumnSummary(api, 41);
            var sumXL = utils().dataTable().getColumnSummary(api, 42);
            var sumXXL = utils().dataTable().getColumnSummary(api, 43);
            var sum3XL = utils().dataTable().getColumnSummary(api, 44);
            var sum4XL = utils().dataTable().getColumnSummary(api, 45);
            var sum5XL = utils().dataTable().getColumnSummary(api, 46);
            var sum6XL = utils().dataTable().getColumnSummary(api, 47);
            var totalUnit = utils().dataTable().getColumnSummary(api, 32);
            var ftyTotalPrice = utils().dataTable().getColumnSummary(api, 27);
            var zoneTotalPrice = utils().dataTable().getColumnSummary(api, 28);
            var agentTotalPrice = utils().dataTable().getColumnSummary(api, 29);
            var ftyCurrency = utils().dataTable().getColumnValue(api, 30);
            var zoneCurrency = utils().dataTable().getColumnValue(api, 31);;
            var agentCurrency = utils().dataTable().getColumnValue(api, 31);
            var footerTpl = '';
            footerTpl = '<tr><td colspan="27"></td></tr>' +
                '<tr>' +
                '<td colspan="7" class="text-right">SUMMARY</td>' +
                '<td class="vertical-middle; text-center">' + formatThousand(sum6XS) + '</td>' +
                '<td class="vertical-middle; text-center">' + formatThousand(sum5XS) + '</td>' +
                '<td class="vertical-middle; text-center">' + formatThousand(sum4XS) + '</td>' +
                '<td class="vertical-middle; text-center">' + formatThousand(sum3XS) + '</td>' +
                '<td class="vertical-middle; text-center">' + formatThousand(sumXXS) + '</td>' +
                '<td class="vertical-middle; text-center">' + formatThousand(sumXS) + '</td>' +
                '<td class="vertical-middle; text-center">' + formatThousand(sumS) + '</td>' +
                '<td class="vertical-middle; text-center">' + formatThousand(sumM) + '</td>' +
                '<td class="vertical-middle; text-center">' + formatThousand(sumL) + '</td>' +
                '<td class="vertical-middle; text-center">' + formatThousand(sumXL) + '</td>' +
                '<td class="vertical-middle; text-center">' + formatThousand(sumXXL) + '</td>' +
                '<td class="vertical-middle; text-center">' + formatThousand(sum3XL) + '</td>' +
                '<td class="vertical-middle; text-center">' + formatThousand(sum4XL) + '</td>' +
                '<td class="vertical-middle; text-center">' + formatThousand(sum5XL) + '</td>' +
                '<td class="vertical-middle; text-center">' + formatThousand(sum6XL) + '</td>' +

                '<td class="vertical-middle; text-center">' + formatThousand(totalUnit) + '</td>' +
                '<td></td>' +
                '<td class="text-right">' + formatThousand(agentTotalPrice, 2) + ' - ' + agentCurrency +
                '</td>' +
                '<td colspan="2"></td>' +
                '</tr>';


            $(api.table().footer()).html(footerTpl);
        }

        function renderSketch(data, type, full, meta) {
            if (typeof(data.prd_sketch) === 'undefined' || data.prd_sketch.length === 0) {
                return "NO IMAGE";
            }
            return '<a rel="lightbox-mygallery' + '_' + data.id_order_det + '" href="/includes/img/ao/' + data.prd_sketch + '" title="' + data.prd_description + '">\
                           <img src="/includes/img/ao/' + data.prd_sketch + '" alt="' + data.prd_description + '" height="auto" width="70px">\
                    </a>';
        }

        function renderGarment(data, type, full, meta) {
            //pj_display-pattern_code-patt_vari_code - pr_version
            return data.pj_display + '-' + data.pattern_code + '-' + data.patt_vari_code + ' - ' + data.prd_version;
        }

        function renderCosting(data, type, full, meta) {
            //2 cost_code - cv_version
            return data.cost_code + ' - ' + data.cv_version;
        }

        function renderUnits(data, type, full, meta) {
            return formatNumberThousand(data.ordd_units);
        }


        function renderPrice(data, type, full, meta) {
            return '<span style="minheight:50px;">' + formatNumberThousand(data.price_agent) + ' - ' + data.ord_plz_currency + '</span>';

        }

        function renderTotalPrice(data, type, full, meta) {
            return '<span style="minheight:50px;">' + formatNumberThousand(data.ordd_ag_tot, 2) + ' - ' + data.ord_plz_currency + '</span>';

        }

        function renderCurrency(data, type, full, meta) {
            return '<span style="minheight:50px;">' + data.ord_plf_currency + '</span><hr><span style="minheight:50px;">' + data.ord_plz_currency + '</span><hr><span style="minheight:50px;">' + data.ord_plz_currency + '</span>';

        }

        function renderViewDetail(data, type, full, meta) {
            return 'Detail';

        }

        function renderAction(data, type, full, meta) {
            return 'Edit - Del';

        }



        function createdRow(row, data, dataIndex, iDisplayIndexFull) {
            // Recompiling so we can bind Angular directive to the DT
            $('td', row).unbind('dblclick');
            $('td', row).bind('dblclick', function() {
                $scope.$apply(function() {
                    doubleclickHandler(data);
                });
            });
            $compile(angular.element(row).contents())($scope);
            return row;
        };

        function doubleclickHandler(info) {
           
        }


        function showAddOrderPopup() {
            vm.tplAddOrder = '../../views/order/client/add-order/views/add-order-factory.view.html?v=15';
            $('#modalAddOrder').modal('show');
        }

        function showAddProductPopup() {
            vm.tplAddProduct = '../../views/order/client/product/views/product-factory.view.html?v=12';
            $('#modalAddOrder').modal('hide');
            $('#modalAddProduct').modal('show');
        }

    };
})();