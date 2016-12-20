(function() {
    'use strict';

    angular.module('project.services').factory('addProjectService', addprojectService);

    function addprojectService($q, baseService) {


        return {
            getMaxOfProjectNumber: getMaxOfProjectNumber,
            getZones: getZones,
            getAgents: getAgents,
            createProject: createProject,
        };

        function getMaxOfProjectNumber(){
            return baseService.makeRequest("getMaxOfProjectNumber");
        }

        function getZones() {
            return baseService.makeRequest("getZone");
        }

        function getAgents(id) {
            var params = { zoneId: parseInt(id) };
            return baseService.makeRequest("getAgent", params);
        }

        function createProject(project) {
            return baseService.makeRequest("createProject", project);
        }

    }
})();