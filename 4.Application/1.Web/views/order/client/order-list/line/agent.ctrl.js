(function() {
    'use strict'
    angular
        .module('order.ctrls')
        .controller("LineAgentCtrl", lineAgentCtrl);

    function lineAgentCtrl($q, $scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, $resource, orderListService) {
        var vm = this;
        angular.extend(vm, $controller('LineCtrl', { $scope: $scope }));

        vm.options = {};
        vm.columns = [];
        vm.instance = {};

        vm.init = init;

        function init() {
            loadDatatable();
        }

        function loadDatatable() {
            var url = '/index.cfm/order/getListOrders';
            vm.options = DTOptionsBuilder.newOptions()
                .withDataProp('data')
                .withOption('ajax', {
                    url: url
                })
                .withOption('serverSide', true)
                .withFnServerData(function (sSource, aoData, fnCallback, oSettings){
                    $http.get(url, {
                        params:{
                            start: aoData[3].value,
                            length: aoData[4].value,
                            draw: aoData[0].value,
                            order: aoData[2].value,
                            search: aoData[5].value,
                            columns: aoData[1].value
                        }
                    }).then(function(data) {
                        fnCallback(data.data);
                    });
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
                    }
                })
                .withOption('footerCallback', renderSummary)
                .withOption('createdRow', createdRow)
                .withOption('stateSave', true)
                .withOption('order', [0, 'desc'])
                .withOption('select', { style: 'single' })
                .withOption('stateLoadCallback', function(oSettings) {
                    return vm.getCachedData();
                })
                .withOption('fnInitComplete', function() {

                    vm.removeVisibleHeader();
                    vm.renderCachedFilter();
                    //custom button configuration
                    customButton().updateButtonContainerStyle();

                })
                .withButtons(utils().dataTable().getButtonsConfiguration());

            vm.columns = [

                DTColumnBuilder.newColumn('id_order').withTitle('ORDER').withClass("text-center"), //0
                DTColumnBuilder.newColumn(null).withTitle('CUSTOMER').renderWith(renderCustomer), //1
                DTColumnBuilder.newColumn('ord_description').withTitle('DESCRIPTION'), //2
                DTColumnBuilder.newColumn('ot_description').withTitle('TYPE'), //3
                DTColumnBuilder.newColumn('oc_description').withTitle('CONDITION'), //4
                DTColumnBuilder.newColumn(null).withTitle('STATUS').renderWith(vm.renderStatus), //5
                DTColumnBuilder.newColumn(null).withTitle('CONFIRMATION').renderWith(renderconfirmdates).withClass("text-right"), //6
                DTColumnBuilder.newColumn(null).withTitle('DELIVERY').renderWith(renderdeliverydates).withClass("text-right"), //7
                DTColumnBuilder.newColumn(null).withTitle('UNITS').renderWith(renderUnits).withOption("width", "1%").withClass("text-center"), //8

                DTColumnBuilder.newColumn(null).withTitle('DED').renderWith(renderunitsdelivered).withClass("text-center"), //9
                DTColumnBuilder.newColumn(null).withTitle('TO DEL').renderWith(renderpendent).withClass("text-center"), //10
                DTColumnBuilder.newColumn(null).withTitle('VALUE').renderWith(rendervalues).withOption("width", "8%").withClass("text-right"), //11
                DTColumnBuilder.newColumn(null).withTitle('VALUE DISCOUNT 1').renderWith(renderdis1).withOption("width", "2%").withClass("text-right"), //12
                DTColumnBuilder.newColumn(null).withTitle('VALUE DISCOUNT 2').renderWith(renderdis2).withOption("width", "2%").withClass("text-right"), //13
                DTColumnBuilder.newColumn('ord_plz').withTitle('CUR').withClass("text-center"), //14
                DTColumnBuilder.newColumn(null).withTitle('DETAIL').notSortable().renderWith(vm.renderDetail).withOption("width", "2%").withClass("text-center detail"), //15
                DTColumnBuilder.newColumn(null).withTitle('').notSortable().renderWith(vm.renderActions).withOption("width", "2%").withClass("text-center action"), //16

                DTColumnBuilder.newColumn('ord_units').withTitle('17').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_fty_delivered').withTitle('16').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_zone_delivered').withTitle('17').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_ag_delivered').withTitle('18').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_fty_pendent').withTitle('19').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_zone_pendent').withTitle('20').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_ag_pendent').withTitle('21').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_fty_value').withTitle('22').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_zone_value').withTitle('23').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_ag_value').withTitle('24').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_plf').withTitle('25').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_plz').withTitle('26').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_plz').withTitle('27').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_discount_1').withTitle('28').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_ag_value_dsc1').withTitle('29').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_ag_remain_dsc1').withTitle('30').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_discount_2').withTitle('31').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_ag_value_dsc2').withTitle('32').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_ag_remain_dsc2').withTitle('33').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_plz').withTitle('34').withOption("visible", false),
            ];

        }

        function renderUnits(data, type, full, meta) {
            return formatNumberThousand(data.ord_units);
        }
      
        function renderSummary(tfoot, row, data, start, end, display) {
            var api = this.api();
            if (row.length === 0) {
                $(api.table().footer()).html('');
                return;
            }

            // Update footer
            var startIndex = 17;

            var unitsTotal = utils().dataTable().getColumnSummary(api, startIndex);
            var ftyUnitsDeliveredTotal = utils().dataTable().getColumnSummary(api, startIndex + 1);
            var zoneUnitsDeliveredTotal = utils().dataTable().getColumnSummary(api, startIndex + 2);
            var agentUnitsDeliveredTotal = utils().dataTable().getColumnSummary(api, startIndex + 3);
            var factoryPendent = utils().dataTable().getColumnSummary(api, startIndex + 4);
            var zonePendent = utils().dataTable().getColumnSummary(api, startIndex + 5);
            var agentPendent = utils().dataTable().getColumnSummary(api, startIndex + 6);
            var ftyOrderValues = utils().dataTable().getColumnSummary(api, startIndex + 7);
            var zoneOrderValues = utils().dataTable().getColumnSummary(api, startIndex + 8);
            var agentOrderValues = utils().dataTable().getColumnSummary(api, startIndex + 9);
            var ftyCurrency = utils().dataTable().getColumnValue(api, startIndex + 10);
            var zoneCurrency = utils().dataTable().getColumnValue(api, startIndex + 11);;
            var agentCurrency = utils().dataTable().getColumnValue(api, startIndex + 12);;

            var discount1 = utils().dataTable().getColumnSummary(api, startIndex + 13);
            var agentDiscount1 = utils().dataTable().getColumnSummary(api, startIndex + 14);
            var agentRemain1 = utils().dataTable().getColumnSummary(api, startIndex + 15);
            var discount2 = utils().dataTable().getColumnSummary(api, startIndex + 16);
            var agentDiscount2 = utils().dataTable().getColumnSummary(api, startIndex + 17);
            var agentRemain2 = utils().dataTable().getColumnSummary(api, startIndex + 18);

            var orderCurrency = utils().dataTable().getColumnValue(api, startIndex + 19);
            var footerTpl = '';

            footerTpl = '<tr><td colspan="' + startIndex + '"></td></tr>' +
                '<tr>' +
                '<td colspan="8" class="vertical-middle text-right">SUMMARY</td>' +

                '<td class="vertical-middle text-center">' + formatNumberThousand(unitsTotal) + '</td>' +
                '<td class="text-center">' +
                formatNumberThousand(zoneUnitsDeliveredTotal) + '<hr>' +
                formatNumberThousand(agentUnitsDeliveredTotal) +
                '</td>' +

                '<td class="text-center">' +
                formatNumberThousand(zonePendent) + '<hr>' +
                formatNumberThousand(agentPendent) +
                '</td>' +

                '<td class="text-right">' +
                formatNumberThousand(zoneOrderValues, 2) + '-' + zoneCurrency + '<hr>' +
                formatNumberThousand(agentOrderValues, 2) + '-' + agentCurrency +
                '</td>' +

                '<td class="text-right vertical-bottom">' + formatNumberThousand(agentRemain1, 2) + '</td>' +
                '<td class="text-right vertical-bottom">' + formatNumberThousand(agentRemain2, 2) + '</td>' +
                '<td class="text-center vertical-bottom">' + orderCurrency + '</td>' +
                '<td colspan="2"></td>' +
                '</tr>';

            $(api.table().footer()).html(footerTpl);
        }


        function renderCustomer(data, type, full, meta) {

            return '<span style="minheight:50px;">' + data.id_customer + " - " + data.cs_name + '</span>';
        }

        function renderconfirmdates(data, type, full, meta) {
            return '<span style="minheight:50px;">' + full.ord_zone_confirm + '</span><hr><span style="minheight:50px;">' + full.ord_date + '</span>';
        }

        function renderdeliverydates(data, type, full, meta) {
            return '<span style="minheight:50px;">' + full.ord_zone_del_date + '</span><hr><span style="minheight:50px;">' + full.ord_ag_del_date + '</span>';

        }

        function renderunitsdelivered(data, type, full, meta) {
            return '<span style="minheight:50px;">' + full.ord_zone_delivered + '</span><hr><span style="minheight:50px;">' + full.ord_ag_delivered + '</span>';

        }

        function renderpendent(data, type, full, meta) {
            return '<span style="minheight:50px;">' + full.ord_zone_pendent + '</span><hr><span style="minheight:50px;">' + full.ord_ag_pendent + '</span>';

        }

        function rendervalues(data, type, full, meta) {
            return '<span style="minheight:50px;">' +
                formatNumberThousand(data.ord_zone_value, 2) + '-' + data.ord_plz + '</span><hr><span style="minheight:50px;">' +
                formatNumberThousand(data.ord_ag_value, 2) + '-' + data.ord_plz + '</span>';

        }

        function renderdis1(data, type, full, meta) {
            return '<span style="minheight:50px;">' + formatNumberThousand(full.ord_discount_1, 2) + '</span><hr><span style="minheight:50px;">' + formatNumberThousand(full.ord_ag_value_dsc1, 2) + '</span><hr><span style="minheight:50px;">' + formatNumberThousand(full.ord_ag_remain_dsc1, 2) + '</span>';

        }

        function renderdis2(data, type, full, meta) {
            return '<span style="minheight:50px;">' + formatNumberThousand(full.ord_discount_2, 2) + '</span><hr><span style="minheight:50px;">' + formatNumberThousand(full.ord_ag_value_dsc2, 2) + '</span><hr><span style="minheight:50px;">' + formatNumberThousand(full.ord_ag_remain_dsc2, 2) + '</span>';

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
           window.location.href = "/index.cfm/order.order-detail?orderId=" + info.id_order;
        }
    };
})();