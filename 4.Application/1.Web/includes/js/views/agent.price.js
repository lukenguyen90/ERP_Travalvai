(function() {
    angular.module('agent.price', ['datatables', 'datatables.light-columnfilter', "ui.select2"]).controller("BindAngularDirectiveCtrl", BindAngularDirectiveCtrl)

    function BindAngularDirectiveCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder) {
        var vm = this;
        vm.message = '';
        vm.edit = edit;
        vm.delete = deleteRow;
        vm.deleteUser = deleteUser;
        vm.showAddAgentPricePopup = showAddAgentPricePopup;
        vm.addRow = addRow;
        vm.refresh = refresh;
        vm.dtInstance = {};
        vm.persons = {};
        vm.user = {};
        vm.regex = "[a-z A-Z 0-9-\_\.]+";
        var original = angular.copy(vm.user);
        vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getpagent')
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
            .withOption('createdRow', createdRow);
        vm.dtColumns = [
            DTColumnBuilder.newColumn('CODE').withTitle('AGENT'),
            DTColumnBuilder.newColumn('DES').withTitle('DESCRIPTION'),
            DTColumnBuilder.newColumn('FDATE').withTitle('FROM DATE').withClass('text-right'),
            DTColumnBuilder.newColumn('TODATE').withTitle('TO DATE').withClass('text-right'),
            DTColumnBuilder.newColumn('PRICELIST').withTitle('PRICE LIST'),
            DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable()
            .renderWith(actionsHtml)
        ];

        $("#agent").change(function() {
            var idagent = $("#agent").val();
            if (idagent > 0) {
                $.ajax({
                    type: "POST",
                    url: "/index.cfm/agent_price/getagentdetail",
                    async: false,
                    data: {
                        'idagent': idagent
                    },
                    success: function(data) {
                        if (data.success) {
                            vm.user.code = data.code_agent;
                            vm.user.description = data.des_agent;
                        }
                    }
                });
            } else {
                vm.user.code = "";
                vm.user.description = "";
            }
        });

        $http.get("/index.cfm/basicdata/getagent").success(function(dataResponse) {
            vm.agents = dataResponse;
        });

        $http.get("/index.cfm/basicdata/getPLZ").success(function(dataResponse) {
            vm.plzs = dataResponse;
        });

        function showAddAgentPricePopup() {
            $('#addNew').modal('show');
            $('#btnRefresh').css('display', 'none');
            document.getElementById("titleID").innerHTML = "Add Agent Price";
            $(".highlight").removeClass("highlight");

            vm.user = {};

            $('#id_pagent').val("");
        }

        function edit(person) {
            $('#addNew').modal('show');
            $('#btnRefresh').css('display', 'none');
            document.getElementById("titleID").innerHTML = "Edit";
            $(".highlight").removeClass("highlight");
            $("#mytable td").filter(function() {
                    return ($.text([this]) == person.CODE && $.text([this]) == person.PRICELIST);
                })
                .parent()
                .addClass("highlight");
            vm.user.agent = person.IDAGENT;
            vm.user.code = person.CODE;
            vm.user.description = person.DES;
            vm.user.fdate = person.FDATE;
            vm.user.todate = person.TODATE;
            vm.user.plz = person.PRICELISTID;
            $('#id_pagent').val(person.ID);
        }

        function deleteRow(person) {
            vm.did = person.ID;
            $('#showDelete').modal('show');
        }

        function deleteUser(person) {
            $('#showDelete').modal('hide');
            $.ajax({
                type: "POST",
                url: "/index.cfm/agent_price/delete",
                async: false,
                data: {
                    'paId': vm.did
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


        function addRow() {
            $.ajax({
                type: "POST",
                url: "/index.cfm/agent_price/addNew",
                async: false,
                data: {
                    'agent': vm.user.agent,
                    'fdate': $filter('date')(vm.user.fdate, "yyyy-MM-dd"),
                    'todate': $filter('date')(vm.user.todate, "yyyy-MM-dd"),
                    'plz': vm.user.plz,
                    'id_pagent': $('#id_pagent').val()
                },
                success: function(data) {
                    if (data.success) {
                        noticeSuccess(data.message);
                        vm.dtInstance.reloadData();
                        setTimeout(function() {
                            $('#addNew').modal('hide');
                        }, 1000);
                    } else {
                        noticeFailed("Please try again!");
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
            $('#id_pagent').val(0);
            vm.user = angular.copy(original);
            $scope.userForm.$setPristine();
        }
    };

})();