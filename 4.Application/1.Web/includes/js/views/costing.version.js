(function(){
  var myapp = angular.module('costing.version', ['datatables', 'datatables.light-columnfilter']);
  myapp.controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm               = this;
     vm.message           = '';
     vm.saveCostingVersion = saveCostingVersion;
     vm.deleteCV          = deleteCV;
     vm.refresh           = refresh;
     vm.dtInstance        = {};
     vm.showEditDes       = showEditDes;
     vm.refreshLanguage   = refreshLanguage;
     vm.persons           = {};
     vm.user              = {};
     vm.newDes            = {};
     vm.dataDes           = {};
     vm.updateDes         = updateDes;
     vm.showAddNew        = showAddNew;
     vm.backState         = backState;
     vm.regex             = /^[0-9]+([\.][0-9]+)?$/;
     vm.isReadonly        = false;
     var original         = angular.copy(vm.user);

     function getQueryVariable(variable) {
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i=0;i<vars.length;i++) {
          var pair = vars[i].split("=");
          if (pair[0] == variable) {
            return pair[1];
          }
        }
    }

     $.ajax({
        async: false,
        type: 'POST',
        url: '/index.cfm/costing_version/getCosting',
        data: {'id_cost' : getQueryVariable("id_cost")},
        success: function(data) {
             //callback
              if(!data.success){
                 vm.costing = data;
                 $("#id_cost").val(vm.costing.ID_COST);
              }else{
                noticeFailed(data.message);
              }
          }
      });

      $.ajax({
        async: false,
        type: 'POST',
        url: '/index.cfm/basicdata/getLanguage',
        success: function(data) {
             //callback
               vm.newDes = data.slice();
               vm.dataDes = data.slice();
          }
      });

     vm.dtOptions  = DTOptionsBuilder.fromSource('/index.cfm/costing_version/getCosting_Version'+window.location.search)
          .withPaginationType('full_numbers')
          .withLightColumnFilter({
            '0' : {
                type : 'text'
            },
            '1' : {
                type : 'text'
            },
            '2' : {
                type : 'text'
            },
            '3' : {
                type : 'text'
            },
            '4' : {
                type : 'text'
            },
            '5' : {
                type : 'text'
            },
            '6' : {
                type : 'text'
            },
            '7' : {
                type : 'text'
            },
            '8' : {
                type : 'text'
            },
            '9' : {
                type : 'text'
            },
            '10' : {
                type : 'text'
            },
            '11' : {
                type : 'text'
            }
          })
          .withOption('createdRow', createdRow)
          .withOption('select', { style: 'single' });;
      vm.dtColumns = [
          DTColumnBuilder.newColumn('CV_VERSION').withTitle('VERSION No.').withOption('width', '10%').withClass('text-center  th-align-left'),
          DTColumnBuilder.newColumn('CV_DESCRIPTION').withTitle('DESCRIPTION'),
          DTColumnBuilder.newColumn('CV_WASTE').withTitle('WASTE (%)').withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn('CV_MARGIN').withTitle('MARGIN (%)').withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn(null).withTitle('FACTORY COST').renderWith(numberCv_fty).withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn('CV_WEIGHT').withTitle('WEIGHT (gr)').withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn('CV_VOLUME').withTitle('VOLUME (cm3)').withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn('UPDATED').withTitle('DATE UPDATE').withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').notSortable().withClass('text-right  th-align-left')
              .renderWith(actionsHtml).withOption('width','9%')
      ];

      function numberCv_fty(data, type, full, meta){
        return $filter('number')(data.CV_FTY_COST_0, 2);
      }

      function showAddNew (argument) {
        vm.isAddNew = true;
        // body...
        refresh();
        document.getElementById("titleID").innerHTML="Create";
        $(".highlight").removeClass("highlight");
        $('#btnRefresh').css('display','inline-block');
        vm.isReadonly = false;
        $('#addNew').modal('show');
        $.ajax({
          async: false,
          type: 'POST',
          url: '/index.cfm/costing_version/getSomeFields',
          data: {'id_cost' : getQueryVariable("id_cost")},
          success: function(data) {
               vm.user.cv_version = data.NEWVERNO;
               vm.user.cv_weight = data.COSTWEIGHT;
               vm.user.cv_volume = data.COSTVOLUME;
               vm.user.c_pl = data.COSTPL;
               $('#id_cost_version').val(0);
            }
        });
        $(document).ready(function(){
            vm.isReadonly = true;
            $("#addNew").on('shown.bs.modal', function(){
            $(this).find('#cv_version').focus();
          });
        });
      }

      var fd = new FormData();
      var fileup = '';
      $scope.uploadFile = function(files) {
        fd = new FormData();
        //Take the first selected file
        fileup = files[0];
      };

      function saveCostingVersion() {
        var isExist = false;
        vm.createonpl = false;
        if(vm.user.c_pl == true && vm.isAddNew == true) {
          var result = confirm('Do you want to add to price list?');
          vm.createonpl = result?true:false;
        }
        $.ajax({
             type: "POST",
             url: "/index.cfm/costing_version/checkExistVersion",
             async: false,
              data: {
                 'id_cost' : $("#id_cost").val()
                ,'cv_version' : vm.user.cv_version
                ,'id_cost_version' : $('#id_cost_version').val()
              },
          success: function( data ) {
            isExist = data.exists;
            if(!isExist){
                fd = new FormData();
                $scope.userForm.$invalid=true;
                fd.append('id_cost'            , $("#id_cost").val());
                fd.append('id_cost_version'   , $('#id_cost_version').val());
                fd.append('cv_version'       , vm.user.cv_version);
                fd.append('cv_waste'         , vm.user.cv_waste);
                fd.append('cv_margin'        , vm.user.cv_margin);
                fd.append('cv_fty_cost_0'    , vm.user.cv_fty_cost_0);
                fd.append('cv_weight'        , vm.user.cv_weight);
                fd.append('cv_volume'        , vm.user.cv_volume);
                fd.append('des'              , JSON.stringify(vm.dataDes));
                fd.append("image", fileup);
                fd.append('createonpl', vm.createonpl);
                $.ajax({
                     type: "POST",
                     url: "/index.cfm/costing_version/updateCostingVersion",
                     async: false,
                      data: fd,
                      processData: false,
                      contentType: false,
                  success: function( data ) {
                    if(data.success){
                      vm.dtInstance.reloadData();
                      $('#addNew').modal('hide');
                      noticeSuccess(data.message);
                    }else{
                      noticeFailed(data.message);
                    }

                  }
               });
            }else{
              noticeFailed('Version is exist!');
            }

          }
         });
      }
      
      function backState() {
        history.back();
      }

      function showEditDes(person)
      {
        vm.isAddNew = false;
        vm.isReadonly = true;
        document.getElementById("titleID").innerHTML="Update";
        refresh();
        $.ajax({
          type: "POST"
          , url: '/index.cfm/costing_version/getCosting_VersionByCVID'
          , data: {"id_cost": getQueryVariable("id_cost"), "id_cv": person.IDCV}
          , success: function(data){
              vm.user.cv_version = data[0].CV_VERSION;
              vm.user.cv_waste   = data[0].CV_WASTE;
              vm.user.cv_margin   = data[0].CV_MARGIN;
              vm.user.cv_fty_cost_0   = data[0].CV_FTY_COST_0;
              vm.user.cv_weight   = data[0].CV_WEIGHT;
              vm.user.cv_volume   = data[0].CV_VOLUME;
              vm.user.cv_sketch   = data[0].CV_SKETCH;
              vm.updateDes(data[0].CV_DES,data[0].IDCV);
              $scope.$apply();
              $('#addNew').modal('show');
              $('#id_cost_version').val(data[0].IDCV);
          }
        });
      }

      function updateDes(data,id){
        for(i = 0;i < data.length; i++){
          for(j = 0;j<vm.dataDes.length;j++){
            if(vm.dataDes[j].id_language == data[i].ID_LANGUAGE){
              vm.dataDes[j].description = data[i].DES;
              $scope.$apply();
            }
            vm.dataDes[j].id_cv = id;
          }
        }
      }

      function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
      }

      function actionsHtml(data, type, full, meta) {
          vm.persons[data.IDCV] = data;
          return '<span class="txt-color-green btnedit padding-right-30" title="Edit" ng-click="showCase.showEditDes(showCase.persons[' + data.IDCV + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i></span>' +
              '<span class="txt-color-red btndelete" title="Delete costing version" ng-click="showCase.deleteCV(' + data.IDCV + ')">' +
                    '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
      }

      function refreshNewDes(){
        for(i = 0;i<vm.newDes.length;i++){
          vm.newDes[i].description = "";
        }
      }

      function refreshDataDes(){
        for(i = 0;i<vm.dataDes.length;i++){
          vm.dataDes[i].description = "";
          vm.dataDes[i].id_cv = 0;
        }
      }

      function refresh() {
          $('#id_cost_version').val(0);
          refreshNewDes();
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
          $('#cv_sketch').val('');
          $('#code').val('');
          $('#description').val('');
      }

      function refreshLanguage() {
          $('#id_cv').val(0);
          vm.des= angular.copy(originalLanguage);
          $scope.languageForm.$setPristine();
      }

      function deleteCV(cvID) {
        $.ajax({
          type: "POST",
          url: "/index.cfm/costing_version/deleteCV",
          data: {"id_cv": cvID},
          success: function( data ) {
            if(data.success)
            {
              noticeSuccess(data.message);
              vm.dtInstance.reloadData();
            }
            else
            {
              noticeFailed(data.message);
            }
          }
        });
      }
    };

})();
