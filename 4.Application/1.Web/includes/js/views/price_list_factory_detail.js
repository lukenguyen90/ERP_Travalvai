(function () {
  var app = angular.module('price_list_factory_detail', ['datatables', 'ui.select2', 'datatables.light-columnfilter']).controller('BindAngularDirectiveCtrl', BindAngularDirectiveCtrl);

  function BindAngularDirectiveCtrl ($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder) {
        var vm = this;
        vm.showFilterModal = showFilterModal;
        vm.searchCosting = searchCosting;
        vm.userInfo =  {};
        vm.user =  {};
        vm.dtInstance =  {};
        vm.dtInstance_costing =  {};
        vm.dtOptions_costing = [];
        vm.enableEditSell3 = enableEditSell3;
        vm.doneEditSell3 = doneEditSell3;
        vm.returnFilter = returnFilter;
        vm.addCostingVersion = addCostingVersion;
        vm.refreshEdit = refreshEdit;
        vm.formatNumberThousand = formatNumberThousand;
        vm.metadata = -1;
        vm.PLF_Detail_Table =  {};
        vm.deletePLF = deletePLF;
        vm.ResetPrice = ResetPrice;
        vm.backState = backState;
        id_plf = getQueryVariable('id');

        function getQueryVariable (variable) {
          var query = window.location.search.substring(1);
          var vars = query.split('&');
          for (var i = 0; i < vars.length; i++ ) {
            var pair = vars[i].split('=');
            if (decodeURIComponent(pair[0]) == variable) {
              return decodeURIComponent(pair[1]);
            }
          }
        }

        $.ajax( {
          async:false,
          type:'GET',
          url:'/index.cfm/basicdata/getUserLevel',
          success:function (data) {
            vm.userInfo = data
            // if it is factory admin
            if (vm.userInfo.TYPEUSER == 1) {
              vm.isShowCreateBtn = true;
            }else {
              vm.isShowCreateBtn = false;
            }
          }
        })

        $.ajax( {
          async:false,
          type:'GET',
          url:'/index.cfm/price_list_factory_detail/getSeason',
          success:function (data) {
            vm.old_seasons = data;
          }
        })

        $.ajax( {
          type:'POST',
          url:'/index.cfm/price_list_factory/getPLF',
          async:false,
          data: {
            'id_price_list_factory':getQueryVariable('id')
          },
          success:function (data) {
            vm.user = angular.fromJson(data[0])
            $.ajax( {
              async:false,
              type:'GET',
              url:'/index.cfm/price_list_factory_detail/getCurrencyConvertById',
              data: {
                id_currency:vm.user.FTYCURRENCYID
              },
              success: function (data) {
                vm.user.exRateUSDToFtyCurrency = formatNumberThousand(data, 2);
                vm.user.calcuExRate = formatNumberThousand(data / vm.user.CREATION_DATE, 2);
                vm.user.devidedCalcuExRate = formatNumberThousand(1 / data, 2);
                vm.user.devidedExRate = formatNumberThousand(1 / vm.user.EX_RATE, 2);
              }
            })
          }
        })

        vm.sell3 = [];
        vm.editing = false;

        vm.dtOptions_detail = DTOptionsBuilder.fromSource('/index.cfm/price_list_factory_detail/getPLF_detail?id=' + getQueryVariable('id'))
          .withPaginationType('full_numbers')
          .withLightColumnFilter( {
            '0': {
              type:'text'
            },
            '1': {
              type:'text'
            },
            '2': {
              type:'text'
            },
            '3': {
              type:'text'
            },
            '4': {
              type:'text'
            },
            '5': {
              type:'text'
            },
            '6': {
              type:'text'
            },
            '7': {
              type:'text'
            }
          })
          .withOption('createdRow', createdRow)
          .withOption('select',  {style:'single'});

        vm.dtColumns_detail = [
          DTColumnBuilder.newColumn('COST_CODE').withTitle('CODE'),
          DTColumnBuilder.newColumn('CD_DESCRIPTION').withTitle('DESCRIPTION'),

          DTColumnBuilder.newColumn('CV_VERSION').withTitle('No.').withClass('text-center th-align-left'),
          DTColumnBuilder.newColumn('CVD_DESCRIPTION').withTitle('DESCRIPTION'),

          DTColumnBuilder.newColumn('FAC_COST').withTitle('FACTORY COST').renderWith(factoryCost).withClass('text-right th-align-left'),

          DTColumnBuilder.newColumn('FTY_CURR').withTitle('FACTORY SELL CALC').renderWith(factorySellCalc).withClass('text-right th-align-left'),

          DTColumnBuilder.newColumn('PL_CURR').withTitle('P.L. SELL CALC').renderWith(priceSellCalc).withClass('text-right th-align-left'),

          DTColumnBuilder.newColumn('PLFD_FTY_SELL_3').withTitle('FACTORY SELL PRICE').renderWith(editsell3).withClass('text-right th-align-left').withOption('width', '15%'),

          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').renderWith(actionsHtml).notSortable().withOption('width', '2%')
        ]

        function factoryCost (data, type, full, meta) {
          return '<span>' + formatNumber(full.FAC_COST) + ' - ' + full.CURR_CODE_FAC + '</span>';
        }

        function factorySellCalc (data, type, full, meta) {
          return '<span>' + formatNumber(full.FTY_CURR) + ' - ' + full.CURR_CODE_FAC + '</span>';
        }

        function priceSellCalc (data, type, full, meta) {
          return '<span>' + formatNumber(full.PL_CURR) + ' - ' + full.CURR_CODE + '</span>';
        }

        function formatNumber (data, type, full, meta) {
          return formatNumberThousand(data, 2);
        }

        
        // remove action without factory admin
        if (vm.userInfo.TYPEUSER != 1) {
          vm.dtColumns_detail.splice(13, 1);
        }

        function deletePLF (plfid) {
          $.ajax( {
            type:'POST',
            url:'/index.cfm/price_list_factory_detail/deletePLF',
            async:false,
            data: {
              'id_plf':plfid
            },
            success:function (data) {
              if (data.success) {
                noticeSuccess(data.message);
                vm.dtInstance.reloadData();
              }else {
                noticeFailed(data.message);
              }
            }
          })
        }

        function actionsHtml (data, type, full, meta) {
          vm.PLF_Detail_Table[data.ID] = data
          if (vm.userInfo.TYPEUSER == 1) {
            return '<span class="txt-color-red btndelete" title="Delete price list factory" ng-click="showCase.deletePLF(' + data.ID + ')">' +
              '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
          }else {
            return '';
          }
        }

        function editsell3 (data, type, full, meta) {
          var strStyle = ''
          if (full.PLFD_FTY_SELL_3 < full.PL_CURR) {
            strStyle = 'style="color: red;"';
          }
          return '<span ' + strStyle + ' ng-hide="showCase.editing && showCase.metadata == ' + meta.row + '" ng-click="showCase.enableEditSell3(' + meta.row + ',' + full.ID + ',' + full.PLFD_FTY_SELL_3 + ')">' + formatNumberThousand(data, 2) + '</span>' +
            '<input ng-show="showCase.editing && showCase.metadata == ' + meta.row + '" ng-enter="showCase.doneEditSell3(showCase.sell3[' + meta.row + '].ID,showCase.sell3[' + meta.row + '].PLFD_FTY_SELL_3)" autofocus ng-model="showCase.sell3[' + meta.row + '].PLFD_FTY_SELL_3"/>' + ' - ' + '<span>' + full.CURR_CODE + '</span>' +
            '<span class="txt-color-green btnedit" title="Edit" ng-show="!(showCase.editing && showCase.metadata == ' + meta.row + ')" ng-click="showCase.enableEditSell3(' + meta.row + ',' + full.ID + ',' + full.PLFD_FTY_SELL_3 + ')"><i class="ace-icon bigger-130 fa fa-pencil"></i></span>' +
            '<span class="txt-color-red btnSave" ng-show="showCase.editing && showCase.metadata == ' + meta.row + '" ng-click="showCase.doneEditSell3(showCase.sell3[' + meta.row + '].ID,showCase.sell3[' + meta.row + '].PLFD_FTY_SELL_3)">' +
            '   <i class="ace-icon bigger-130 fa fa-floppy-o"></i>' +
            '</span>' +
            '<span class="txt-color-red btnSave" ng-show="showCase.editing && showCase.metadata == ' + meta.row + '" ng-click="showCase.refreshEdit()">' +
            '   <i class="ace-icon bigger-130 fa fa-times"></i>' +
            '</span>';
        }

        function enableEditSell3 (metainfo, id, sell3value) {
          vm.editing = true;
          vm.metadata = metainfo;
        }

        function refreshEdit () {
          vm.editing = true;
          vm.metadata = -1;
        }

        function doneEditSell3 (id, data) {
          vm.editing = false;
          vm.metadata = -1;
          $.ajax( {
            type:'POST',
            url:'/index.cfm/price_list_factory_detail/updatePLFD_FTY_SELL_3',
            async:false,
            data: {
              'id':id,
              'sell3':Number(data)
            },
            success:function (data) {
              if (data == true) {
                vm.sell3 = [];
                vm.dtInstance.reloadData();
              }else {
                alert('Something went wrong. Can not update data!')
              }
            }
          })
        }

        function createdRow (row, data, dataIndex) {
          var newdata =  {
            'ID':data.ID,
            'PLFD_FTY_SELL_3':data.PLFD_FTY_SELL_3
          }
          vm.sell3.push(newdata);
          $compile(angular.element(row).contents())($scope);
        }

        $(document).ready(function () {
          $('#modalFilterArticle').on('shown.bs.modal', function () {
            $(this).find('#oseason').focus();
          })
        });

        function showFilterModal () {
          $("#oCode").select2("val","");
          vm.user.typecopy = 0;
          vm.user.oseason = '';
          vm.oCodes = [];
          $('#modalFilterArticle').modal('show');
          $scope.userForm1.oseason.$pristine = true;
        }
        
        var titleHtml = '<input name="select_all" id="select_all" type="checkbox">';

        vm.dtOptions_costing = DTOptionsBuilder.fromSource('/index.cfm/costing/getCostingVerions?view=0')
          .withPaginationType('full_numbers')
          .withOption('createdRow', function (row, data, dataIndex) {
            // Recompiling so we can bind Angular directive to the DT
            $compile(angular.element(row).contents())($scope)
          });

        vm.dtColumns_costing = [
          DTColumnBuilder.newColumn('id_cost').withTitle('ID'),
          DTColumnBuilder.newColumn('id_cost_version').withTitle('ID VERSION'),
          DTColumnBuilder.newColumn('cost_code').withTitle('CODE'),
          DTColumnBuilder.newColumn('cd_description').withTitle('DESCRIPTION'),
          DTColumnBuilder.newColumn('cost_season').withTitle('SEASON').withClass('text-right'),
          DTColumnBuilder.newColumn('cost_pl').withTitle('PRICE LIST'),
          DTColumnBuilder.newColumn('cv_version').withTitle('No.VERSION').withClass('text-center'),
          DTColumnBuilder.newColumn(null).withTitle(titleHtml).notSortable()
            .renderWith(function (data, type, full, meta) {
              return '<input type="checkbox" class="rowcheckbox" ng-click="showCase.chooseVersion(' + meta.row + ', ' + full.id_cost_version + ')" id="ck' + full.id_cost_version + '" name="id_cost_version" value="' +
                $('<div/>').text(full.id_cost_version).html() + '">'
            }).withClass('text-center')
        ];

        vm.dtColumns_costing[0].visible = false;
        vm.dtColumns_costing[1].visible = false;

        var unCheckAll = false;
        var bindedCheckAll = false;

        vm.chooseVersion = function (rowIndex, idCheckBox) {
          var tblCosting = $('#datatable_costing_listing').DataTable();
          var rowData = tblCosting.rows(rowIndex).data();
          var isChecked = $('#ck' + idCheckBox).is(':checked');
          
          rowData[0].chosen = isChecked;
          tblCosting.rows(rowIndex).data(rowData);
          
          $('#select_all').prop('checked', isCheckAll());

        }

        function isCheckAll(){
            var tblCosting = $('#datatable_costing_listing').DataTable();
            var dataRowLength = tblCosting.rows().data().length;

            for(var i = 0; i < dataRowLength; i++){
                var dataRow = tblCosting.rows(i).data()[0];
                if (typeof (dataRow.chosen) === 'undefined' || dataRow.chosen === false) {
                  return false;
                }
            }

            return true;
        }
        

        function updateCheckAll () {

            $('#datatable_costing_listing').DataTable().rows('tr:visible').every(function () {
                var rowData = this.data();
                var isChecked = (typeof(rowData.chosen) !== 'undefined' && rowData.chosen);
                $('#ck' + rowData.id_cost_version).prop('checked', isChecked);
            });

        }

        function bindCheckAll () {
            $('#select_all').on('click', function () {
              var isChecked = this.checked;
              $('.rowcheckbox').prop('checked', isChecked)

              var tblCosting = $('#datatable_costing_listing').DataTable();

              tblCosting.rows().every(function () {
                this.data().chosen = isChecked;
              
              })

            })

        }

        function searchCosting () {
          $('#modalFilterArticle').modal('hide');
          $('#modalCostListing').modal('show');
          $('#select_all').prop('checked', false);
          $(document).ready(function () {
            vm.dtOptions_costing = DTOptionsBuilder.fromSource('/index.cfm/costing/getCostingVerions?view=1&oseason=' + $('#oseason').val() + '&ocode=' + $('#oCode').val())
              .withOption('headerCallback', function (header) {
              })
              .withOption('fnInitComplete', function () {
                  bindCheckAll();
              })
              .withOption('fnDrawCallback', function () {
                
                  updateCheckAll();
              })
              .withOption('createdRow', function (row, data, dataIndex) {
                // Recompiling so we can bind Angular directive to the DT
                $compile(angular.element(row).contents())($scope);
              })

            vm.dtInstance_costing.reloadData();
          })
        }

        function rowClick (row, data, dataIndex) {
          // Recompiling so we can bind Angular directive to the DT
          $compile(angular.element(row).contents())($scope);
        }

        function addCostingVersion () {
          var arr_CV = []
          $('#datatable_costing_listing').DataTable().rows().every(function () {
            var rowData = this.data();
            if (typeof (rowData.chosen) !== 'undefined' && rowData.chosen === true)
              arr_CV.push(rowData.id_cost_version);
          })

          if (arr_CV.length === 0) {
            alert('Please select at least one costing version!')
          }else {
                $.ajax( {
                  type:'POST',
                  url:'/index.cfm/price_list_factory_detail/insertPLFDetail',
                  async:false,
                  data: {
                    'arr_cv':arr_CV,
                    'id_plf':getQueryVariable('id')
                  },
                  success:function (data) {
                    if (data.success === true) {
                      noticeSuccess(data.message);
                      vm.sell3 = [];
                      vm.dtInstance.reloadData();
                    }else {
                      noticeSuccess(data.message);
                    }
                    $('#modalCostListing').modal('hide');
                  }
                })
          }
        }

        $('#oseason').change(function () {
          if ( ! $('#oseason').val()) {
            $('#oCode').attr('disabled', 'disabled');
            vm.oCodes = [];
          }else {
            vm.oCodes = '';
            $('#oCode').removeAttr('disabled');
            var oseason = $('#oseason').val();
            $.ajax( {
              type:'POST',
              url:'/index.cfm/costing/getCostingLst',
              async:false,
              data: {
                'season':oseason
              },
              success:function (data) {
                vm.oCodes = data;
                $('#sameCode').attr('disabled', 'disabled')
              }
            });
          }
        });

        function returnFilter () {
          $('#modalCostListing').modal('hide');
          $('#modalFilterArticle').modal('show');
        }


        function ResetPrice (vm) {
          var result = confirm('Do you want to reset Factory Sell Price?')
          if (result) {
            var oTable = vm.dtInstance.dataTable;
            var filteredRows = oTable._('tr', { "filter": "applied", "page": "all" });
            var filteredData = [];
            for(var i=0; i < filteredRows.length;i++){
              filteredData.push(filteredRows[i]);
            }
            $.ajax( {
              type:'POST',
              url:'/index.cfm/price_list_factory_detail/resetPrice',
              async:false,
              data: {
                'id_plf':id_plf,
                'filteredData': JSON.stringify(filteredData)
              },
              success:function (data) {
                if (data.success == true) {
                  noticeSuccess(data.message);
                }else {
                  noticeSuccess(data.message);
                }
                vm.sell3 = []
                vm.dtInstance.reloadData();
              }
            })
          }
        }

        function backState () {
          history.back()
        }

  }


  app.directive('ngEnter', function () {
      return function (scope, element, attrs) {
        element.bind('keydown keypress', function (event) {
          if (event.which === 13) {
            scope.$apply(function () {
              scope.$eval(attrs.ngEnter);
            })
            event.preventDefault()
          }
        })
      }
    });
})();
