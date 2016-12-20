(function() {
    'use strict'
    angular
        .module('project.ctrls')
        .controller("ProjectListCtrl", projectListCtrl);

    function projectListCtrl($state, $q,
        $scope, $filter, $http,
        $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout,
        $controller, $resource, projectService) {


        var vm = this;
        vm.instance = {};
        vm.options = {};
        vm.columns = [];

        $scope.userId = 0;
        $scope.userTypeId = "";

        vm.projects = {};
        vm.init = init;
        vm.initProject = initProject;
        vm.showAddProjectPopup = $scope.showAddProjectPopup = showAddProjectPopup;
        vm.showProjectDetail = showProjectDetail;
        vm.deleteProject = deleteProject;

        function init(userType, userTypeId) {
            console.log($scope);
            if (userType.length === 0) {
                window.location.href = window.location.href;
            } else {
                initVariable(userType, userTypeId);
                showProjectList();
            }
        }

        function initVariable(userType, userTypeId) {
            $scope.userTypeId = userTypeId;
            $scope.userType = userType;
            vm.tplProjectList = "";
        }

        function initProject() {
            loadDatatable();
        }

        function loadDatatable() {
            vm.options = DTOptionsBuilder.fromFnPromise(function() {

                    return projectService.getListProjects();

                    //return orderListService.getListOrders();
                    // return $resource('../../../../views/order/client/order-list/data.json').query().$promise;
                })
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
                    },
                    '5': {
                        type: 'text'
                    },
                    '6': {
                        type: 'text'
                    }
                })
                .withOption('createdRow', createdRow)
                .withOption('stateSave', true)
                .withDOM("<'dt-toolbar'<'col-md-1 col-xs-12'C><'col-md-10 col-xs-12'f><'col-md-1 col-xs-12'l>r>"+
                         "t"+
                         "<'dt-toolbar-footer'<'col-md-6 col-xs-12'i><'col-xs-12 col-md-6'p>>")
                .withOption('select', { style: 'single' })


            vm.columns = [
                // DTColumnBuilder.newColumn('id_project').withTitle('ID').withClass("text-center"), //0
                DTColumnBuilder.newColumn('ID_DISPLAY').withTitle('PROJECT').withClass('text-center').withOption('width','5%'), //1
                DTColumnBuilder.newColumn('PJ_DESCRIPTION').withTitle('DESCRIPTION').withOption('width','15%'),
                DTColumnBuilder.newColumn('CS_NAME').withTitle('CUSTOMER').withOption('width','15%'),
                DTColumnBuilder.newColumn('AGENT').withTitle('AGENT').withOption('width','15%'),
                DTColumnBuilder.newColumn('ZONE').withTitle('ZONE').withOption('width','15%'),
                DTColumnBuilder.newColumn('DATE').withTitle('DATE').withOption('width','10%'),
                DTColumnBuilder.newColumn('NAME_STATUS').withTitle('STATUS').withOption('width','15%'),
                DTColumnBuilder.newColumn(null).withTitle('DEATAIL').notSortable().renderWith(actionsDetail).withClass('text-center').withOption('width','5%'),
                DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable().renderWith(actionsHtml).withClass('text-center').withOption('width','5%') //2
            ];

        }

        function createdRow(row, data, dataIndex, iDisplayIndexFull) {
            $('td', row).unbind('dblclick');
            $('td', row).bind('dblclick', function() {
                $scope.$apply(function() {
                    doubleclickHandler(data);
                });
            });
            $compile(angular.element(row).contents())($scope);
            return row;
        }

        function doubleclickHandler(data) {
            window.location.href = "/index.cfm/project.edit?id=" + data.ID_PROJECT;
        }

        function showAddProjectPopup() {
            vm.tplAddProject = "../../views/project/client/project-list/add-project/views/add-project.view.html";
            $('#modalAddProject').modal('show');
        }

        function showProjectList() {
            vm.tplProjectList = "../../views/project/client/project-list/views/project-list.view.html";
        }

        function showOrderListResume(userType) {
            var template = getTemplate(templates.resume, userType);
            vm.tplOrderList = template;
        }

        function showProjectDetail(id){
            window.location.href = "/index.cfm/project.edit?id=" + id;
        }

        function deleteProject(id){
            var result = confirm('Are you sure you want to delete this project?');
            if(result){
                $.ajax({
                    type: "POST",
                    url: "/index.cfm/project/deleteProject",
                    async: false,
                    data: {'id_project' : id },
                    success: function( data ) {
                        if(data.success)
                        {
                            noticeSuccess(data.message);
                            window.location.reload();
                        }else{
                            noticeFailed(data.message);
                        }
                    }
                });
            }
        }

        function actionsHtml(data, type, full, meta) {
          // vm.shipments[data.id_shipment_type] = data;
          return   '<span class="txt-color-red btnDelete" title="Delete" ng-click="vmProjectList.deleteProject('+ data.ID_PROJECT +')">' +
                    '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
                    '</span>';
        }

        function actionsDetail(data, type, full, meta){
            return '<span class="txt-color-green btngotoplfdetail" title="Click to view project detail" ng-click="vmProjectList.showProjectDetail(' + data.ID_PROJECT + ')">' +
                    '<i class="ace-icon bigger-130 fa fa-sign-out"></i>' + 
                '</span>';
        }

    };

})();