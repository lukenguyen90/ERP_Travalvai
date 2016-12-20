(function(){
  angular.module('customer.List', ['datatables.light-columnfilter','Formcontact','datatables', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http  , $filter,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
       // -----------------------------Start Customer--------------------------------------------

     var vm         = this;
      vm.message    = '';
      vm.edit       = edit;
      vm.delete     = deleteRow;
      vm.deleteUser = deleteUser;
      vm.addRow     = addRow;
      vm.refresh    = refresh;
      vm.dtInstance = {};
      vm.customers    = {};
      vm.getAgent   = getAgent;
      vm.showAddNew = showAddNew;
      vm.editRowContact = editRowContact;
      vm.user       ={};

      vm.regex      = "[a-z A-Z 0-9-\_\.]+";
      vm.regex_email = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      var original  = angular.copy(vm.user);

      vm.userInfo = {};

      $.ajax({
        async: false,
        type: 'GET',
        url: '/index.cfm/basicdata/getUserLevel',
        success: function(data) {
          vm.userInfo = data;
          //if it is a`gent admin
          if(vm.userInfo.TYPEUSER == 1){
            $("#zone").closest(".form-group").removeClass("display-none");
          } else if( vm.userInfo.TYPEUSER == 2 ){
            $("#agent").closest(".form-group").removeClass("display-none");

            $http.get("/index.cfm/basicdata/getagent").success(function(dataResponse){
              vm.agents = dataResponse;
            });
          } else if( vm.userInfo.TYPEUSER == 4 ){
            $('#btnAddNew').hide();
          }
        }
      });
      var url = 'index.cfm/basicdata/getCustomerList';
      vm.dtOptions = DTOptionsBuilder.newOptions()
          .withDataProp('data')
          .withOption('ajax', {
              url: url
          })
          .withOption('serverSide', true)
          .withDOM("<'dt-toolbar'<'col-md-2 col-xs-12'C><'col-md-9 col-xs-12'f><'col-md-1 col-xs-12'l>r>"+
                    "t"+
                    "<'dt-toolbar-footer'<'col-md-6 col-xs-12'i><'col-xs-12 col-md-6'p>>")
          .withFnServerData(function (sSource, aoData, fnCallback, oSettings){
              $http.get(url, {
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
              });
          })
          .withOption('order', [0, 'desc'])
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
            }
          })
          .withOption('createdRow', createdRow)
          .withOption('select', { style: 'single' });
      vm.dtColumns = [
          DTColumnBuilder.newColumn('ID').withTitle('CODE').withOption("width","5%").withClass('text-center'),
          DTColumnBuilder.newColumn('NAME').withTitle('NAME').withOption("width","20%").renderWith(renderCustomer),
          DTColumnBuilder.newColumn('ZONE').withTitle('ZONE').withOption("width","5%"),
          DTColumnBuilder.newColumn('AGENT').withTitle('AGENT').withOption("width","25%").renderWith(renderAgent),
          DTColumnBuilder.newColumn('LANGUAGE').withTitle('LANGUAGE').withOption("width","10%"),
          DTColumnBuilder.newColumn('TC_DESCRIPTION').withTitle('TYPE').withOption("width","10%"),
          DTColumnBuilder.newColumn('CONTACT').withTitle('CONTACT').withOption("width","15%"),
          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable()
              .renderWith(actionsHtml).withOption("width","10%")
      ];

      function renderCustomer(data, type, full, meta){
        return full.NAME;
      }
      function renderAgent(data, type, full, meta){
        return full.AGENT + full.AGENT_DES;
      }

      $http.get("/index.cfm/basicdata/getlanguage").success(function(dataResponse){
        vm.languages = dataResponse;
      });

      $http.get("/index.cfm/basicdata/getzone").success(function(dataResponse){
        vm.zones = dataResponse;
      });

      $http.get("/index.cfm/basicdata/gettype_customer").success(function(dataResponse){
        vm.tocs = dataResponse;
      });

      $http.get("/index.cfm/contact/getcontacts").success(function(dataResponse){
        vm.contacts = dataResponse;
      });

      var tempCode = "";
      // $( "#agent" ).change(function() {
      //       var singleValues = $("#agent").val();
      //       var idcus = singleValues.slice(7);
      //       if(idcus > 0){
      //         $.ajax({
      //               type: "POST",
      //               url: "/index.cfm/customer/getzoneforid",
      //               async: false,
      //               data: {
      //                     'idcus' : idcus
      //               },
      //                 success: function( data ) {
      //                   if(data.success){
      //                       vm.user.zone = data.name_zone;
      //                 }
      //               }
      //         });
      //       }else{
      //         vm.user.zone = "";
      //       }
      //   });
      
      function getAgent(){
        $("#agent").closest(".form-group").removeClass("display-none");
         $.ajax({
                type: "POST",
                url: "/index.cfm/basicdata/getagent",
                async: false,
                data: {
                      'idzone' : $("#zone").val()
                },
                  success: function( data ) {
                    vm.agents = data;
                }
          });
      }

      function edit(customer) {
          document.getElementById("titleID").innerHTML="Edit";
          $('#addNew').modal('show');
          $('#btnRefresh').css('display','none');
          $(document).ready(function(){
            $("#addNew").on('shown.bs.modal', function(){
              $(this).find('#code').focus();
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
          if(customer.CONTACT != ""){
            $('#editContact').css("display", "inline-block");
            $('#createContact').css("display", "none");
          }else{
            $('#editContact').css("display", "none");
            $('#createContact').css("display", "inline-block");
          }

          //highlight row being edit
          $(".highlight").removeClass("highlight");
          $("#mytable td").filter(function() { return $.text([this]) == customer.CODE; })
            .parent()
            .addClass("highlight");


          if(vm.userInfo.TYPEUSER == 1){
            $("#agent").closest(".form-group").removeClass("display-none");
            $.ajax({
              type: "POST",
              url: "/index.cfm/basicdata/getagent",
              async: false,
              data: {
                    'idzone' : customer.ZONEID
              },
                success: function( data ) {
                  vm.agents = data;
              }
            });
          }

          vm.user.description=customer.NAME;
          vm.user.zone = customer.ZONEID;
          vm.user.language = customer.LANGUAGEID;
          vm.user.agent = customer.AGENTID;
          vm.user.toc = customer.TOCID;
          vm.user.contactID = customer.CONTACTID;
          $('#id_Customer').val(customer.ID);
          $scope.idContactEdit = customer.CONTACTID;
          vm.user.contact = customer.CONTACT;
          $("#id_Contact").val(customer.CONTACTID);
          $scope.usertype = 4;
          $scope.distype=1;
          $scope.showtype=0;

      }

      function showAddNew (argument) {
        // body...
          refresh();
          document.getElementById("titleID").innerHTML="Create";
          $(".highlight").removeClass("highlight");
          $('#btnRefresh').css('display','inline-block');
          $('#addNew').modal('show');
          $('#description').focus();
          $(document).ready(function(){
            $("#addNew").on('shown.bs.modal', function(){
              $(this).find('#description').focus();
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

          $('#createContact').css("display", "inline-block");
          $('#editContact').css("display", "none");
          $scope.idContactEdit = 0;
          $("#id_Contact").val(0);
          $scope.usertype = 4;
          $scope.distype=1;
          $scope.showtype=0;
        });
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

      function deleteRow(customer){
           vm.did = customer.ID;
          $('#showDelete').modal('show');
      }

      function deleteUser(customer) {
        $('#showDelete').modal('hide');
          $.ajax({
               type: "POST",
               url: "/index.cfm/customer/delete",
               async: false,
               data: {'id' : vm.did
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
                 url: "/index.cfm/customer/addNewCus",
                 async: false,
                 data: {
                      'name'      : vm.user.description,
                      'zone'      : vm.user.zone,
                      'language'  : vm.user.language,
                      'agent'     : vm.user.agent,
                      'type'      : vm.user.toc,
                      'contact'   : $("#id_Contact").val(),
                      'id_Cu'     : $('#id_Customer').val()
              },
              success: function( data ) {
                if(data.success){
                  noticeSuccess(data.message);
                  vm.dtInstance.reloadData();
                  tempCode = data.code_Cust;
                  setTimeout(function() {
                    $('#addNew').modal('hide');
                  }, 1000);
                }
                else
                {
                  noticeFailed("Please try again!");
                }
               // refresh();
              }
           });
      }

       function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
       }
      function actionsHtml(data, type, full, meta) {
          vm.customers[data.ID] = data;
          if(vm.userInfo.TYPEUSER < 4){
            return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.customers[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.customers[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
          }else {
            return "";
          }
      }

      function refresh () {
          $('#id_Customer').val(0);
          vm.user= angular.copy(original);
          if(vm.userInfo.TYPEUSER == 1){
            $("#agent").closest(".form-group").addClass("display-none");
          }
          vm.code = Math.floor((Math.random()*9999)+1);
          $scope.userForm.$setPristine();
      }

       // -----------------------------End Customer--------------------------------------------


  };

})();
