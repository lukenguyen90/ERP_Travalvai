(function() {
    angular.module('currency_convert.List', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl", BindAngularDirectiveCtrl)

    function BindAngularDirectiveCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder) {
        var vm = this;
        vm.message = '';
        vm.edit = edit;
        vm.delete = deleteRow;
        vm.deleteUser = deleteUser;
        vm.addRow = addRow;
        vm.refresh = refresh;
        vm.dtInstance = {};
        vm.persons = {};
        vm.user = [];
        vm.regex = "[a-z A-Z 0-9-\_\.]+";
        var original = vm.user;
        vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getcurrencyconvert')
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
                }
            })
            .withOption('createdRow', createdRow)
            .withOption('select', { style: 'single' });
        vm.dtColumns = [
            DTColumnBuilder.newColumn('CODE').withTitle('CODE'),
            DTColumnBuilder.newColumn('DATEFORMAT').withTitle('DATE').withClass('text-right'),
            DTColumnBuilder.newColumn('VAL').withTitle('CONVERSION').withClass('text-right') 
        ];

        $http.get("/index.cfm/basicdata/getcurrency").success(function(dataResponse) {
            vm.currencies = dataResponse;
        });

        // $http.get("https://query.yahooapis.com/v1/public/yql?q=select*from%20yahoo.finance.xchange%20where%20pair%20in%20('USDMXN','USDEUR','USDRUB','USDVND')&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=").success(function(dataResponse){
        //   vm.valueconvert = dataResponse;
        // });

        // $http.get("/index.cfm/basicdata/getcurrency").success(function(dataResponse){
        //   vm.currencys = dataResponse;
        // });

        function edit(person) {
            $(".highlight").removeClass("highlight");
            $("#mytable td").filter(function() { return $.text([this]) == person.CURRENCYID; })
                .parent()
                .addClass("highlight");
            vm.user.currencyID = person.CURRENCYID;
            // vm.user.date=$filter('date')(person.DATE, "dd-MM-yyyy");
            vm.user.date = new Date(person.DATE);
            // vm.user.date = person.DATE;
            vm.user.convention = person.VAL;
            $('#id_Convert').val(person.ID);
        }

        function deleteRow(person) {
            vm.did = person.ID;
            $('#showDelete').modal('show');
        }

        function deleteUser(person) {
            // console.log(person);
            $('#showDelete').modal('hide');
            $.ajax({
                type: "POST",
                url: "/index.cfm/currency_convert/delete",
                async: false,
                data: { 'currencyID': vm.did },
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

        function addRow() {
            var flag = false;

            $.ajax({
                type: "POST",
                url: "/index.cfm/basicdata/checkExistCode",
                async: false,
                data: {
                    'code': vm.user.currencyID,
                    'table': 'currency_convert',
                    'nameCol': 'id_currency',
                    'id': $('#id_Convert').val(),
                    'idfield': 'id_curr_conv'
                },
                success: function(data) {
                    flag = data.isExist;
                    if (!flag) {
                        $.ajax({
                            type: "POST",
                            url: "/index.cfm/currency_convert/addNew",
                            async: false,
                            data: {
                                'currencyID': vm.user.currencyID,
                                'date': $filter('date')(vm.user.date, "yyyy-MM-dd"),
                                'convention': vm.user.convention,
                                'id_Convert': $('#id_Convert').val()
                            },
                            success: function(data) {
                                if (data.success) {
                                    noticeSuccess(data.message);
                                    vm.dtInstance.reloadData();
                                } else {
                                    noticeFailed("Please try again!");
                                }

                                refresh();
                            }
                        });
                    } else {
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
            vm.persons[data.ID] = data;
            return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.persons[' + data.ID + '])">' +
                '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
                '</span>&nbsp;' +
                '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.persons[' + data.ID + '])">' +
                '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
                '</span>';
        }

        function refresh() {
            $('#id_Convert').val(0);
            vm.user = angular.copy(original);
            $scope.userForm.$setPristine();
        }

    };

})();