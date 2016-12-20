<cfoutput>	

<div id="shipment-list-ctrl" class="" ng-app="shipment" ng-controller="ShipmentListCtrl as vm" ng-init="vm.init('#application.userType#', #application.userTypeId#)">	
	<div class="col-md-12">
        <div id="filter">
           
            <div class="col-md-2">  
                <label class="pull-left">From</label>             
                <ol class="nya-bs-select pull-right" ng-model="vm.filter.from" data-size="10 " data-live-search="true">
                    <li nya-bs-option="from in vm.fromList ">
                        <a> <span ng-bind="from.name"></span>
                        </a>
                    </li>
                </ol>              
            </div>
            
            <div class="col-md-2" style="padding-left: 15px">  
                <label class="pull-left">To</label>             
                <ol class="nya-bs-select pull-right" ng-model="vm.filter.to" data-size="10 " data-live-search="true">
                    <li nya-bs-option="to in vm.toList ">
                        <a> <span ng-bind="to.name"></span>
                        </a>
                    </li>
                </ol>              
            </div>
            <div class="row col-md-6" style="padding-left:15px"> 
                <button type="button" style="margin-top: 2px" class="btn btn-sm btn-info pull-left" ng-click="vm.loadShipments()">Show</button>
            </div>
            <div>
                <button type="button" style="margin-top: 2px" class="btn btn-sm btn-info pull-right" ng-click="vm.showAddShipmentPopup('#application.userType#')">Add Shipment</button>
            </div>
        </div>
        <div class="row col-md-12" style="height:5px">&nbsp;</div>
        <!--tab content-->
        <div class="col-md-12" id="shipments-ctrl">
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
                        <th>NO. BOXES</th>
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
        <!--/tab content-->
    </div>
    <!--Add shipment Popup-->
    <div class="modal fade" id="modalAddShipment" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg-shipment">
            <div class="modal-content">
                <div class="modal-body">
                    <div id="add-shipment-ctrl" ng-include="vm.tplAddShipment"></div>
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

<!--shipment list -->
<link rel="stylesheet" href="/views/shipment/css/shipment.css?v=#application.version#">
<script src="/views/shipment/client/shipment.baseCtrl.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment.baseService.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment.utils.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment.models.js?v=#application.version#"></script>

<script src="/views/shipment/client/shipment-list/shipment-list.service.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment-list/datatable.ctrl.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment-list/shipment-list.ctrl.js?v=#application.version#"></script>

<!--/shipment list -->

<!--add shipment -->
<script src="/views/shipment/client/shipment-list/add-shipment/add-shipment.service.js?v=#application.version#"></script>
<script src="/views/shipment/client/shipment-list/add-shipment/add-shipment.ctrl.js?v=#application.version#"></script>


<!--/add shipment -->



</cfoutput>



