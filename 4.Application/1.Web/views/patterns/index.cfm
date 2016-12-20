<style type="text/css">
	.modal-dialog {
    	width: 900px;
    }
	.modal-content {
	    width: 900px !important;
	}
	.select2-container{
		width: 200px;
	}

</style>
<section id="widget-grid" class="" ng-app="pattern.main" ng-controller="BindAngularDirectiveCtrl as showCase">
	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Pattern</h2>

				</header>

				<!-- widget div-->
				<div>
					<!-- widget content -->
					<div class="widget-body"a>
						<input type='hidden' name="id_pattern" id="id_pattern" value="0">
						<div class="row">
							<div class="col-md-12">
								<fieldset>
									<div class="btn col-md-2 bg-color-blueDark txt-color-white pull-right" id="btnCreate" ng-click="showCase.showAddNew()" style="margin-bottom: 10px;">
                                        <i class="fa fa-save"></i>&nbsp;Add Pattern
                                    </div>
									<div class="fcontent">
										<table id="datatable_fixed_column_1" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance">
										</table>
									</div>
								</fieldset>
							</div>
						</div>
						<div class="row">
							<div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                                <div class="modal-dialog modal-width">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                            <button type="button" class="close" id="close" data-dismiss="modal" style="float:right;">&times;</button>
                                            <legend class="fcollapsible" id="titleID">Create</legend>
                                            <div class="fcontent">
                                                <form class="form-horizontal" role="form" id="order_information" name="userForm" ng-submit="showCase.submitForm()" novalidate>
													<fieldset>
														<div class="fcontent">
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="col-md-2 control-label text-left bold">Code</label>
																		<div class="col-md-3" ng-class="{'has-error':userForm.code.$invalid && !userForm.code.$pristine}">
																			<input class="form-control" placeholder="" type="text" name="code" id="code" ng-model="showCase.user.code" ng-pattern="showCase.regex"  required>
																			<p ng-show="userForm.code.$error.required && !userForm.code.$pristine" class="help-block">Code is required</p>
				                                                            <p ng-show="userForm.code.$error.pattern  && !userForm.code.$pristine" class="help-block">Can not enter special char</p>
																		</div>
																		<label class="col-md-3 control-label text-right bold">Group of Product</label>
																		<div class="col-md-3 pull-right" style="margin-right: 5px;" ng-class="{'has-error':userForm.groupProduct.$invalid && !userForm.groupProduct.$pristine}">
																			<select ui-select2 id="groupProduct" name="groupProduct" ng-model="showCase.user.groupID" data-placeholder="Choose" required>
																			    <option ng-repeat="group in showCase.groupProduct" value="{{group.id_group_products}}">{{group.gp_code}}</option>
																			</select>
																		</div>
																	</div>

																	<div class="form-group">
																		<label class="col-md-2 control-label text-left bold">Internal Note</label>
																		<div class="col-md-10">
																			<input class="form-control" placeholder="" type="text" id="internalNode" name="internalNode" ng-model="showCase.user.internalNode">
																		</div>
																	</div>

																	<div class="form-group">
																		<label class="col-md-2 control-label text-left bold">Description</label>
																		<div class="col-md-10 pull-left">
				                                                        	<ul class="nav nav-tabs">
								                                                <li ng-repeat="item in showCase.dataDes" ng-class="{'active':$first}"><a data-toggle="tab" href="##{{item.id_language}}{{item.lg_code}}">{{item.lg_code}}</a></li>
								                                            </ul>
								                                            <div class="tab-content">
								                                                <div ng-repeat="item in showCase.dataDes" id="{{item.id_language}}{{item.lg_code}}" class="tab-pane fade" ng-class="{'in active':$first}">
								                                                    <textarea class="form-control pdescription" placeholder="in {{item.lg_name}}" name="{{item.lg_code}}" id="{{item.lg_code}}{{item.id_language}}{{item.id_language}}" ng-model="item.description"></textarea>
								                                                </div>
								                                            </div>
				                                                    	</div>
																	</div>

																	<div class="form-group">
																		<div class="col-md-6">
																			<div class="form-group">
																				<label class="col-md-12 control-label text-left bold">Sketch</label>
																			</div>
																			<div class="form-group">
																				<div class="col-md-12">
																					<input type="file" style="text-align: left;" class="btn btn-default btn-block" id="sketch" name="sketch" ng-model="showCase.user.sketch" accept="image/*" onchange="angular.element(this).scope().uploadSketch(this.files)">
																				</div>
																			</div>
																			<div class="form-group" id="divImgSketch">
																				<div class="col-md-12">
																					<a href="" data-lightbox="gallery">
																						<img id="imgSketch" class="img-responsive" src="">
																					</a>
																				</div>
																			</div>
																		</div>

																		<div class="col-md-6">
																			<div class="form-group">
																				<label class="col-md-3 control-label text-left bold">Parts</label>
																			</div>
																			<div class="form-group">
																				<div class="col-md-12">
																					<input type="file" accept="image/*" class="btn btn-default btn-block" style="text-align: left;" id="parts" name="parts" ng-model="showCase.user.parts" onchange="angular.element(this).scope().uploadParts(this.files)">
																				</div>
																			</div>
																			<div class="form-group" id="divImgParts">
																				<div class="col-md-12">
																					<a href="" data-lightbox="gallery">
																						<img id="imgParts" class="img-responsive" src="">
																					</a>
																				</div>
																			</div>
																		</div>
																	</div>
																	<div class="form-group">
																		<div class="col-md-12 text-right">
																			<button class="btn bg-color-blueDark txt-color-white" id="save_order" ng-click="showCase.addRow()" ng-disabled="userForm.$invalid">
																				<i class="fa fa-save"></i>
																				&nbsp;Save
																			</button>
																			<!--- <div class="btn btn-default">
																				<i class="fa fa-sign-out"></i>
																				&nbsp;Cancel
																			</div> --->
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</fieldset>
												</form>
                                            </div>
                                        </div>
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
<script src="/includes/js/jquery.dataTables.min.js?v=#application.version#"></script>
<script src="/includes/js/dataTables.select.min.js?v=#application.version#"></script>
<script src="/includes/js/angular-datatables.min.js?v=#application.version#"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js?v=#application.version#"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js?v=#application.version#"></script>
<script src="/includes/js/views/costing.main.js?v=#application.version#"></script>
<script src="/includes/js/jquery-ui.js?v=#application.version#"></script>
<script src="/includes/js/views/pattern.main.js?v=#application.version#"></script>
</cfoutput>