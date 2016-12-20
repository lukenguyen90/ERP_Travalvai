<style type="text/css">

.modal-lg-order {
    width: 724px;
}

.modal-wrapper {
        margin-left:5px;
}
.modal-lg-product {
        width: 900px;
} 

hr {
	margin: 5px;
}

#order-list-ctrl legend {
        border-bottom: 1px dotted #ddd !important;
        font-size: 14px;
        font-weight: 600;
        padding-left: 6px !important;
        padding-right: 0px !important;
        padding-bottom: 0px !important;
        padding-top: 5px !important;
        margin-bottom: 10px !important;
        margin-left: -5px !important;
        margin-right: 5px !important;
        width: 99.7% !important;
    }


#tbl-order-list-line.table thead tr th{
    font-size: 10px !important;
    padding-left: 2px !important;
    padding-right: 2px !important;
    text-align: left !important;

}


#tbl-order-list-line.table tbody tr td, #tbl-order-list-line.table tfoot tr td{
    font-size: 11px !important;
    padding-left: 2px !important;
    padding-right: 2px !important;
    vertical-align:middle;
}


#tbl-order-list-line.table tfoot tr td {
    font-weight: 600;
}

#tbl-order-list-resume.table thead tr th{
    font-size: 10px !important;
    padding-left: 2px !important;
    padding-right: 2px !important;
    text-align: left !important;

}


#tbl-order-list-resume.table tbody tr td, #tbl-order-list-resume.table tfoot tr td{
    font-size: 11px !important;
    padding-left: 2px !important;
    padding-right: 2px !important;
    vertical-align:middle;
}


#tbl-order-list-resume.table tfoot tr td {
    font-weight: 600;
}

#modalAddOrder input {
    font-weight: normal !important;
}

#tab [class*="col-"] {
        height: 42px !important;
    }
    
    #tab .row {
        overflow: hidden;
    }
    
    #tab {
        height: 42px !important;
    }

</style>
<cfoutput>	
<div id="order-list-ctrl" class="" ng-app="order" ng-controller="OrderListCtrl as vmOrderList" ng-init="vmOrderList.init('#application.userType#', #application.userTypeId#)">	
	<div class="col-md-12">
        <div id="tab" class="nav nav-tabs">
            <div class="row col-md-10">
                <uib-tabset active="active">
                    <uib-tab index="0" heading="Lines" ng-click="vmOrderList.showOrderListLines('#application.userType#')">

                    </uib-tab>
                    <uib-tab index="1" heading="Resume" ng-click="vmOrderList.showOrderListResume('#application.userType#')">

                    </uib-tab>
                </uib-tabset>
            </div>
            <div>
                <button type="button" class="btn btn-sm btn-info pull-right" ng-click="vmOrderList.showAddOrderPopup('#application.userType#')">Add Order</button>
            </div>
        </div>
        <div class="row col-md-12" style="height:5px">&nbsp;</div>
        <!--tab content-->
        <div>
            <div ng-include="vmOrderList.tplOrderList">
            </div>
        </div>
        <!--/tab content-->
    </div>
    <!--Add Order Popup-->
    <div class="modal fade" id="modalAddOrder" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg-order">
            <div class="modal-content">
                <div class="modal-body">
                    <div ng-include="vmOrderList.tplAddOrder"></div>
                </div>
            </div>
        </div>
    </div>

    <!--Add Product Popup-->
    <div class="modal fade" id="modalAddProduct" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg-product">
            <div class="modal-content">
                <div class="modal-body">
                    <div ng-include="vmOrderList.tplAddProduct"></div>
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

<script src="/views/order/client/order.baseCtrl.js?v=#application.version#"></script>
<script src="/views/order/client/order.baseService.js?v=#application.version#"></script>
<script src="/views/order/client/order.utils.js?v=#application.version#"></script>
<script src="/views/order/client/order.js?v=#application.version#"></script>
<script src="/views/order/client/order.models.js?v=#application.version#"></script>

<script src="/views/order/client/order-list/order-list.service.js?v=#application.version#"></script>
<script src="/views/order/client/order-list/order-list.ctrl.js?v=#application.version#"></script>



<script src="/views/order/client/add-order/add-order.service.js?v=#application.version#"></script>
<script src="/views/order/client/add-order/add-order.ctrl.js?v=#application.version#"></script>

<script src="/views/order/client/product/product.service.js?v=#application.version#"></script>
<script src="/views/order/client/product/product.ctrl.js?v=#application.version#"></script>
<script src="/views/order/client/product/add.size.ctrl.js?v=#application.version#"></script>
<script src="/views/order/client/product/add.name_number_size.ctrl.js?v=#application.version#"></script>

<script src="/views/order/client/order-list/line/line.ctrl.js?v=#application.version#"></script>
<script src="/views/order/client/order-list/line/#application.userType#.ctrl.js?v=#application.version#"></script>

<script src="/views/order/client/order-list/resume/resume.ctrl.js?v=#application.version#"></script>
<script src="/views/order/client/order-list/resume/#application.userType#.ctrl.js?v=#application.version#"></script>



</cfoutput>



