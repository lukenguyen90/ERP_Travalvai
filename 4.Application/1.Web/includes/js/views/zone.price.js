(function() {
    angular.module('zone.price', ['datatables', 'datatables.light-columnfilter', "ui.select2"]).controller("BindAngularDirectiveCtrl", BindAngularDirectiveCtrl)

    function BindAngularDirectiveCtrl($scope, $http, $filter, $compile, DTOptionsBuilder, DTColumnBuilder) {
        var vm = this;
        vm.message = '';
        vm.edit = edit;
        vm.delete = deleteRow;
        vm.deleteUser = deleteUser;
        vm.addRow = addRow;
        vm.refresh = refresh;
        vm.showAddZonePricePopup = showAddZonePricePopup;
        vm.dtInstance = {};
        vm.zone_prices = {};
        vm.user = [];
        vm.regex = "[a-z A-Z 0-9-\_\.]+";
        var original = angular.copy(vm.user);
        vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getzone_price')
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
                }
            })
            .withOption('createdRow', createdRow);
        vm.dtColumns = [
            DTColumnBuilder.newColumn('ZONE').withTitle('ZONE'),
            DTColumnBuilder.newColumn('FDATE').withTitle('FROM DATE').withClass("text-right"),
            DTColumnBuilder.newColumn('TODATE').withTitle('TO DATE').withClass("text-right"),
            DTColumnBuilder.newColumn('PRICELIST').withTitle('PRICE LIST'),
            DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable()
            .renderWith(actionsHtml)
        ];

        $http.get("/index.cfm/basicdata/getzone").success(function(dataResponse) {
            vm.zones = dataResponse;
        });

        $("#zone").change(function() {
            if ($(this).val() != "") {
                $.ajax({
                    type: "POST",
                    url: "/index.cfm/zone_price/getPLF",
                    async: false,
                    data: {
                        'idzone': $(this).val()
                    },
                    success: function(data) {
                        if (data.success) {
                            vm.plfs = data.plfs;
                        } else {
                            vm.plfs = [];
                        }
                    }
                });
            } else {
                vm.plfs = [];
            }
        });

        function showAddZonePricePopup() {
            $('#addNew').modal('show');
            $('#btnRefresh').css('display', 'none');
            document.getElementById("titleID").innerHTML = "Add Zone Price";
            $.ajax({
                type: "POST",
                url: "/index.cfm/zone_price/getPLF",
                async: false,
                data: {
                    'idzone': zone_price.ZONEID
                },
                success: function(data) {
                    if (data.success) {
                        vm.plfs = data.plfs;
                    } else {
                        vm.plfs = [];
                    }
                }
            });
            vm.user = {};
            $('#zone_price').val("");
        }

        function edit(zone_price) {
            $('#addNew').modal('show');
            $('#btnRefresh').css('display', 'none');
            document.getElementById("titleID").innerHTML = "Edit";
            $.ajax({
                type: "POST",
                url: "/index.cfm/zone_price/getPLF",
                async: false,
                data: {
                    'idzone': zone_price.ZONEID
                },
                success: function(data) {
                    if (data.success) {
                        vm.plfs = data.plfs;
                    } else {
                        vm.plfs = [];
                    }
                }
            });
            vm.user.zone = zone_price.ZONEID;
            vm.user.fdate = zone_price.FDATE;
            vm.user.todate = zone_price.TODATE;
            vm.user.plf = zone_price.PRICELISTID;
            $('#zone_price').val(zone_price.ID);
        }

        function deleteRow(zone_price) {
            vm.did = zone_price.ID;
            // console.log(vm.did);
            $('#showDelete').modal('show');
        }

        function deleteUser(zone_price) {
            $('#showDelete').modal('hide');
            $.ajax({
                type: "POST",
                url: "/index.cfm/zone_price/delete",
                async: false,
                data: {
                    'zplid': vm.did
                },
                success: function(data) {
                    if (data.success) {
                        $('#addNew').modal('hide');
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
                url: "/index.cfm/zone_price/addNew",
                async: false,
                data: {
                    'zone_price': $("#zone_price").val(),
                    'fdate': $filter('date')(vm.user.fdate, "yyyy-MM-dd"),
                    'todate': $filter('date')(vm.user.todate, "yyyy-MM-dd"),
                    'plf': vm.user.plf,
                    'zone': vm.user.zone
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
            vm.zone_prices[data.ID] = data;
            return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.zone_prices[' + data.ID + '])">' +
                '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
                '</span>&nbsp;' +
                '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.zone_prices[' + data.ID + '])">' +
                '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
                '</span>';
        }

        function refresh() {
            $('#zone_price').val(0);
            vm.plfs = [];
            vm.user = angular.copy(original);
            $scope.userForm.$setPristine();
        }
    };

})();