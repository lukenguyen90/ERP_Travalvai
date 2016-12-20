(function() {
    'use strict'
    angular
        .module('order.ctrls')
        .controller("ResumeZoneCtrl", resumeZoneCtrl);

    function resumeZoneCtrl($q, $scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, $resource, orderListService) {
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
                DTColumnBuilder.newColumn('ag_description').withTitle('AGENT'), //2
                DTColumnBuilder.newColumn('ord_description').withTitle('ORDER DESCRIPTION'), //3
                DTColumnBuilder.newColumn('ot_description').withTitle('ORDER TYPE'), //4
                DTColumnBuilder.newColumn('oc_description').withTitle('ORDER CONDITION'), //5
                DTColumnBuilder.newColumn('os_description').withTitle('STATUS'), //6
                DTColumnBuilder.newColumn('ord_fty_del_date').withTitle('FACTORY DELIVERY DATE').withClass("text-right"), //7
                DTColumnBuilder.newColumn('ord_zone_del_date').withTitle('ZONE DELIVERY DATE').withClass("text-right"), //8
                DTColumnBuilder.newColumn('ord_ag_del_date').withTitle('AGENT DELIVERY DATE').withClass("text-right"), //9
                DTColumnBuilder.newColumn(null).withTitle('TOTAL UNITS').renderWith(renderUnits).withOption("width", "1%").withClass("text-center"), //10                
                DTColumnBuilder.newColumn(null).renderWith(renderUnitsReceived).withTitle('UNITS RECEIVED').withClass("text-center"), //11
                DTColumnBuilder.newColumn(null).renderWith(renderUnitsDeliverToAgent).withTitle('UNITS DELIV. TO AGENT').withClass("text-center"),//12
                DTColumnBuilder.newColumn(null).renderWith(renderUnitsDeliverToCustomer).withTitle('UNITS DELIV. TO CUSTOMER').withClass("text-center"),//13
                DTColumnBuilder.newColumn(null).renderWith(renderOrderCost).withTitle('ORDER COST').withClass("text-right"),//14            
                DTColumnBuilder.newColumn(null).renderWith(renderDiscount1).withTitle('ORDER VALUE CUST. DISCOUNT 1').withClass("text-right"),//15
                DTColumnBuilder.newColumn(null).renderWith(renderDiscount2).withTitle('ORDER VALUE CUST. DISCOUNT 2').withClass("text-right"),//16 
                DTColumnBuilder.newColumn('ord_plz').withTitle('ZONE CURRENCY').withClass("text-left"), //17

                DTColumnBuilder.newColumn('ord_units').withTitle('18').withOption("visible", false),
                DTColumnBuilder.newColumn('count_row').withTitle('19').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_fty_delivered').withTitle('20').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_zone_delivered').withTitle('21').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_ag_delivered').withTitle('22').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_fty_value').withTitle('23').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_ag_value_dsc1').withTitle('24').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_ag_value_dsc2').withTitle('25').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_plf').withTitle('26').withOption("visible", false),
                DTColumnBuilder.newColumn(null).withTitle('DETAIL').notSortable().renderWith(vm.renderDetail).withOption("width", "2%").withClass("text-center detail"), //28
                DTColumnBuilder.newColumn(null).withTitle('').notSortable().renderWith(vm.renderActions).withOption("width", "2%").withClass("text-center action"), //28
            ];
        }
        function renderUnits(data, type, full, meta) {
            return formatNumberThousand(data.ord_units);
        }
        function renderUnitsReceived(data, type, full, meta) {
            return formatNumberThousand(data.ord_fty_delivered);
        }
        function renderUnitsDeliverToAgent(data, type, full, meta) {
            return formatNumberThousand(data.ord_zone_delivered);
        }
        function renderUnitsDeliverToCustomer(data, type, full, meta) {
            return formatNumberThousand(data.ord_ag_delivered);
        }
        function renderOrderCost(data, type, full, meta) {
            if(data.ord_fty_value > 0){
                return formatNumberThousand(data.ord_fty_value) + '-' + data.ord_plf;
            }else{
                return "-";
            }
        }
        function renderDiscount1(data, type, full, meta) {
            return formatNumberThousand(data.ord_ag_value_dsc1, 2);
        }
        function renderDiscount2(data, type, full, meta) {
            return formatNumberThousand(data.ord_ag_value_dsc2, 2);
        }

        function renderSummary(tfoot, row, data, start, end, display) {
            var api = this.api();
            // Update footer
            var startIndex = 18;

            var unitsTotal = utils().dataTable().getColumnSummary(api, startIndex);
            var count_agent_deliver  = utils().dataTable().getColumnSummary(api, startIndex + 1);
            var unitsReceivedTotal   = utils().dataTable().getColumnSummary(api, startIndex + 2);           
            var unitsDeliverAgent    = utils().dataTable().getColumnSummary(api, startIndex + 3);
            var unitsDeliverCustomer = utils().dataTable().getColumnSummary(api, startIndex + 4);
            var unitsOrderCost   = utils().dataTable().getColumnSummary(api, startIndex + 5);
            var unitsDiscount1   = utils().dataTable().getColumnSummary(api, startIndex + 6);
            var unitsDiscount2   = utils().dataTable().getColumnSummary(api, startIndex + 7);
            var orderZoneCurrency = utils().dataTable().getColumnValue(api, 17);
            var orderFacCurrency = utils().dataTable().getColumnValue(api, 26);
            var footerTpl = '';
            footerTpl = '<tr><td colspan="20"></td></tr>' +
                '<tr>' +
                    '<td colspan="9" class="vertical-middle text-right">SUMMARY</td>' +

                    '<td class="vertical-middle text-center">' + (count_agent_deliver > 0 ? formatNumberThousand(count_agent_deliver) : "-") + '</td>' +
                    '<td class="text-center">' +
                    formatNumberThousand(unitsTotal) +
                    '</td>' +

                    '<td class="text-center">'+ (unitsReceivedTotal > 0 ? formatNumberThousand(unitsReceivedTotal) : "-") + '</td>' +
                    '<td class="text-center">' + (unitsDeliverAgent > 0 ? formatNumberThousand(unitsDeliverAgent) : "-") + '</td>' +
                    '<td class="text-center">' + (unitsDeliverCustomer > 0 ? formatNumberThousand(unitsDeliverCustomer) : "-") + '</td>' +
                    '<td class="text-center">' + (unitsOrderCost >0 ? (formatNumberThousand(unitsOrderCost, 2) + "-" + orderFacCurrency) : "-")  + '</td>' +
                    '<td class="text-right">'  + formatNumberThousand(unitsDiscount1, 2) + '</td>' +
                    '<td class="text-right">'  + formatNumberThousand(unitsDiscount2, 2) + '</td>' +
                    '<td>'  + orderZoneCurrency + '</td>' +
                    '<td colspan="2">'  +  '</td>' +
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