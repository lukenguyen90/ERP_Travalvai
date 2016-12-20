var app = angular.module('Formcontact', ['datatables']);

app.directive('supplierContact',function(){
    var controller = function($scope ,$http , $filter,$compile, DTOptionsBuilder, DTColumnBuilder) {

        var vm              = this;
        vm.userInfo         = {};
        $scope.hanhtan      = [];
        $scope.regex        = "[a-z A-Z 0-9-\_\.]+";
        $scope.regex_email  = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        $scope.regex_number = "^[0-9]*$";
        // body...
        // -----------------------------Start Person--------------------------------------------
        var hanhtan = [];
        $scope.persons = [];
        $scope.addRowPerson = addRowPerson;
        $scope.refreshPerson = refreshPerson
        $scope.editPerson = editPerson;
        $scope.deletePerson = deletePerson;
        $scope.deleteUserPerson = deleteUserPerson;
        $scope.showAddNewPerson = showAddNewPerson;
        $scope.user_person=[];
        var original_person = $scope.user_person;
        $scope.dtInstancePerson={};

        $scope.dtOptionsPerson = DTOptionsBuilder.fromSource('/index.cfm/person/getperson')
            .withPaginationType('full_numbers')
            .withOption('createdRow', createdRow);

        $scope.dtColumnsPerson = [
            DTColumnBuilder.newColumn('NAME').withTitle('Name'),
            DTColumnBuilder.newColumn('POS').withTitle('Position'),
            DTColumnBuilder.newColumn('PHONE').withTitle('Telephone'),
            DTColumnBuilder.newColumn('EMAIL').withTitle('Email'),
            DTColumnBuilder.newColumn('BDAYFORMAT').withTitle("B'Day"),
            DTColumnBuilder.newColumn('NOTE').withTitle("Notes"),
            DTColumnBuilder.newColumn(null).withTitle('Actions').notSortable()
              .renderWith(actionsHtmlPerson)
        ];

        function createdRow(row, data, dataIndex) {
          $compile(angular.element(row).contents())($scope);
        }

        function editPerson(person) {
            $('#btnRefreshPerson').css('display','none');
            $('#addNewPersonForm').modal('show');
            $('#title_Person').text('Edit');
            $scope.user_person.name = person.NAME ;
            $scope.user_person.pos = person.POS ;
            $scope.user_person.phone = person.PHONE ;
            $scope.user_person.email_person = person.EMAIL ;
            $scope.user_person.bday = new Date(person.BDAY);
            $scope.user_person.note = person.NOTE ;
            $scope.user_person.id = person.ID;
            $('#id_Person').val(person.ID);
        }
        function showAddNewPerson (argument) {
          $('#btnRefreshPerson').css('display','inline-block');
          $('#addNewPersonForm').modal('show');
          $('#title_Person').text('Create');
          $('#name').focus();
          refreshPerson();
        }
        var tempCodePer = '';
        function addRowPerson() {
            $.ajax({
               type: "POST",
               url: "/index.cfm/person/addNewPerson",
               async: false,
               data: {
                    'name' : $scope.user_person.name,
                    'position' : ($scope.user_person.pos  == null) ? "" :  $scope.user_person.pos,
                    'phone' : ($scope.user_person.phone  == null) ? "" :  $scope.user_person.phone,
                    'email' : ($scope.user_person.email_person  == null) ? "" :  $scope.user_person.email_person,
                    'note' : ($scope.user_person.note  == null) ? "" :  $scope.user_person.note,
                    // 'bday' : $filter('date')($scope.user_person.bday, "yyyy-MM-dd"),
                    'bday' : $filter('date')($('#bday').val(), "yyyy-MM-dd"),
                    'contactID' : $('#id_Contact').val() ,
                    'id_Person':$('#id_Person').val()
            },
            success: function( data ) {
              if(data.success){
                noticeSuccess(data.message);
                // $scope.dtInstancePerson.reloadData();
                $scope.dtOptionsPerson = DTOptionsBuilder.fromSource('/index.cfm/person/getperson?idcontact=' + $('#id_Contact').val())
                  .withPaginationType('full_numbers')
                  .withOption('createdRow', createdRow);
                tempCodePer = data.name_Person;
                setTimeout(function() {
                  $('#addNewPersonForm').modal('hide');
                }, 1000);
                refreshPerson();
              }
              else
              {
                noticeFailed("Please fill in all fields and try again!");
              }
            }
         });
        }

      $('#addNewPersonForm').on('hidden.bs.modal', function () {
          $(".highlight-Per").removeClass("highlight-Per");
           $("#mytable-Per td").filter(function() { return $.text([this]) == tempCodePer; })
                .parent()
                .addClass("highlight-Per");
        });
      function deletePerson(person){
           $scope.didperson = person.ID;
          // console.log($scope.didperson);
          $('#showDeletePerson').modal('show');
      }
      function deleteUserPerson(person) {
        $('#showDeletePerson').modal('hide');
        $.ajax({
               type: "POST",
               url: "/index.cfm/person/deletePerson",
               async: false,
               data: {'id_Person' : $scope.didperson
            },
            success: function( data ) {
                if(data.success)
                {
                    noticeSuccess(data.message);
                    $scope.dtInstancePerson.reloadData();
                }else{
                    noticeFailed("Can not delete this type");
                }
            }
         });
      }

      function refreshPerson () {
          $('#id_Person').val(0);
          $scope.user_person= angular.copy(original_person);
          $('#name').val('');
          $('#pos').val('');
          $('#phone').val('');
          $('#email').val('');
          $('#bday').val('');
          $('#note').val('');
      }

      function actionsHtmlPerson(data, type, full, meta) {
          $scope.hanhtan[data.ID] = data;
          return '<span class="txt-color-green btnedit" title="Edit" ng-click="editPerson(hanhtan[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="deletePerson(hanhtan[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
      }


      // // -----------------------------End Person--------------------------------------------


      // // -----------------------------Start Contact--------------------------------------------

      $('#myTab1_s2').css("display", "inline-block");
      $scope.contactID = 0;
      $scope.dtInstance={};
      $scope.addRowContact = addRowContact;
      $scope.refreshContact = refreshContact;
      $scope.contact=[];
      $scope.shipmentinfor=[];
      var original_contact = $scope.contact;
       $scope.typeOptions = [
        { id: 1, name: 'Factory' },
        { id: 2, name: 'Zone' },
        { id: 3, name: 'Agent' },
        { id: 4, name: 'Customer' },
        { id: 5, name: 'User' },
        ];

      var tempContactId;
      $("#myModalContact").on('shown.bs.modal', function(){
        $('.nav-tabs a[href="#contactTab1"]').tab('show');
        $(this).find('#cn_name').focus();
        if($("#contactcontactid").val() != undefined && $("#contactcontactid").val() != 0 ){
          document.getElementById("titlecontact").innerHTML="Edit Contact";
          $('#myTab1_s2').css("display", "inline-block");
          $('#btnRefreshContact').css("display", "none");
          $.ajax({
            type: "GET",
            url: '/index.cfm/contact/getcontacts',
            async:false,
            data:{'id':$("#contactcontactid").val()},
            success: function (data) {
              // body...
              $scope.contact.id_contact      = data[0].ID;
              $scope.contact.cn_name         = data[0].NAME;
              $scope.contact.cts_address_1   = data[0].ADDRESS_1;
              $scope.contact.cts_address_2   = data[0].ADDRESS_2;
              $scope.contact.cts_address_3   = data[0].ADDRESS_3;
              $scope.contact.cts_city        = data[0].CITY;
              $scope.contact.cts_province    = data[0].PROVINCE;
              $scope.contact.cts_zip_code    = data[0].ZIP_CODE;
              $scope.contact.cts_country     = data[0].COUNTRY;
              $scope.contact.cts_phone       = data[0].PHONE;
              $scope.contact.cts_email       = data[0].EMAIL;
              $scope.contact.cts_vat_code    = data[0].VAT_CODE;
              $scope.contact.cts_notes       = data[0].NOTES;
              $scope.contact.cts_sh_name     = data[0].SH_NAME;
              $scope.contact.cts_sh_address_1= data[0].SH_ADDRESS_1;
              $scope.contact.cts_sh_address_2= data[0].SH_ADDRESS_2;
              $scope.contact.cts_sh_address_3= data[0].SH_ADDRESS_3;
              $scope.contact.cts_sh_city     = data[0].SH_CITY;
              $scope.contact.cts_sh_province = data[0].SH_PROVINCE;
              $scope.contact.cts_sh_zip_code = data[0].SH_ZIP_CODE;
              $scope.contact.cts_type        = $scope.usertype;
              $scope.contact.disType         = $scope.distype;
              $scope.contact.showType        = $scope.showtype; 
              $scope.shipmentinfor.hideTab   = $scope.hidetab;
              $('#id_Contact').val(data[0].ID);
              $("#name_Contact").val(data[0].NAME);
              tempContactId = data[0].ID;  
              var path_person = '/index.cfm/person/getperson?idcontact=' + $('#id_Contact').val();
              console.log(path_person);
              $scope.dtOptionsPerson = DTOptionsBuilder.fromSource(path_person)
              .withPaginationType('full_numbers')
              .withOption('createdRow', createdRow);

              $scope.dtColumnsPerson = [
                  DTColumnBuilder.newColumn('NAME').withTitle('Name'),
                  DTColumnBuilder.newColumn('POS').withTitle('Position'),
                  DTColumnBuilder.newColumn('PHONE').withTitle('Telephone'),
                  DTColumnBuilder.newColumn('EMAIL').withTitle('Email'),
                  DTColumnBuilder.newColumn('BDAYFORMAT').withTitle("B'Day"),
                  DTColumnBuilder.newColumn('NOTE').withTitle("Notes"),
                  DTColumnBuilder.newColumn(null).withTitle('Actions').notSortable()
                      .renderWith(actionsHtmlPerson)
              ];
              $scope.$apply();
            }
          });

         $.ajax({
          type: "GET",
          url: '/index.cfm/shipment/getShipmentInfor',
          async:false,
          data:{'id':$("#contactcontactid").val()},
          success: function (data) {
            $scope.shipmentinfor.sh_name        = data.NAME;
            $scope.shipmentinfor.sh_address_1   = data.ADDRESS1;
            $scope.shipmentinfor.sh_address_2   = data.ADDRESS2;
            $scope.shipmentinfor.sh_address_3   = data.ADDRESS3;
            $scope.shipmentinfor.sh_city        = data.CITY;
            $scope.shipmentinfor.sh_province    = data.PROVINCE;
            $scope.shipmentinfor.sh_zip_code    = data.ZIPCODE;
            $scope.shipmentinfor.sh_country     = data.COUNTRY;
            $scope.shipmentinfor.sh_phone       = data.PHONE;
            $scope.shipmentinfor.sh_email       = data.EMAIL;
            $scope.shipmentinfor.sh_note        = data.NOTE;
            $('#id_shipmentinfor').val(data.ID);
            $scope.$apply();
          }
          });

        }else{
          $('#myTab1_s2').css("display", "inline-block");
          $('#btnRefreshContact').css("display", "inline-block");
          document.getElementById("titlecontact").innerHTML="Create Contact";
          refreshContact();
        }
      });

      function refreshContact () {
        $('#id_Contact').val(0);
        $scope.contact= angular.copy(original_contact);
        $scope.userFormContact.$setPristine();
        $('#cn_name').val('');
        $('#cts_vat_code').val('');
        $('#cts_address_1').val('');
        $('#cts_address_2').val('');
        $('#cts_address_3').val('');
        $('#cts_city').val('');
        $('#cts_province').val('');
        $('#cts_zip_code').val('');
        $('#cts_country').val('');
        $('#cts_phone').val('');
        $('#cts_email').val('');
        $('#cts_notes').val('');
        $('#cts_sh_name').val('');
        $('#cts_sh_zip_code').val('');
        $('#cts_sh_address_1').val('');
        $('#cts_sh_address_2').val('');
        $('#cts_sh_address_3').val('');
        $('#cts_sh_city').val('');
        $('#cts_sh_province').val('');
        $("#name_Contact").val('');
        $scope.contact.cts_type        = $scope.usertype;
        $scope.contact.disType         = $scope.distype;
        $scope.contact.showType        = $scope.showtype;    
        $scope.shipmentinfor.hideTab   = $scope.hidetab; 
        $scope.$apply();     
      }


      function addRowContact() {
        $.ajax({
          type: "POST",
          url: "/index.cfm/contact/addNewContact",
          async: false,
          data: {
            'name'          : $scope.contact.cn_name,
            'address_1'     : ($scope.contact.cts_address_1 == null)    ? "" : $scope.contact.cts_address_1,
            'address_2'     : ($scope.contact.cts_address_2 == null)    ? "" : $scope.contact.cts_address_2,
            'address_3'     : ($scope.contact.cts_address_3 == null)    ? "" : $scope.contact.cts_address_3,
            'city'          : ($scope.contact.cts_city == null)         ? "" : $scope.contact.cts_city,
            'province'      : ($scope.contact.cts_province == null)     ? "" : $scope.contact.cts_province,
            'zip_code'      : ($scope.contact.cts_zip_code == null)     ? "" : $scope.contact.cts_zip_code,
            'country'       : ($scope.contact.cts_country == null)      ? "" : $scope.contact.cts_country,
            'phone'         : ($scope.contact.cts_phone == null)        ? "" : $scope.contact.cts_phone,
            'email'         : ($scope.contact.cts_email == null)        ? "" : $scope.contact.cts_email,
            'vat_code'      : ($scope.contact.cts_vat_code == null)     ? "" : $scope.contact.cts_vat_code,
            'notes'         : ($scope.contact.cts_notes == null)        ? "" : $scope.contact.cts_notes,
            'type'          : ($scope.contact.cts_type == null)         ? "" : $scope.contact.cts_type,
            'sh_name'       : ($scope.contact.cts_sh_name == null)      ? "" : $scope.contact.cts_sh_name,
            'sh_address_1'  : ($scope.contact.cts_sh_address_1 == null) ? "" : $scope.contact.cts_sh_address_1,
            'sh_address_2'  : ($scope.contact.cts_sh_address_2 == null) ? "" : $scope.contact.cts_sh_address_2,
            'sh_address_3'  : ($scope.contact.cts_sh_address_3 == null) ? "" : $scope.contact.cts_sh_address_3,
            'sh_city'       : ($scope.contact.cts_sh_city == null)      ? "" : $scope.contact.cts_sh_city,
            'sh_province'   : ($scope.contact.cts_sh_province == null)  ? "" : $scope.contact.cts_sh_province,
            'sh_zip_code'   : ($scope.contact.cts_sh_zip_code == null)  ? "" : $scope.contact.cts_sh_zip_code,
            'id_Contact'    :  $('#id_Contact').val()
          },
          success: function( data ) {
            if(data.success){
              noticeSuccess(data.message);
              $scope.contactID = data.groupId;
              $scope.idContactEdit = data.groupId;
              $('#myTab1_s2').css("display", "inline-block");
              if(tempContactId != $scope.contactID){
                var path_person = '/index.cfm/person/getperson?idcontact=' + $scope.contactID;
                $scope.dtOptionsPerson = DTOptionsBuilder.fromSource(path_person)
                .withPaginationType('full_numbers')
                .withOption('createdRow', createdRow);

                $scope.dtColumnsPerson = [
                    // DTColumnBuilder.newColumn('ID').withTitle('No.'),
                    DTColumnBuilder.newColumn('NAME').withTitle('Name'),
                    DTColumnBuilder.newColumn('POS').withTitle('Position'),
                    DTColumnBuilder.newColumn('PHONE').withTitle('Telephone'),
                    DTColumnBuilder.newColumn('EMAIL').withTitle('Email'),
                    DTColumnBuilder.newColumn('BDAYFORMAT').withTitle("B'Day"),
                    DTColumnBuilder.newColumn('NOTE').withTitle("Notes"),
                    DTColumnBuilder.newColumn(null).withTitle('Actions').notSortable()
                        .renderWith(actionsHtmlPerson)
                ];
              }
              $("#name_Contact").val($scope.contact.cn_name);
              $("#id_Contact").val($scope.contactID);
              $('#myModalContact').modal('hide');
            }
            else
            {
              noticeFailed("Please fill in all fields and try again!");
            }
          }
        });
        addShipmentInfor();
      }

      // -----------------------------End Contact--------------------------------------------

      // // -----------------------------Start Shipment Information--------------------------------------------

      function addShipmentInfor(){
         $.ajax({
          type: "POST",
          url: "/index.cfm/shipment/addNewShipmentInfor",
          async: false,
          data: {
            'name'          : $scope.shipmentinfor.sh_name,
            'address_1'     : ($scope.shipmentinfor.sh_address_1 == null)    ? "" : $scope.shipmentinfor.sh_address_1,
            'address_2'     : ($scope.shipmentinfor.sh_address_2 == null)    ? "" : $scope.shipmentinfor.sh_address_2,
            'address_3'     : ($scope.shipmentinfor.sh_address_3 == null)    ? "" : $scope.shipmentinfor.sh_address_3,
            'city'          : ($scope.shipmentinfor.sh_city == null)         ? "" : $scope.shipmentinfor.sh_city,
            'province'      : ($scope.shipmentinfor.sh_province == null)     ? "" : $scope.shipmentinfor.sh_province,
            'zip_code'      : ($scope.shipmentinfor.sh_zip_code == null)     ? "" : $scope.shipmentinfor.sh_zip_code,
            'country'       : ($scope.shipmentinfor.sh_country == null)      ? "" : $scope.shipmentinfor.sh_country,
            'phone'         : ($scope.shipmentinfor.sh_phone == null)        ? "" : $scope.shipmentinfor.sh_phone,
            'email'         : ($scope.shipmentinfor.sh_email == null)        ? "" : $scope.shipmentinfor.sh_email,
            'note'          : ($scope.shipmentinfor.sh_note == null)        ? "" : $scope.shipmentinfor.sh_note,
            'id_shipmentinfor'    :  $('#id_shipmentinfor').val(),
            'contact' : $("#id_Contact").val()
          },
          success: function( data ) {
            if(data.success){
              noticeSuccess(data.message);
            }
            // else
            // {
            //   noticeFailed("Please fill in all fields and try again!");
            // }
          }
        });
      }
    }
    return{
        restrict: 'EA',
        templateUrl: '../../../views/basicdata/formcontact.cfm',
        controller: controller
    }
  });
