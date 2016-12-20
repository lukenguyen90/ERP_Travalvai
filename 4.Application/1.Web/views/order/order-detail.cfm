<style type="text/css" media="screen">
    .modal-wrapper {
        margin-left:5px;
    }
    .modal-lg-product {
            width: 900px;
    }
    .modal-lg-edit-size {
        width: 400px;
    }   

  
    #order-detail-ctrl .form-group {
        margin-bottom: 4px !important;
    }
    
    #order-detail-ctrl legend {
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

    #order-detail-ctrl .row{
        margin-right: -8px !important;
    }

    #order-detail-ctrl .jarviswidget {
        margin: 0px !important;
    }
    #order-detail-ctrl .nav-tabs {
        width: 98.7% !important;
    }
    
    #delivery-info-ctrl {
        font-size: 12px !important;
    }

    #delivery-info-ctrl .col-md-12,
    .col-md-4 {
        padding-left: 1px !important;
        padding-right: 1px !important;
    }
    
    #delivery-info-ctrl .delivery-detail {
        border-bottom: 1px dotted #565252
    }

    #delivery-info-ctrl .delivery-detail-value {
        border-bottom: 1px dotted #c1bbbb;
        padding-bottom: 2px;
    }

    #delivery-info-ctrl input, #delivery-info-ctrl label {
        width: 46% !important;
        font-weight: normal !important;
    }

    #delivery-info-ctrl input.discount {
        width: 60% !important;
        padding: 5px 9px;
    }
    
    #delivery-info-ctrl .factory-info {
        width: 21% !important;
    }
    
    #delivery-info-ctrl .zone-info {
        width: 21% !important;
    }
    
    #delivery-info-ctrl .agent-info {
        width: 58% !important;
    } 
    #delivery-info-ctrl .content-info {
        width: 37% !important;
        padding-left: 0px;
        padding-right: 0px;
    }        
    
    #order-info-ctrl {
        font-size: 12px !important;
    }
    #order-info-ctrl .form-control {
        height: 22px !important;
        font-size: 12px;
    }


    #delivery-info-ctrl .form-control {
        height: 22px !important;
        font-size: 12px;
        padding: 5px;
    }

    #order-info-ctrl input {
        width: 65% !important;
        font-weight: normal !important;
        padding: 5px 9px;
    }

    #order-info-ctrl .label-value {
        width: 65% !important;
    }

    #order-info-ctrl .nya-bs-select {
        height: 22px !important;
        width: 65% !important
    }
    #order-info-ctrl .nya-bs-select .btn {
        padding: 0px 10px !important;
        height: 22px !important;
        font-size: 12px !important;
    }

    #payment .nya-bs-select .btn {
        padding: 0px 10px !important;
        height: 22px !important;
        font-size: 12px !important;
        margin-bottom: 0px;
    }
    #payment input{
        width: 100% !important;
    }

    hr {
        margin: 5px;
    }      

    #product-list-ctrl .form-control{
        height: 32px !important;
    }

    #product-list-ctrl .col-md-12 {
         padding-left: 1px !important;
        padding-right: 1px !important;
    }

    

    legend i , header i {
        cursor: pointer;
    }

    
    #tab [class*="col-"] {
        height: 38px !important;
    }
    
    #tab .row {
        overflow: hidden;
    }
    
    #tab {
        height: 38px !important;
    }
    .modal-footer {
        border: 0;
    }
    .form-edit-size .form-control {
        width: 30% !important;
        height: 21px !important;
        font-size: 10px !important;
    } 
    .form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control {
        background-color: #eee !important;
    }
        
</style>
<cfoutput>

<div id="order-detail-ctrl" ng-app="order"  ng-controller="OrderDetailCtrl as vmOrderDetail" ng-init="vmOrderDetail.init('#application.userType#')">
    <div class="jarviswidget jarviswidget-color-darken">
        <header>
                <span class="widget-icon"> 
                    <i class="fa fa-arrow-left" ng-click="vmOrderDetail.viewOrderList()" title="Back to Order List"></i> 
                </span>
                <h2>Order Detail</h2>               
        </header>
    </div> 
    
    <div ng-include="vmOrderDetail.mainDetailTpl" ></div>
       
    <!--Add Product Popup-->
    <div class="modal fade" id="modalAddProduct" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg-product">
            <div class="modal-content">
                <div class="modal-body">
                    <div ng-include="vmOrderDetail.tplAddProduct" onload="vmOrderDetail.updateProduct()"></div>
                </div>
            </div>
        </div>
    </div> 

    <div class="modal fade" id="errorImportCSV" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg-product">
            <div class="modal-content">
                
                <div class="modal-body">
                    <legend class="popup-header" style="margin-left: -15px !important; width: 898px !important;"><span><strong>List Error Import CSV<strong></strong></strong></span></legend>
                    <div ng-repeat="x in vmOrderDetail.arrErrCSV" class="row">
                        <div class="col-md-11 col-md-offset-1 text-danger"><i class="fa fa-exclamation-circle" aria-hidden="true"></i> {{x}}</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button " class="btn btn-sm btn-info pull-right" data-dismiss="modal"><span>Close</span></button>
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
<script src="/views/order/client/order.js?v=#application.version#"></script>

<script src="/views/order/client/order.models.js?v=#application.version#"></script>



<script src="/views/order/client/add-order/add-order.service.js?v=#application.version#"></script>
<script src="/views/order/client/add-order/add-order.ctrl.js?v=#application.version#"></script>

<script src="/views/order/client/product/product.service.js?v=#application.version#"></script>
<script src="/views/order/client/product/product.ctrl.js?v=#application.version#"></script>
<script src="/views/order/client/product/product.edit.ctrl.js?v=#application.version#"></script>

<script src="/views/order/client/product/add.size.ctrl.js?v=#application.version#"></script>
<script src="/views/order/client/product/add.name_number_size.ctrl.js?v=#application.version#"></script>

<script src="/views/order/client/product/edit.size.ctrl.js?v=#application.version#"></script>
<script src="/views/order/client/product/edit.name_number.ctrl.js?v=#application.version#"></script>

<script src="/views/order/client/order-detail/order-detail.ctrl.js?v=#application.version#"></script>
<script src="/views/order/client/order-detail/order-detail.service.js?v=#application.version#"></script>

<script src="/views/order/client/order-detail/line/line.ctrl.js?v=#application.version#"></script>
<script src="/views/order/client/order-detail/size/size.ctrl.js?v=#application.version#"></script>

<script src="/views/order/client/order-detail/line/#application.userType#.ctrl.js?v=#application.version#"></script>
<script src="/views/order/client/order-detail/size/#application.userType#.ctrl.js?v=#application.version#"></script>
  
  
</cfoutput>
