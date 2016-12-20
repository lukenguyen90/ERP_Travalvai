(function() {
    'use strict'
    angular
        .module('order.ctrls')
        .controller("LineCustomerCtrl", lineCustomerCtrl);

    function lineCustomerCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, $resource, orderDetailService) {
        var vm = this;
        angular.extend(vm, $controller('LineCtrl', { $scope: $scope }));

        vm.options = {};
        vm.columns = [];
        vm.instance = {};

        vm.initCustomer = initCustomer;


        function initCustomer() {
            loadDatatable();
        }
        function loadDatatable() {
            vm.options = DTOptionsBuilder
                .fromFnPromise(function() {
                    return orderDetailService.getProductsLineView(utils().http().queryString("orderId"));
                    // return $resource('../index.cfm/order_details/getOrderDetailsLineView').query().$promise;
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

                DTColumnBuilder.newColumn('id_order_detail').withTitle('LINE').withOption("width", "4%"), //0
                DTColumnBuilder.newColumn('prodid').withTitle('PRODUCT').withOption("width", "4%"), //0
                DTColumnBuilder.newColumn(null).withTitle('GARMENT').withOption("width", "8.3%").renderWith(renderGarment), //1 pj_display-id_patt-id_patt_var - pr_version
                DTColumnBuilder.newColumn(null).withTitle('COSTING').renderWith(renderCosting), //2 cost_code - cv_version
                DTColumnBuilder.newColumn('prd_description').withTitle('DESCRIPTION'), //3 PRODUCT DESCRIPTION
                DTColumnBuilder.newColumn('sz_description').withTitle('SIZES'), //4 SIZE DESCRIPTION
                DTColumnBuilder.newColumn('ordd_cg_name').withTitle('GROUP'), //5
                DTColumnBuilder.newColumn('ordd_name').withTitle('NAME'), //6
                DTColumnBuilder.newColumn('ordd_number').withTitle('NO.').withOption("width", "4%"), //7
                DTColumnBuilder.newColumn('ordd_size').withTitle('SIZE').withOption("width", "4%"), //8
                DTColumnBuilder.newColumn(null).withTitle('QTY').renderWith(renderQuantity).withOption("width", "4%").withClass('text-center'), //9
                DTColumnBuilder.newColumn(null).withTitle('DED').withOption("width", "4%").renderWith(renderDelivered), //10 ordd_del_fty - ordd_del_zone - ordd_del_ag
                DTColumnBuilder.newColumn(null).withTitle('PRICE').renderWith(renderPrice).withClass('text-right'), //11 price_factory - price_zone - price_agent
                DTColumnBuilder.newColumn(null).withTitle('TOTAL').renderWith(renderTotalPrice).withClass('text-right'), //12 total_price_factory - total_price_zone - total_price_agent
                DTColumnBuilder.newColumn(null).withTitle('DETAIL').withOption("width", "6%").withOption("visible", false), //13
                DTColumnBuilder.newColumn(null).withTitle('ACTIONS').withOption("width", "6%").renderWith(vm.renderActions), //14 

                //Columns that will be used for summary calculation
                DTColumnBuilder.newColumn('ordd_quantity').withTitle('15').withOption("visible", false), //15
                DTColumnBuilder.newColumn('ordd_fty_tot').withTitle('16').withOption("visible", false), //16
                DTColumnBuilder.newColumn('ordd_zone_tot').withTitle('17').withOption("visible", false), //17
                DTColumnBuilder.newColumn('ordd_ag_tot').withTitle('18').withOption("visible", false), //18
                DTColumnBuilder.newColumn('ord_plf_currency').withTitle('19').withOption("visible", false), //19 factory currency
                DTColumnBuilder.newColumn('ord_plz_currency').withTitle('20').withOption("visible", false), //20 zone currency
            ];

        }

        function renderFooter(tfoot, row, data, start, end, display) {
            var api = this.api();

            var totalUnit = formatNumberThousand(utils().dataTable().getColumnSummary(api, 16));

            var ftyTotalPrice = utils().dataTable().getColumnSummary(api, 17);
            var zoneTotalPrice = utils().dataTable().getColumnSummary(api, 18);
            var agentTotalPrice = utils().dataTable().getColumnSummary(api, 19);
            var ftyCurrency  = utils().dataTable().getColumnValue(api, 20);
            var zoneCurrency = utils().dataTable().getColumnValue(api, 21);

            var agentCurrency = utils().dataTable().getColumnValue(api, 21);

            var footerTpl = '';

            footerTpl = '<tr><td colspan="16"></td></tr>' +
                '<tr>' +
                '<td colspan="10" class="text-right">SUMMARY</td>' +

                '<td class="vertical-middle; text-center">' + totalUnit + '</td>' +
                '<td colspan="2"></td>' +
                '<td class="text-right">' + formatNumberThousand(agentTotalPrice, 2) + (agentCurrency != " " ? (' - ' + agentCurrency) :' - ') +
                '</td>' +
                '<td colspan="2"></td>' +
                '</tr>';

            $(api.table().footer()).html(footerTpl);
        }

        function renderGarment(data, type, full, meta) {
            return data.pj_display + '-' + data.pattern_code + '-' + data.patt_vari_code + ' - ' + data.prd_version;
        }

        function renderQuantity(data, type, full, meta) {
            return formatNumberThousand(data.ordd_quantity);
        }

        function renderCosting(data, type, full, meta) {
            //2 cost_code - cv_version
            return data.cost_code + ' - ' + data.cv_version;
        }

        function renderDelivered(data, type, full, meta) {
            return '<span style="minheight:50px;">' + data.ordd_del_ag + '</span>';

        }

        function renderPrice(data, type, full, meta) {
            return '<span style="minheight:50px;">' + formatNumberThousand(data.price_agent, 2) + ' - ' + data.ord_plz_currency + '</span>';

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
    };
})();