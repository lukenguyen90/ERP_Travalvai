(function(){
	var myapp = angular.module('order.lines', ['datatables', 'datatables.light-columnfilter', 'ui.select2']);
	myapp.controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl);

	function BindAngularDirectiveCtrl($scope ,$filter,$http ,$compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout){
		var vm = this;
		vm.order = {};
		vm.isAgent = false;
		vm.isZone  = false;
		vm.dtInstance1 = {};
		vm.dtColumns1  = [];
		vm.classHideForZone = "";


		$http.get("/index.cfm/order/getUserLevel").success(function(dataResponse){
          	vm.userLvl = dataResponse;
      	});

		vm.dtOptions1 = DTOptionsBuilder.fromSource('/index.cfm/order.getOrderDetails?orderId=' + getQueryVariable('id'))
			.withPaginationType('full_numbers')
			.withLightColumnFilter({
	            '0' : {
	                type : 'text'
	            },
	            '1' : {
	                type : 'text'
	            },
	            '2' : {
	                type : 'text'
	            },
	            '3' : {
	                type : 'text'
	            },
	            '4' : {
	                type : 'text'
	            },
	            '5' : {
	                type : 'text'
	            },
	            '6' : {
	                type : 'text'
	            },
	            '7' : {
	                type : 'text'
	            },
	            '8' : {
	                type : 'text'
	            },
	            '9' : {
	                type : 'text'
	            },
	            '10' : {
	                type : 'text'
	            },
	            '11' : {
	                type : 'text'
	            },
	            '12' : {
	                type : 'text'
	            },
	            '13' : {
	                type : 'text'
	            },
	            '14' : {
	                type : 'text'
	            },
	            '15' : {
	                type : 'text'
	            },
	            '16' : {
	                type : 'text'
	            }
	            ,
	            '17' : {
	                type : 'text'
	            }
	            ,
	            '18' : {
	                type : 'text'
	            }
          	})
			.withOption('footerCallback', footerCallback)
			.withOption('createdRow', createdRow);

		function createdRow(row, data, dataIndex,iDisplayIndexFull) {
			// Recompiling so we can bind Angular directive to the DT
			$compile(angular.element(row).contents())($scope);
			return row;
		};

		vm.dtColumns1 = [
			DTColumnBuilder.newColumn('id_order_det').withTitle('LINE'),
			DTColumnBuilder.newColumn('garment').withTitle('GARMENT CODE'),
			DTColumnBuilder.newColumn('pr_version').withTitle('VERSION'),
			DTColumnBuilder.newColumn('cost_code').withTitle('COST CODE'),
			DTColumnBuilder.newColumn('cv_version').withTitle('COST CODE VERS'),
			DTColumnBuilder.newColumn('pr_description').withTitle('DESCRIPTION'),
			DTColumnBuilder.newColumn('sz_description').withTitle('SIZES'),
			DTColumnBuilder.newColumn('ordd_cg_name').withTitle('GROUP'),
			DTColumnBuilder.newColumn('ordd_name').withTitle('NAME'),
			DTColumnBuilder.newColumn('ordd_number').withTitle('NUMBER'),
			DTColumnBuilder.newColumn('ordd_size').withTitle('SIZE'),
			DTColumnBuilder.newColumn('ordd_qtty').withTitle('QUANTITY'),
			DTColumnBuilder.newColumn(null).withTitle('DELIVERED').renderWith(renderDelivered),
			DTColumnBuilder.newColumn(null).withTitle('PRICE PT.LST.').renderWith(renderPricePrList),
			DTColumnBuilder.newColumn(null).withTitle('PRICE PROD').renderWith(renderPriceProd),
			DTColumnBuilder.newColumn(null).withTitle('PRICE ORDER').renderWith(renderPriceOrder),
			DTColumnBuilder.newColumn(null).withTitle('CUSTOMIZATION').renderWith(renderCustom),
			DTColumnBuilder.newColumn(null).withTitle('TOTAL').renderWith(renderTotal),
			DTColumnBuilder.newColumn(null).withTitle('CURRENCY').renderWith(renderCurrecvy),
			DTColumnBuilder.newColumn('ord_fty_tot').withTitle('19').withOption("visible", false),
			DTColumnBuilder.newColumn('ord_zone_tot').withTitle('20').withOption("visible", false),
			DTColumnBuilder.newColumn('ord_ag_tot').withTitle('21').withOption("visible", false),
			DTColumnBuilder.newColumn('ord_plf').withTitle('22').withOption("visible", false),
			DTColumnBuilder.newColumn('ord_plz').withTitle('23').withOption("visible", false),
			DTColumnBuilder.newColumn('ordd_rcv_cs').withTitle('24').withOption("visible", false),
			DTColumnBuilder.newColumn('ordd_rcv_pr').withTitle('25').withOption("visible", false)
		];

		(function () {
			$(document).ready(function() {
				$('#orderDetailsTable').find('th').each(function() {
					if($(this).is(':empty')) {
						$(this).remove();
					}
				});
			})
		})();

		function renderDelivered(data, type, full, meta) {
			if(full.userLevel == 1) {
				return '<span style="minheight:50px;">' + full.ordd_del_fty + '</span><hr><span style="minheight:50px;">' + full.ordd_del_zone + '</span><hr><span style="minheight:50px;">' + full.ordd_del_ag + '</span>';
			}
			else if (full.userLevel == 2) {
				return '<span style="minheight:50px;">' + full.ordd_del_zone + '</span><hr><span style="minheight:50px;">' + full.ordd_del_ag + '</span>';
			}
			else if(full.userLevel == 3) {
				var deli = full.ordd_rcv_cs + full.ordd_rcv_pr;
				return '<span style="minheight:50px;">' + deli + '</span>';
			}
		}

		function renderPricePrList(data, type, full, meta) {
			if(full.userLevel == 1) {
				return '<span style="minheight:50px;">' + full.plfd_fty_sell_3 + '</span><hr><span style="minheight:50px;">' + full.plzd_zone_sell_6 + '</span><hr><span style="minheight:50px;">' + full.plzd_pvpr_8 + '</span>';
			}
			else if (full.userLevel == 2) {
				return '<span style="minheight:50px;">' + full.plzd_zone_sell_6 + '</span><hr><span style="minheight:50px;">' + full.plzd_pvpr_8 + '</span>';
			}
			else if(full.userLevel == 3) {
				return '<span style="minheight:50px;">' + full.plzd_pvpr_8 + '</span>';
			}
		}


		function renderPriceProd(data, type, full, meta) {
			if(full.userLevel == 1) {
				return '<span style="minheight:50px;">' + full.pr_fty_sell_9 + '</span><hr><span style="minheight:50px;">' + full.pr_zone_sell_10 + '</span><hr><span style="minheight:50px;">' + full.pr_pvpr_11 + '</span>';
			}
			else if (full.userLevel == 2) {
				return '<span style="minheight:50px;">' + full.pr_zone_sell_10 + '</span><hr><span style="minheight:50px;">' + full.pr_pvpr_11 + '</span>';
			}
			else if(full.userLevel == 3) {
				return '<span style="minheight:50px;">' + full.pr_pvpr_11 + '</span>';
			}
		}


		function renderPriceOrder(data, type, full, meta) {
			if(full.userLevel == 1) {
				return '<span style="minheight:50px;">' + full.ordd_fty_pr + '</span><hr><span style="minheight:50px;">' + full.ordd_zone_pr + '</span><hr><span style="minheight:50px;">' + full.pr_pvpr_11 + '</span>';
			}
			else if (full.userLevel == 2) {
				return '<span style="minheight:50px;">' + full.ordd_zone_pr + '</span><hr><span style="minheight:50px;">' + full.ordd_ag_pr + '</span>';
			}
			else if(full.userLevel == 3) {
				return '<span style="minheight:50px;">' + full.ordd_ag_pr + '</span>';
			}
		}

		function renderCustom(data, type, full, meta) {
			if(full.userLevel == 1) {
				return '<span style="minheight:50px;"></span><hr><span style="minheight:50px;"></span><hr><span style="minheight:50px;"></span>';
			}
			else if (full.userLevel == 2) {
				return '<span style="minheight:50px;"></span><hr><span style="minheight:50px;"></span>';
			}
			else if(full.userLevel == 3) {
				return '<span style="minheight:50px;"></span>';
			}
		}


		function renderTotal(data, type, full, meta) {
			if(full.userLevel == 1) {
				return '<span style="minheight:50px;">' + full.ord_fty_tot + '</span><hr><span style="minheight:50px;">' + full.ord_zone_tot + '</span><hr><span style="minheight:50px;">' + full.pr_pvpr_11 + '</span>';
			}
			else if (full.userLevel == 2) {
				return '<span style="minheight:50px;">' + full.ord_zone_tot + '</span><hr><span style="minheight:50px;">' + full.ord_ag_tot + '</span>';
			}
			else if(full.userLevel == 3) {
				return '<span style="minheight:50px;">' + full.ord_ag_tot + '</span>';
			}
		}



		function renderCurrecvy(data, type, full, meta) {
			if(full.userLevel == 1) {
				return '<span style="minheight:50px;">' + full.ord_plf + '</span><hr><span style="minheight:50px;">' + full.ord_plz + '</span><hr><span style="minheight:50px;">' + full.ord_plz + '</span>';
			}
			else if (full.userLevel == 2) {
				return '<span style="minheight:50px;">' + full.ord_plz + '</span><hr><span style="minheight:50px;">' + full.ord_plz + '</span>';
			}
			else if(full.userLevel == 3) {
				return '<span style="minheight:50px;">' + full.ord_plz + '</span>';
			}
		}


		function getQueryVariable(variable) {
	        var query = window.location.search.substring(1);
	        var vars = query.split("&");
	        for (var i=0;i<vars.length;i++) {
	          var pair = vars[i].split("=");
	          if (pair[0] == variable) {
	            return pair[1];
	          }
	        }
	    }
		$http.get("/index.cfm/order/getOrderById?orderId=" + getQueryVariable('id')).success(function(dataResponse){
			vm.order = dataResponse;
			if(vm.order.userLevel == 2) {
				vm.classHideForZone = "hide";
			}
			if(vm.order.userLevel == 3) {
				vm.isAgent = true;
			}


      	});	

      	function footerCallback(tfoot, row, data, start, end, display) {
            var api = this.api(), data;
			if(row.length==0) {
				return false;
			}
            // Remove the formatting to get integer data for summation
            var intVal = function ( i ) {
                return typeof i === 'string' ?
                    i.replace(/[\$,]/g, '')*1 :
                    typeof i === 'number' ?
                        i : 0;
            };
			var footerTpl = '';
			unitsTotal = api
						.column(11, { page: 'current'} )
						.data()
						.reduce( function (a, b) {
							return intVal(a) + intVal(b);
						}, 0 );
			ord_fty_value = api
						.column(19, { page: 'current'} )
						.data()
						.reduce( function (a, b) {
							return intVal(a) + intVal(b);
						}, 0 );
			ord_zone_value = api
						.column(20, { page: 'current'} )
						.data()
						.reduce( function (a, b) {
							return intVal(a) + intVal(b);
						}, 0 );
			ord_ag_value = api
						.column(21, { page: 'current'} )
						.data()
						.reduce( function (a, b) {
							return intVal(a) + intVal(b);
						}, 0 );
			ftyCurrency = api.column( 22, { page: 'current'} ).data()[0];
			zoneCurrency = api.column( 23, { page: 'current'} ).data()[0];
			agCurrency = api.column( 23, { page: 'current'} ).data()[0];
			ordd_rcv_cs = api
						.column(24, { page: 'current'} )
						.data()
						.reduce( function (a, b) {
							return intVal(a) + intVal(b);
						}, 0 );
			ordd_rcv_pr = api
						.column(25, { page: 'current'} )
						.data()
						.reduce( function (a, b) {
							return intVal(a) + intVal(b);
						}, 0 );

			ord_fty_value = $filter('number')(ord_fty_value, 2);
			ord_zone_value = $filter('number')(ord_zone_value, 2);
			ord_ag_value = $filter('number')(ord_ag_value, 2);
			if(vm.userLvl == 1) {
				footerTpl = '<tr><td colspan="21"></td></tr>'+
		 					'<tr>'+
							 	'<td colspan="11" style="font-weight: bold; text-align:right;">SUMMARY</td>'+
								'<td>'+ unitsTotal +'</td>'+
								'<td colspan="5"></td>'+
								'<td>'+ ord_fty_value +'</td>'+
								'<td>'+ ftyCurrency +'</td>'+
							'</tr>'+ 
							'<tr>'+
							 	'<td colspan="17"></td>'+
								'<td>'+ ord_zone_value +'</td>'+
								'<td>'+ zoneCurrency +'</td>'+
							'</tr>'+
							'<tr>'+
							 	'<td colspan="17"></td>'+
								'<td>'+ ord_ag_value +'</td>'+
								'<td>'+ agCurrency +'</td>'+
							'</tr>';
			}
			if(vm.userLvl == 2) {
				footerTpl = '<tr><td colspan="21"></td></tr>'+
		 					'<tr>'+
							 	'<td colspan="11" style="font-weight: bold; text-align:right;">SUMMARY</td>'+
								'<td>'+ unitsTotal +'</td>'+
								'<td colspan="5"></td>'+
								'<td>'+ ord_zone_value +'</td>'+
								'<td>'+ zoneCurrency +'</td>'+
							'</tr>'+
							'<tr>'+
							 	'<td colspan="17"></td>'+
								'<td>'+ ord_ag_value +'</td>'+
								'<td>'+ agCurrency +'</td>'+
							'</tr>';
			}
			if(vm.userLvl == 3) {
				var delivered = (ordd_rcv_cs + ordd_rcv_pr)*1;
				footerTpl = '<tr><td colspan="21"></td></tr>'+
		 					'<tr>'+
							 	'<td colspan="11" style="font-weight: bold; text-align:right;">SUMMARY</td>'+
								'<td>'+ unitsTotal +'</td>'+
								'<td>'+ delivered +'</td>'+
								'<td colspan="4"></td>'+
								'<td>'+ ord_ag_value +'</td>'+
								'<td>'+ agCurrency +'</td>'+
							'</tr>';
			}
			addFooterIntoTableResume(footerTpl);
		}

		function addFooterIntoTableResume(foot) {
			if($("#orderDetailsTable").children('tfoot').length > 0) {
				$("#orderDetailsTable").children('tfoot').remove();
			}				
			$("#orderDetailsTable").prepend("<tfoot>"+foot+"</tfoot>");		
		}
	};
})();