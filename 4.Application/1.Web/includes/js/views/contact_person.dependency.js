(function(){
	  var app = angular.module('person.List', ['datatables']);
	  app.directive('supplierCtrl',function(){
	    return{
	        restrict: 'EA',
	        templateUrl: '/html/contact_person.html',
	        controller: function ($scope,$http,$compile,DTOptionsBuilder,DTColumnBuilder,$filter,$locale){
			     // var vm = this;
			       $scope.typeOptions = [
			        { id: 1, name: 'Factory' },
			        { id: 2, name: 'Zone' },
			        { id: 3, name: 'Agent' },
			        { id: 4, name: 'Customer' },
			        { id: 5, name: 'Particular' }
			        ];
			      $scope.message = '';
			      $scope.edit = edit;
			      $scope.addRowContact = addRowContact;
			      $scope.delete = deleteRow;
			      $scope.addRow = addRow;
			      $scope.refresh = refresh;
			      $scope.dtInstance = {};
			      $scope.persons = {};
			      $scope.user=[];
			      $scope.contact=[];
			      $scope.contactID = 0;
			      $scope.regex = "[a-z A-Z 0-9-\_\.]+";
			      $scope.regex_email = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
			      var original = $scope.user;
			      $scope.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/person/getperson')
			          .withPaginationType('full_numbers')
			          .withOption('createdRow', createdRow);

			      $scope.dtColumns = [
			          // DTColumnBuilder.newColumn('ID').withTitle('No.'),
			          DTColumnBuilder.newColumn('NAME').withTitle('Name'),
			          DTColumnBuilder.newColumn('POS').withTitle('Position'),
			          DTColumnBuilder.newColumn('PHONE').withTitle('Telephone'),
			          DTColumnBuilder.newColumn('EMAIL').withTitle('Email'),
			          DTColumnBuilder.newColumn('BDAY').withTitle("B'Day"),
			          DTColumnBuilder.newColumn('NOTE').withTitle("Notes"),
			          DTColumnBuilder.newColumn(null).withTitle('Actions').notSortable()
			              .renderWith(actionsHtml)
			      ];

			      // $http.get("/index.cfm/basicdata/getlanguage").success(function(dataResponse){
			      //   $scope.languages = dataResponse;
			      // });

			      // $http.get("/index.cfm/basicdata/getcurrency").success(function(dataResponse){
			      //   $scope.currencys = dataResponse;
			      // });

			      function edit(person) {
			          $scope.user.name = person.NAME ;
			          $scope.user.pos = person.POS ;
			          $scope.user.phone = person.PHONE ;
			          $scope.user.email = person.EMAIL ;
			          $scope.user.bday = person.BDAY ;
			          $scope.user.note = person.NOTE ;
			          $scope.user.id = person.ID;
			          $('#id_Person').val(person.ID);
			      }

			      function test()
			      {
			        console.log(123);
			      }
			      function deleteRow(person) {
			        var result = confirm('Are you sure you want to delete this item?');
			        if(result)
			        {
			          $.ajax({
			             type: "POST",
			             url: "/index.cfm/person/deletePerson",
			             async: false,
			             data: {'id_Person' : person.ID
			          },
			          success: function( data ) {
			              if(data.success)
			              {
			                  noticeSuccess(data.message);
			                  $scope.dtInstance.reloadData();
			              }else{
			                  noticeFailed("Can not delete this type");
			              }
			          }
			       });
			          // Delete some data and call server to make changes...
			          // Then reload the data so that DT is refreshed

			        }
			      }
			      function addRow() {
			        $.ajax({
			                 type: "POST",
			                 url: "/index.cfm/person/checkExistName",
			                 async: false,
			                 data: {
			                 	'name' : $scope.user.name,
			                    'table':'person',
			                    'nameCol':'cts_p_name'
			              },
			              success: function( data ) {
			                flag = data.success;
					        if(flag == false || $('#id_Person').val()!="0")
					        {
					            $.ajax({
					                     type: "POST",
					                     url: "/index.cfm/person/addNewPerson",
					                     async: false,
					                     data: {
					                          'name' : $scope.user.name,
					                          'position' : $scope.user.pos ,
					                          'phone' : $scope.user.phone ,
					                          'email' : $scope.user.email ,
					                          'note' : $scope.user.note ,
					                          'bday' : $scope.user.bday ,
					                          'contactID' : $scope.contactID ,
					                          'id_Person':$('#id_Person').val()
					                  },
					                  success: function( data ) {
					                    if(data.success){
					                      noticeSuccess(data.message);
					                      $scope.dtInstance.reloadData();
					                    }
					                    else
					                    {
					                      noticeFailed("Please try again!");
					                    }

					                    refresh();
					                    refreshContact();
					                  }
					               });
				           }else
				           {
				            	noticeFailed("Code is exist in systems!");
				           }
			              }
			           });
			      }

			      function addRowContact() {
			        console.log("alsjkdflajsdf");
			        $.ajax({
			                 type: "POST",
			                 url: "/index.cfm/basicdata/checkExistCode",
			                 async: false,
			                 data: {
		                 		'code' : $scope.contact.cn_name,
		                        'table':'contact',
		                        'nameCol':'cn_name',
		                        'id':$('#id_Contact').val(),
		                        'idfield':'id_contact'
			              },
			              success: function( data ) {
			                flag = data.isExist;
					        if(!flag)
					        {
					            $.ajax({
					                     type: "POST",
					                     url: "/index.cfm/contact/addNewContact",
					                     async: false,
					                     data: {
					                          'name' : $scope.contact.cn_name,
					                          'address_1' : $scope.contact.cts_address_1,
					                          'address_2' : $scope.contact.cts_address_2,
					                          'address_3' : $scope.contact.cts_address_3,
					                          'city' : $scope.contact.cts_city,
					                          'province' : $scope.contact.cts_province,
					                          'zip_code' : $scope.contact.cts_zip_code,
					                          'country' : $scope.contact.cts_country,
					                          'phone' : $scope.contact.cts_phone,
					                          'email' : $scope.contact.cts_email,
					                          'vat_code' : $scope.contact.cts_vat_code,
					                          'notes' : $scope.contact.cts_notes,
					                          'type' : $scope.contact.cts_type,
					                          'sh_name' : $scope.contact.cts_sh_name,
					                          'sh_address_1' : $scope.contact.cts_sh_address_1,
					                          'sh_address_2' : $scope.contact.cts_sh_address_2,
					                          'sh_address_3' : $scope.contact.cts_sh_address_3,
					                          'sh_city' : $scope.contact.cts_sh_city,
					                          'sh_province' : $scope.contact.cts_sh_province,
					                          'sh_zip_code' : $scope.contact.cts_sh_zip_code,
					                          'id_Contact':$('#id_Contact').val()
					                  },
					                  success: function( data ) {
					                    if(data.success){
					                      noticeSuccess(data.message);
					                      $scope.dtInstance.reloadData();
					                      $scope.contactID = data.groupId;
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
					            noticeFailed("Code is exist in systems!");
					          }
			              }
			           });
			      }

			       function createdRow(row, data, dataIndex) {
			        // Recompiling so we can bind Angular directive to the DT
			        $compile(angular.element(row).contents())($scope);
			        // angular.element($scope).injector().get('$compile')(angular.element(row).contents())($scope);
			       }
			      function actionsHtml(data, type, full, meta) {
			          $scope.persons[data.ID] = data;
			          return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.persons[' + data.ID + '])">' +
			              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
			              '</span>&nbsp;' +
			              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.persons[' + data.ID + '])">' +
			              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
			              '</span>';
			      }

			      function refresh () {
			          $('#id_Person').val(0);
			          $scope.user= angular.copy(original);
			          $scope.userForm.$setPristine();
			      }

			      function refreshContact () {
			          $('#id_Contact').val(0);
			          $scope.contact= angular.copy(original);
			          $scope.userFormContact.$setPristine();
			      }
	        }
	    };
	  });
	$(".modal-body" ).tabs({
        activate:function(event,ui){
        }
     });

})();


