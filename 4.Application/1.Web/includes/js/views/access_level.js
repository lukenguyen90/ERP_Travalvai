(function(){
  angular.module('access_level', ['datatables', 'datatables.scroller']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  	function BindAngularDirectiveCtrl($http, $window, DTOptionsBuilder, DTColumnDefBuilder)
  	{
     	var vm = this;
     	vm.addRow = addRow;
     	vm.myCheckboxClick = myCheckboxClick;
    	vm.persons = [];
    	vm.refresh = refresh;
    	// vm.dtInstance = {};
    	$.ajax({
	        async: false,
	        type: 'GET',
	        url: '/index.cfm/basicdata/getAccessLevel',
	        success: function(data) {
	             //callback
             	vm.persons = angular.fromJson(data);
	        }
	    });
	    arraycolummindex = [];
		vm.nameright = vm.persons[0].right;		
	    for(var i = 0; i<vm.nameright.length; i++){
	    	arraycolummindex.push(i);
	    }
	    // console.log(arraycolummindex);
    	
	    vm.dtOptions = {paging: false, searching: false, scrollX:true, "columnDefs": [{ "width": "160px", "targets": arraycolummindex }]};
	    // vm.dtOptions = DTOptionsBuilder.newOptions().withScroller().withOption('deferRender', true).withOption('scrollX', true);
	    vm.dtColumnDefs = [
	        DTColumnDefBuilder.newColumnDef(0),
	        DTColumnDefBuilder.newColumnDef(1).notSortable(),
	        DTColumnDefBuilder.newColumnDef(2).notSortable()
	    ];
		
      	
	    
	    // vm.persons = angular.fromJson([
	    // 								{"name":"a_factory","right":{"open":false,"edit":true,"delete":true}}
	    // 								,{"name":"a_zone","right":{"open":true,"edit":false,"delete":true}}
	    // 								,{"name":"a_agent","right":{"open":false,"edit":true,"delete":true}}
	    // 								,{"name":"a_cus","right":{"open":true,"edit":true,"delete":false}}
	    // 							]);
		function myCheckboxClick (event) {
			$(".highlight").removeClass("highlight");
			// body...
			// $(param).parent().addClass("highlight");
			$(event.currentTarget).parent().parent().addClass("highlight");
			// console.log($abc);
		}
		function refresh () {
			$window.location.reload();
		}
		function addRow () {
			// console.log(vm.persons);

			// var newItems = [];
			// for(var i=0; i<vm.persons.length; i++){
			// 	var rights = [];
			// 	for(var j=0; j<vm.persons[i].right.length; j++){
			// 		var subright = {
			// 			"open": vm.persons[i].id + '-' + vm.persons[i].right[j].name + '-open',
			// 			"edit": vm.persons[i].right[j].right.edit,
			// 			"delete": vm.persons[i].right[j].right.delete
			// 		}
			// 		var right = {
			// 			"name": vm.persons[i].right[j].name,
			// 			"right": subright
			// 		}
			// 		rights.push(right);
			// 		// console.log(subright.toString());
			// 		// console.log(vm.persons[i].right[j].right.open);
			// 	}
			// 	var newItem = {
			// 		"id" : vm.persons[i].id,
			// 		"name" : vm.persons[i].name,
			// 		"right": rights
			// 	}
			// 	newItems.push(newItem);


			// 	// console.log(newItem);
			// 	// console.log(JSON.stringify(newItems));
			// 	// console.log(vm.persons[i].id);
			// }

			$.ajax({
             	type: "POST",
             	url: "/index.cfm/access_level/update",
             	async: false,
         		data: {
					'data' 	: JSON.stringify(vm.persons)
              	},
              	success: function( data ) {
              		if(data.success){
						noticeSuccess(data.message); 
						// vm.dtInstance.reloadData();
	                } 
              	}
           	});
		}
		// console.log(vm.nameright);
		// console.log(vm.persons[0].right);
 	};

})();