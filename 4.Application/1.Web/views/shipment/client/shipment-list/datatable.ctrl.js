(function() {
    'use strict';
    angular.module('shipment.services').factory('datatableCtrl', datatableCtrl);

    function datatableCtrl(shipmentListService) {

        return {
            getOptions: getOptions,
            getColumnsDef: getColumnsDef
        }

        function getOptions(DTOptionsBuilder, from, to) {
            var options = DTOptionsBuilder.fromFnPromise(function() {
                    var shipmentType = shipmentListService.getShipmentType(from, to);
                    return shipmentListService.getShipments(shipmentType);
                    //return orderListService.getListOrders();
                    // return $resource('../../../../views/order/client/order-list/data.json').query().$promise;
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
                    }
                })
                //.withOption('footerCallback', renderSummary)
                //.withOption('createdRow', createdRow)
                .withOption('stateSave', true)
                .withOption('select', { style: 'single' })
                .withOption('order', [0, 'desc'])
                .withOption('stateLoadCallback', function(oSettings) {
                    //return vm.getCachedData();
                })
                .withOption('fnInitComplete', function() {

                    // vm.removeVisibleHeader();
                    // vm.renderCachedFilter();
                    //custom button configuration
                    // customButton().updateButtonContainerStyle();

                });
            // .withButtons(utils().dataTable().getButtonsConfiguration());

            return options;
        }

        function getColumnsDef(DTColumnBuilder) {
            var columns = [
                DTColumnBuilder.newColumn('id_shipment'), //0
                DTColumnBuilder.newColumn('st_code'), //1
                DTColumnBuilder.newColumn('sh_send'), //2
                DTColumnBuilder.newColumn('sh_desti'), //3
                DTColumnBuilder.newColumn('sh_status'), //4
                DTColumnBuilder.newColumn('fw_name'), //5
                DTColumnBuilder.newColumn('fr_description'), //6
                DTColumnBuilder.newColumn('sh_incoterm'), //7
                DTColumnBuilder.newColumn('sh_tot_unit'), //8

                DTColumnBuilder.newColumn('sh_tot_box'), //9
                DTColumnBuilder.newColumn('sh_tot_weight'), //10
                DTColumnBuilder.newColumn('sh_tot_vol'), //11
                DTColumnBuilder.newColumn('sh_open_date'), //12
                DTColumnBuilder.newColumn('sh_estim_del_date'), //13
                DTColumnBuilder.newColumn('sh_delivery_date'), //14
                DTColumnBuilder.newColumn('sh_estim_arr_date'), //15
                DTColumnBuilder.newColumn('sh_arrival_date'), //16

                DTColumnBuilder.newColumn('sh_frg_cost'), //17

                DTColumnBuilder.newColumn('sh_taxes'), //18

                DTColumnBuilder.newColumn('sh_imp_duty') //19


            ];

            return columns;
        }
    }

})();