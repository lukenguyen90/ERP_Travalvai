(function(){
	var myapp = angular.module('order.create', ['datatables', 'datatables.light-columnfilter', 'ui.select2']);
	myapp.controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)
	function BindAngularDirectiveCtrl($scope , $http ,$compile, DTOptionsBuilder, DTColumnBuilder){
		var vm = this;
		vm.regex 			= "[a-z A-Z 0-9-\_\.]+";
		vm.regexNumber  	= /^[0-9]+(\.[0-9]{1,2})?$/;
		vm.order = {};




		//get order types
		getOrderTypes().then(function(dataResponse){
			vm.ord_type = dataResponse;
			console.log(vm.ord_type);
		});

        function getOrderTypes(){
        	return new Promise(function(resolve, reject){
				$http.get("/index.cfm/order/getOrderTypes").success(function(dataResponse){
					resolve(dataResponse);
				});
        	});
        }
        

		// get sizes
		// vm.dtOptionsSizes  = DTOptionsBuilder.fromSource('/index.cfm/patterns.getPatternList')
		// 	.withPaginationType('full_numbers')
		// 	.withOption('createdRow', createdRow).withOption('order', [1, 'desc']);
		// vm.dtColumnsSizes  = [
		// 	DTColumnBuilder.newColumn('CODE').withTitle('Code').withOption('width',"2%"),
		// 	DTColumnBuilder.newColumn('IDPATTERN').withTitle('id'),
		// 	DTColumnBuilder.newColumn('GROUPPRODUCTNAME').withTitle('Group').withOption('width',"2%"),
		// 	DTColumnBuilder.newColumn('DESCRIPTION').withTitle('Description').withOption('width',"10%"),
		// 	DTColumnBuilder.newColumn('CREATEDATE').withTitle('Date').withOption('width',"12%"),
		// 	DTColumnBuilder.newColumn('UPDATEDATE').withTitle('Update').withOption('width',"12%"),
		// 	DTColumnBuilder.newColumn('NOTES').withTitle('Notes').withOption('width',"40%"),
		// 	DTColumnBuilder.newColumn('SKETCH').withTitle('Sketch').withOption('width',"20%"),
		// 	DTColumnBuilder.newColumn(null).renderWith(actionsHtml).notSortable().withOption('width',"2%")
		// ];
		// vm.dtColumns[1].visible = false;

	function createdRow(row, data, dataIndex,iDisplayIndexFull) {
		// Recompiling so we can bind Angular directive to the DT
		$compile(angular.element(row).contents())($scope);
		return row;
	};

	};
})();