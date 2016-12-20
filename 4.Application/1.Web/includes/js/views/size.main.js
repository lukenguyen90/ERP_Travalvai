(function(){
  angular.module('size.List', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  	function BindAngularDirectiveCtrl($scope ,$filter,$http ,$compile, DTOptionsBuilder, DTColumnBuilder, $window)
  	{
		var vm = this;
		vm.dtInstance = {};
		vm.showEdit = showEdit;
		vm.showAddNew = showAddNew;
		vm.delete      = deleteRow;
		vm.refresh = refresh;
		vm.insertData = insertData;
		vm.deleteSize = deleteSize;
		vm.doubleclickHandler = doubleclickHandler;
		vm.size = [];
		var original = angular.copy(vm.size);

		vm.dtOptionsSizesViewTable = DTOptionsBuilder.fromSource('/index.cfm/sizes/getSizes')
		  .withPaginationType('full_numbers')
		  .withLightColumnFilter({
	            '0' : {
	                type : 'text'
	            },
	            '1' : {
	                type : 'text'
	            }
          	})
		  	.withOption('createdRow', createdRow)
		  	.withOption('select',{style:'single'});

		vm.dtColumnsSizesViewTable = [
		  	DTColumnBuilder.newColumn('DES').withTitle('DESCRIPTION'),
		  	DTColumnBuilder.newColumn('QTTY').withTitle('QTTY'),
		  	DTColumnBuilder.newColumn(null).withTitle('ACTIONS').renderWith(actionsHtml)
		];

		function actionsHtml(data, type, full, meta) {
          	return '<span class="txt-color-red btndelete" title="Edit product" ng-click="showCase.showEdit(' + full.IDSIZE + ', false)">' +
	                    '<i class="ace-icon bigger-130 fa fa-pencil"></i></span>' + 
	                '<span class="txt-color-red btndelete" title="Delete product" ng-click="showCase.delete(' + full.IDSIZE + ')">' +
	                    '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
      	}
      	function doubleclickHandler(info) {
	        window.location.href = "/index.cfm/size.detail?idsize=" + info.IDSIZE;
	      }

      	function createdRow(row, data, dataIndex) {
	        // Recompiling so we can bind Angular directive to the DT
         	$('td', row).unbind('dblclick');
	        $('td', row).bind('dblclick', function() {
	            $scope.$apply(function() {
	                vm.doubleclickHandler(data);
	            });
	        });
	        $compile(angular.element(row).contents())($scope);
       	}

       	function showAddNew()
       	{
       		refresh();
       		$("#addNew").modal('show');
       		document.getElementbyID("titleID").innerHTML="Create";
       		$('#btnRefresh').css('display','inline-block');
       	}

       	function showEdit(id) {
       		document.getElementById("titleID").innerHTML="Edit";
       		$('#addNew').modal('show');
       		$('#btnRefresh').css('display','none');
       		$.ajax({
		        async: false,
		        type: 'GET',
		        url: '/index.cfm/sizes/getSizeById?idsize=' + id,
		        success: function(data) {
		          if(data.success == true) {
		          	vm.size.sz_des = data.size.DES;
		          	vm.size.sz_qtty = data.size.QTTY;
		          	$('#sizeId').val(data.size.IDSIZE);
		          }
		          else {
		          	noticeFailed(data.message)
		          }
		        }
	      	});
       	}

       	function refresh() {
       		vm.size = angular.copy(original);
       		$('#sizeId').val(0);
       		$scope.sizeForm.$setPristine();
       	}

       	function insertData() {
       		$.ajax({
				type: "POST",
				url: "/index.cfm/sizes/insertData",
				async: false,
				data: {
					'des': vm.size.sz_des,
					'qtty': vm.size.sz_qtty,
					'idsize': $('#sizeId').val()
				},
				success: function( data ) {
					if(data.success)
					{
					  	noticeSuccess(data.message);
					  	vm.dtInstance.reloadData();
					  	setTimeout(function() {
                  			$('#addNew').modal('hide');
                		}, 1000);
					  	if($('#sizeId').val() == 0) {
					  	window.location.href = "/index.cfm/size.detail?idsize=" + data.idsize;
					  	}
					}
					else
					{
					  	noticeFailed(data.message);
					}
				}
	        });
       	}

       	function deleteRow(id){
       		$('#showDelete').modal('show');
       		vm.did= id;
       	}

       	function deleteSize() {
       		$('#showDelete').modal('hide');
       		$.ajax({
				type: "POST",
				url: "/index.cfm/sizes/deleteDataById",
				async: false,
				data: {
					'idsize': vm.did
				},
				success: function( data ) {
					if(data.success)
					{
						$('#showDelete').modal('hide');	
						noticeSuccess(data.message);
						vm.dtInstance.reloadData();
					}
					else
					{
						noticeFailed(data.message);
					}
				}
	        });
       	}
   	}
})();
