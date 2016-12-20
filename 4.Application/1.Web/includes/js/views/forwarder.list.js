(function(){
  angular.module('forwarder.List', ['Formcontact','datatables', 'datatables.light-columnfilter','ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http, $filter, $compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm         = this;
      vm.message    = '';
      vm.deleteUser = deleteUser;
      vm.edit       = edit;
      vm.delete     = deleteRow;
      vm.showAddNew = showAddNew;
      vm.editRowContact = editRowContact;
      vm.addRow     = addRow;
      vm.refresh    = refresh;
      vm.dtInstance = {};
      vm.forwarder  = {};
      vm.user       =[];
      vm.regex      = "[a-z A-Z 0-9-\_\.]+";
      vm.regex_email = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      var original = angular.copy(vm.user);
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/forwarder/getforwarder')
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
            }
          })
          .withOption('createdRow', createdRow)
          .withDOM("<'dt-toolbar'<'col-md-1 col-xs-12'C><'col-md-10 col-xs-12'f><'col-md-1 col-xs-12'l>r>"+
                    "t"+
                    "<'dt-toolbar-footer'<'col-md-6 col-xs-12'i><'col-xs-12 col-md-6'p>>")
          .withOption('select', { style: 'single' });
      vm.dtColumns = [
          DTColumnBuilder.newColumn('ID').withTitle('CODE').withClass('text-center').withOption('width','10%'),
          DTColumnBuilder.newColumn('NAME').withTitle('NAME').withOption('width','20%'),
          DTColumnBuilder.newColumn('ZONE').withTitle('ZONE').withOption('width','20%'),
          DTColumnBuilder.newColumn('AGENT').withTitle('AGENT').withOption('width','20%'),
          DTColumnBuilder.newColumn('CONTACT').withTitle('CONTACT').withOption('width','20%'),
          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable()
              .renderWith(actionsHtml)
      ];

      $http.get("/index.cfm/contact/getcontacts").success(function(dataResponse){
        vm.contacts = dataResponse;
      });

      var tempCode = "";
      function editRowContact () {
        $('#myModalContact').modal('show');
      }

      // $('#addNew').on('hidden.bs.modal', function () {
      //     $(".highlight").removeClass("highlight");
      //      $("#mytable td").filter(function() { return $.text([this]) == tempCode; })
      //           .parent()
      //           .addClass("highlight");
      //   });

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

      function edit(forwarder) {
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
        if(forwarder.CONTACT != ""){
          $('#editContact').css("display", "inline-block");
          $('#createContact').css("display", "none");
        }else{
          $('#editContact').css("display", "none");
          $('#createContact').css("display", "inline-block");
        }
          //highlight row
        $(".highlight").removeClass("highlight");
        $("#mytable td").filter(function() { return $.text([this]) == forwarder.NAME; })
          .parent()
          .addClass("highlight");
        vm.user.forwarder=forwarder.NAME;
        vm.user.contactID = forwarder.CONTACTID;
        $('#id_Forwarder').val(forwarder.ID);
        $scope.idContactEdit = forwarder.CONTACTID;
        vm.user.contact = forwarder.CONTACT;
        $("#id_Contact").val(forwarder.CONTACTID);
        document.getElementById("titleID").innerHTML="Edit";
        $scope.hidetab  = 1;
      }

      function deleteRow(forwarder) {
          vm.did = forwarder.ID;
          $('#showDelete').modal('show');
      }

    function deleteUser(forwarder){
      $('#showDelete').modal('hide');
        $.ajax({
             type: "POST",
             url: "/index.cfm/forwarder/delete",
             async: false,
             data: {'forwarderID' : vm.did
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
      }

     function showAddNew (argument) {
        refresh();
        document.getElementById("titleID").innerHTML="Create";
        $(".highlight").removeClass("highlight");
        $('#btnRefresh').css('display','inline-block');
        $('#addNew').modal('show');
        $(document).ready(function(){
          $("#addNew").on('shown.bs.modal', function(){
            $(this).find('#forwarder').focus();
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
        $scope.hidetab  = 1;
      }

      function addRow() {
        $.ajax({
                 type: "POST",
                 url: "/index.cfm/basicdata/checkExistCode",
                 async: false,
                 data: {'code' : vm.user.forwarder,
                        'table':'forwarder',
                        'nameCol':'fw_name',
                        'id':$('#id_Forwarder').val(),
                        'idfield':'id_forwarder'
              },
              success: function( data ) {
                  flag = data.isExist;
                  if(!flag)
                  {
                    $.ajax({
                             type: "POST",
                             url: "/index.cfm/forwarder/addNew",
                             async: false,
                             data: {
                                  'name' : vm.user.forwarder,
                                  'contact' : $("#id_Contact").val(),
                                  'id_Forwarder':$('#id_Forwarder').val()
                          },
                          success: function( data ) {
                            if(data.success){
                              $('#addNew').modal('hide');
                              noticeSuccess(data.message);
                              vm.dtInstance.reloadData();
                              tempCode = data.forw_Name;
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
       }
      function actionsHtml(data, type, full, meta) {
          vm.forwarder[data.ID] = data;
          return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.forwarder[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.forwarder[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
      }

      function refresh () {
          $('#id_Forwarder').val(0);
          vm.user= angular.copy(original);
          // $scope.userForm.$setPristine();
      }

      // -----------------------------End Forwarder--------------------------------------------


  };

})();

