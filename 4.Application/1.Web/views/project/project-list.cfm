<style type="text/css">

.modal-wrapper{
    margin-left:5px;
}

hr{
    margin: 5px;
}

#modalAddProject input{
    font-weight: normal !important;
}

#tab [class*="col-"]{
    height: 42px !important;
}
    
#tab .row{
    overflow: hidden;
}
    
#tab{
    height: 42px !important;
}

.ColVis{
        float: left !important;
}

div.dataTables_filter label {
    font-weight: 400;
    float: left !important;
    margin-left: 10px !important;
}

.ColVis button span{
    display: none;
}

.ColVis button:after{
    content: 'Select columns' !important;
}

</style>
<cfoutput>  
<div id="project-list-ctrl" ng-app="project" ng-controller="ProjectListCtrl as vmProjectList" ng-init="vmProjectList.init('#application.userType#', #application.userTypeId#)">  
    <div class="col-md-12">
        <div>
            <button type="button" class="btn btn-sm btn-info pull-right" ng-click="vmProjectList.showAddProjectPopup('#application.userType#')">Create
            </button>
        </div>
        <div ng-include="vmProjectList.tplProjectList"></div>
    </div>
    <!--Add Project Popup-->
    <div class="modal fade" id="modalAddProject" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <div id="add-project-ctrl" ng-include="vmProjectList.tplAddProject"></div>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="/includes/js/jquery.dataTables.min.js?v=#application.version#"></script>
<script src="/includes/js/dataTables.select.min.js?v=#application.version#"></script>
<script src="/includes/js/angular-datatables.min.js?v=#application.version#"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js?v=#application.version#"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js?v=#application.version#"></script>

<!--datatable button-->

<link rel="stylesheet" href="/includes/js/plugin/datatables/button/css/buttons.dataTables.min.css">
<link rel="stylesheet" href="/includes/js/plugin/datatables/button/css/buttons.custom.css">


<script src="/includes/js/plugin/datatables/button/dataTables.buttons.min.js?v=#application.version#"></script>
<script src="/includes/js/plugin/datatables/button/buttons.bootstrap.min.js?v=#application.version#"></script>

<script src="/includes/js/plugin/datatables/button/pdfmake.min.js?v=#application.version#"></script>
<script src="/includes/js/plugin/datatables/button/vfs_fonts.js?v=#application.version#"></script>
<script src="/includes/js/plugin/datatables/button/jszip.min.js?v=#application.version#"></script>
<script src="/includes/js/plugin/datatables/button/buttons.flash.min.js?v=#application.version#"></script>
<script src="/includes/js/plugin/datatables/button/buttons.html5.min.js?v=#application.version#"></script>
<script src="/includes/js/plugin/datatables/button/buttons.print.min.js?v=#application.version#"></script>
<script src="/includes/js/plugin/datatables/button/buttons.custom.js?v=#application.version#"></script>
<script src="/includes/js/plugin/angular-datatable/button/angular-datatables.buttons.min.js"></script>
<!--/datatable button-->

<!--core-->
<script src="/views/project/client/project.baseCtrl.js?v=#application.version#"></script>
<script src="/views/project/client/project.baseService.js?v=#application.version#"></script>
<script src="/views/project/client/project.utils.js?v=#application.version#"></script>
<script src="/views/project/client/project.js?v=#application.version#"></script>
<script src="/views/project/client/project.models.js?v=#application.version#"></script>
<!--/core-->

<!--project-list-->
<script src="/views/project/client/project-list/project.service.js?v=#application.version#"></script>
<script src="/views/project/client/project-list/project-list.ctrl.js?v=#application.version#"></script>
<!--/project-list-->

<!--add-project-->
<script src="/views/project/client/project-list/add-project/add-project.service.js?v=#application.version#"></script>
<script src="/views/project/client/project-list/add-project/add-project.ctrl.js?v=#application.version#"></script>
<!--/add-project-->

</cfoutput>



