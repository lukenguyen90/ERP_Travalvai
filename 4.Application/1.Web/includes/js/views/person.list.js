(function(){
  angular.module('person.List', ['datatables']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {

     var vm = this;
       vm.typeOptions = [
        { id: 1, name: 'Factory' },
        { id: 2, name: 'Zone' },
        { id: 3, name: 'Agent' },
        { id: 4, name: 'Customer' },
        { id: 5, name: 'Particular' }
        ];
      vm.message = '';
      vm.edit = edit;
      vm.addRowContact = addRowContact;
      vm.delete = deleteRow;
      vm.addRow = addRow;
      vm.refresh = refresh;
      vm.dtInstance = {};
      vm.persons = {};
      vm.user=[];
      vm.contact=[];
      vm.contactID = 0;
      vm.regex = "[a-z A-Z 0-9-\_\.]+";
      vm.regex_email = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      var original = vm.user;
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/person/getperson')
          .withPaginationType('full_numbers')
          .withOption('createdRow', createdRow);

      vm.dtColumns = [
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
      //   vm.languages = dataResponse;
      // });

      // $http.get("/index.cfm/basicdata/getcurrency").success(function(dataResponse){
      //   vm.currencys = dataResponse;
      // });
      var tempCode = "";
        $('#myModal').on('hidden.bs.modal', function () {
           $("#mytable1 td").filter(function() { return $.text([this]) == tempCode; })
                .parent()
                .addClass("highlight");
        });

      function edit(person) {
          $(document).ready(function(){
              $("#addNewPersonForm").on('shown.bs.modal', function(){
              $(this).find('#name').focus();
              });
          });
          vm.user.name = person.NAME ;
          vm.user.pos = person.POS ;
          vm.user.phone = person.PHONE ;
          vm.user.email = person.EMAIL ;
          vm.user.bday = person.BDAY ;
          vm.user.note = person.NOTE ;
          vm.user.id = person.ID;
          $('#id_Person').val(person.ID);
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
                  vm.dtInstance.reloadData();
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
                 data: {'name' : vm.user.name,
                        'table':'person',
                        'nameCol':'cts_p_name'
              },
              success: function( data ) {
                  flag = data.success;
                  if(flag == false || $('#id_Person').val()!="0")
                  {
                  	console.log(vm.user);
                    $.ajax({
                             type: "POST",
                             url: "/index.cfm/person/addNewPerson",
                             async: false,
                             data: {
                                  'name' : vm.user.name,
                                  'position' : vm.user.pos ,
                                  'phone' : vm.user.phone ,
                                  'email' : vm.user.email ,
                                  'note' : vm.user.note ,
                                  'bday' : vm.user.bday ,
                                  'contactID' : vm.contactID ,
                                  'id_Person':$('#id_Person').val()
                          },
                          success: function( data ) {
                            if(data.success){
                              $('#addNewPersonForm').modal('hide');
                              noticeSuccess(data.message);
                              vm.dtInstance.reloadData();
                              tempCode = data.per_email;
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

      // function addRowContact() {
      //   console.log("alsjkdflajsdf");
      //   $.ajax({
      //            type: "POST",
      //            url: "/index.cfm/basicdata/checkExistCode",
      //            async: false,
      //            data: {'code' : vm.contact.cn_name,
      //                   'table':'contact',
      //                   'nameCol':'cn_name'
      //         },
      //         success: function( data ) {
      //             flag = data.success;
      //             console.log(flag);
      //         }
      //      });
      //     if(flag == false || $('#id_Contact').val()!="0")
      //     {
      //       $.ajax({
      //                type: "POST",
      //                url: "/index.cfm/contact/addNewContact",
      //                async: false,
      //                data: {
      //                     'name' : vm.contact.cn_name,
      //                     'address_1' : vm.contact.cts_address_1,
      //                     'address_2' : vm.contact.cts_address_2,
      //                     'address_3' : vm.contact.cts_address_3,
      //                     'city' : vm.contact.cts_city,
      //                     'province' : vm.contact.cts_province,
      //                     'zip_code' : vm.contact.cts_zip_code,
      //                     'country' : vm.contact.cts_country,
      //                     'phone' : vm.contact.cts_phone,
      //                     'email' : vm.contact.cts_email,
      //                     'vat_code' : vm.contact.cts_vat_code,
      //                     'notes' : vm.contact.cts_notes,
      //                     'type' : vm.contact.cts_type,
      //                     'sh_name' : vm.contact.cts_sh_name,
      //                     'sh_address_1' : vm.contact.cts_sh_address_1,
      //                     'sh_address_2' : vm.contact.cts_sh_address_2,
      //                     'sh_address_3' : vm.contact.cts_sh_address_3,
      //                     'sh_city' : vm.contact.cts_sh_city,
      //                     'sh_province' : vm.contact.cts_sh_province,
      //                     'sh_zip_code' : vm.contact.cts_sh_zip_code,
      //                     'id_Contact':$('#id_Contact').val()
      //             },
      //             success: function( data ) {
      //               console.log(data);
      //               if(data.success){
      //                 noticeSuccess(data.message);
      //                 vm.dtInstance.reloadData();
      //                 vm.contactID = data.groupId;
      //               }
      //               else
      //               {
      //                 noticeFailed("Please try again!");
      //               }

      //               refresh();
      //             }
      //          });
      //     }
      //     else
      //     {
      //       noticeFailed("Code is exist in systems!");
      //     }
      // }

       function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
       }
      function actionsHtml(data, type, full, meta) {
          vm.persons[data.ID] = data;
          return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.persons[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.persons[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
      }

      function refresh () {
          $('#id_Person').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
      }

      function refreshContact () {
          $('#id_Contact').val(0);
          vm.contact= angular.copy(original);
          $scope.userFormContact.$setPristine();
      }

  };

  $(".modal-body" ).tabs({
        activate:function(event,ui){
        }
     });

})();
