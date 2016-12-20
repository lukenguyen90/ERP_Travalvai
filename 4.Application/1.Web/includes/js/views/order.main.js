(function(){
	var myapp = angular.module('order.main', ['datatables', 'datatables.light-columnfilter', 'ui.select2']);
	myapp.controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl);

	function BindAngularDirectiveCtrl($scope ,$filter,$http ,$compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout){
		var vm = this;
		vm.dtInstance1 = {};
		vm.dtInstance2 = {};
		vm.dtColumns1  = [];
		vm.dtColumns2  = [];
    	vm.doubleclickHandler = doubleclickHandler;


		$http.get("/index.cfm/order/getUserLevel").success(function(dataResponse){

          	vm.userLvl = dataResponse;
			if(vm.userLvl == 1) {
				vm.dtColumns2  = [
					DTColumnBuilder.newColumn('id_order').withTitle('ORDER'),
					DTColumnBuilder.newColumn('id_customer').withTitle('CUSTOMER'),
					DTColumnBuilder.newColumn('cs_name').withTitle('CUSTOMER'),
					DTColumnBuilder.newColumn('ag_description').withTitle('AGENT'),
					DTColumnBuilder.newColumn('z_description').withTitle('ZONE'),
					DTColumnBuilder.newColumn('ord_description').withTitle('ORDER DESCRIPTION'),
					DTColumnBuilder.newColumn('ot_description').withTitle('ORDER TYPE'),
					DTColumnBuilder.newColumn('oc_description').withTitle('ORDER CONDITION'),
					DTColumnBuilder.newColumn('os_description').withTitle('STATUS'),
					DTColumnBuilder.newColumn('ord_fty_confirm').withTitle('FACTORY CONFIRMATION'),
					DTColumnBuilder.newColumn('ord_fty_del_date').withTitle('FACTORY DELIVERY DATE'),
					DTColumnBuilder.newColumn('ord_units').withTitle('TOTAL UNITS'),
					DTColumnBuilder.newColumn('ord_fty_delivered').withTitle('UNITS DELIVERED'),
					DTColumnBuilder.newColumn('calc_1').withTitle('PENDENT TO DELIVERY'),
					DTColumnBuilder.newColumn('ord_fty_value').withTitle('ORDER VALUE'),
					DTColumnBuilder.newColumn('ord_plf').withTitle('CURRENCY')
				];
			}
			if(vm.userLvl == 2) {
				vm.dtColumns2  = [
					DTColumnBuilder.newColumn('id_order').withTitle('ORDER'),
					DTColumnBuilder.newColumn('id_customer').withTitle('CUSTOMER'),
					DTColumnBuilder.newColumn('cs_name').withTitle('CUSTOMER'),
					DTColumnBuilder.newColumn('ag_description').withTitle('AGENT'),
					DTColumnBuilder.newColumn('ord_description').withTitle('ORDER DESCRIPTION'),
					DTColumnBuilder.newColumn('ot_description').withTitle('ORDER TYPE'),
					DTColumnBuilder.newColumn('oc_description').withTitle('ORDER CONDITION'),
					DTColumnBuilder.newColumn('os_description').withTitle('STATUS'),
					DTColumnBuilder.newColumn('ord_fty_del_date').withTitle('FACTORY DELIVERY DATE'),
					DTColumnBuilder.newColumn('ord_zone_del_date').withTitle('ZONE DELIVERY DATE'),
					DTColumnBuilder.newColumn('ord_ag_del_date').withTitle('AGENT DELIVERY DATE'),
					DTColumnBuilder.newColumn('ord_units').withTitle('TOTAL UNITS'),
					DTColumnBuilder.newColumn('ord_fty_delivered').withTitle('UNITS RECEIVED'),
					DTColumnBuilder.newColumn('ord_zone_delivered').withTitle('UNITS DELIV. TO AGENT'),
					DTColumnBuilder.newColumn('ord_ag_delivered').withTitle('UNITS DELIV. TO CUSTOMER'),
					DTColumnBuilder.newColumn('ord_fty_value').withTitle('ORDER COST'),
					DTColumnBuilder.newColumn('ord_plf').withTitle('CURRENCY'),
					DTColumnBuilder.newColumn('ord_ag_value_dsc1').withTitle('ORDER VALUE CUST. DISCOUNT 1'),
					DTColumnBuilder.newColumn('ord_ag_value_dsc2').withTitle('ORDER VALUE CUST. DISCOUNT 2'),
					DTColumnBuilder.newColumn('ord_plz').withTitle('CURRENCY')
				];
			}
			if(vm.userLvl == 3) {

				vm.dtColumns2  = [
					DTColumnBuilder.newColumn('id_order').withTitle('ORDER'),
					DTColumnBuilder.newColumn('id_customer').withTitle('CUSTOMER'),
					DTColumnBuilder.newColumn('cs_name').withTitle('CUSTOMER'),
					DTColumnBuilder.newColumn('ord_description').withTitle('ORDER DESCRIPTION'),
					DTColumnBuilder.newColumn('ot_description').withTitle('ORDER TYPE'),
					DTColumnBuilder.newColumn('oc_description').withTitle('ORDER CONDITION'),
					DTColumnBuilder.newColumn('os_description').withTitle('STATUS'),
					DTColumnBuilder.newColumn('ord_zone_del_date').withTitle('ZONE DELIVERY DATE'),
					DTColumnBuilder.newColumn('ord_ag_del_date').withTitle('AGENT DELIVERY DATE'),
					DTColumnBuilder.newColumn('ord_units').withTitle('TOTAL UNITS'),
					DTColumnBuilder.newColumn('ord_zone_delivered').withTitle('UNITS RECEIVED'),
					DTColumnBuilder.newColumn('ord_ag_delivered').withTitle('UNITS DELIV. TO CUSTOMER'),
					DTColumnBuilder.newColumn('ord_fty_value').withTitle('COST'),
					DTColumnBuilder.newColumn('ord_ag_value_dsc1').withTitle('ORDER VALUE CUST. DISCOUNT 1'),
					DTColumnBuilder.newColumn('ord_ag_value_dsc2').withTitle('ORDER VALUE CUST. DISCOUNT 2'),
					DTColumnBuilder.newColumn('ord_plz').withTitle('CURRENCY')					
				];

			}
			
      	});



		vm.dtOptions1  = DTOptionsBuilder.fromSource('/index.cfm/order.getOrders')
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
          	})
			.withOption('footerCallback', footerCallback)
			.withOption('createdRow', createdRow);

		vm.dtOptions2  = DTOptionsBuilder.fromSource('/index.cfm/order.getOrders')
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
	            },
	            '17' : {
	                type : 'text'
	            },
	            '18' : {
	                type : 'text'
	            },
	            '19' : {
	                type : 'text'
	            }
          	})
			.withOption('footerCallback', footerCallback2)
			.withOption('createdRow', createdRow);
		
		function footerCallback2(tfoot, row, data, start, end, display) {
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

			if(vm.userLvl == 1) {

				deliveriedDateTotal = api
					.column( 0, { page: 'current'} )
					.data().length;
				unitsTotal = api
					.column(11, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );	
				unitsDeliveredTotal = api
					.column(12, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );
				pendent = api
					.column(13, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );
				orderValues = api
					.column(14, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );
				finalCurrency = api.column( 15, { page: 'current'} ).data()[0];			
				footerTpl = '<tr><td colspan="16"></td></tr>'+
			 					'<tr>'+
								 	'<td colspan="10" style="font-weight: bold; text-align:right;">SUMMARY</td>'+
									'<td>'+deliveriedDateTotal+'</td>'+
									'<td>'+unitsTotal+'</td>'+
									'<td>'+unitsDeliveredTotal+'</td>'+
									'<td>'+pendent+'</td>'+
									'<td>'+orderValues+'</td>'+
									'<td>'+finalCurrency+'</td>'+
								'</tr>';
			}
			if(vm.userLvl == 2) {
				deliveriedDateTotal = api
					.column( 0, { page: 'current'} )
					.data().length;
				unitsTotal = api
					.column(11, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );	
				unitsReceived = api
					.column(12, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );
				unitsDeliToAgent = api
					.column(13, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );
				unitsDeliToCustomer = api
					.column(14, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );
				cost = api
					.column(15, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );
				ordPlf = api.column( 16, { page: 'current'} ).data()[0];		
				discount1 = api
					.column(17, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );
				discount2 = api
					.column(18, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );
				finalCurrency = api.column( 19, { page: 'current'} ).data()[0];		
				

				footerTpl = '<tr><td colspan="20"></td></tr>'+
			 					'<tr>'+
								 	'<td colspan="10" style="font-weight: bold; text-align:right;">SUMMARY</td>'+
									'<td>'+deliveriedDateTotal+'</td>'+
									'<td>'+unitsTotal+'</td>'+
									'<td>'+unitsReceived+'</td>'+
									'<td>'+unitsDeliToAgent+'</td>'+
									'<td>'+unitsDeliToCustomer+'</td>'+
									'<td>'+cost+'</td>'+
									'<td>'+ordPlf+'</td>'+
									'<td>'+discount1+'</td>'+
									'<td>'+discount2+'</td>'+
									'<td>'+finalCurrency+'</td>'+
								'</tr>';
				addFooterIntoTableResume(footerTpl);	
			}
			if(vm.userLvl == 3) {
				deliveriedDateTotal = api
					.column( 0, { page: 'current'} )
					.data().length;
				unitsTotal = api
					.column(9, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );	
				unitsReceived = api
					.column(10, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );
				unitsDeliToCustomer = api
					.column(11, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );
				cost = api
					.column(12, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );
				discount1 = api
					.column(13, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );
				discount2 = api
					.column(14, { page: 'current'} )
					.data()
					.reduce( function (a, b) {
						return intVal(a) + intVal(b);
					}, 0 );
				finalCurrency = api.column( 15, { page: 'current'} ).data()[0];			
				footerTpl = '<tr><td colspan="16"></td></tr>'+
			 					'<tr>'+
								 	'<td colspan="8" style="font-weight: bold; text-align:right;">SUMMARY</td>'+
									'<td>'+deliveriedDateTotal+'</td>'+
									'<td>'+unitsTotal+'</td>'+
									'<td>'+unitsReceived+'</td>'+
									'<td>'+unitsDeliToCustomer+'</td>'+
									'<td>'+cost+'</td>'+
									'<td>'+discount1+'</td>'+
									'<td>'+discount2+'</td>'+
									'<td>'+finalCurrency+'</td>'+
								'</tr>';
				addFooterIntoTableResume(footerTpl);		
			}

			if(vm.userLvl != 2 && vm.userLvl != 3) {
				$(api.table().footer()).html(footerTpl); 
			}
			
		}

		function footerCallback(tfoot, row, data, start, end, display) {
            var api = this.api(), data;
            // Remove the formatting to get integer data for summation
            var intVal = function ( i ) {
                return typeof i === 'string' ?
                    i.replace(/[\$,]/g, '')*1 :
                    typeof i === 'number' ?
                        i : 0;
            };
 
            
            // Update footer
			deliveriedDateTotal = api
                .column( 0, { page: 'current'} )
                .data().length;
			unitsTotal = api
                .column( 9, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );	
			ftyUnitsDeliveredTotal = api
                .column( 10, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
			zoneUnitsDeliveredTotal = api
                .column( 11, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );	
			agentUnitsDeliveredTotal = api
                .column( 12, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );	
			calc1 = api
                .column( 13, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );	
			calc2 = api
                .column( 14, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );	
			calc3 = api
                .column( 15, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );	

			ftyOrderValues = api
                .column( 16, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );	
			zoneOrderValues = api
                .column( 17, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );	
			agentOrderValues = api
                .column( 18, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
			ftyCurrency = api.column( 19, { page: 'current'} ).data()[0];
			zoneCurrency = api.column( 20, { page: 'current'} ).data()[0];
			agentCurrency = api.column( 21, { page: 'current'} ).data()[0];

			ftyDiscount1 = api
                .column( 22, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
			zoneDiscount1 = api
                .column( 23, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
			agentDiscount1 = api
                .column( 24, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
			ftyDiscount2 = api
                .column( 25, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
			zoneDiscount2 = api
                .column( 26, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
			agentDiscount2 = api
                .column( 27, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
			
			finalCurrency = api.column( 34, { page: 'current'} ).data()[0];
			var footerTpl = '';
			if(vm.userLvl === 1) {
				footerTpl = '<tr><td colspan="17"></td></tr>'+
			 					'<tr>'+
								 	'<td colspan="8" style="font-weight: bold; text-align:right;">SUMMARY</td>'+
									'<td>'+ deliveriedDateTotal +'</td>'+
									'<td>'+unitsTotal+'</td>'+
									'<td>'+ftyUnitsDeliveredTotal+'</td>'+
									'<td>'+calc1+'</td>'+
									'<td>'+ftyOrderValues+'</td>'+
									'<td>'+ftyCurrency+'</td>'+
									'<td>'+ftyDiscount1+'</td>'+
									'<td>'+ftyDiscount2+'</td>'+
									'<td>'+finalCurrency+'</td>'+
								'</tr>'+
								'<tr>'+
									'<td colspan="10"></td>'+
									'<td>'+zoneUnitsDeliveredTotal+'</td>'+
									'<td>'+calc2+'</td>'+
									'<td>'+zoneOrderValues+'</td>'+
									'<td>'+zoneCurrency+'</td>'+
									'<td>'+zoneDiscount1+'</td>'+
									'<td>'+zoneDiscount2+'</td>'+
									'<td>'+finalCurrency+'</td>'+
								'</tr>'+
								'<tr>'+
									'<td colspan="10"></td>'+
									'<td>'+agentUnitsDeliveredTotal+'</td>'+
									'<td>'+calc3+'</td>'+
									'<td>'+agentOrderValues+'</td>'+
									'<td>'+agentCurrency+'</td>'+
									'<td>'+agentDiscount1+'</td>'+
									'<td>'+agentDiscount2+'</td>'+
									'<td>'+finalCurrency+'</td>'+
								'</tr>';
			}
			if(vm.userLvl === 2) {
				footerTpl = '<tr><td colspan="17"></td></tr>'+
							'<tr>'+
								'<td colspan="8" style="font-weight: bold; text-align:right;">SUMMARY</td>'+
								'<td>'+ deliveriedDateTotal +'</td>'+
								'<td>'+unitsTotal+'</td>'+
								'<td>'+zoneUnitsDeliveredTotal+'</td>'+
								'<td>'+calc2+'</td>'+
								'<td>'+zoneOrderValues+'</td>'+
								'<td>'+zoneCurrency+'</td>'+
								'<td>'+zoneDiscount1+'</td>'+
								'<td>'+zoneDiscount2+'</td>'+
								'<td>'+finalCurrency+'</td>'+
							'</tr>'+
							'<tr>'+
								'<td colspan="10"></td>'+
								'<td>'+agentUnitsDeliveredTotal+'</td>'+
								'<td>'+calc3+'</td>'+
								'<td>'+agentOrderValues+'</td>'+
								'<td>'+agentCurrency+'</td>'+
								'<td>'+agentDiscount1+'</td>'+
								'<td>'+agentDiscount2+'</td>'+
								'<td>'+finalCurrency+'</td>'+
							'</tr>';
			}
			if(vm.userLvl === 3) {
				footerTpl = '<tr><td colspan="17"></td></tr>'+
							'<tr>'+
								'<td colspan="8" style="font-weight: bold; text-align:right;">SUMMARY</td>'+
								'<td>'+ deliveriedDateTotal +'</td>'+
								'<td>'+unitsTotal+'</td>'+
								'<td>'+agentUnitsDeliveredTotal+'</td>'+
								'<td>'+calc3+'</td>'+
								'<td>'+agentOrderValues+'</td>'+
								'<td>'+agentCurrency+'</td>'+
								'<td>'+agentDiscount1+'</td>'+
								'<td>'+agentDiscount2+'</td>'+
								'<td>'+finalCurrency+'</td>'+
							'</tr>';
			}
			$(api.table().footer()).html(footerTpl); 
        }

		vm.dtColumns1  = [
			DTColumnBuilder.newColumn('id_order').withTitle('ORDER'),
			DTColumnBuilder.newColumn('id_customer').withTitle('CUSTOMER'),
			DTColumnBuilder.newColumn(null).withTitle('CUSTOMER').renderWith(renderCustomer),
			DTColumnBuilder.newColumn('ord_description').withTitle('ORDER DESCRIPTION'),
			DTColumnBuilder.newColumn('ot_description').withTitle('ORDER TYPE'),
			DTColumnBuilder.newColumn('oc_description').withTitle('ORDER CONDITION'),
			DTColumnBuilder.newColumn('os_description').withTitle('STATUS'),
			DTColumnBuilder.newColumn(null).withTitle('CONFIRMATION DATES').renderWith(renderconfirmdates),
			DTColumnBuilder.newColumn(null).withTitle('DELIVERY DATES').renderWith(renderdeliverydates),
			DTColumnBuilder.newColumn('ord_units').withTitle('TOTAL UNITS'),
			DTColumnBuilder.newColumn('ord_fty_delivered').withTitle('10'),
			DTColumnBuilder.newColumn('ord_zone_delivered').withTitle('11'),
			DTColumnBuilder.newColumn('ord_ag_delivered').withTitle('12'),
			DTColumnBuilder.newColumn('calc_1').withTitle('13'),
			DTColumnBuilder.newColumn('calc_2').withTitle('14'),
			DTColumnBuilder.newColumn('calc_3').withTitle('15'),
			DTColumnBuilder.newColumn('ord_fty_value').withTitle('16'),
			DTColumnBuilder.newColumn('ord_zone_value').withTitle('17'),
			DTColumnBuilder.newColumn('ord_ag_value').withTitle('18'),
			DTColumnBuilder.newColumn('ord_plf').withTitle('19'),
			DTColumnBuilder.newColumn('ord_plz').withTitle('20'),
			DTColumnBuilder.newColumn('ord_plz').withTitle('21'),
			DTColumnBuilder.newColumn('ord_discount_1').withTitle('22'),
			DTColumnBuilder.newColumn('calc_4').withTitle('23'),
			DTColumnBuilder.newColumn('ord_ag_value_dsc1').withTitle('24'),
			DTColumnBuilder.newColumn('ord_discount_2').withTitle('25'),
			DTColumnBuilder.newColumn('calc_6').withTitle('26'),
			DTColumnBuilder.newColumn('ord_ag_value_dsc2').withTitle('27'),
			DTColumnBuilder.newColumn(null).withTitle('UNITS DELIVERED').renderWith(renderunitsdelivered),
			DTColumnBuilder.newColumn(null).withTitle('PENDENT TO DELIVERY').renderWith(renderpendent),
			DTColumnBuilder.newColumn(null).withTitle('VALUE').renderWith(rendervalues),
			DTColumnBuilder.newColumn(null).withTitle('CURRENCY').renderWith(rendercurrency),
			DTColumnBuilder.newColumn(null).withTitle('ORDER VALUE DISCOUNT 1').renderWith(renderdis1),
			DTColumnBuilder.newColumn(null).withTitle('ORDER VALUE DISCOUNT 2').renderWith(renderdis2),
			DTColumnBuilder.newColumn('ord_plz').withTitle('CURRENCY')
		];

		(function () {
			for(var i= 10; i <= 27; i++ ) {
				 vm.dtColumns1[i].visible = false;
			}

			$(document).ready(function() {
				$('#orderviewTable1').find('th').each(function() {
					if($(this).is(':empty')) {
						$(this).remove();
					}
				});
			})
		})();


		vm.dtColumns2  = [
			DTColumnBuilder.newColumn('id_order').withTitle('ORDER'),
			DTColumnBuilder.newColumn('id_customer').withTitle('CUSTOMER'),
			DTColumnBuilder.newColumn('cs_name').withTitle('CUSTOMER'),
			DTColumnBuilder.newColumn('ag_description').withTitle('AGENT'),
			DTColumnBuilder.newColumn('z_description').withTitle('ZONE'),
			DTColumnBuilder.newColumn('ord_description').withTitle('ORDER DESCRIPTION'),
			DTColumnBuilder.newColumn('ot_description').withTitle('ORDER TYPE'),
			DTColumnBuilder.newColumn('oc_description').withTitle('ORDER CONDITION'),
			DTColumnBuilder.newColumn('os_description').withTitle('STATUS'),
			DTColumnBuilder.newColumn('ord_fty_confirm').withTitle('FACTORY CONFIRMATION'),
			DTColumnBuilder.newColumn('ord_fty_del_date').withTitle('FACTORY DELIVERY DATE'),
			DTColumnBuilder.newColumn('ord_units').withTitle('TOTAL UNITS'),
			DTColumnBuilder.newColumn('ord_fty_delivered').withTitle('UNITS DELIVERED'),
			DTColumnBuilder.newColumn('calc_1').withTitle('PENDENT TO DELIVERY'),
			DTColumnBuilder.newColumn('ord_fty_value').withTitle('ORDER VALUE'),
			DTColumnBuilder.newColumn('ord_plf').withTitle('CURRENCY')
		];

		function addFooterIntoTableResume(foot) {
			if($("#datatable_fixed_column_2").children('tfoot').length > 0) {
				$("#datatable_fixed_column_2").children('tfoot').remove();
			}				
			$("#datatable_fixed_column_2").prepend("<tfoot>"+foot+"</tfoot>");		
		}

		function createdRow(row, data, dataIndex,iDisplayIndexFull) {
			// Recompiling so we can bind Angular directive to the DT
			$('td', row).unbind('dblclick');
	        $('td', row).bind('dblclick', function() {
	            $scope.$apply(function() {
	                vm.doubleclickHandler(data);
	            });
	        });
			$compile(angular.element(row).contents())($scope);
			return row;
		};

		function doubleclickHandler(info) {
	        window.location.href = "/index.cfm/order.lines?id=" + info.id_order;
	      }

		function renderCustomer(data, type, full, meta) {
			if(full.userLevel == 1) {
				return '<span style="minheight:50px;">' + full.cs_name + '</span><hr><span style="minheight:50px;">' + full.ag_description + '</span><hr><span style="minheight:50px;">' + full.z_description + '</span>';
			}
			else if (full.userLevel == 2) {
				return '<span style="minheight:50px;">' + full.ag_description + '</span><hr><span style="minheight:50px;">' + full.z_description + '</span>';
			}
			else if(full.userLevel == 3) {
				return '<span style="minheight:50px;">' + full.z_description + '</span>';
			}
		}

		function renderconfirmdates(data, type, full, meta) {
			if(full.userLevel == 1) {
				return '<span style="minheight:50px;">' + full.ord_fty_confirm + '</span><hr><span style="minheight:50px;">' + full.ord_zone_confirm + '</span><hr><span style="minheight:50px;">' + full.ord_date + '</span>';
			}
			else if (full.userLevel == 2) {
				return '<span style="minheight:50px;">' + full.ord_zone_confirm + '</span><hr><span style="minheight:50px;">' + full.ord_date + '</span>';
			}
			else if(full.userLevel == 3) {
				return '<span style="minheight:50px;">' + full.ord_date + '</span>';
			}
		}

		function renderdeliverydates(data, type, full, meta) {
			if(full.userLevel == 1) {
				return '<span style="minheight:50px;">' + full.ord_fty_del_date + '</span><hr><span style="minheight:50px;">' + full.ord_zone_del_date + '</span><hr><span style="minheight:50px;">' + full.ord_ag_del_date + '</span>';
			}
			else if (full.userLevel == 2) {
				return '<span style="minheight:50px;">' + full.ord_zone_del_date + '</span><hr><span style="minheight:50px;">' + full.ord_ag_del_date + '</span>';
			}
			else if(full.userLevel == 3) {
				return '<span style="minheight:50px;">' + full.ord_ag_del_date + '</span>';
			}
		}

		function renderunitsdelivered(data, type, full, meta) {
			if(full.userLevel == 1) {
				return '<span style="minheight:50px;">' + full.ord_fty_delivered + '</span><hr><span style="minheight:50px;">' + full.ord_zone_delivered + '</span><hr><span style="minheight:50px;">' + full.ord_ag_delivered + '</span>';
			}
			else if (full.userLevel == 2) {
				return '<span style="minheight:50px;">' + full.ord_zone_delivered + '</span><hr><span style="minheight:50px;">' + full.ord_ag_delivered + '</span>';
			}
			else if(full.userLevel == 3) {
				return '<span style="minheight:50px;">' + full.ord_ag_delivered + '</span>';
			}
		}

		function renderpendent(data, type, full, meta) {
			if(full.userLevel == 1) {
				return '<span style="minheight:50px;">' + full.calc_1 + '</span><hr><span style="minheight:50px;">' + full.calc_2 + '</span><hr><span style="minheight:50px;">' + full.calc_3 + '</span>';
			}
			else if (full.userLevel == 2) {
				return '<span style="minheight:50px;">' + full.calc_2 + '</span><hr><span style="minheight:50px;">' + full.calc_3 + '</span>';
			}
			else if(full.userLevel == 3) {
				return '<span style="minheight:50px;">' + full.calc_3 + '</span>';
			}
		}

		function rendervalues(data, type, full, meta) {
			if(full.userLevel == 1) {
				return '<span style="minheight:50px;">' + full.ord_fty_value + '</span><hr><span style="minheight:50px;">' + full.ord_zone_value + '</span><hr><span style="minheight:50px;">' + full.ord_ag_value + '</span>';
			}
			else if (full.userLevel == 2) {
				return '<span style="minheight:50px;">' + full.ord_zone_value + '</span><hr><span style="minheight:50px;">' + full.ord_ag_value + '</span>';
			}
			else if(full.userLevel == 3) {
				return '<span style="minheight:50px;">' + full.ord_ag_value + '</span>';
			}
		}

		function rendercurrency(data, type, full, meta) {
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

		function renderdis1(data, type, full, meta) {
			if(full.userLevel == 1) {
				return '<span style="minheight:50px;">' + full.ord_discount_1 + '</span><hr><span style="minheight:50px;">' + full.calc_4 + '</span><hr><span style="minheight:50px;">' + full.ord_ag_value_dsc1 + '</span>';
			}
			else if (full.userLevel == 2) {
				return '<span style="minheight:50px;">' + full.calc_4 + '</span><hr><span style="minheight:50px;">' + full.ord_ag_value_dsc1 + '</span>';
			}
			else if(full.userLevel == 3) {
				return '<span style="minheight:50px;">' + full.ord_ag_value_dsc1 + '</span>';
			}
		}

		function renderdis2(data, type, full, meta) {
			if(full.userLevel == 1) {
				return '<span style="minheight:50px;">' + full.ord_discount_2 + '</span><hr><span style="minheight:50px;">' + full.calc_6 + '</span><hr><span style="minheight:50px;">' + full.ord_ag_value_dsc2 + '</span>';
			}
			else if (full.userLevel == 2) {
				return '<span style="minheight:50px;">' + full.calc_6 + '</span><hr><span style="minheight:50px;">' + full.ord_ag_value_dsc2 + '</span>';
			}
			else if(full.userLevel == 3) {
				return '<span style="minheight:50px;">' + full.ord_ag_value_dsc2 + '</span>';
			}
		}
	};
})();