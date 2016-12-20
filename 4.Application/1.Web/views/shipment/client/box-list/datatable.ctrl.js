(function() {
    'use strict';
    angular.module('shipment.services').factory('DatatableBoxCtrl', datatableBoxCtrl);

    function datatableBoxCtrl(BoxListService, $http, $compile) {
        return {
            getOptions: getOptions,
            getColumnsDef: getColumnsDef
        }

        function getOptions(DTOptionsBuilder, $scope) {
            var options = DTOptionsBuilder.newOptions()
                .withDataProp('data')
                .withOption('ajax', {
                    url: 'index.cfm/shipment/getBoxList'
                })
                .withOption('serverSide', true)
                .withFnServerData(function (sSource, aoData, fnCallback, oSettings){
                    $http.get('index.cfm/shipment/getBoxList', {
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
                        JsBarcode(".barcode").init();
                    });
                })
                .withPaginationType('full_numbers')
                .withLightColumnFilter({
                    '0': {
                        type: 'text',
                    },
                    '1': {
                        type: 'text'
                    },
                    '2': {
                        type: 'text'
                    },
                    '3': {
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
                .withOption('createdRow', function createdRow(row, data, dataIndex, iDisplayIndexFull) {
                    $compile(angular.element(row).contents())($scope);
                    return row;
                })

                .withOption('fnInitComplete', function() {
                    JsBarcode(".barcode").init();
                    removeInVisibleHeader();
                });
            // .withButtons(utils().dataTable().getButtonsConfiguration());

            return options;
        }

        function getColumnsDef(DTColumnBuilder) {
            var columns = [
                DTColumnBuilder.newColumn('id_box').withTitle('ID').withOption("width", "20%").withClass('text-center'), //0
                DTColumnBuilder.newColumn('bx_code').withTitle('CODE').withOption("width", "20%"), //1
                DTColumnBuilder.newColumn('tb_description').withTitle('TYPE BOX (D*L*W)'), //2
                DTColumnBuilder.newColumn('bx_weight').withTitle('WEIGHT').withClass('text-right'), //3
                DTColumnBuilder.newColumn(null).withTitle('BARCODE').renderWith(renderBarcode).withOption("width", "20%"),//4
                DTColumnBuilder.newColumn(null).withTitle('ACTIONS').withOption("width", "4%").renderWith(renderActions).withClass('text-left'), //5
                DTColumnBuilder.newColumn('id_type_box').withTitle('ID TYPE BOX').withOption("visible", false), //6

            ];

            return columns;
        }
       
        function renderActions(data, type, full, meta) {
            var strData = JSON.stringify(data).toString();
            return "<span class='txt-color-green btnedit' title='Edit Box' ng-click='vm.editBox("+strData+")'>" +
                "   <i class='ace-icon bigger-130 fa fa-pencil'></i></span>"+
            "<span class='txt-color-red btnDelete' title='Delete Box' ng-click='vm.deleteBox("+data.id_box+")' ng-confirm-message>" +
                "   <i class='ace-icon bigger-130 fa fa-trash-o'></i>" +
                "</span>";
        }

        function renderBarcode(data, type, full, meta) {
            return "<svg class='barcode'\
                        jsbarcode-height = '50'\
                        jsbarcode-width = '1'\
                        jsbarcode-value='"+data.bx_code+"'>\
                    </svg>"
        }        

        function removeInVisibleHeader() {

            window.setTimeout(function() {
                $('#tbl-box-list thead tr:last').children('th').each(function() {
                    if ($(this).is(':empty')) {
                        $(this).remove();
                    }
                });
            }, 100);

        }


    }

})();