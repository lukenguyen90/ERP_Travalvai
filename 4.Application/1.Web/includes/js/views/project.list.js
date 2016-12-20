(function(){
  	angular.module('project.list',['ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  	function BindAngularDirectiveCtrl($scope ,$http, $filter ,$compile)
  	{
     	var vm = this;
      vm.deleteProject = deleteProject;
      vm.regex      = "[a-z A-Z 0-9-\_\.]+";
      vm.addRow     = addRow;
      vm.showAddNew = showAddNew;
      vm.user       = {};
      var original  = angular.copy(vm.user);

      $http.get("/index.cfm/basicdata/getcustomer").success(function(dataResponse){
          vm.customers = dataResponse;
      });

      $http.get("/index.cfm/project/getstatus").success(function(dataResponse){
        vm.status = dataResponse;
      });

      function showAddNew(){
        $('#addNew').modal('show');
        $http.get("/index.cfm/project/getMaxOfProjectNumber").success(function(dataResponse){
          vm.user.display_format = dataResponse + 1;
          vm.user.display    = vm.user.display_format;
        });
      }

      function addRow(){
        $.ajax({
              type: "POST",
              url: "/index.cfm/project/addNew",
              async: false,
              data: {
                    'display'        : vm.user.display,
                    'description'    : vm.user.description,
                    'customer'       : vm.user.customerID,
                    'date'           : $filter('date')(vm.user.date, "yyyy-MM-dd"),
                    'status'         : vm.user.statusID,
                    'groupWaitingFD_VN'  : vm.user.groupWaitingFD_VN=="YES"?true:false,
                    'groupWaitingFD_local' : vm.user.groupWaitingFD_local=="YES"?true:false,
                    'groupUrgent'    : vm.user.groupUrgent=="YES"?true:false,
                    'groupVUrgent'   : vm.user.groupVUrgent=="YES"?true:false,
                    'groupSentTCom'  : vm.user.groupSentTCom=="YES"?true:false,
                    'groupSentTCus'  : vm.user.groupSentTCus=="YES"?true:false,
                    'groupSentTD'    : vm.user.groupSentTD=="YES"?true:false,
                    'groupWaitingFC' : vm.user.groupWaitingFC=="YES"?true:false,
                    'groupDesignProcess'     : vm.user.groupDesignProcess=="YES"?true:false,
                    'pj_act_9'       : vm.user.pj_act_9=="YES"?true:false,
                    'pj_act_10'      : vm.user.pj_act_10=="YES"?true:false,
                    'id_Project':$('#id_Project').val()
              },
              success: function( data ) {
                if(data.success){
                  window.location.href="/index.cfm/project.edit?id="+data.projectId;
                }else{
                  $('#addNew').modal('hide');
                  noticeFailed(data.message);
                }
              }
          });
      }
       

      function refresh(){
        vm.user = angular.copy(original);
        $scope.userForm.$setPristine();
      }

      function deleteProject(id) {
        var result = confirm('Are you sure you want to delete this project?');
        if(result){
          $.ajax({
                 type: "POST",
                 url: "/index.cfm/project/deleteProject",
                 async: false,
                 data: {'id_project' : id
              },
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
  	}

})();
