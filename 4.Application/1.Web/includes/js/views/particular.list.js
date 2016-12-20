(function(){
  angular.module('particular.List', ['Formcontact','datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http, $filter ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm         = this;
      vm.message    = '';
      vm.edit       = edit;
      vm.delete     = deleteRow;
      vm.deleteUser = deleteUser;
      vm.addRow     = addRow;
      vm.refresh    = refresh;
      vm.showAddNew = showAddNew;
      vm.editRowContact = editRowContact;
      vm.dtInstance = {};
      vm.particulars    = {};
      vm.user       ={};
      vm.regex      = "[a-z A-Z 0-9-\_\.]+";
      vm.regex_email = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      var original = angular.copy(vm.user);
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/particular/getparticular')
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
            }
          })
          .withOption('createdRow', createdRow)
          .withOption('select', { style: 'single' });
      vm.dtColumns = [
          DTColumnBuilder.newColumn('ID').withTitle('CODE'),
          DTColumnBuilder.newColumn('NAME').withTitle('NAME'),
          DTColumnBuilder.newColumn('DNI').withTitle('DNI'),
          DTColumnBuilder.newColumn('PASSWORD').withTitle('PASSWORD'),
          DTColumnBuilder.newColumn('MAIL').withTitle('MAIL'),
          DTColumnBuilder.newColumn('ZONE').withTitle('ZONE'),
          DTColumnBuilder.newColumn('AGENT').withTitle('AGENT'),
          DTColumnBuilder.newColumn('CUSTOMER').withTitle('CUSTOMER'),
          DTColumnBuilder.newColumn('LANGUAGE').withTitle('LANGUAGE'),
          DTColumnBuilder.newColumn('CONTACT').withTitle('CONTACT'),
          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable().withOption('width', '10%')
              .renderWith(actionsHtml)
      ];

      	$http.get("/index.cfm/contact/getcontacts").success(function(dataResponse){
        	vm.contacts = dataResponse;
      	});

      	$http.get("/index.cfm/basicdata/getcustomer").success(function(dataResponse){
        	vm.customers = dataResponse;
      	});

      	$http.get("/index.cfm/basicdata/getlanguage").success(function(dataResponse){
        	vm.languages = dataResponse;
      	});


        var tempCode = "";
      function edit(particular) {
        $('#addNew').modal('show');
        $('#btnRefresh').css('display','none');
        $(document).ready(function(){
          $("#addNew").on('shown.bs.modal', function(){
            $(this).find('#name').focus();
            $(document).click(function (e)
            {
              var container1 = $("#addNew");
              var container2 = $("#modal_formcontact")
              if (!container1.is(e.target) && container1.has(e.target).length === 0 && 
                  !container2.is(e.target) && container2.has(e.target).length === 0)
              {
                  
                $("#myModalContact").modal('hide');
              } 
            });
          });
        });
        if(particular.CONTACT != ""){
          $('#editContact').css("display", "inline-block");
          $('#createContact').css("display", "none");
        }else{
          $('#editContact').css("display", "none");
          $('#createContact').css("display", "inline-block");
        }
          //highlight row being edit
        $(".highlight").removeClass("highlight");
        $("#mytable td").filter(function() { return $.text([this]) == particular.ID; })
          .parent()
          .addClass("highlight");
          vm.user.code=particular.ID;
          vm.user.name=particular.NAME;
          vm.user.dni=particular.DNI;
          vm.user.password=particular.PASSWORD;
          vm.user.mail=particular.MAIL;
          vm.user.languageID = particular.LANGUAGEID;
          vm.user.customerID = particular.CUSTOMERID;
          vm.user.contactID = particular.CONTACTID;
          $('#id_Particular').val(particular.ID);
          $scope.idContactEdit = particular.CONTACTID;
          vm.user.contact = particular.CONTACT;
          document.getElementById("titleID").innerHTML="Edit";
          $("#id_Contact").val(particular.CONTACTID);
          $scope.showtype=1;
          $("#type").removeClass('col-md-10');
          $("#type").addClass('col-md-4');
      }

      function showAddNew (argument) {
        // body...
          refresh();
          document.getElementById("titleID").innerHTML="Create";
          $(".highlight").removeClass("highlight");
          $('#btnRefresh').css('display','inline-block');
          $('#addNew').modal('show');
//          vm.user.title_formparticular = "Create new Particular";
          $(document).ready(function(){
            $("#addNew").on('shown.bs.modal', function(){
              $(this).find('#name').focus();
              $(document).click(function (e)
              {
                var container1 = $("#addNew");
                var container2 = $("#modal_formcontact")
                if (!container1.is(e.target) && container1.has(e.target).length === 0 && 
                    !container2.is(e.target) && container2.has(e.target).length === 0)
                {
                    
                  $("#myModalContact").modal('hide');
                } 
              });
            });
          });
          $('#createContact').css("display", "inline-block");
          $('#editContact').css("display", "none");
          $scope.idContactEdit = 0;
          $("#id_Contact").val(0);
          $scope.showtype=1;
          $("#type").removeClass('col-md-10');
          $("#type").addClass('col-md-4');
      }

      function deleteRow(particular) {
          vm.did = particular.ID;
          $('#showDelete').modal('show');
      }

      function editRowContact () {
        $('#myModalContact').modal('show');
      }

      $('#addNew').on('hidden.bs.modal', function () {
          $(".highlight").removeClass("highlight");
           $("#mytable td").filter(function() { return $.text([this]) == tempCode; })
                .parent()
                .addClass("highlight");
        });
      $('#myModalContact').on('hidden.bs.modal', function () {
        var contact = $("#name_Contact").val();
        vm.user.contact = contact;
        $scope.$apply();
        $('#editContact').css("display", "inline-block");
        $('#createContact').css("display", "none");
      })

      $("#createContact").on('click', function () {
        // body...
        $('#id_Contact').val(0);
      })

      function deleteUser(particular) {
        $('#showDelete').modal('hide');
          $.ajax({
                 type: "POST",
                 url: "/index.cfm/particular/delete",
                 async: false,
                 data: {'particularID' : vm.did
              },
              success: function( data ) {
                  if(data.success)
                  {
                      noticeSuccess(data.message);
                      vm.dtInstance.reloadData();
                  }else{
                      noticeFailed("Can not delete this type");
                  }
              }
           });
          // Delete some data and call server to make changes...
          // Then reload the data so that DT is refreshed
      }

      function addRow() {
        $.ajax({
                 type: "POST",
                 url: "/index.cfm/particular/checkExistCode",
                 async: false,
                 data: {
                  'code' : vm.user.dni,
                  'table':'particular',
                  'nameCol':'pt_dni',
                  'id':$('#id_Particular').val(),
                  'idfield':'id_particular'
              },
              success: function( data ) {
                  flag = data.success;
                  if(flag == false || $('#id_Particular').val()!="0")
                  {
                    $.ajax({
                             type: "POST",
                             url: "/index.cfm/particular/addNew",
                             async: false,
                             data: {
                             	  'name' 		: 	vm.user.name,
                    					  'dni'		  : 	vm.user.dni,
                        				'pass' 		: 	vm.user.password,
                        				'mail'		:  	vm.user.mail,
                        				'language': 	vm.user.languageID,
                        				'customer': 	vm.user.customerID,
                        				'contact'	:	$("#id_Contact").val(),
                              	'id_Particular':$('#id_Particular').val()
                          },
                          success: function( data ) {
                            if(data.success){
                              noticeSuccess(data.message);
                              vm.dtInstance.reloadData();
                              tempCode = data.part_Name;
                              setTimeout(function() {
                                $('#addNew').modal('hide');
                              }, 1000);
                            }
                            else
                            {
                              noticeFailed("Please try again!");
                            }

                          }
                       });
                  }
                  else
                  {
                    noticeFailed("DNI is exist in systems!");
                  }
              }
           });
      }

     function createdRow(row, data, dataIndex) {
      // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
     }

      function actionsHtml(data, type, full, meta) {
          vm.particulars[data.ID] = data;
          return '<span class="txt-color-green btnedit padding-right-30" title="Edit" ng-click="showCase.edit(showCase.particulars[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.particulars[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
      }

      function refresh () {
          $('#id_Particular').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
      }

  };

})();
