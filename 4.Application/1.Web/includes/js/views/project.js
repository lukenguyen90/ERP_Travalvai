(function(){
  	angular.module('project', ['datatables', 'ui.select2', 'datatables.light-columnfilter','ckeditor']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  	function BindAngularDirectiveCtrl($scope ,$http, $filter ,$compile, DTOptionsBuilder, DTColumnBuilder, $window)
  	{
     	var vm = this;
      vm.regex               = "[a-z A-Z 0-9-\_\.]+";
      vm.message             = '';
      vm.addRow              = addRow;
      vm.addRowComment       = addRowComment;
      vm.editproject         = editproject;
      vm.editComment         = editComment;
      vm.deletecomment       = deletecomment;
      vm.addComment          = addComment;
      vm.showCommentDetail   = showCommentDetail; 
      vm.persons             = {};
      vm.user                = {};
      vm.dtInstance          = {};
      vm.pddtInstance        = {};
      vm.idpro               = 0;
      vm.comment             = {};
      vm.backState           = backState;
      vm.comments            = {};
      vm.user.groupWaitingFD_VN = 0;
      vm.user.groupWaitingFD_local  = 0;
      vm.user.groupUrgent    = 0;
      vm.user.groupVUrgent   = 0;
      vm.user.groupDesignProcess    = 0;
      vm.user.groupSentTCom  = 0;
      vm.user.groupSentTCus  = 0;
      vm.user.pj_act_9       = 0;
      vm.user.pj_act_10      = 0;
      vm.editProduct         = editProduct;
      vm.user.groupWaitingFC = 0;
      vm.deleteRow           = deleteRow;
      var original = angular.copy(vm.comment);
      // Editor options.
      $scope.options = {
        language: 'en',
        allowedContent: true,
        entities: false
      };

      // Called when the editor is completely ready.
      $scope.onReady = function () {

      };

      vm.comment.todaycomment = new Date($filter('date')(Date.now(),"yyyy/MM/dd "));
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/project/getComment?idproject='+getQueryVariable("id"))
          .withPaginationType('full_numbers')
          .withOption('createdRow', createdRowComment)
          .withLightColumnFilter( {
            '0': {
              type:'text'
            },
            '1': {
              type:'text'
            },
            '2': {
              type:'text'
            }
          })
          .withOption('select', { style: 'single' });

      vm.pddtOptions= DTOptionsBuilder.fromSource("/index.cfm/project/getProj_product?idproject="+getQueryVariable("id"))
          .withPaginationType('full_numbers')
          .withOption('createdRow', createdRow)
          .withLightColumnFilter( {
            '0': {
              type:'text'
            },
            '1': {
              type:'text'
            },
            '2': {
              type:'text'
            },
            '3': {
              type:'text'
            },
            '4': {
              type:'text'
            },
            '5': {
              type:'text'
            },
            '6': {
              type:'text'
            }
          })
          .withOption('select', { style: 'single' });

      vm.dtColumns = [
            DTColumnBuilder.newColumn('DATE').withTitle('DATE').withOption("width","15%")
          , DTColumnBuilder.newColumn('USER').withTitle('COMMENTATOR').withOption("width","10%")
          , DTColumnBuilder.newColumn('COMMENT').withTitle('COMMENT').withOption("width","65%").renderWith(subComment)
          , DTColumnBuilder.newColumn(null).withTitle('DETAIL').renderWith(detailComment).withOption("width","5%")
          , DTColumnBuilder.newColumn(null).withTitle('ACTIONS').renderWith(renderEditComment).withOption("width","5%")
      ];

      function renderEditComment(data, type, full, meta){
        if(data.EDITABLE){
          return '<span class="txt-color-green btngotoversion" title="Go to edit comment" ng-click="showCase.editComment(' + data.ID + ')">' +
                  '<i class="ace-icon bigger-130 fa fa-pencil"></i></span>';
        }else return "";
      }

      function detailComment(data, type, full, meta){
        return '<span class="txt-color-green btngotoversion" title="Go to comment detail" ng-click="showCase.showCommentDetail(' + data.ID + ')">' +
                '<i class="ace-icon bigger-130 fa fa-align-justify"></i></span>';
      }

      function subComment(data, type, full, meta){
        return '<span class="txt-color-green btngotoversion" title="Go to comment detail" ng-click="showCase.showCommentDetail(' + full.ID + ')">'
                + splitComment(data,200) +'</span>';
      }

      function splitComment(paragraghStr, numplace){
        var substr = paragraghStr.substring(0,numplace);
        var lasOfIndex = substr.lastIndexOf(" ");
        substr = lasOfIndex == -1?substr:substr.substring(0,lasOfIndex);
        return substr + " ...";
      }

      vm.pddtColumns = [
            DTColumnBuilder.newColumn('id_product').withTitle('PRODUCT').withOption("width","5%").withClass('text-center')
          , DTColumnBuilder.newColumn('Garment_code').withTitle('DESIGN CODE').renderWith(GarmentCode).withOption("width","20%")
          , DTColumnBuilder.newColumn('cost_code').withTitle('PRICE CODE').renderWith(costingDisplay).withOption("width","10%")
          , DTColumnBuilder.newColumn('pr_description').withTitle('DESCRIPTION').withOption("width","20%")
          , DTColumnBuilder.newColumn('sizes').withTitle('SIZES').withOption("width","10%")
          , DTColumnBuilder.newColumn('section').withTitle('SECTION').withOption("width","5%")
          , DTColumnBuilder.newColumn('pr_status_desc').withTitle('STATUS').withOption("width","10%")
          , DTColumnBuilder.newColumn(null).withTitle('SKETCH').renderWith(sketchDisplay).withOption("width","10%")
          , DTColumnBuilder.newColumn(null).withTitle('DETAILS').renderWith(renderDetail).withOption("width","5%").withClass('text-center')
          , DTColumnBuilder.newColumn(null).withTitle('ACTION').renderWith(renderActions).withOption("width","5%").withClass('text-center')
      ];

      function costingDisplay(data, type, full, meta){
        return full.cost_code + " - v" + full.cv_version;
      }

      function renderDetail(data, type, full, meta){
        return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.editProduct(' + full.id_product + ')">' +
                '<i class="ace-icon bigger-130 fa fa-sign-out"></i>';
      }

      function renderActions(data, type, full, meta){
        return '<span class="txt-color-red btndelete" title="Delete product" ng-click="showCase.deleteRow(' + full.id_product + ')">' +
                  '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
      }

      function editProduct(IDProduct){
        window.location.href = "/index.cfm/product.edit?id=" + IDProduct;
      }

      function deleteRow(IDProduct){
        var result = confirm('Are you sure you want to delete this product?');
        if(result)
        {
          $.ajax({
              async: false,
              type: 'POST',
              url: '/index.cfm/product/deleteProduct',
              data: {
                id_product :  IDProduct
              },success: function(data) {
              if(data.success) {
                noticeSuccess(data.message);
              }
              else {
                noticeFailed(data.message);
              }
              vm.pddtInstance.reloadData();
            }
          });
        }
      }

      function GarmentCode(data, type, full, meta){
        return full.Garment_code + " - v" + full.pr_version;
      }


	  	$http.get("/index.cfm/basicdata/getcustomer").success(function(dataResponse){
        	vm.customers = dataResponse;
      });

    	$http.get("/index.cfm/project/getstatus").success(function(dataResponse){
      	vm.status = dataResponse;
    	});

    	$( "#customer" ).change(function() {
  		  	var idcus = $("#customer").val();
  		  	if(idcus > 0){
  			  	$.ajax({
  	             	type: "POST",
  	             	url: "/index.cfm/project/getzoneagent",
  	             	async: false,
  	             	data: {
  	                  	'idcus' : idcus
  	          		},
  	              	success: function( data ) {
  	                	if(data.success){
  	                  		vm.user.zone = data.name_zone;
  	                  		vm.user.agent = data.name_agent;
  	           	 		}
  	              	}
           	});
  		  	}else{
            vm.user.zone = "";
            vm.user.agent = "";
          }
  		});

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

      function backState(){
          history.back();
      }

      var queryString = window.location.search;
      if(queryString) editproject(getQueryVariable("id"));

      function editproject(id) {
        $.ajax({
            type: "POST",
            url: "/index.cfm/project/getprojectforid",
            async: false,
            data: {
                  'id_Project': id
            },
            success: function(data) {
                vm.user.display_format = data.id_display;
                vm.user.display        = "PJ-" +  data.id_display;
                vm.user.description    = data.pj_description;
                vm.user.customerID     = data.id_Customer;
                vm.user.date           = $filter('date')(new Date(data.pj_date),"dd-MM-yyyy");
                vm.user.statusID       = data.id_pj_Status;
                vm.user.zone           = data.zone + ' - ' + data.z_des;
                vm.user.agent          = data.agent + ' - ' + data.ag_des;
                vm.user.groupWaitingFD_VN = data.pj_act_1?"YES":"NO";
                vm.user.groupWaitingFD_local  = data.pj_act_5?"YES":"NO";
                vm.user.groupUrgent    = data.pj_act_2?"YES":"NO";
                vm.user.groupVUrgent   = data.pj_act_3?"YES":"NO";
                vm.user.groupDesignProcess    = data.pj_act_6?"YES":"NO";
                vm.user.groupSentTCom  = data.pj_act_4?"YES":"NO";
                vm.user.groupSentTCus  = data.pj_act_8?"YES":"NO";
                vm.user.groupWaitingFC = data.pj_act_7?"YES":"NO";
                vm.user.pj_act_9       = data.pj_act_9?"YES":"NO";
                vm.user.pj_act_10      = data.pj_act_10?"YES":"NO";
            }
        });
      }

      function sketchDisplay(data, type, full, meta){
        return '<a rel="lightbox-mygallery-priceview'+data.cost_code+'" href="/includes/img/ao/' + data.pr_sketch+ '" title="' + data.cost_code + '">\
                           <img src="/includes/img/ao/' + data.pr_sketch + '" alt="IMAGE" height="auto" width="80">\
                    </a>';
      }

      function addComment(){
        refresh();
        $("#addComment").modal("show");
      }

      function getComment(){
        var id = getQueryVariable("id");

        $.ajax({
          type: "POST",
          url: "/index.cfm/project/getcomment?idproject="+id,
          async: false,
          success: function( data ) {
            if(data.success){
                 vm.comments = data.comments;
            }
            else
            {
                noticeFailed("Can not get Comments");
            }
            refresh();
          }
        });
      }

      function showCommentDetail(idComment){
        $('#contentComment').html(vm.comments[idComment].COMMENT);
        vm.comment.DATE = vm.comments[idComment].DATE;
        vm.comment.USER = vm.comments[idComment].USER;
        $("#detailComment").modal("show");
      }

    	function addRow () {
      	$.ajax({
           	type: "POST",
           	url: "/index.cfm/project/addNew",
           	async: false,
           	data: {
                	'display'         : vm.user.display_format,
			            'description'     : vm.user.description,
                	'customer'	      : vm.user.customerID,
			            'date'            : $filter('date')(vm.user.date, "dd-MM-yyyy"),
                	'status'	        : vm.user.statusID,
                  'groupWaitingFD_VN'  : vm.user.groupWaitingFD_VN,
                  'groupWaitingFD_local'   : vm.user.groupWaitingFD_local,
                  'groupUrgent'     : vm.user.groupUrgent,
                  'groupVUrgent'    : vm.user.groupVUrgent,
                  'groupDesignProcess'     : vm.user.groupDesignProcess,
                  'groupSentTCom'   : vm.user.groupSentTCom,
                  'groupSentTCus'   : vm.user.groupSentTCus,
                  'groupWaitingFC'  : vm.user.groupWaitingFC,
                  'pj_act_9'        : vm.user.pj_act_9,
                  'pj_act_10'       : vm.user.pj_act_10,
                	'id_Project'      : getQueryVariable("id")
        		},
            success: function( data ) {
            	if(data.success){
            		noticeSuccess(data.message);
                vm.idpro = data.projectId;
                window.location.href = "project/project-list";
         	 		}
              else
              {
                	noticeFailed("Please try again!");
              }
          	refresh();
          }
         });
    	}

      function addRowComment() {
        vm.idpro = getQueryVariable("id");
        if(vm.idpro != 0){
          $.ajax({
            type: "POST",
            url: "/index.cfm/project/addNewComment",
            async: false,
            data: {
                  'comment'    : vm.comment.commentContent,
                  'date'       : $filter('date')(Date.now(),"yyyy/MM/dd hh:mm:ss"),
                  'project'    : vm.idpro,
                  'id_Comment' : $('#id_Comment').val()
            },
            success: function( data ) {
              if(data.success){
                noticeSuccess(data.message);
              }
              else
              {
                  noticeFailed(data.message);
              }
              $("#addComment").modal("hide");
              refresh();
            }
          });
        }else{
            noticeFailed('insert project before');
        }
      }

      function createdRowComment(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        vm.comments[data.ID] = data; 
        $compile(angular.element(row).contents())($scope);
      }

      function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
      }

      function editComment(idComment) {
        refresh();
        vm.comment.commentContent = vm.comments[idComment].COMMENT;
        $('#id_Comment').val(vm.comments[idComment].ID);
        vm.idpro = vm.comments[idComment].PROJECTID;
        $("#addComment").modal("show");
      }

      function deletecomment(person) {
        $('#addNew').modal('show');
        $('#butsubmit').click(function(){
          $.ajax({
                 type: "POST",
                 url: "/index.cfm/zone/delete",
                 async: false,
                 data: {'zId' : person.ID
              },
              success: function( data ) {
                  if(data.success)
                  {
                      $('#addNew').modal('hide');
                      noticeSuccess(data.message);
                      vm.dtInstance.reloadData();
                  }else{
                      noticeFailed("Can not delete this type");
                  }
              }
           });
        });
      }

      function refresh () {
        $('#id_Comment').val(0);
        vm.comment = angular.copy(original);
        vm.comment.todaycomment = new Date($filter('date')(Date.now(),"yyyy/MM/dd"));
        $scope.userForm.$setPristine();
        vm.dtInstance.reloadData();
      }
  	};

})();
