(function(){
  angular.module('user', ['Formcontact','datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope , $http, $filter ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm         = this;
      vm.message    = '';
      vm.editRow    = editRow;
      vm.delete     = deleteRow;
      vm.deleteUser = deleteUser;
      vm.addRow     = addRow;
      vm.refresh    = refresh;
      vm.showAddNew = showAddNew;
      vm.editRowContact = editRowContact;
      vm.dtInstance = {};
      vm.users      = {};
      vm.user       = {};
      vm.regex      = "[a-z A-Z 0-9-\_\.]+";
      var original = angular.copy(vm.user);
      vm.userInfo = {};
      var sumColumnFilter = {'0' : {type : 'text'}, '1' : {type : 'text'}, '2' : {type : 'text'}, '3' : {type : 'text'}, '4' : {type : 'text'}, '5' : {type : 'text'}, '6' : {type : 'text'}, '7' : {type : 'text'}, '8' : {type : 'text'}, '9' : {type : 'text'}};
      vm.dtColumns = [
          DTColumnBuilder.newColumn('NAME').withTitle('NAME').withOption('width', '20%'),
          DTColumnBuilder.newColumn('FACTORY').withTitle('FACTORY'),
          DTColumnBuilder.newColumn('ZONE').withTitle('ZONE'),
          DTColumnBuilder.newColumn('AGENT').withTitle('AGENT').renderWith(renderAgent),
          DTColumnBuilder.newColumn('CUSTOMER').withTitle('CUSTOMER').renderWith(renderCustomer),
          DTColumnBuilder.newColumn('POSITION').withTitle('POSITION').withOption('width', '20%'),
          DTColumnBuilder.newColumn('ACCESS_LEVEL').withTitle('ROLE'),
          DTColumnBuilder.newColumn('PASSWORD').withTitle('PASSWORD'),
          DTColumnBuilder.newColumn('LGNAME').withTitle('LANGUAGE'),
          DTColumnBuilder.newColumn('CONTACT').withTitle('CONTACT').withOption('width', '20%'),
          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable()
              .renderWith(actionsHtml).withOption('width', '12%')
      ];
      $.ajax({
          async: false,
          type: 'GET',
          url: '/index.cfm/basicdata/getUserLevel',
          success: function(data) {
               //callback
               vm.userInfo = data;
               if( vm.userInfo.TYPEUSER == 2 ){
                  vm.dtColumns.splice(1,1);
                  sumColumnFilter = {'0' : {type : 'text'}, '1' : {type : 'text'}, '2' : {type : 'text'}, '3' : {type : 'text'}, '4' : {type : 'text'}, '5' : {type : 'text'}, '6' : {type : 'text'}, '7' : {type : 'text'}};
                }
                else if( vm.userInfo.TYPEUSER == 3 ){
                  vm.dtColumns.splice(1,2);
                  sumColumnFilter = {'0' : {type : 'text'}, '1' : {type : 'text'}, '2' : {type : 'text'}, '3' : {type : 'text'}, '4' : {type : 'text'}, '5' : {type : 'text'}, '6' : {type : 'text'}};
                }
                else if( vm.userInfo.TYPEUSER == 4 ){
                  vm.dtColumns=[];
                }
          }
      });
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/user/getUser')
          .withPaginationType('full_numbers')
          .withLightColumnFilter(sumColumnFilter)
          .withOption('createdRow', createdRow)
          .withOption('select', { style: 'single' });
      $http.get("/index.cfm/basicdata/getfactory").success(function(dataResponse){
        vm.factories = dataResponse;
      });

      $http.get("/index.cfm/basicdata/getLanguage").success(function(dataResponse){
        vm.languages = dataResponse;
      });

      // $http.get("/index.cfm/user/getUser").success(function(dataResponse){
      //   vm.users = dataResponse;
      // });


      $http.get("/index.cfm/access_level/getaccess_level").success(function(dataResponse){
          vm.access_levels = dataResponse;
        });

      // $http.get("/index.cfm/contact/getcontacts").success(function(dataResponse){
      //     vm.contacts = dataResponse;
      // });


    if(vm.userInfo.TYPEUSER == 0){
      $( "#factory" ).change(function() {
            vm.user.zone = "";
            vm.user.agent = "";
            $("#agent").parent().parent().addClass('display-none');
            vm.user.customer = "";
            $("#customer").parent().parent().addClass('display-none');
            var idagentFac = $("#factory").val();
            if(idagentFac > 0){
              $scope.$apply(function () {
                  $.ajax({
                    type: "POST",
                        url: "/index.cfm/basicdata/getzone",
                        async: false,
                        data: {
                              'idfac' : idagentFac
                        },
                        success: function( data ) {
                          vm.zones = data;
                        }
                  });
              });
              $("#zone").parent().parent().removeClass('display-none');

              $("#zone").change(function() {
                vm.user.agent = "";
                vm.user.customer = "";
                $("#customer").parent().parent().addClass('display-none');
                var idagentZone = $("#zone").val();
                if(idagentZone > 0){
                  $scope.$apply(function () {
                      $.ajax({
                        type: "POST",
                            url: "/index.cfm/basicdata/getagent",
                            async: false,
                            data: {
                              'idzone' : idagentZone
                            },
                            success: function( data ) {
                              vm.agents = data;
                            }
                      });
                  });

                  $("#agent").parent().parent().removeClass('display-none');
                  $("#agent").change(function() {
                    vm.user.customer = "";
                    var idagentAgent = $("#agent").val();
                    if(idagentAgent > 0){
                      $scope.$apply(function () {
                        $.ajax({
                          type: "POST",
                              url: "/index.cfm/basicdata/getcustomer",
                              async: false,
                              data: {
                                'idagent' : idagentAgent
                              },
                              success: function( data ) {
                                vm.customers = data;
                              }
                        });
                      });
                      $("#customer").parent().parent().removeClass('display-none');
                    }else{
                      $("#customer").parent().parent().addClass('display-none');
                      vm.user.customer = "";
                    }
                  });
                }else{
                  $("#agent").parent().parent().addClass('display-none');
                  vm.user.agent = "";
                  $("#customer").parent().parent().addClass('display-none');
                  vm.user.customer = "";
                }
              });
            }
            else{
              $("#zone").parent().parent().addClass('display-none');
              vm.user.zone = "";
              $("#agent").parent().parent().addClass('display-none');
              vm.user.agent = "";
              $("#customer").parent().parent().addClass('display-none');
              vm.user.customer = "";
            }
        });
    }
    else if(vm.userInfo.TYPEUSER == 1){
      vm.user.factory = vm.user.FACTORYID;
      // alert(vm.user.FACTORYID);
      vm.user.zone = vm.user.ZONEID;
      $("#factory").parent().parent().addClass('display-none');
          $.ajax({
            type: "POST",
                url: "/index.cfm/basicdata/getzone",
                async: false,
                data: {
                      'idfac' : vm.user.FACTORYID
                },
                success: function( data ) {
                  vm.zones = data;
                }
          });
      $("#zone").parent().parent().removeClass('display-none');

      $("#zone").change(function() {
        vm.user.agent = "";
        vm.user.customer = "";
        $("#customer").parent().parent().addClass('display-none');
        var idagentZone = $("#zone").val();
        if(idagentZone > 0){
          $scope.$apply(function () {
              $.ajax({
                type: "POST",
                    url: "/index.cfm/basicdata/getagent",
                    async: false,
                    data: {
                      'idzone' : idagentZone
                    },
                    success: function( data ) {
                      vm.agents = data;
                    }
              });
          });

          $("#agent").parent().parent().removeClass('display-none');
          $("#agent").change(function() {
            vm.user.customer = "";
            var idagentAgent = $("#agent").val();
            if(idagentAgent > 0){
              $scope.$apply(function () {
                $.ajax({
                  type: "POST",
                      url: "/index.cfm/basicdata/getcustomer",
                      async: false,
                      data: {
                        'idagent' : idagentAgent
                      },
                      success: function( data ) {
                        vm.customers = data;
                      }
                });
              });
              $("#customer").parent().parent().removeClass('display-none');
            }else{
              $("#customer").parent().parent().addClass('display-none');
              vm.user.customer = "";
            }
          });
        }else{
          $("#agent").parent().parent().addClass('display-none');
          vm.user.agent = "";
          $("#customer").parent().parent().addClass('display-none');
          vm.user.customer = "";
        }
      });
    }
    else if(vm.userInfo.TYPEUSER == 2) {
      $("#factory").parent().parent().addClass('display-none');
      $("#zone").parent().parent().addClass('display-none');
      vm.user.factory = vm.user.FACTORYID;
      vm.user.zone = vm.user.ZONEID;
          $.ajax({
            type: "POST",
                url: "/index.cfm/basicdata/getagent",
                async: false,
                data: {
                  'idzone' : vm.user.ZONEID
                },
                success: function( data ) {
                  vm.agents = data;
                }
          });

      $("#agent").parent().parent().removeClass('display-none');
      $("#agent").change(function() {
        vm.user.customer = "";
        var idagentAgent = $("#agent").val();
        if(idagentAgent > 0){
          $scope.$apply(function () {
            $.ajax({
              type: "POST",
                  url: "/index.cfm/basicdata/getcustomer",
                  async: false,
                  data: {
                    'idagent' : idagentAgent
                  },
                  success: function( data ) {
                    vm.customers = data;
                  }
            });
          });
          $("#customer").parent().parent().removeClass('display-none');
        }else{
          $("#customer").parent().parent().addClass('display-none');
          vm.user.customer = "";
        }
      });
    }
    else if (vm.userInfo.TYPEUSER == 3){
      $("#factory").parent().parent().addClass('display-none');
      $("#zone").parent().parent().addClass('display-none');
      $("#agent").parent().parent().addClass('display-none');
      vm.user.factory = vm.user.FACTORYID;
      vm.user.zone = vm.user.ZONEID;
      vm.user.agent= vm.user.AGENTID;
        $.ajax({
          type: "POST",
              url: "/index.cfm/basicdata/getcustomer",
              async: false,
              data: {
                'idagent' : vm.user.AGENTID
              },
              success: function( data ) {
                vm.customers = data;
              }
        });
      $("#customer").parent().parent().removeClass('display-none');
    }



      var tempCode = "";
      function editRowContact () {
        $('#myModalContact').modal('show');
      }
      // vm.contact = "asfasf";

      $('#addNew').on('hidden.bs.modal', function () {
        if(tempCode != ""){
          $(".highlight").removeClass("highlight");
           $("#mytable td").filter(function() { return $.text([this]) == tempCode; })
                .parent()
                .addClass("highlight");
        }
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

      function editRow(datauser) {
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
          $('#close').css('display','block');
          // $('#factory').attr('disabled',true);
          // $('#zone').attr('disabled',true);
          // $('#agent').attr('disabled',true);
          // $('#customer').attr('disabled',true);
          // $('#factory').closest(".form-group").removeClass("display-none");
          // $('#zone').closest(".form-group").removeClass("display-none");
          // $('#agent').closest(".form-group").removeClass("display-none");
          // $('#customer').closest(".form-group").removeClass("display-none");
          if(datauser.CONTACT != ""){
            $('#editContact').css("display", "inline-block");
            $('#createContact').css("display", "none");
          }else{
            $('#editContact').css("display", "none");
            $('#createContact').css("display", "inline-block");
          }
            //highlight row being edit
          $(".highlight").removeClass("highlight");
          $("#mytable td").filter(function() { return $.text([this]) == datauser.NAME; })
            .parent()
            .addClass("highlight");
          vm.index_highlight = datauser.COUNT;
          vm.user.name = datauser.NAME;
          vm.user.password = datauser.PASSWORD;
          vm.user.factory = datauser.FACTORYID;
          vm.user.zone = datauser.ZONEID;
          vm.user.agent = datauser.AGENTID;
          vm.user.customer = datauser.CUSTOMERID;
          vm.user.position = datauser.POSITION;
          vm.user.access_level = datauser.ACCESS_LEVELID;
          vm.user.contactID = datauser.CONTACTID;
          vm.user.language = datauser.IDLANGUAGE;
          $('#id_User').val(datauser.ID);
          $scope.idContactEdit = datauser.CONTACTID;
          vm.user.contact = datauser.CONTACT;
          $("#id_Contact").val(datauser.CONTACTID);
          document.getElementById("titleID").innerHTML="Edit";
          $scope.usertype = 5;
          $scope.distype  = 1;
          $scope.showtype = 0;
          $scope.hidetab  = 1;
      }

      function deleteRow(data) {
        vm.logID  = data.LOGID;
        vm.did = data.ID;
        $('#showDelete').modal('show');
      }

      function deleteUser(data) {
        $('#showDelete').modal('hide');
        $.ajax({
             type: "POST",
             url: "/index.cfm/user/delete",
             async: false,
             data: {'id' : vm.did
          },
          success: function( data ) {
              if(data.success)
              {
                  noticeSuccess(data.message);
                  vm.dtInstance.reloadData();
              }else{
                  noticeFailed("Can not delete this user");
                  vm.dtInstance.reloadData();
              }
          }
        });
      }

    function showAddNew (argument) {
        // body...
          refresh();
          $('#close').css('display','block');
          $('#factory').attr('disabled',false);
          $('#zone').attr('disabled',false);
          $('#agent').attr('disabled',false);
          $('#customer').attr('disabled',false);
          $('#factory').closest(".form-group").addClass("display-none");
          $('#zone').closest(".form-group").addClass("display-none");
          $('#agent').closest(".form-group").addClass("display-none");
          $('#customer').closest(".form-group").addClass("display-none");
          if(vm.userInfo.TYPEUSER == 0){
            $('#factory').closest(".form-group").removeClass("display-none");
          }
          else if(vm.userInfo.TYPEUSER == 1){
            $('#zone').closest(".form-group").removeClass("display-none");
          }
          else if(vm.userInfo.TYPEUSER == 2){
            $('#agent').closest(".form-group").removeClass("display-none");
          }
          else if(vm.userInfo.TYPEUSER == 3){
            $('#customer').closest(".form-group").removeClass("display-none");
          }
          document.getElementById("titleID").innerHTML="Create";
          $(".highlight").removeClass("highlight");
          $('#btnRefresh').css('display','inline-block');
          $('#addNew').modal('show');
          // vm.user.title_formtypeOfCust = "Create new Type of Customer";
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
          $scope.usertype = 5;
          $scope.distype=1;
          $scope.showtype=0;
          $scope.hidetab  = 1;
      }

      
        $("#name").change(function(){
          if($(this).val()){
            $.ajax({
              async: false,
              type: 'POST',
              data: {
                'code' : vm.user.name,
                'table':'user',
                'nameCol':'user_name',
                'id':$('#id_User').val(),
                'idfield':'id_user'
              },
              url: '/index.cfm/basicdata/checkExistCode',
              success: function(data) {
                flag = data.isExist;
                if(flag){
                  noticeFailed("Username is exist in systems!");
                }
              }
            });
          }
        });
      

      function addRow() {
        $scope.userForm.$invalid=true;
        $.ajax({
                 type: "POST",
                 url: "/index.cfm/basicdata/checkExistCode",
                 async: false,
                 data: {'code' : vm.user.name,
                        'table':'user',
                        'nameCol':'user_name',
                        'id':$('#id_User').val(),
                        'idfield':'id_user'
              },
              success: function( data ) {
                flag = data.isExist;
                if(!flag)
                {
                    $.ajax({
                         type: "POST",
                         url: "/index.cfm/user/addNew",
                         async: false,
                         data: {
                              'name' : vm.user.name,
                              'pass' : (vm.user.password == null)?'':vm.user.password,
                              'factory' : (vm.user.factory == null)?'':vm.user.factory,
                              'zone' : (vm.user.zone == null)?'':vm.user.zone,
                              'agent' : (vm.user.agent == null)?'':vm.user.agent,
                              'customer' : (vm.user.customer == null)?'':vm.user.customer,
                              'position' : (vm.user.position == null)?'':vm.user.position,
                              'access_level' : (vm.user.access_level == null)?'':vm.user.access_level,
                              'language' : (vm.user.language == null)?'':vm.user.language,
                              'contact' : $("#id_Contact").val(),
                              'id':$('#id_User').val()
                      },
                      success: function( data ) {

                          if(data.success){
                            noticeSuccess(data.message);
                            vm.dtInstance.reloadData();
                            tempCode = data.username;
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
                }else{
                  noticeFailed("Username is exist in systems!");
                }
              }
           });
      }

      function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
      }

      function actionsHtml(data, type, full, meta) {
          if(data.LOGID != undefined){
            vm.logID = data.LOGID;
          }     
          vm.users[data.ID] = data;
          if(vm.logID == data.ID){
            return '<span class="txt-color-green btnedit text-center" title="Edit" ng-click="showCase.editRow(showCase.users[' + data.ID + '])">' +
                '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
                '</span>';
          }else{
             return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.editRow(showCase.users[' + data.ID + '])">' +
                '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
                '</span>&nbsp;' +
                '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.users[' + data.ID + '])">' +
                '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
                '</span>';
          }
      }

      function renderAgent(data, type, full, meta){
          return full.AGENT + ' - ' + full.AGENT_DES;
      }

      function renderCustomer(data, type, full, meta){
          return full.CUSTOMERID + ' - ' + full.CUSTOMER;
      }

      function refresh () {
          $('#id_User').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
          $('#name').val('');
          $('#password').val('');
      }
  };



})();


