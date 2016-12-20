<style type="text/css">
.display-none{
    display: none;
}

.ws-date{
    width: 400px !important;
}
</style>
<section id="widget-grid" class="" ng-app="contact">
    <!-- row -->
    <div class="row">
        <!-- NEW WIDGET START -->
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <!-- Widget ID (each widget will need unique ID)-->
            <div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
                <header>
                    <span class="widget-icon"> <i class="fa fa-table"></i> </span>
                    <h2>Contact Detail</h2>
                </header>
                <!-- widget div-->
                <div>
                    <!-- widget content -->
                    <div class="widget-body" ng-controller="BindAngularDirectiveCtrl as showCase">
                        <div class="row">
                            <div class="col-md-12">
                                <fieldset>
                                    <div class="fcontent">
                                        <table id="mytable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance">
                                        </table>
                                    </div>
                                </fieldset>
                            </div>
                        </div>
                        <div id="myModalContact" class="modal fade" role="dialog">
                            <supplier-Contact></supplier-Contact>
                        </div>
                        <div class="modal fade" id="formdelete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                            <div class="modal-dialog" id="modalForm">
                                <div class="modal-content">
                                    <div class="modal-header alert-info">
                                        <h3 class="modal-title" id="myModalLabel">Are you sure you want to delete this item?</h3>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                                        <button type="submit" id="butsubmit" class="btn btn-info" ng-click="showCase.deleteUserPerson()">Yes</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </article>
    </div>
</section>
<cfoutput>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/dataTables.select.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/contact.list.js?v=#application.version#"></script>
<script src="/includes/js/views/formcontact.list.js"></script>
</cfoutput>