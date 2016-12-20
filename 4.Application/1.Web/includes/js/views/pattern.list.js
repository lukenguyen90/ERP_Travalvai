(function() {
    var myapp = angular.module('pattern.list', ['datatables', 'datatables.light-columnfilter', 'ui.select2', 'ckeditor']);
    myapp.controller("BindAngularDirectiveCtrl", BindAngularDirectiveCtrl)

    function BindAngularDirectiveCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $q) {
        var vm = this;
        vm.message = '';
        vm.addRow = addRow;
        vm.refresh = refresh;
        vm.refreshPart = refreshPart;
        vm.refreshVari = refreshVari;
        vm.addPatternPart = addPatternPart;
        vm.addPatternVari = addPatternVari;
        vm.editPatternPart = editPatternPart;
        vm.showCommentDetail = showCommentDetail;
        vm.editComment = editComment;
        vm.addComment = addComment;
        vm.comment = {};
        vm.comments = {};
        vm.dtInstance = {};
        vm.dtInstance2 = {};
        vm.dtInstance3 = {};
        vm.dtInstance4 = {};
        vm.dtInstance_parts = {};
        vm.showAddNew = showAddNew;
        vm.showAddPart = showAddPart;
        vm.showAddVar = showAddVar;
        vm.refreshLanguage = refreshLanguage;
        vm.persons = {};
        vm.user = {};
        vm.showAddVariParts = showAddVariParts;
        vm.addVariParts = addVariParts;
        vm.closeAddVariPartsPopup = closeAddVariPartsPopup;
        vm.user.craeateDate = $.datepicker.formatDate('dd/mm/yy', new Date());
        vm.user.updateDate = $.datepicker.formatDate('dd/mm/yy', new Date());        
        vm.dataDesDefine = {};
        vm.newDes = {};
        vm.dataDes = {};
        vm.showEditVariForm = showEditVariForm;
        vm.dataDesPart = {};
        vm.dataDesVari = {};
        vm.regex = "[a-z A-Z 0-9-\_\.]+";
        vm.regexPartVari = "[a-z A-Z 0-9-\_\,]+";
        vm.isReadonly = false;
        vm.patternPart = {};
        vm.patternVari = {};
        vm.deletePatternVari = deletePatternVari;
        vm.deletePatternPart = deletePatternPart;
        vm.backState = backState;
        vm.patternPartsVari = {};
        vm.ckeditor = '';
        var original = angular.copy(vm.user);
        var originalDesVari = angular.copy(vm.dataDesVari);
        var originalNotes = angular.copy(vm.comment);
        vm.comment.todaycomment = new Date($filter('date')(Date.now(), "yyyy/MM/dd"));
        vm.user.id_pattern_var = 0;
        vm.user.id_pattern_var_temp = 0;
        vm.user.varicode_temp = "";
        vm.patternVari_temp = {};
        // Editor options.
        $scope.options = {
            language: 'en',
            allowedContent: true,
            entities: false
        };

        // Called when the editor is completely ready.
        $scope.onReady = function() {

        };


        vm.patterns = [];
        //table notes
        vm.dtOptions2 = DTOptionsBuilder.fromSource('/index.cfm/patterns.getPatternNotes?id=' + getQueryVariable('id'))
            .withPaginationType('full_numbers')
            .withOption('createdRow', createdRowComment)
            .withOption('order', [4, 'desc'])
            .withLightColumnFilter({
                '0': {
                    type: 'text'
                },
                '1': {
                    type: 'text'
                }
            });
        vm.dtColumns2 = [
            DTColumnBuilder.newColumn('createDate').withTitle('DATE'),
            DTColumnBuilder.newColumn('notes').withTitle('NOTES').withOption('width', "80%").renderWith(subComment),
            DTColumnBuilder.newColumn(null).withTitle('DETAIL').renderWith(detailComment).withOption("width", "5%"),
            DTColumnBuilder.newColumn(null).withTitle('ACTIONS').renderWith(renderEditComment).withOption("width", "5%"),
            DTColumnBuilder.newColumn('id').withTitle('')
        ];
        vm.dtColumns2[4].visible = false;


        function detailComment(data, type, full, meta) {
            return '<span class="txt-color-green btngotoversion" title="Go to comment detail" ng-click="showCase.showCommentDetail(' + data.id + ')">' +
                '<i class="ace-icon bigger-130 fa fa-align-justify"></i></span>';
        }

        function renderEditComment(data, type, full, meta) {
            return '<span class="txt-color-green btngotoversion" title="Go to edit comment" ng-click="showCase.editComment(' + data.id + ')">' +
                '<i class="ace-icon bigger-130 fa fa-pencil"></i></span>';
        }

        function subComment(data, type, full, meta) {
            return splitComment(data, 200);
        }

        function splitComment(paragraghStr, numplace) {
            var substr = paragraghStr.substring(0, numplace);
            var lasOfIndex = substr.lastIndexOf(" ");
            substr = lasOfIndex == -1 ? substr : substr.substring(0, lasOfIndex);
            return substr + " ...";
        }

        function refreshComment() {
            $('#id_Comment').val(0);
            vm.comment = angular.copy(original);
            vm.comment.todaycomment = new Date($filter('date')(Date.now(), "yyyy/MM/dd"));
            $scope.commentForm.$setPristine();
            vm.dtInstance2.reloadData();
            $("#cke_editor1").focus();
        }

        function addComment() {
            refreshComment();
            $("#addComment").modal("show");
        }

        function showCommentDetail(patternNotes) {
            vm.comment.patternnode = vm.comments[patternNotes].notes;
            vm.comment.DATE = vm.comments[patternNotes].createDate;
            vm.comment.USER = vm.comments[patternNotes].user;
            $('#contentComment').html(vm.comments[patternNotes].notes);
            $("#detailComment").modal("show");
        }

        function editComment(patternNotes) {
            // refresh();
            vm.ckeditor = vm.comments[patternNotes].notes;
            vm.id_pattern_notes = vm.comments[patternNotes].id;
            $('#id_Comment').val(vm.id_pattern_notes);
            $("#addComment").modal("show");
        }

        function createdRowComment(row, data, dataIndex) {
            // Recompiling so we can bind Angular directive to the DT
            vm.comments[data.id] = data;
            $compile(angular.element(row).contents())($scope);
        }
        //delete last column when hidden ID column by add filter
        window.setTimeout(function() {
            $("#datatable_notes thead tr:last-child th:last-child").remove();
        }, 100);

        //table part
        vm.dtOptions3 = DTOptionsBuilder.fromFnPromise(function() {
                var defer = $q.defer();
                vm.patternParts = [];
                $http.get('/index.cfm/patterns.getPatternPart?id=' + getQueryVariable("id")).then(function(result) {
                    defer.resolve(result.data);
                    vm.patternParts = result.data;
                });
                return defer.promise;
            })
            .withPaginationType('full_numbers')
            .withOption('createdRow', createdRow)
            .withOption('order', [0, 'desc'])
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
            });
            
        vm.dtColumns3 = [
            DTColumnBuilder.newColumn('code').withTitle('CODE').withOption('width', "10%"),
            DTColumnBuilder.newColumn('pp_en').withTitle('ENGLISH').withOption('width', "43%").withClass("text-left"),
            DTColumnBuilder.newColumn('pp_vn').withTitle('VIETNAMESE').withOption('width', "43%").withClass("text-left"),
            DTColumnBuilder.newColumn(null).renderWith(actionsHtmlPart).withTitle("ACTIONS").notSortable().withOption('width', "4%")
        ];

        //table vari
        vm.dtOptions4 = DTOptionsBuilder.fromSource('/index.cfm/patterns.getPatternVari?id=' + getQueryVariable("id"))
            .withPaginationType('full_numbers')
            .withOption('createdRow', createdRow)
            .withOption('order', [0, 'desc']);
        // .withOption('searching', false)
        // .withOption('paging', false);
        vm.dtColumns4 = [
            DTColumnBuilder.newColumn('id').withTitle('ID'),
            DTColumnBuilder.newColumn('code').withTitle('CODE').withOption('width', "6%"),
            DTColumnBuilder.newColumn('des').withTitle('DESCRIPTION').withOption('width', "30%"),
            DTColumnBuilder.newColumn('comment').withTitle('COMMENT').withOption('width', "30%"),
            DTColumnBuilder.newColumn('parts').withTitle('PARTS').withOption('width', "20%").renderWith(parseVParttostr),
            DTColumnBuilder.newColumn('sketch').withTitle('SKETCH').withOption('width', "10%"),
            DTColumnBuilder.newColumn(null).renderWith(actionsHtmlVari).withTitle("ACTIONS").notSortable().withOption('width', "4%")
        ];
        vm.dtColumns4[0].visible = false;
        //get group product
        $http.get("/index.cfm/patterns/getGroupOfProduct").success(function(dataResponse) {
            vm.groupProduct = dataResponse;
        });
        //parse json Vparttostr
        function parseVParttostr(data, type, full, meta) {
            return parseVariPartToStr(full.parts);
        }
        //get multi lang
        $.ajax({
            async: false,
            type: 'POST',
            url: '/index.cfm/patterns/getLanguage',
            success: function(data) {
                //callback
                vm.dataDesPart = data.slice();
                vm.dataDesDefine = data.slice();
                vm.dataDesVari = data.slice();
            }
        });

        if (getQueryVariable('id')) {
            $('#pattern_part').css("display", "inline-block");
            $('#pattern_vari').css("display", "inline-block");
            $('#divImgParts').css("display", "inline-block");
            $('#divImgSketch').css("display", "inline-block");
            $('#divImgVari').css("display", "none");

            //get pattern base on id_pattern
            $.ajax({
                async: false,
                type: 'POST',
                url: '/index.cfm/patterns/getPatternID?id=' + getQueryVariable('id'),
                success: function(data) {
                    vm.user = data;
                    vm.dataDes = angular.fromJson(data.full_language);
                    sketchPath = data.sketch;
                    $('#imgSketch').attr('src', sketchPath);
                    $('#imgSketch').parent().attr('href', sketchPath);

                    $('.imgSketch').attr('src', sketchPath);
                    $('.imgSketch').parent().attr('href', sketchPath);

                    partsPath = data.parts;
                    $('.imgParts').attr('src', partsPath);
                    $('.imgParts').parent().attr('href', partsPath);

                    if (data.hasOwnProperty('id')) {
                        $('#id_pattern').val(data.id);
                    } else {
                        $('#id_pattern').val(0);
                    }
                    $('#btnCreateNotes').removeAttr("disabled");
                }
            });
        } else {
            $('#pattern_part').css("display", "none");
            $('#pattern_vari').css("display", "none");
            $('#divImgParts').css("display", "none");
            $('#divImgSketch').css("display", "none");

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
        }

        /* $(document).ready(function() {
             $('#modalFilterArticle').on('hide.bs.modal', function() {
                 $(this).find('#oseason').focus();
             })
         });*/

        function showAddNew() {
            // body...
            if (vm.ckeditor != "") {
                var id_pattern_note = $('#id_Comment').val();
                $.ajax({
                    type: "POST",
                    url: "/index.cfm/patterns/addNewNote",
                    async: false,
                    data: {
                        'patternnode': vm.ckeditor,
                        'idpattern': $('#id_pattern').val(),
                        'id_pattern_note': id_pattern_note
                    },
                    success: function(data) {
                        if (data.success) {
                            noticeSuccess(data.message);
                            vm.comment.patternnode = '';
                            vm.dtInstance2.reloadData();
                            $('#patternnode').val("");
                            $("#addComment").modal("hide");
                        } else {
                            noticeFailed("Please insert contents to add notes");
                            $('#patternnode').focus();
                        }
                        vm.ckeditor = '';
                    }
                });
            } else {
                noticeFailed("Please insert contents to add notes");
                $('#patternnode').focus();
            }
        }

        vm.dtOptions_parts = DTOptionsBuilder.fromFnPromise(function() {
                var defer = $q.defer();
                defer.resolve(vm.patternParts);
                return defer.promise;
            })
            .withPaginationType('full_numbers')
            .withOption('createdRow', createdVariationPartsRowEvent);

        vm.dtColumns_parts = [
            DTColumnBuilder.newColumn("code").withTitle('PART').renderWith(textCodeDes),
            DTColumnBuilder.newColumn("code_des").withTitle('QUANTITY').renderWith(renderInputVariParts)
        ];

        function showAddVariParts() {
            $('#Addvariation').modal('hide');
            $("#modalFilterPart").modal("show");
            vm.dtOptions_parts = DTOptionsBuilder.fromFnPromise(function() {
                    var defer = $q.defer();
                    defer.resolve(vm.patternParts);
                    return defer.promise;
                })
                .withOption('createdRow', createdVariationPartsRowEvent);
            vm.dtColumns_parts = [
                DTColumnBuilder.newColumn("code").withTitle('PART').renderWith(textCodeDes),
                DTColumnBuilder.newColumn("code_des").withTitle('QUANTITY').renderWith(renderInputVariParts)
            ];
            vm.dtInstance_parts.reloadData();
        }

        function createdVariationPartsRowEvent(row, data, dataIndex) {
            if (typeof(vm.patternPartsVari[data.id]) === 'undefined' || vm.user.varipart === null || vm.user.varipart.length === 0) {
                vm.patternPartsVari[data.id] = {};
                vm.patternPartsVari[data.id].quantity = "";
            }
            vm.patternPartsVari[data.id].id = data.id;
            vm.patternPartsVari[data.id].code = data.code + 'sdfsdsdf';

            $compile(angular.element(row).contents())($scope);
        }

        function parseVariPartToStr(Varipart) {
            var strParts = "";
            for (var item in Varipart) {
                strParts += Varipart[item].code + "(" + Varipart[item].quantity + "), "
            }
            return strParts.trim().substring(0, strParts.length - 2);
        }


        function closeAddVariPartsPopup() {
            $('#Addvariation').modal('show');
            $("#modalFilterPart").modal("hide");
        }

        function addVariParts() {
            $('#Addvariation').modal('show');
            $("#modalFilterPart").modal("hide");

            var objPartsVari = {};
            for (var partVari in vm.patternPartsVari) {
                if (parseInt(vm.patternPartsVari[partVari].quantity) > 0) {
                    objPartsVari[vm.patternPartsVari[partVari].id] = vm.patternPartsVari[partVari];
                }
            }
            vm.user.varipartJson = objPartsVari;
            vm.user.varipart = parseVariPartToStr(objPartsVari);
        }




        function renderInputVariParts(data, type, full, meta) {
            return '<input type="text" id="row-' + meta + '-position" name="row-' + meta + '-position" ng-model="showCase.patternPartsVari[' + full.id + '].quantity" value="">';
        }

        function textCodeDes(data, type, full, meta) {
            return full.code + " - " + full.pp_en;
        }

        function showAddPart() {
            refreshPart();
            $("#AddPart").modal("show");
        }

        function getQueryVariable(variable) {
            var query = window.location.search.substring(1);
            var vars = query.split("&");
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split("=");
                if (pair[0] == variable) {
                    return pair[1];
                }
            }
        }

        function addPatternPart() {
            var flag2 = false;
            var pp_code = $("#pp_code").val();
            $.ajax({
                type: "POST",
                url: "/index.cfm/patterns/checkExistPartCode",
                async: false,
                data: {
                    'pattern_code': vm.user.code,
                    'id_pattern': $("#id_pattern").val(),
                    'part_code': vm.user.partcode,
                    'pp_code': pp_code
                },
                success: function(data) {
                    flag2 = data.exist;
                    if (flag2 == false) {
                        $.ajax({
                            type: "POST",
                            url: '/index.cfm/patterns/addNewPatternPart' + window.location.search,
                            async: false,
                            data: {
                                // 'des' : JSON.stringify(vm.dataDesPart)
                                'partcode': (vm.user.partcode == null) ? "" : (vm.user.partcode),
                                'pp_code': pp_code,
                                'pp_vn': vm.user.pp_vn,
                                'pp_en': vm.user.pp_en
                            },
                            success: function(idata) {
                                if (idata.success) {
                                    noticeSuccess(idata.message);
                                } else {
                                    noticeFailed(idata.message);
                                }
                                refreshPart();
                                $('#AddPart').modal('hide');
                                $('#partcode').removeAttr('readonly', true);
                                $("#pp_code").val("");
                                vm.dtInstance3.reloadData();
                            }
                        });
                    } else {
                        $(".noti_code").remove();
                        $("#partcode").after('<p class="help-block noti_code"><font color="red">Code is exist in systems!</p>');
                        $("#partcode").focus();
                    }
                }
            });
        }
        var fd2 = new FormData();
        $scope.uploadVariSketch = function(files) {
            //Take the first selected file
            fd2.append("varisketch", files[0]);
            vm.user.varisketch = files[0].type;
        };

        function addPatternVari() {            
            $scope.variForm.$invalid = true;
            fd2.append('des', JSON.stringify(vm.dataDesVari));            
            fd2.append('varicode', (vm.user.varicode == null) ? "" : (vm.user.varicode));
            fd2.append('pv_comment', vm.user.pv_comment);
            fd2.append('varipart', (vm.user.varipart == null) ? "" : JSON.stringify(vm.user.varipartJson));
            fd2.append('id_pattern_var', (vm.user.id_pattern_var));
            fd2.append('variSketchName', (vm.user.varisketch == null) ? "" : vm.user.varisketch);
            var flag2 = false;
            // console.log(fd2);
            $.ajax({
                type: "POST",
                url: "/index.cfm/patterns/checkExistVariCode",
                async: false,
                data: {
                    'id_pattern': $("#id_pattern").val(),
                    'id_pattern_var': vm.user.id_pattern_var,
                    'pv_code': vm.user.varicode,
                    'id_pattern_var_temp':vm.user.id_pattern_var_temp,
                    'varicode_temp':vm.user.varicode_temp
                },
                success: function(data) {
                    flag2 = data.exist;
                    if (flag2 == false) {
                        $.ajax({
                            type: "POST",
                            url: '/index.cfm/patterns/addNewPatternVari?id=' + getQueryVariable("id"),
                            async: false,
                            processData: false,
                            contentType: false,
                            data: fd2,
                            success: function(idata) {
                                if (idata.success) {
                                    noticeSuccess(idata.message);
                                } else {
                                    noticeFailed(idata.message);
                                }
                                resetFormd2();
                                refreshVari();
                                $("#Addvariation").modal("hide");
                                $('#varicode').removeAttr('readonly', true);
                                $("#pv_code_temp").val('');
                                vm.dtInstance4.reloadData();
                                $('#divImgVari').addClass('hidden');
                            }
                        });
                    } else {
                        if(vm.user.id_pattern_var == 0){
                            $("#varisketch").val('');
                        }
                        resetFormd2();
                        $(".noti_code").remove();
                        $("#varicode").after('<p class="help-block noti_code"><font color="red">Code is exist in systems!</p>');
                        $("#varicode").focus();
                        $scope.variForm.$invalid = true;
                    }
                }
            });
        }

        function resetFormd2() {
            fd2 = null;
            fd2 = new FormData();
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
                                    $.ajax({
                                        async: false,
                                        type: 'POST',
                                        url: '/index.cfm/patterns/getPatternID?id=' + getQueryVariable('id'),
                                        success: function(data) {
                                            vm.user = data;
                                            $scope.$applyAsync();
                                            vm.dataDes = angular.fromJson(data.full_language);
                                            sketchPath = data.sketch;
                                            $('#imgSketch').attr('src', sketchPath);
                                            $('#imgSketch').parent().attr('href', sketchPath);

                                            partsPath = data.parts;
                                            $('.imgParts').attr('src', partsPath);
                                            $('.imgParts').parent().attr('href', partsPath);

                                            if (data.hasOwnProperty('id')) {
                                                $('#id_pattern').val(data.id);
                                            } else {
                                                $('#id_pattern').val(0);
                                            }
                                        }
                                    });
                                    $('#sketch').val('');
                                    $('#parts').val('');
                                    $scope.userForm.$setPristine();
                                } else {
                                    noticeFailed(idata.message);
                                }
                            }
                        });
                    } else {
                        resetFormd();
                        $scope.userForm.code.$invalid = true;
                        $scope.userForm.$invalid = true;
                        $("#code").after('<p class="help-block noti_code"><font color="red">Code is exist in systems!</p>');
                        refresh();
                    }
                }
            });
        }

        function getQueryVariable(variable) {
            var query = window.location.search.substring(1);
            var vars = query.split('&');
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split('=');
                if (decodeURIComponent(pair[0]) == variable) {
                    return decodeURIComponent(pair[1]);
                }
            }
        }

        function resetFormd() {
            vm.user.sketch = '';
            vm.user.parts = '';
            fd = null;
            fd = new FormData();
        }

        function edit(person) {
            refresh();
            $('#addNew').modal('show');
            $('#btnRefresh').css('display', 'none');
            //highlight row being edit
            $(".highlight").removeClass("highlight");
            $("#mytable td").filter(function() { return $.text([this]) == person.CODE; })
                .parent()
                .addClass("highlight");
            vm.user.code = person.CODE;
            vm.comment.patternnode = person.patterncode;
            vm.newDes = angular.fromJson(person.FULL_LANGUAGE);

            $('#id_pattern').val(person.ID);
            document.getElementById("titleID").innerHTML = "Edit";
        }

        function refreshLanguage() {
            $('#id_cv').val(0);
            vm.des = angular.copy(originalLanguage);
            $scope.languageForm.$setPristine();
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

        function refreshPart() {
            $(".noti_code").remove();
            $('#partcode').val('');
            $('.partDescription').val('');
            vm.user.pp_vn = "";
            vm.user.pp_en = "";
            $scope.partForm.$setPristine();
            vm.dataDesPart = vm.dataDesDefine;
            window.setTimeout(function() {
                $("#partcode").focus();
            }, 500)
        }

        function showAddVar() {
            refreshVari();
            $("#Addvariation").modal("show");
        }

        function refreshVari() {
            $('#fd2').each(function() {
                this.reset();
            });
            $("#imgVari").attr("src", "");
            $(".noti_code").remove();
            $("#varisketch").val('');
            vm.user.varipart = null;
            vm.user.varicode = null;
            vm.user.pv_comment = "";
            vm.dataDesVari = vm.dataDesDefine;
            vm.user.id_pattern_var = 0;
            vm.user.id_pattern_var_temp = 0;
            vm.user.varicode_temp = "";
            $('.variDescription').val('');
            vm.user.varisketch = "";
            $scope.variForm.$setPristine();
            window.setTimeout(function() {
                $("#varicode").focus();
            }, 500)
        }

        function editPatternPart(array) {
            refreshPart();
            vm.user.partcode = array.code;
            vm.user.pp_vn = array.pp_vn;
            vm.user.pp_en = array.pp_en;
            $("#pp_code").val(array.id);
            $('.noti_code').remove();
            $("#AddPart").modal("show");
        }

        function showEditVariForm(patternVari) {
            vm.patternVari_temp = patternVari;
            getPatternVari(patternVari);
            $("#Addvariation").modal("show");
        }

        function getPatternVari(array) {
            $('.noti_code').remove();
            $('#divImgVari').removeClass('hidden');
            $.ajax({
                type: "POST",
                url: "/index.cfm/patterns/getPatternVariData?id=" + getQueryVariable("id"),
                async: false,
                data: {
                    'pvid': array.id,
                    'pv_code': array.code
                },
                success: function(data) {
                    vm.dataDesVari = angular.fromJson(data.full_language_part);
                    vm.user.varicode = data.pvcode;
                    vm.user.varipart = parseVariPartToStr(data.parts);

                    vm.patternPartsVari = data.parts;
                    vm.user.varipartJson = data.parts;
                    vm.user.pv_comment = data.pvcomment;
                    vm.user.id_pattern_var = data.id_pattern_var;

                    vm.user.id_pattern_var_temp = data.id_pattern_var;
                    vm.user.varicode_temp = data.pvcode;
                    ///image vari
                    $('#divImgVari').css("display", "inline-block");
                    VariSketchPath = data.pv_sketch;
                    $('#imgVari').attr('src', VariSketchPath);
                    $('#imgVari').parent().attr('href', VariSketchPath);
                }
            });
        }

        function deletePatternPart(array) {
            $.ajax({
                type: "POST",
                url: "/index.cfm/patterns/delPatternPart" + window.location.search,
                async: false,
                data: {
                    'id_pattern': $('#id_pattern').val(),
                    'pp_code': array.code
                },
                success: function(data) {
                    if (data.success) {
                        noticeSuccess(data.message);
                        vm.dtInstance3.reloadData();
                    } else {
                        noticeFailed("Can not delete this pattern part");
                    }
                }
            });
        }

        function deletePatternVari(array) {
            $.ajax({
                type: "POST",
                url: "/index.cfm/patterns/deletePatternVari" + window.location.search,
                async: false,
                data: {
                    'id_pattern': $('#id_pattern').val(),
                    'pv_code': array.code
                },
                success: function(data) {
                    if (data.success) {
                        noticeSuccess(data.message);
                        vm.dtInstance4.reloadData();
                    } else {
                        noticeFailed(data.message);
                    }
                }
            });
        }


        function actionsHtmlPart(data, type, full, meta) {
            vm.patternPart[data.id] = data;
            return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.editPatternPart(showCase.patternPart[' + data.id + '])">' +
                '<i class="ace-icon bigger-130 fa fa-pencil"></i></span></a>' +
                '<span class="txt-color-red btndelete" title="Delete pattern part" ng-click="showCase.deletePatternPart(showCase.patternPart[' + data.id + '])">' +
                '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
        }

        function actionsHtmlVari(data, type, full, meta) {
            vm.patternVari[data.id] = data;
            return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.showEditVariForm(showCase.patternVari[' + data.id + '])">' +
                '<i class="ace-icon bigger-130 fa fa-pencil"></i></span></a>' +
                '<span class="txt-color-red btndelete" title="Delete pattern vari" ng-click="showCase.deletePatternVari(showCase.patternVari[' + data.id + '])">' +
                '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
        }

        function createdRow(row, data, dataIndex, iDisplayIndexFull) {
            // Recompiling so we can bind Angular directive to the DT
            $compile(angular.element(row).contents())($scope);
            return row;
        };

        function backState() {
            history.back();
        }



    };

})();