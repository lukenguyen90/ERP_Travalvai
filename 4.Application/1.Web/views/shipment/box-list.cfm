<cfoutput>	
<style type="text/css">
    .modal-dialog {
    width: 400px;
}
.modal-content {
    width: 400px !important;
}

.form-control {
    width: 66%;
    height: 33px;
}
</style>
<div id="box-list-ctrl" class="" ng-app="shipment" ng-controller="BoxListCtrl as vm" ng-init="vm.init('#application.userType#', #application.userTypeId#)">	
	<div class="col-md-12">
        <div id="filter">
            <div>
                <button type="button" style="margin-top: 2px" class="btn btn-sm btn-info pull-right" ng-click="vm.showAddBoxPopup('#application.userType#')">Add Box</button>
            </div>
        </div>
        <div class="row col-md-12" style="height:5px">&nbsp;</div>
        <!--tab content-->
        <div class="col-md-12" id="shipments-ctrl">
            <table id="tbl-box-list" class="table table-striped table-bordered" width="100%" datatable dt-options="vm.dtOptions" dt-columns="vm.dtColumns" dt-instance="vm.dtInstance">
            </table>
        </div>
        <!--/tab content-->
    </div>
    <!--Add Box Popup-->
    <div class="modal fade" id="modalAddBox" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg-shipment">
            <div class="modal-content">
                <div class="modal-body">
                    <div id="add-box-ctrl" ng-include="vm.tplAddBox"></div>
                </div>
            </div>
        </div>
    </div>
     <!--Edit Box Popup-->
    <div class="modal fade" id="modalEditBox" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg-shipment">
            <div class="modal-content">
                <div class="modal-body">
                    <div id="add-box-ctrl" ng-include="vm.tplEditBox"></div>
                </div>
            </div>
        </div>
    </div>


</div>

<!--- barcode --->
<script src="/includes/js/JsBarcode.all.min.js?v=#application.version#"></script>
<!--- data table --->
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

<!--shipment list -->
<link rel="stylesheet" href="/views/shipment/css/shipment.css?v=#application.version#">
<script src="/views/shipment/client/shipment.baseCtrl.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment.baseService.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment.utils.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment.models.js?v=#application.version#"></script>

<script src="/views/shipment/client/box-list/box-list.service.js?v=#application.version#"></script>
<script src="/views/shipment/client/box-list/datatable.ctrl.js?v=#application.version#"></script>
<script src="/views/shipment/client/box-list/box-list.ctrl.js?v=#application.version#"></script>

<!--/shipment list -->

<script src="/views/shipment/client/box-list/add-box/add-box.service.js?v=#application.version#"></script>
<script src="/views/shipment/client/box-list/add-box/add-box.ctrl.js?v=#application.version#"></script>

<!--- edit box --->
<script src="/views/shipment/client/box-list/edit-box/edit-box.service.js?v=#application.version#"></script>
<script src="/views/shipment/client/box-list/edit-box/edit-box.ctrl.js?v=#application.version#"></script>







</cfoutput>



