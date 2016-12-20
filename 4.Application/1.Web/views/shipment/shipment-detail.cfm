
<cfoutput>

<div id="shipment-detail-ctrl" class="" ng-app="shipment" ng-controller="ShipmentDetailCtrl as vm" ng-init="vm.init('#application.userType#', #application.userTypeId#)">	
	<div class="col-md-12 container">
        <div class="row col-md-12 header-box"><span class="pull-left">- Shipping Information</span></div>
        <div id="shipment-info-ctrl" ng-include="vm.tplShipmentInfo" onload="vm.loadedShippingInfo()">
        </div>   

        <div class="row col-md-12" style="height:5px">&nbsp;</div>

        <div class="row col-md-12 header-box">
            <span class="pull-left">- Shipping Items</span>
            <button class="btn btn-info btn-sm pull-right btn-add-box" value="" ng-click="vm.showAddBoxPopup()">Add Box</button>
        </div>        
        <!--shipment items-->
        <div class="row col-md-12" id="shipment-items-ctrl">
            <table id="tbl-shipment-list" class="table table-striped table-bordered" width="100%" datatable dt-options="vm.dtOptions" dt-columns="vm.dtColumns" dt-instance="vm.dtInstance">
                <thead>
                    <tr>
                        <th>SHIPMENT</th>
                        <th>TYPE</th>
                        <th>SENDER</th>
                        <th>DEST</th>
                        <th>STATUS</th>
                        <th>FORWARDER</th>
                        <th>FREIGHT</th>
                        <th>INCOTERM</th>
                        <th>TOTAL UNITS</th>
                        <th>No. BOXES</th>
                        <th>WEIGHT</th>
                        <th>VOLUME</th>
                        <th>OPEN DATE</th>
                        <th>ESTIMATED <br> DELIVERY <br> DATE</th>
                        <th>DELIVERY DATE</th>
                        <th>ESTIMATED <br> ARRIVAL <br> DATE</th>
                        <th>ARRIVAL DATE</th>
                        <th>FREIGHT COST</th>
                        <th>TAXES</th>
                        <th>IMPORT DUTY</th>                    
                    </tr>
                </thead>
                <tfoot>
                    <tr></tr>
                </tfoot>
            </table>
        </div>
        <!--/shipment items-->
    </div>
    <!--Add shipment Popup-->
    <div class="modal fade" id="modalAddBox" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg-box">
            <div class="modal-content">
                <div class="modal-body">
                    <div id="add-box-ctrl" ng-include="vm.tplAddBox"></div>
                </div>
            </div>
        </div>
    </div>


</div>



    
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/dataTables.select.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>

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


<!--shipment detail -->
<link rel="stylesheet" href="/views/shipment/css/shipment.css?v=#application.version#">
<script src="/views/shipment/client/shipment.baseCtrl.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment.baseService.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment.utils.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment.models.js?v=#application.version#"></script>

<script src="/views/shipment/client/shipment-detail/shipment-detail.service.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment-detail/datatable.ctrl.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment-detail/shipment-detail.ctrl.js?v=#application.version#"></script>

<!--/shipment detail -->

<!--add box -->
<script src="/views/shipment/client/shipment-detail/add-box/add-box.service.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment-detail/add-box/add-box.ctrl.js?v=#application.version#"></script>
<!--/add box -->  
  
</cfoutput>
