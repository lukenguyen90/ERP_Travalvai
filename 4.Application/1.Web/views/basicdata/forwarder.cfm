<style type="text/css">
.display-none{
	display: none;
}

.ws-date{
    width: 400px !important;
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
<div ng-app="forwarder.List" ng-controller="BindAngularDirectiveCtrl as showCase">
    <section id="widget-grid" class="" >
    	<div class="row" >
    		<!-- NEW WIDGET START -->
    		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    			<!-- Widget ID (each widget will need unique ID)-->
    			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
    				<header>
    					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
    					<h2>Forwarder</h2>
    				</header>
    				<!-- widget div-->
    				<div>
    					<!-- widget content -->
    					<div class="widget-body"  >
    						<div class="row">
    							<div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-body">
                								<legend class="fcollapsible" id="titleID">Create</legend>
                								<div class="fcontent">
                									<form class="form-horizontal">
                										<input type='hidden' name="id_Forwarder" id="id_Forwarder" value="0">
                										<div class="form-group" ng-class="{'has-error':userForm.forwarder.$invalid && !userForm.forwarder.$pristine}">
                											<label class="col-md-3 control-label text-left"><b>Forwarder</b></label>
                											<div class="col-md-9">
                												<input class="form-control" placeholder="" type="text" name="forwarder" id="forwarder" ng-model="showCase.user.forwarder" ng-pattern="showCase.regex"  required>
                												<p ng-show="userForm.forwarder.$error.required && !userForm.forwarder.$pristine" class="help-block">Forwarder is required</p>
                                                                <p ng-show="userForm.forwarder.$error.pattern  && !userForm.forwarder.$pristine" class="help-block">Can not enter special char</p>
                											</div>
                										</div>
                										<div class="form-group">
                                                        <label class="col-md-3 control-label text-left"><b>Contact</b></label>
                                                        <div class="col-md-6">
                                                            <input class="form-control" readonly placeholder="" type="text" name="contact" id="contact" ng-model="showCase.user.contact" required>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <button id="createContact" type="button" class="btn btn-block bg-color-blueDark txt-color-white" data-toggle="modal" data-target="#myModalContact">Add Contact</button>
                                                            <button id="editContact" type="button" class="btn btn-block bg-color-blueDark txt-color-white" ng-click="showCase.editRowContact()">Edit Contact</button>
                                                        </div>
                                                    </div>
                										<div class="form-group text-center">
                                                            <div class="col-md-7 col-md-offset-6">
                    											<button class="btn bg-color-blueDark txt-color-white" id="btnAddRow" ng-click="showCase.addRow()">
                    												<i class="fa fa-save"></i>
                    												&nbsp;Add/Update
                    											</button>
                    											<button class="btn btn-default" id="btnRefresh" ng-click="showCase.refresh()">
                    												<i class="fa fa-refresh"></i>
                    												&nbsp;Refresh
                    											</button>
                                                            </div>
                										</div>
                									</form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
    							<div class="row width-table-content">
    								<fieldset>
                                        <div class="btn col-md-2 col-md-offset-10 bg-color-blueDark txt-color-white" id="btnAddNew" ng-click="showCase.showAddNew()">
                                        <i class="fa fa-save"></i>&nbsp;Create
                                        </div>
    									<div class="fcontent">
    										<table id="mytable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance">
                                            </table>
    									</div>
    								</fieldset>
    							</div>
    						</div>
    					</div>
    				</div>
    			</div>
    		</article>
    	</div>
    <div id="myModalContact" class="modal fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" tabindex="-1">
        <supplier-Contact></supplier-Contact>
    </div>
    <div class="modal fade" id="showDelete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
        <div class="modal-dialog" id="modalForm">
            <div class="modal-content">
                <div class="modal-header alert-info">
                    <!--- <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">#getLabel('Close')#</span></button> --->
                    <h3 class="modal-title" id="myModalLabel">Are you sure you want to delete this item?</h3>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                    <button type="submit" id="butsubmit" class="btn btn-info" ng-click="showCase.deleteUser()">Yes</button>
                </div>
            </div>
        </div>
    </div>
    </section>
</div>
<cfoutput>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/dataTables.select.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/plugin/datatables/dataTables.colVis.min.js"></script>
<script src="/includes/js/views/forwarder.list.js?v=#application.version#"></script>
<script src="/includes/js/views/formcontact.list.js?v=#application.version#"></script>
</cfoutput>