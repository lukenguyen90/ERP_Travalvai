<style type="text/css">

.modal-lg-payment {
    width: 724px;
}

.modal-wrapper {
        margin-left:5px;
}

hr {
	margin: 5px;
}

#modalAddPayment input {
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
<div id="payment-list-ctrl" class="" ng-app="order" ng-controller="PaymentListCtrl as vmPaymentList" ng-init="vmPaymentList.init('#application.userType#', #application.userTypeId#)">	
	<div class="col-md-12">
        <div>
            <button type="button" class="btn btn-sm btn-info pull-right" ng-click="vmPaymentList.showAddPaymentPopup('#application.userType#')">Add Payment
            </button>
        </div>
        <div ng-include="vmPaymentList.tplPaymentList">
        </div>
       
    </div>
    <!--Add Order Popup-->
    <div class="modal fade" id="modalAddPayment" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg-payment">
            <div class="modal-content">
                <div class="modal-body">
                    <div ng-include="vmPaymentList.tplAddPayment"></div>
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
<script src="/views/order/client/order.baseCtrl.js?v=#application.version#"></script>
<script src="/views/order/client/order.baseService.js?v=#application.version#"></script>
<script src="/views/order/client/order.utils.js?v=#application.version#"></script>
<script src="/views/order/client/order.js?v=#application.version#"></script>
<script src="/views/order/client/order.models.js?v=#application.version#"></script>
<!--/core-->

<!--payment-list-->
<script src="/views/order/client/basic-data/payment/payment.service.js?v=#application.version#"></script>
<script src="/views/order/client/basic-data/payment/payment-list.ctrl.js?v=#application.version#"></script>
<!--/payment-list-->

<!--add-payment-->
<script src="/views/order/client/basic-data/payment/add-payment/add-payment.service.js?v=#application.version#"></script>
<script src="/views/order/client/basic-data/payment/add-payment/add-payment.ctrl.js?v=#application.version#"></script>
<!--/add-payment-->

</cfoutput>



