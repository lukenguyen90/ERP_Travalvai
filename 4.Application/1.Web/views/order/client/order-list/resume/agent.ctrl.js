(function() {
    'use strict'
    angular
        .module('order.ctrls')
        .controller("ResumeAgentCtrl", resumeAgentCtrl);

    function resumeAgentCtrl($q, $scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, $resource, orderListService) {
        var vm = this;
        angular.extend(vm, $controller('ResumeCtrl', { $scope: $scope }));

        vm.options = {};
        vm.columns = [];
        vm.instance = {};


        vm.initResume = initResume;

        function initResume() {

            loadDatatable();
        }

        function loadDatatable() {
            var url = '/index.cfm/order/getResumeOrders';
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
                .withOption('order', [0, 'desc'])
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
                .withOption('footerCallback', renderSummary)
                .withOption('createdRow', createdRow)
                .withOption('stateSave', true)
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
                DTColumnBuilder.newColumn('ord_description').withTitle('ORDER DESCRIPTION'), //2
                DTColumnBuilder.newColumn('ot_description').withTitle('ORDER TYPE'), //3
                DTColumnBuilder.newColumn('oc_description').withTitle('ORDER CONDITION'), //4
                DTColumnBuilder.newColumn('os_description').withTitle('STATUS'), //5

                DTColumnBuilder.newColumn('ord_zone_del_date').withTitle('ZONE DELIVERY DATE').withClass("text-right"), //6
                DTColumnBuilder.newColumn('ord_ag_del_date').withTitle('AGENT DELIVERY DATE'), //7              
                DTColumnBuilder.newColumn(null).renderWith(renderTotalUnits).withTitle('TOTAL UNITS').withOption("width", "1%").withClass("text-center"), //8

                DTColumnBuilder.newColumn(null).renderWith(renderUnitsReceived).withTitle('UNITS RECEIVED').withClass("text-center"), //9
                DTColumnBuilder.newColumn(null).renderWith(renderCost).withTitle('COST').withClass('text-right'), //10   
                DTColumnBuilder.newColumn(null).renderWith(renderDiscount1).withTitle('ORDER VALUE CUST. DISCOUNT 1').withClass('text-right'), //11   
                DTColumnBuilder.newColumn(null).renderWith(renderDiscount2).withTitle('ORDER VALUE CUST. DISCOUNT 2').withClass('text-right'), //12    
                DTColumnBuilder.newColumn('ord_plz').withTitle('CURRENCY'), //13

                DTColumnBuilder.newColumn('count_row').withTitle('14').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_units').withTitle('15').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_zone_delivered').withTitle('16').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_ag_value').withTitle('17').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_ag_value_dsc1').withTitle('18').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_ag_value_dsc2').withTitle('19').withOption("visible", false),
                DTColumnBuilder.newColumn(null).withTitle('DETAIL').notSortable().renderWith(vm.renderDetail).withOption("width", "2%").withClass("text-center detail"), //20
                DTColumnBuilder.newColumn(null).withTitle('').notSortable().renderWith(vm.renderActions).withOption("width", "2%").withClass("text-center action"), //21
            ];
        }

        function renderTotalUnits(data, type, full, meta) {
            return formatNumberThousand(data.ord_units);
        }

        function renderUnitsReceived(data, type, full, meta) {
            return formatNumberThousand(data.ord_zone_delivered);
        }

        function renderCost(data, type, full, meta) {
            return formatNumberThousand(data.ord_ag_value);
        }

        function renderDiscount1(data, type, full, meta) {
            return formatNumberThousand(data.ord_ag_value_dsc1);
        }

        function renderDiscount2(data, type, full, meta) {
            return formatNumberThousand(data.ord_ag_value_dsc2);
        }

        function renderSummary(tfoot, row, data, start, end, display) {
            var api = this.api();
            // Update footer
            var startIndex = 14;

            var count_agent_deliver = utils().dataTable().getColumnSummary(api, startIndex);
            var unitsTotal = utils().dataTable().getColumnSummary(api, startIndex + 1);
            var zoneUnitsDeliveredTotal = utils().dataTable().getColumnSummary(api, startIndex + 2);
            var unitsCost = utils().dataTable().getColumnSummary(api, startIndex + 3);
            var discount1 = utils().dataTable().getColumnSummary(api, startIndex + 4);
            var discount2 = utils().dataTable().getColumnSummary(api, startIndex + 5);
            var orderCurrency = utils().dataTable().getColumnValue(api, 13);
            var footerTpl = '';

            footerTpl = '<tr><td colspan="16"></td></tr>' +
                '<tr>' +
                '<td colspan="7" class="vertical-middle text-right">SUMMARY</td>' +

                '<td class="vertical-middle text-center">' + formatNumberThousand(count_agent_deliver) + '</td>' +
                '<td class="vertical-middle text-center">' + formatNumberThousand(unitsTotal) + '</td>' +
                '<td class="text-center">' + formatNumberThousand(zoneUnitsDeliveredTotal) + '</td>' +
                '<td class="text-right">' + formatNumberThousand(unitsCost, 2) + '</td>' +
                '<td class="text-right">' + formatNumberThousand(discount1, 2) + '</td>' +
                '<td class="text-right vertical-bottom">' + formatNumberThousand(discount2, 2) + '</td>' +
                '<td class="text-left vertical-bottom">' + orderCurrency + '</td>' +
                '<td colspan="2">' + '</td>' +
                '</tr>';

            $(api.table().footer()).html(footerTpl);
        }


        function renderCustomer(data, type, full, meta) {

            return '<span style="minheight:50px;">' + data.id_customer + " - " + data.cs_name + '</span>';
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