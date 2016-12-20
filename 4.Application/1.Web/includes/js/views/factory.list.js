(function() {
    angular.module('factory.list', ['datatables', 'datatables.light-columnfilter', 'Formcontact', 'ui.select2']).controller("BindAngularDirectiveCtrl", BindAngularDirectiveCtrl)

    function BindAngularDirectiveCtrl($scope, $http, $filter, $compile, DTOptionsBuilder, DTColumnBuilder) {
        // -----------------------------Start Factory--------------------------------------------

        var vm = this;
        vm.delete = deleteRow;
        vm.deleteUser = deleteUser;
        vm.addRow = addRow;
        vm.edit = edit;
        vm.message = '';
        vm.regex = "[a-z A-Z 0-9-\_\.]+";
        vm.refresh = refresh;
        vm.showAddNew = showAddNew;
        vm.editRowContact = editRowContact;
        vm.dtInstance = {};
        vm.factorys = {};
        vm.user = {};
        vm.user.uid = 0;
        vm.regex_email = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        var original = angular.copy(vm.user);

        // $.ajax({
        // 	async: false,
        // 	type: 'GET',
        // 	url: '/index.cfm/basicdata/getFactoryRight',
        // 	success: function(data) {
        // 	     //callback
        // 	     vm.user_right = data;
        //       		 if( vm.user_right == 1 ){
        //       			$('#btnAddNew').show();
        //       		 }
        // 	}
        // });
        vm.userInfo = {};
        $.ajax({
            async: false,
            type: 'GET',
            url: '/index.cfm/basicdata/getUserLevel',
            success: function(data) {
                vm.userInfo = data;
                //if it is agent admin
                if (vm.userInfo.TYPEUSER == 0) {
                    $('#btnAddNew').show();
                }
            }
        });

        vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getfactory')
            .withPaginationType('full_numbers')
            .withLightColumnFilter({
                '0': {
                    type: 'text'
                },
                '1': {
                    type: 'text'
                },
                '2': {
                    type: 'text'
                },
                '3': {
                    type: 'text'
                },
                '4': {
                    type: 'text'
                }
            })
            .withOption('createdRow', createdRow)
            .withOption('select', { style: 'single' });
        vm.dtColumns = [
            DTColumnBuilder.newColumn('CODE').withTitle('CODE').withOption('width', '9%'),
            DTColumnBuilder.newColumn('DESCRIPTION').withTitle('DESCRIPTION'),
            DTColumnBuilder.newColumn('CURRENCY').withTitle('CURRENCY'),
            DTColumnBuilder.newColumn('LANGUAGE').withTitle('LANGUAGE'),
            DTColumnBuilder.newColumn('CONTACT').withTitle('CONTACT').withOption('width', '30%'),
            DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable().withOption('width', '10px').renderWith(actionsHtml)
        ];



        $http.get("/index.cfm/basicdata/getlanguage").success(function(dataResponse) {
            vm.languages = dataResponse;
        });

        $http.get("/index.cfm/basicdata/getcurrency").success(function(dataResponse) {
            vm.currencies = dataResponse;
        });

        $http.get("/index.cfm/contact/getcontacts").success(function(dataResponse) {
            vm.contacts = dataResponse;
        });

        var tempCode = "";

        function addRow() {
            $.ajax({
                type: "POST",
                url: "/index.cfm/factory/addNew",
                async: false,
                data: {
                    'code': vm.user.code,
                    'description': vm.user.description,
                    'currency': vm.user.currency,
                    'language': vm.user.language,
                    'contact': $("#id_Contact").val(),
                    'id_factory': vm.user.uid
                },
                success: function(data) {
                    if (data.success) {
                        noticeSuccess(data.message);
                        vm.dtInstance.reloadData();
                        tempCode = data.code_Factory;
                        setTimeout(function() {
                            $('#addNew').modal('hide');
                        }, 1000);
                    } else {
                        noticeFailed("Please try again!");
                    }

                }
            });
        }

        function editRowContact() {
            $('#myModalContact').modal('show');
        }

        $('#addNew').on('hidden.bs.modal', function() {
            $(".highlight").removeClass("highlight");
            $("#mytable td").filter(function() { return $.text([this]) == tempCode; })
                .parent()
                .addClass("highlight");
        });

        $('#myModalContact').on('hidden.bs.modal', function() {
            var contact = $("#name_Contact").val();
            vm.user.contact = contact;
            $scope.$apply();
            $('#editContact').css("display", "inline-block");
            $('#createContact').css("display", "none");
        })

        $("#createContact").on('click', function() {
            // body...
            $('#id_Contact').val(0);
        })

        function showAddNew(argument) {
            // body...
            refresh();
            document.getElementById("titleID").innerHTML = "Create";
            $(".highlight").removeClass("highlight");
            $('#btnRefresh').css('display', 'inline-block');
            $('#addNew').modal('show');
            $('#editContact').css("display", "inline-block");
            $('#createContact').css("display", "none");
            //       	vm.user.title_formfactory = "Create new Factory";
            //focus on first input field
            $(document).ready(function() {
                $("#addNew").on('shown.bs.modal', function() {
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
            $('#createFactory').css("display", "inline-block");
            $('#editFactory').css("display", "none");
            $('#createContact').css("display", "inline-block");
            $('#editContact').css("display", "none");
            $scope.idContactEdit = 0;
            $("#id_Contact").val(0);
            $scope.usertype = 1;
            $scope.distype = 1;
            $scope.showtype = 0;
        }

        function deleteRow(factory) {
            vm.did = factory.ID;
            // console.log(vm.did);
            $('#showDelete').modal('show');
        }

        function deleteUser(factory) {
            $('#showDelete').modal('hide');
            $.ajax({
                type: "POST",
                url: "/index.cfm/factory/delete",
                async: false,
                data: {
                    'id': vm.did
                },
                success: function(data) {
                    if (data.success) {
                        noticeSuccess(data.message);
                        vm.dtInstance.reloadData();
                    } else {
                        noticeFailed("Can not delete this type");
                    }
                }
            });
        }



        function edit(factory) {
            $('#addNew').modal('show');
            $('#btnRefresh').css('display', 'none');
            document.getElementById("titleID").innerHTML = "Edit";
            $(document).ready(function() {
                $("#addNew").on('shown.bs.modal', function() {
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
            if (factory.CONTACT != "") {
                $('#editContact').css("display", "inline-block");
                $('#createContact').css("display", "none");
            } else {
                $('#editContact').css("display", "none");
                $('#createContact').css("display", "inline-block");
            }
            //highlight row being edit
            $(".highlight").removeClass("highlight");
            $("#mytable td").filter(function() { return $.text([this]) == factory.CODE; })
                .parent()
                .addClass("highlight");
            vm.user.uid = factory.ID;
            vm.user.code = factory.CODE;
            vm.user.description = factory.DESCRIPTION;
            vm.user.currency = factory.CURRENCYID;
            vm.user.language = factory.LANGUAGEID;
            vm.user.contact = factory.CONTACT;
            vm.user.contactID = factory.CONTACTID;
            $scope.idContactEdit = factory.CONTACTID;
            $('#id_Factory').val(factory.ID);
            $("#id_Contact").val(factory.CONTACTID);
            $scope.usertype = 1;
            $scope.distype = 1;
            $scope.showtype = 0;
        }

        function createdRow(row, data, dataIndex) {
            // Recompiling so we can bind Angular directive to the DT
            $compile(angular.element(row).contents())($scope);
        }

        function actionsHtml(data, type, full, meta) {
            //			console.log( vm.user_right );
            vm.factorys[data.ID] = data;
            if (vm.userInfo.TYPEUSER == 1) {
                return '<span class="txt-color-green btnedit padding-right-30" title="Edit" ng-click="showCase.edit(showCase.factorys[' + data.ID + '])">' +
                    '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
                    '</span>';
                //edit and delete factory
                // return '<span class="txt-color-green btnedit padding-right-30" title="Edit" ng-click="showCase.edit(showCase.factorys[' + data.ID + '])">' +
                // '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
                // '</span>&nbsp;' +
                // '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.factorys[' + data.ID + '])">' +
                // '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
                // '</span>';
            } else {
                return "";
            }
        }

        function refresh() {
            $('#id_Factory').val(0);
            vm.user = angular.copy(original);
            $scope.userForm.$setPristine();
            $('#code').val('');
        }


        // -----------------------------End Factory--------------------------------------------




    };

})();