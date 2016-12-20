(function(){
  angular.module('zone.List', ['Formcontact','datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http , $filter,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm          = this;
      //---------------------------------Start Zone---------------------------------------------
      vm.message     = '';
      vm.edit        = edit;
      vm.delete      = deleteRow;
      vm.addRow      = addRow;
      vm.refreshZone = refreshZone;
      vm.dtInstance  = {};
      vm.zones       = {};
      vm.user        =[];
      vm.showAddNew  = showAddNew;
      vm.editRowContact = editRowContact;
      vm.deleteUser  = deleteUser;
      vm.regex       = "[a-z A-Z 0-9-\_\.]+";
      vm.regex_email = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      var original = angular.copy(vm.user);
      vm.userInfo = {};
      
      $.ajax({
        async: false,
        type: 'GET',
        url: '/index.cfm/basicdata/getUserLevel',
        success: function(data) {
          vm.userInfo = data;
          //if it is factory admin
          if( vm.userInfo.TYPEUSER == 1 ){
            $('#btnAddNew').show();
          }
        }
      });

      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getzone')
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
            }
          })
          .withOption('createdRow', createdRow)
          .withOption('select', { style: 'single' });
      vm.dtColumns = [
          DTColumnBuilder.newColumn('CODE').withTitle('CODE').withOption('width', '9%'),
          DTColumnBuilder.newColumn('DES').withTitle('DESCRIPTION'),
          DTColumnBuilder.newColumn('FACTORY').withTitle('FACTORY'),
          DTColumnBuilder.newColumn('CURRENCY').withTitle('CURRENCY'),
          DTColumnBuilder.newColumn('LANGUAGE').withTitle('LANGUAGE'),
          DTColumnBuilder.newColumn('CONTACT').withTitle('CONTACT'),
          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable()
              .renderWith(actionsHtml)
      ];

      $http.get("/index.cfm/basicdata/getlanguage").success(function(dataResponse){
        vm.languages = dataResponse;
      });

      $http.get("/index.cfm/basicdata/getcurrency").success(function(dataResponse){
        vm.currencys = dataResponse;
      });

      $http.get("/index.cfm/contact/getcontacts").success(function(dataResponse){
        vm.contacts = dataResponse;
      });

      $http.get("/index.cfm/basicdata/getfactory").success(function(dataResponse){
        vm.factory = dataResponse;
      });

      var tempCode = "";
      function showAddNew () {
        refreshZone();
        document.getElementById("titleID").innerHTML="Create";
        $(".highlight").removeClass("highlight");
        $('#btnRefresh').css('display','inline-block');
        $('#addNew').modal('show');
//        vm.user.title_formzone = "Create new Zone";
//        vm.user.title_formzone = "Zone";
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
        $('#createContact').css("display", "inline-block");
        $('#editContact').css("display", "none");
        $scope.idContactEdit = 0;
        $("#id_Contact").val(0);
        $scope.usertype = 2;
        $scope.distype=1;
        $scope.showtype=0;
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

      function edit(zone) {
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
        if(zone.CONTACT != ""){
          $('#editContact').css("display", "inline-block");
          $('#createContact').css("display", "none");
        }else{
          $('#editContact').css("display", "none");
          $('#createContact').css("display", "inline-block");
        }
        $(".highlight").removeClass("highlight");
        $("#mytable td").filter(function() { return $.text([this]) == zone.CODE; })
          .parent()
          .addClass("highlight");
          vm.user.code=zone.CODE;
          vm.user.description=zone.DES;
          vm.user.factory = zone.FACTORYID;
          vm.user.currency = zone.CURRENCYID;
          vm.user.language = zone.LANGUAGEID;
          vm.user.contactID = zone.CONTACTID;
          $scope.idContactEdit = zone.CONTACTID;
          vm.user.contact = zone.CONTACT;
          $('#id_Zone').val(zone.ID);
          $("#id_Contact").val(zone.CONTACTID);
          $scope.usertype = 2;
          $scope.distype = 1;
          $scope.showtype = 0;
      }
      function deleteRow(zone) {
        $('#showDelete').modal('show');
        vm.did = zone.ID;
      }

      function deleteUser() {
        $('#showDelete').modal('hide');
        $.ajax({
             type: "POST",
             url: "/index.cfm/zone/delete",
             async: false,
             data: {'zId' : vm.did
          },
          success: function( data ) {
              if(data.success)
              {
                  $('#showDelete').modal('hide');
                  noticeSuccess(data.message);
                  vm.dtInstance.reloadData();
              }else{
                  noticeFailed("Can not delete this type");
              }
          }
       });
      }
      function addRow() {
         var flag = false;

        $.ajax({
                 type: "POST",
                 url: "/index.cfm/basicdata/checkExistCode",
                 async: false,
                 data: {'code' : vm.user.code,
                        'table':'zone',
                        'nameCol':'z_code',
                        'id':$('#id_Zone').val(),
                        'idfield':'id_Zone'
              },
              success: function( data ) {
                  flag = data.isExist;
                  if(!flag)
                  {
                    $.ajax({
                             type: "POST",
                             url: "/index.cfm/zone/addNew",
                             async: false,
                             data: {'code' : vm.user.code,
                                  'description' : vm.user.description,
                                  'factory'  : vm.user.factory,
                                  'currency' : vm.user.currency,
                                  'language' : vm.user.language,
                                  'contact' : $("#id_Contact").val(),
                                  'id_Zone':$('#id_Zone').val()
                          },
                          success: function( data ) {
                            if(data.success){
                              noticeSuccess(data.message);
                              vm.dtInstance.reloadData();
                              tempCode = data.code_Zone;
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
                    noticeFailed("Code is exist in systems!");
                  }
              }
           });
      }

       function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
       }
      function actionsHtml(data, type, full, meta) {
          vm.zones[data.ID] = data;
          if( vm.userInfo.TYPEUSER == 1 || vm.userInfo.TYPEUSER == 2 ){
            return '<span class="txt-color-green btnedit padding-right-30" title="Edit" ng-click="showCase.edit(showCase.zones[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.zones[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
          }
          else
           return "";
      }

      function refreshZone () {
          $('#id_Zone').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
          $('#code').val('');
          $('#description').val('');
      }


      //---------------------------------End Zone---------------------------------------------
  };

})();
