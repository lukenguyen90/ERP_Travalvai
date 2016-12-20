(function() {
    'use strict'
    angular
        .module('order.ctrls')
        .controller("ResumeFactoryCtrl", resumeFactoryCtrl);

    function resumeFactoryCtrl($q, $scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, $resource, orderListService) {
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
                         if(data.data.session == false){
                           window.location.href = data.data.backlink;
                        }else{
                            fnCallback(data.data);
                        }
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
                    customButton().updateButtonContainerStyle();

                })
                .withButtons(utils().dataTable().getButtonsConfiguration());

            vm.columns = [
                DTColumnBuilder.newColumn('id_order').withTitle('ORDER').withClass("text-center"), //0
                DTColumnBuilder.newColumn(null).withTitle('CUSTOMER').renderWith(renderCustomer), //1
                DTColumnBuilder.newColumn('ag_description').withTitle('AGENT'), //2
                DTColumnBuilder.newColumn('z_description').withTitle('ZONE'), //3
                DTColumnBuilder.newColumn('ord_description').withTitle('ORDER DESCRIPTION'), //4
                DTColumnBuilder.newColumn('ot_description').withTitle('ORDER TYPE'), //5
                DTColumnBuilder.newColumn('oc_description').withTitle('ORDER CONDITION'), //6
                DTColumnBuilder.newColumn('os_description').withTitle('STATUS'), //7
                DTColumnBuilder.newColumn('ord_fty_confirm').withTitle('FACTORY CONFIRMATION').withClass("text-right"), //8
                DTColumnBuilder.newColumn('ord_fty_del_date').withTitle('FACTORY DELIVERY DATE').withClass("text-center"), //9
                DTColumnBuilder.newColumn(null).withTitle('TOTAL UNITS').renderWith(renderTotalUnits).withOption("width", "1%").withClass("text-center"), //10
                DTColumnBuilder.newColumn(null).withTitle('UNITS DELIVERED').renderWith(renderUnitsDelivered).withClass("text-center"), //11
                DTColumnBuilder.newColumn(null).withTitle('PENDENT TO DELIVER').renderWith(renderPendentDelivered).withClass("text-center"), //12
                DTColumnBuilder.newColumn(null).withTitle('ORDER VALUE').renderWith(renderOderValue).withClass("text-right"), //13              
                DTColumnBuilder.newColumn('ord_plf').withTitle('CUR').withClass("text-left"), //14

                DTColumnBuilder.newColumn('ord_units').withTitle('15').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_fty_delivered').withTitle('16').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_fty_pendent').withTitle('17').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_fty_value').withTitle('18').withOption("visible", false),
                DTColumnBuilder.newColumn('ord_plf').withTitle('19').withOption("visible", false),
                DTColumnBuilder.newColumn('count_row').withTitle('20').withOption("visible", false),
                DTColumnBuilder.newColumn(null).withTitle('DETAIL').notSortable().renderWith(vm.renderDetail).withOption("width", "2%").withClass("text-center detail"), //21
                DTColumnBuilder.newColumn(null).withTitle('').notSortable().renderWith(vm.renderActions).withOption("width", "2%").withClass("text-center action"), //22
            ];
        }

        function renderUnits(data, type, full, meta) {
            return formatNumberThousand(data.ord_units);
        }

        function renderSummary(tfoot, row, data, start, end, display) {
            var api = this.api();
            // Update footer
            var startIndex = 15;
            var unitsTotal = utils().dataTable().getColumnSummary(api, startIndex);
            var ftyUnitsDeliveredTotal = utils().dataTable().getColumnSummary(api, startIndex + 1);
            var factoryPendent = utils().dataTable().getColumnSummary(api, startIndex + 2);
            var ftyOrderValues = utils().dataTable().getColumnSummary(api, startIndex + 3);

            var orderCurrency = utils().dataTable().getColumnValue(api, startIndex + 4);
            var count_row = utils().dataTable().getColumnSummary(api, startIndex + 5);
            var footerTpl = '';

            footerTpl = '<tr><td colspan="18"></td></tr>' +
                '<tr>' +
                '<td colspan="9" class="vertical-middle text-right">SUMMARY</td>' +

                '<td class="vertical-middle text-center">' + formatNumberThousand(count_row) + '</td>' +
                '<td class="text-center">' +
                formatNumberThousand(unitsTotal) +
                '</td>' +

                '<td class="text-center">' +
                formatNumberThousand(ftyUnitsDeliveredTotal) +
                '</td>' +

                '<td class="text-center">' +
                formatNumberThousand(factoryPendent) +
                '</td>' +

                '<td class="text-right vertical-bottom">' + formatNumberThousand(ftyOrderValues, 2) + '</td>' +
                '<td class="text-left vertical-bottom">' + orderCurrency + '</td>' +
                '<td colspan="2">' + '</td>' +
                '</tr>';

            $(api.table().footer()).html(footerTpl);
        }


        function renderCustomer(data, type, full, meta) {

            return '<span style="minheight:50px;">' + data.id_customer + " - " + data.cs_name + '</span>';
        }


        function renderTotalUnits(data, type, full, meta) {
            return formatNumberThousand(data.ord_units);
        }

        function renderUnitsDelivered(data, type, full, meta) {
            return formatNumberThousand(data.ord_fty_delivered);
        }

        function renderPendentDelivered(data, type, full, meta) {
            return formatNumberThousand(data.ord_fty_pendent);
        }

        function renderOderValue(data, type, full, meta) {
            return formatNumberThousand(data.ord_fty_value, 2);
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