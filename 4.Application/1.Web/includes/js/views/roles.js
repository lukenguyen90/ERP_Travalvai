(function(){
  angular.module('roles', ['datatables', 'datatables.light-columnfilter']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm         = this;
      vm.message    = '';
      vm.edit       = edit;
      vm.delete     = deleteRow;
      vm.deleteUser = deleteUser;
      vm.addRow     = addRow;
      vm.refresh    = refresh;
      vm.showAddNew = showAddNew;
      vm.dtInstance = {};
      vm.roles    = {};
      vm.user       = {};
      vm.regex      = "[a-z A-Z 0-9-\_\.]+";
      var original  = angular.copy(vm.user);
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/access_level/getaccess_level')
          .withPaginationType('full_numbers')
          .withLightColumnFilter({
          	'0' : {
          		type : 'text'
          	}
          })
          .withOption('createdRow', createdRow)
          .withOption('select', { style: 'single' });
      vm.dtColumns = [
          DTColumnBuilder.newColumn('NAME').withTitle('ROLES'),
          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable().withOption('width',"46px")
              .renderWith(actionsHtml)
      ];

      var tempCode = "";
      $('#addNew').on('hidden.bs.modal', function () {
        $(".highlight").removeClass("highlight");
           $("#mytable td").filter(function() { return $.text([this]) == tempCode; })
                .parent()
                .addClass("highlight");
        });
      function edit(person) {
          $('#addNew').modal('show');
          $('#btnRefresh').css('display','none');
            //highlight row being edit
          $(".highlight").removeClass("highlight");
          $("#mytable td").filter(function() { return $.text([this]) == person.lg_code; })
            .parent()
            .addClass("highlight");
          vm.user.code=person.lg_code;
          vm.user.role=person.NAME;
          $('#id_Stt').val(person.ID);
          document.getElementById("titleID").innerHTML="Edit";

      }
      function deleteRow(person) {
        vm.did = person.ID;
        $('#showDelete').modal('show');
      }
      function deleteUser() {
        $('#showDelete').modal('hide');
        $.ajax({
             type: "POST",
             url: "/index.cfm/access_level/delete",
             async: false,
             data: {'id' : vm.did
          },
          success: function( data ) {
              if(data.success)
              {
                  noticeSuccess(data.message);
                  vm.dtInstance.reloadData();
              }else{
                  noticeFailed("Can not delete this language");
              }
          }
        });
      }

	function showAddNew (argument) {
		refresh();
		document.getElementById("titleID").innerHTML="Create";
		$(".highlight").removeClass("highlight");
		$('#btnRefresh').css('display','inline-block');
		$('#addNew').modal('show');
		$(document).ready(function(){
			$("#addNew").on('shown.bs.modal', function(){
				$(this).find('#role').focus();
			});
		});
	}

	function addRow() {
		var flag = false;
		$.ajax({
			type: "POST",
			url: "/index.cfm/basicdata/checkExistCode",
			async: false,
			data: {
				'code' : vm.user.role,
				'table':'access_level',
				'nameCol':'al_name',
                'id':$('#id_Stt').val(),
                'idfield':'id_access_level'
			},
			success: function( data ) {
				flag = data.isExist;
				if(!flag)
				{
					$.ajax({
						type: "POST",
						url: "/index.cfm/access_level/addNewRole",
						async: false,
						data: {
							'name' : vm.user.role,
							'id':$('#id_Stt').val()
						},
						success: function( data ) {
							if(data.success){
								noticeSuccess(data.message);
								vm.dtInstance.reloadData();
								tempCode = data.lang_Code;
								setTimeout(function() {
									$('#addNew').modal('hide');
								}, 1000);
							}
							else
							{
								noticeFailed("Please try again!");
							}
							refresh();
						}
					});
				}
				else
				{
					noticeFailed("Role is exist in systems!");
				}
			}
		});
	}

	function createdRow(row, data, dataIndex) {
		$compile(angular.element(row).contents())($scope);
	}

	function actionsHtml(data, type, full, meta) {
		vm.roles[data.ID] = data;
		return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.roles[' + data.ID + '])">' +
		'   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
		'</span>&nbsp;' +
		'<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.roles[' + data.ID + '])">' +
		'   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
		'</span>';
	}

	function refresh () {
		$('#id_Stt').val(0);
		vm.user= angular.copy(original);
		$scope.userForm.$setPristine();
		$('#code').val('');
		$('#description').val('');
	}

  	};

})();
