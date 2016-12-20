(function() {
    'use strict'
    angular
        .module('project.ctrls')
        .controller("AddProjectCtrl", addProjectCtrl);

    function addProjectCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder, $window, $timeout, $controller, models, addProjectService) {
        var vm = this;
        angular.extend(vm, $controller('ProjectListCtrl', { $scope: $scope }));
        //Define properties


        //expose function to view
        vm.init = init;
        vm.createProject = createProject;
        vm.project = {};

        $http.get("/index.cfm/basicdata/getcustomer").success(function(data){
            vm.customers = data;
        });

        $http.get("/index.cfm/project/getstatus").success(function(data){
            vm.statuses = data;
        });

        //Initiate controller
        //Define functions
        function init() {
            initVariable();
            initDatePicker();
        }

        function initVariable() {
            getMaxOfProjectNumber();
            vm.project.description = "";
        }

        function initDatePicker() {
            $("#date").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true
            });
            $("#date").css({ "background-color": "#FFFFFF" });    
        }

        function createProject(){
            addProjectService.createProject(vm.project).then(function(result){
                if (result.success == true){
                    noticeSuccess("Add project success!");
                    setTimeout(function() {
                        window.location.href="/index.cfm/project.edit?id="+result.id_project;        
                    }, 2000);
                    
                }else{
                    noticeFailed("Add project failed!");
                }
            });
        }

        function getMaxOfProjectNumber(){
            addProjectService.getMaxOfProjectNumber().then(function(data) {
                vm.project.display = data + 1;
            });
        }

    };
})();