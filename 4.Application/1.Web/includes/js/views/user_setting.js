(function(){
  angular.module('user_setting', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm         = this;
      vm.message    = '';
      vm.edit       = edit;
      vm.delete     = deleteRow;
      vm.deleteUser = deleteUser;
      vm.addRow     = addRow;
      vm.refresh    = refresh;
      vm.showAddNew = showAddNew;
      vm.dtInstance = {};
      vm.persons    = {};
      vm.user       = {};
      vm.regex      = "[a-z A-Z 0-9-\_\.]+";
      var original  = angular.copy(vm.user);
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/user/getusersetting')
          .withPaginationType('full_numbers')
          .withLightColumnFilter({
            '0' : {
                type : 'text'
            },
            '1' : {
                type : 'text'
            }
          })
          .withOption('createdRow', createdRow);

        vm.dtColumns = [
            DTColumnBuilder.newColumn('USER').withTitle('User Name'),
            DTColumnBuilder.newColumn('LANGUAGE').withTitle('language'),
            DTColumnBuilder.newColumn(null).withTitle('Actions').notSortable()
                .renderWith(actionsHtml)
        ];

      $http.get("/index.cfm/user/getUser").success(function(dataResponse){
        vm.users = dataResponse;
      });

      $http.get("/index.cfm/basicdata/getlanguage").success(function(dataResponse){
        vm.languages = dataResponse;
      });

      var tempCode = "";
      	$('#addNew').on('hidden.bs.modal', function () {
      		if(tempCode != ""){
      			$(".highlight").removeClass("highlight");
           		$("#mytable td").filter(function() { return $.text([this]) == tempCode; })
                	.parent()
                	.addClass("highlight");
      		}
        });
      function edit(person) {
          $('#addNew').modal('show');
          $('#btnRefresh').css('display','none');
          $(".highlight").removeClass("highlight");
          $("#mytable td").filter(function() { return $.text([this]) == person.user; })
            .parent()
            .addClass("highlight");
          vm.user.user        = person.USERID;
          vm.user.language     = person.LANGUAGEID;
          $('#id_Set').val(person.ID);
          document.getElementById("titleID").innerHTML="Edit";

      }
      function deleteRow(person) {
        vm.did = person.ID;
        $('#showDelete').modal('show');
      }
      function deleteUser() {
        $('#showDelete').modal('hide');
        $.ajax({
             type: "POST",
             url: "/index.cfm/user/deleteUserSetting",
             async: false,
             data: {'gid' : vm.did
          },
          success: function( data ) {
              if(data.success)
              {
                  noticeSuccess(data.message);
                  vm.dtInstance.reloadData();
              }else{
                  noticeFailed("Can not delete this user setting");
              }
          }
        });
      }

      function showAddNew (argument) {
          refresh();
          document.getElementById("titleID").innerHTML="Create";
          $(".highlight").removeClass("highlight");
          $('#btnRefresh').css('display','inline-block');
          $('#addNew').modal('show');
          $(document).ready(function(){
            $("#addNew").on('shown.bs.modal', function(){
            $(this).find('#code').focus();
          });
        });
        }

      function addRow() {
       var flag = false;

      $.ajax({
               type: "POST",
               url: "/index.cfm/basicdata/checkExistCode",
               async: false,
               data: {'code' : vm.user.user,
                      'table':'usersetting',
                      'nameCol':'id_user_setting'
            },
            success: function( data ) {
                flag = data.isExist;
                if(!flag)
                {
                  $.ajax({
                       type: "POST",
                       url: "/index.cfm/user/addNewUserSetting",
                       async: false,
                       data: {
                            'user' 		: vm.user.user,
                            'language' 	: vm.user.language,
                            'id'		: $("#id_Set").val()
                    },
                    success: function( data ) {
                      if(data.success){
                      	tempCode = data.username;
                        noticeSuccess(data.message);
                        vm.dtInstance.reloadData();
                        $('#addNew').modal('hide');
                      }
                      else
                      {
                        noticeFailed("Please try again!");
                      }
                      refresh();
                    }
                  });
                }
                else
                {
                  noticeFailed("User is already exist in settings!");
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

      function refresh () {
          $('#id_Set').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
      }

  };

})();
