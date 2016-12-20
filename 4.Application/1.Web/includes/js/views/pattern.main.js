(function() {
    var myapp = angular.module('pattern.main', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl", BindAngularDirectiveCtrl)

    function BindAngularDirectiveCtrl($scope, $http, $filter, $compile, DTOptionsBuilder, DTColumnBuilder, $window) {
        var vm = this;
        vm.doubleclickHandler = doubleclickHandler;
        vm.showAddNew = showAddNew;
        vm.showEdit = showEdit;
        vm.deletePattern = deletePattern;
        vm.patterns = {};
        vm.user = {};
        vm.dtInstance = {};
        vm.newDes = {};
        vm.dataDes = {};
        var original = angular.copy(vm.user);
        vm.regex = "[a-z A-Z 0-9-\_\.]+";
        vm.addRow = addRow;
        vm.refresh = refresh;
        vm.resetFormd = resetFormd;


        getGroupOfProduct().then(function(dataResponse) {
            vm.groupProduct = dataResponse;
        });

        function getGroupOfProduct() {
            return new Promise(function(resolve, reject) {
                $http.get("/index.cfm/patterns/getGroupOfProduct").success(function(dataResponse) {
                    resolve(dataResponse);
                });
            });
        }

        //get multi lang
        $.ajax({
            async: false,
            type: 'POST',
            url: '/index.cfm/patterns/getLanguage',
            success: function(data) {
                //callback
                vm.newDes = data.slice();
                vm.dataDes = data.slice();
            }
        });

        vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/patterns.getPatternList')
            .withPaginationType('full_numbers')
            .withOption('createdRow', createdRow)
            .withOption('select', { style: 'single' })
            .withOption('stateSave', true)
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
                },
                '5': {
                    type: 'text'
                }
            });
        vm.dtColumns = [
            DTColumnBuilder.newColumn('CODE').withTitle('CODE').withOption('width',"2%"),
            DTColumnBuilder.newColumn('GROUPPRODUCTNAME').withTitle('GROUP').withOption('width',"20%"),
            DTColumnBuilder.newColumn('DESCRIPTION').withTitle('DESCRIPTION').withOption('width',"20%"),
            DTColumnBuilder.newColumn('CREATEDATE').withTitle('DATE').withOption('width',"10%"),
            DTColumnBuilder.newColumn('UPDATEDATE').withTitle('UPDATE').withOption('width',"10%"),
            DTColumnBuilder.newColumn('NOTES').withTitle('NOTES').withOption('width',"20%"),
            DTColumnBuilder.newColumn('SKETCH').withTitle('SKETCH'),
            DTColumnBuilder.newColumn('PARTS').withTitle('PARTS'),
            DTColumnBuilder.newColumn(null).renderWith(actionsHtmlDetail).notSortable().withTitle('DETAIL').withOption('width', "2%").withClass("text-center"),
            DTColumnBuilder.newColumn(null).renderWith(actionsHtmlDelete).notSortable().withTitle('ACTIONS').withOption('width', "2%").withClass("text-center"),
            DTColumnBuilder.newColumn('IDPATTERN').withTitle('ID')
        ];
        vm.dtColumns[10].visible = false;
        //delete last column when hidden ID column by add filter
        window.setTimeout(function() {
            $("#datatable_fixed_column_1 thead tr:last-child th:last-child").remove();
        }, 100);

        var keyURL = 'DataTables_datatable_fixed_column_1_/index.cfm/patterns.index';
        var perform = performance.navigation.type;
        if (perform === 0 || perform === 1) {
            $window.localStorage.removeItem(keyURL);
        }
        (function() {
            $(document).ready(function() {
                var stateColumns = JSON.parse($window.localStorage.getItem(keyURL));

                if (stateColumns) {
                    window.setTimeout(function() {
                        $("#datatable_fixed_column_1 thead tr:last-child").children('th').each(function(index) {
                            if (!$(this).is(':empty')) {
                                $(this).children().val(stateColumns.columns[index].search.search);
                            }
                        });
                    }, 100);
                }
            })
        })();

        $.ajax({
            async: false,
            type: 'GET',
            url: '/index.cfm/basicdata/getUserLevel',
            success: function(data) {
                //callback
                vm.userInfo = data;
                if (vm.userInfo.TYPEUSER == 4) {
                    $("#btnCreate").hide();
                }
            }
        });

        function showAddNew(argument) {
            // body...
            refresh();
            document.getElementById("titleID").innerHTML = "Create";
            // $('#btnRefresh').css('display', 'inline-block');
            $('#addNew').modal('show');
            $(document).ready(function() {
                $("#addNew").on('shown.bs.modal', function() {
                    $(this).find('#code').focus();
                });
            });
        }

        function showEdit(array) {
            // body...
            window.location.href = "/index.cfm/patterns.edit?id=" + array.IDPATTERN;
        }


        var fd = new FormData();
        $scope.uploadSketch = function(files) {
            //Take the first selected file
            fd.append("sketch", files[0]);
            vm.user.sketch = files[0].type;
        };
        $scope.uploadParts = function(files) {
            //Take the first selected file
            fd.append("parts", files[0]);
            vm.user.parts = files[0].type;
        };

        function addRow() {
            $scope.userForm.$invalid = true;
            fd.append('code', (vm.user.code == null) ? "" : vm.user.code);
            fd.append('des', JSON.stringify(vm.dataDes));
            fd.append('sketchName', (vm.user.sketch == null) ? "" : vm.user.sketch);
            fd.append('partsName', (vm.user.parts == null) ? "" : vm.user.parts);
            fd.append('id_pattern', $('#id_pattern').val());
            fd.append('groupProduct', $('#groupProduct').val());
            fd.append('internalNode', $('#internalNode').val());
            var flag = false;
            $.ajax({
                type: "POST",
                url: "/index.cfm/patterns/checkExistCode",
                async: false,
                data: {
                    'code': vm.user.code,
                    'id': $("#id_pattern").val()
                },
                success: function(data) {
                    flag = data.success;
                    if (!flag) {
                        $.ajax({
                            type: "POST",
                            url: "/index.cfm/patterns/addNewPattern",
                            async: false,
                            processData: false,
                            contentType: false,
                            data: fd,
                            success: function(idata) {
                                if (idata.success) {
                                    noticeSuccess(idata.message);
                                    resetFormd();
                                    window.location.href = "/index.cfm/patterns.edit?id=" + idata.typeId;
                                } else {
                                    noticeFailed(idata.message);
                                }
                                refresh();
                            }
                        });
                    } else {
                        resetFormd();
                        $scope.userForm.code.$invalid = true;
                        $scope.userForm.$invalid = true;
                        noticeFailed("Pattern code is exist in system!");
                        $('#code').focus();
                    }
                    $("addNew").modal('hide');
                }
            });
        }
        function resetFormd() {            
            fd = new FormData();
            vm.user.sketch = '';
            vm.user.parts = '';
        }

        function refresh() {
            $('#id_pattern').val(0);
            $(".noti_code").remove();
            vm.user = angular.copy(original);
            $scope.userForm.$setPristine();
            $('#code').val('');
            $('.pdescription').val('');
            $('#sketch').val('');
            $('#parts').val('');
        }

        function deletePattern(array) {
            $.ajax({
                type: "POST",
                url: "/index.cfm/patterns/deletePattern",
                async: false,
                data: {
                    'id_pattern': array
                },
                success: function(data) {
                    if (data.success) {
                        noticeSuccess(data.message);
                        vm.dtInstance.reloadData();
                    } else {
                        noticeFailed("This pattern is using for product. If you want to delete this patter vari, please delete product first!");
                    }
                }
            });
        }

        function actionsHtmlDetail(data, type, full, meta) {
            vm.patterns[data.IDPATTERN] = data;
            return '<span class="txt-color-green btnedit" title="Edit pattern" ng-click="showCase.showEdit(showCase.patterns[' + data.IDPATTERN + '])">' +
                '<i class="ace-icon bigger-130 fa fa-sign-out"></i></span>';
        }

        function actionsHtmlDelete(data, type, full, meta) {
            vm.patterns[data.IDPATTERN] = data;
            return '<span class="txt-color-red btndelete" title="Delete pattern" ng-click="showCase.deletePattern(' + data.IDPATTERN + ')">' +
                '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
        }

        function doubleclickHandler(info) {
            window.location.href = "/index.cfm/patterns.edit?id=" + info.IDPATTERN;
        }

        function createdRow(row, data, dataIndex, iDisplayIndexFull) {
            // Recompiling so we can bind Angular directive to the DT
            $('td', row).unbind('dblclick');
            $('td', row).bind('dblclick', function() {
                $scope.$apply(function() {
                    vm.doubleclickHandler(data);
                });
            });

            $compile(angular.element(row).contents())($scope);
            return row;
        }


    };
})();