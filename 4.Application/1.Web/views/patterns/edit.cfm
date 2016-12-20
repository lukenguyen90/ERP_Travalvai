<style type="text/css">
	.select2-container{
		width: 100%;
	}
	.dt-toolbar-footer{
		padding: 5px 5px;
	}
	.bold{
		font-weight: bold;
	}
	.dt-toolbar{
		padding: 6px 0px 1px;
	}
	/*.btn{
		text-align: left;
	}*/
	.modal-content {
	  background-color: #333333;
	}
	.modal-body {
	  background-color: #fff;
	}
	#modalFilterPart .modal-content,#modalFilterPart .modal-dialog{
		width: 750px;

	}
	#modalFilterPart input {
		line-height: 10px;
		width: 100px;
	}
	#modalFilterPart label>input{
		height: 32px;
	}
</style>
<section id="widget-grid" class="" ng-app="pattern.list" ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
	<div class="row">
		<article class="col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-arrow-left" style="cursor:pointer !important;" ng-click="showCase.backState()" title="Back to Pattern List"></i> </span>
					<h2> Pattern Information </h2>
				</header>

				<!-- widget div-->
				<div>

					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->

					<div class="widget-body">

						<ul id="myTab1" class="nav nav-tabs">
							<li class="active">
								<a href="##s1" data-toggle="tab">Pattern Detail</a>
							</li>
							<li id="pattern_part">
								<a href="##s4" data-toggle="tab">Pattern Part</a>
							</li>
							<li id="pattern_vari">
								<a href="##s2" data-toggle="tab">Pattern Variation</a>
							</li>
							<li>
								<a href="##s3" data-toggle="tab">Notes</a>
							</li>
						</ul>

						<input type='hidden' name="id_pattern" id="id_pattern" value="0">
						<div id="myTabContent1" class="tab-content padding-10">
							<div class="tab-pane fade in active" id="s1">
								<form class="form-horizontal" role="form" id="order_information" name="userForm" ng-submit="showCase.submitForm()" novalidate>
									<fieldset>
										<div class="fcontent">
											<div class="row">
												<div class="col-md-10">
													<div class="class"></div>
													<div class="form-group">
														<label class="col-md-2 control-label text-left bold">Created</label>
														<div class="col-md-3">
															<label class="control-label" name="craeateDate" id="craeateDate" ng-model="showCase.user.craeateDate" readonly> {{showCase.user.craeateDate}}</label>
														</div>
														<div class="col-md-2"></div>
														<label class="col-md-2 control-label text-left bold">Updated</label>
														<div class="col-md-3">
															<label class="control-label" name="updateDate" id="updateDate" ng-model="showCase.user.updateDate" readonly>{{showCase.user.updateDate}}</label>
														</div>
													</div>

													<div class="form-group">
														<label class="col-md-2 control-label text-left bold">Code</label>
														<div class="col-md-3">
															<input class="form-control" placeholder="" type="text" name="code" id="code" ng-model="showCase.user.code" ng-pattern="showCase.regex"  required>
															<p ng-show="userForm.code.$error.required && !userForm.code.$pristine" class="help-block">Code is required</p>
                                                            <p ng-show="userForm.code.$error.pattern  && !userForm.code.$pristine" class="help-block">Can not enter special char</p>
														</div>
														<div class="col-md-2"></div>
														<label class="col-md-2 control-label text-left bold">Group of Product</label>
														<div class="col-md-3">
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
																	<input type="file" accept="image/*" style="text-align: left;" class="btn btn-default btn-block" id="sketch" name="sketch" ng-model="showCase.user.sketch" onchange="angular.element(this).scope().uploadSketch(this.files)">
																</div>
															</div>
															<div class="form-group" id="divImgSketch">
																<div class="col-md-12">
																	<a href="" data-lightbox="gallery-sketch-main">
																		<img id="imgSketch" height="300" width="600" class="img-responsive" src="">
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
																	<a href="" data-lightbox="gallery-parts-main">
																		<img class="imgParts img-responsive" height="300" width="600" src="">
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
							<div class="tab-pane fade" id="s4">
								<div class="row" style="margin-bottom: 10px;">
									<div class="col-md-3">
										<label class="pull-left bold">Parts</label>
									</div>
	                            	<div class="col-md-9 text-right">
	                            		<button class="btn bg-color-blueDark txt-color-white" id="btnAddRow"  ng-click="showCase.showAddPart()">
                                            <i class="fa fa-save"></i>
                                            &nbsp;Add Part
                                        </button>
	                            	</div>
	                            </div>
								<div class="row">
									<div class="col-md-5" id="divImgParts">	
										<a href="" data-lightbox="gallery-parts-add">
											<img class="img-responsive imgParts" src="">
										</a>
									</div>
									<div class="col-md-7">
										<table id="datatable_part" class="table table-striped table-bordered table-responsive" width="100%" datatable dt-options="showCase.dtOptions3" dt-columns="showCase.dtColumns3" dt-instance="showCase.dtInstance3">
											<thead>
												<tr>
													<th rowspan="2" class="text-center">CODE</th>
													<th class="text-center" colspan="2">DESCRIPTION</th>
													<th rowspan="2" class="text-center">ACTIONS</th>
												</tr>
												<tr>
													<th></th>
													<th style="border-right-width: 1px;"></th>
												</tr>
											</thead>
										</table>
									</div>
								</div>
								<div class="modal fade" id="AddPart" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
	                                <div class="modal-dialog">
	                                    <div class="modal-content">
	                                        <div class="modal-body">
												<form class="form-horizontal" role="form" id="order_information" name="partForm" ng-submit="showCase.submitForm()" novalidate>
													<input type='hidden' name="pp_code" id="pp_code" value="">
													<div class="row">
														<div class="col-md-12">
															<fieldset>
																<legend class="fcollapsible">Add New Part</legend>
																<div class="fcontent">
																	<div class="form-group">
																    	<label class="control-label col-sm-3 text-left"><strong>Code</strong></label>
																    	<div class="col-sm-9">
																      		<input type="text" class="form-control" id="partcode" placeholder="" ng-model="showCase.user.partcode" ng-pattern="showCase.regex" required>
																      		<p ng-show="partForm.partcode.$error.required && !partForm.partcode.$pristine" class="help-block">Code is required</p>
				                                                            <p ng-show="partForm.partcode.$error.pattern  && !partForm.partcode.$pristine" class="help-block">Can not enter special char</p>
																    	</div>
																  	</div>
																  	<div class="form-group">
																    	<label class="control-label col-sm-4 text-left"><strong>Description</strong></label>
																  	</div>
																  	<div class="form-group">
			                                                            <div id="pp_en" class="row" style="margin:0px 0px 15px;">
			                                                                <label class="col-md-1 col-md-offset-2 control-label text-left"><strong>EN</strong></label>
			                                                                <div class="col-md-9" style="padding-bottom: 6px">
			                                                                    <textarea class="form-control" placeholder="in English" name="vn" id="English" rows="1" ng-model="showCase.user.pp_en"></textarea>
			                                                                </div>
			                                                            </div>
			                                                            <div id="pp_vn" class="row" style="margin:0px 0px 15px;">
			                                                                <label class="col-md-1 col-md-offset-2 control-label text-left"><strong>VN</strong></label>
			                                                                <div class="col-md-9" style="padding-bottom: 6px">
			                                                                    <textarea class="form-control" placeholder="in Vietnamese" name="vn" id="Vietnameme" rows="1" ng-model="showCase.user.pp_vn"></textarea>
			                                                                </div>
			                                                            </div>
				                                                    </div>
																  	<div class="form-group text-right" style="margin-right: 0px;">
																      	<button class="btn bg-color-blueDark txt-color-white" id="btnAddPatternPart" ng-click="showCase.addPatternPart()" ng-disabled="partForm.$invalid">
																			&nbsp;Add/Update
																		</button>
																  	</div>
																</div>
															</fieldset>
														</div>
													</div>
												</form>
											</div>
	                                    </div>
	                                </div>
	                            </div>
							</div>
							<div class="tab-pane fade" id="s2">
								<div class="row" style="margin-bottom:10px;">
									<div class="col-md-3">
										<label class="pull-left bold">Parts</label>
									</div>
	                            	<div class="col-md-9 text-right">
	                            		<button class="btn bg-color-blueDark txt-color-white" id="btnAddRow"  ng-click="showCase.showAddVar()">
                                            <i class="fa fa-save"></i>
                                            &nbsp;Add Variation
                                        </button>
	                            	</div>
	                            </div>

								
								

								<div class="modal fade" style="overflow-y: scroll;" id="Addvariation" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
	                                <div class="modal-dialog">
	                                    <div class="modal-content">
	                                        <div class="modal-body">
												<form class="form-horizontal" role="form" id="order_information" name="variForm" ng-submit="showCase.submitForm()" novalidate>
													<input type='hidden' name="id_pattern_var" id="id_pattern_var" ng-model="showCase.user.id_pattern_var">
													<div class="row">
														<div class="col-md-12">
															<legend class="fcollapsible">Add New Variation</legend>
															<div class="fcontent">
																<div class="form-group" ng-class="{'has-error':variForm.varicode.$invalid && !variForm.varicode.$pristine}">
															    	<label class="control-label col-sm-2 text-left"><strong>Code</strong></label>
															    	<div class="col-sm-10">
															      		<input type="text" class="form-control" id="varicode" name="varicode" placeholder="" ng-model="showCase.user.varicode" ng-pattern="showCase.regex"  required>
															      		<p ng-show="variForm.varicode.$error.required && !variForm.varicode.$pristine" class="help-block">Code is required</p>
				                                                        <p ng-show="variForm.varicode.$error.pattern  && !variForm.varicode.$pristine" class="help-block">Can not enter special char</p>
															    	</div>
															  	</div>
															  	<div class="form-group">
																	<label class="control-label col-sm-2 text-left"><strong>Parts</strong></label>
															    	<div class="col-sm-7">
															    		<input type="text" class="form-control" id="varipart" name="varipart" placeholder="" ng-model="showCase.user.varipart" readonly="readonly"  required>
															    	</div>
															    	<div class="col-sm-3 text-right">
															    		<div style="" class="btn bg-color-blueDark txt-color-white" id="btnVariAddRow" ng-click="showCase.showAddVariParts()">
																			&nbsp;Add Parts
																		</div>
															    	</div>
															  	</div>
															  	<div class="form-group">
															    	<label class="control-label col-sm-2 text-left"><strong>Comment</strong></label>
															    	<div class="col-sm-10">
															      		<input type="text" class="form-control" id="pv_comment" name="pv_comment" placeholder="" ng-model="showCase.user.pv_comment">
															    	</div>
															  	</div>
															  	<div class="form-group">
															    	<label class="control-label col-sm-2 text-left"><strong>Description</strong></label>
															   	</div>
															    <div class="form-group">
				                                                	<div class="col-md-10 col-md-offset-2 pull-left">
				                                                    	 <ul class="nav nav-tabs">
							                                                <li ng-repeat="item in showCase.dataDesVari" ng-class="{'active':$first}"><a data-toggle="tab" href="##{{item.id_language}}{{item.lg_code}}{{item.id_language}}{{item.id_language}}">{{item.lg_code}}</a></li>
							                                            </ul>
							                                            <div class="tab-content">
							                                                <div ng-repeat="item in showCase.dataDesVari" id="{{item.id_language}}{{item.lg_code}}{{item.id_language}}{{item.id_language}}" class="tab-pane fade" ng-class="{'in active':$first}">
							                                                    <textarea class="form-control variDescription" placeholder="in {{item.lg_name}}" name="{{item.lg_code}}" id="{{item.lg_code}}{{item.id_language}}{{item.id_language}}{{item.lg_code}}" ng-model="item.description"></textarea>
							                                                </div>
							                                            </div>
				                                                	</div>
				                                                </div>
															  	<div class="form-group">
																	<label class="col-md-2 control-label text-left"><strong>Sketch</strong></label>
																	<div class="col-md-10">
																		<input type="file" class="btn btn-default btn-block" id="varisketch" name="varisketch" ng-model="showCase.user.varisketch" onchange="angular.element(this).scope().uploadVariSketch(this.files)">
																			<!--- <p ng-show="userForm.varisketch.$error.required && !userForm.varisketch.$pristine" class="help-block">Sketch is required</p> --->
																	</div>
																</div>
																<div class="form-group">
																	<div class="col-md-2"></div>
																	<div class="col-md-8"  id="divImgVari">
																		<a href="" data-lightbox="galleryVari-add-vari">
																			<img class="img-responsive" id="imgVari" src="">
																		</a>
																	</div>
																	<div class="col-md-2"></div>
																</div>
															  	<div class="form-group text-right">
															  		<div class="col-md-12">
																      	<button class="btn bg-color-blueDark txt-color-white" id="btnVariAddRow" ng-click="showCase.addPatternVari()" ng-disabled="variForm.$invalid">
																			<i class="fa fa-save"></i>
																			&nbsp;Add/Update
																		</button>
																      	<button class="btn btn-default" id="btnVariRefresh">
																			<i class="fa fa-refresh"></i>
																			&nbsp;Refresh
																		</button>
															  		</div>
															  	</div>
															</div>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-md-5" id="divImgParts">
										<a href="" data-lightbox="gallery-part-main">
											<img class="img-responsive imgParts" src="">
										</a>
									</div>
									<div class="col-md-7">
										<table id="datatable_vari" class="table table-striped table-bordered table-responsive" width="100%" datatable dt-options="showCase.dtOptions4" dt-columns="showCase.dtColumns4" dt-instance="showCase.dtInstance4">
										</table>
									</div>
								</div>
								<div class="modal fade" id="modalFilterPart" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false" style="overflow-y:scroll;">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-body">
												<div class="row">
													<div class="col-md-7">
														<div class="table-responsive" id="modalPartsContainer">
															<table id="datatable_part_list" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions_parts" dt-columns="showCase.dtColumns_parts" dt-instance="showCase.dtInstance_parts">
											                </table>
														</div>
													</div>
													<div class="col-md-5">
														<label class="pull-left bold">Parts</label></br>
														<a href="" data-lightbox="gallery-part-poup">
															<img class="img-responsive imgParts" src="">
														</a>
													</div>
												</div>

												
											</div>
											<div class="modal-footer" style="background-color:#fff;">
												<div class="form-group text-right">
								                    <div class="col-md-12">
														<div style="margin-right:-15px">
								                        <button class="btn bg-color-blueDark txt-color-white" id="SaveVariPart" ng-click="showCase.addVariParts()">
								                           	Save
								                        </button>

														<button class="btn btn-default" id="btnCloseAddParts" ng-click="showCase.closeAddVariPartsPopup()">
								                           	Quit
								                        </button>
														</div>
								                    </div>
								                </div>
								            </div>
										</div>
									</div>
								</div>
							</div>
							<div class="tab-pane fade" id="s3">
								<div class="row">
									<div class="col-md-12 col-sm-12 col-xs-12">
										<div class="modal fade" id="addComment" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
			                                <div class="modal-dialog">
			                                    <div class="modal-content">
			                                        <div class="modal-body">
			                                        	<button type="button" class="close" id="close" data-dismiss="modal" style="float:right;">&times;</button>
			                                        	<fieldset>
															<form id="commentForm" name="commentForm" class="form-horizontal col-md-12" ng-submit="showCase.submitForm()" novalidate>
																<input type='hidden' name="id_Comment" id="id_Comment" value="0">
																<div class="form-group">
								                                    <div ckeditor="options" ng-model="showCase.ckeditor" ready="onReady()"></div>
																</div>
																<div class="form-group">
																	<div class="col-md-1">
																		<button class="btn bg-color-blueDark txt-color-white" id="btnAddComment" ng-disabled="commentForm.$invalid" ng-click="showCase.showAddNew()" style="">
																			Add/Edit Comment
																		</button>
																	</div>
																	<div style="display:none;" class="col-md-4 col-md-offset-7">
																		<input type="date" class="form-control" name="todayComment" id="todayComment" ng-model="showCase.comment.todaycomment" readonly required/>
																	</div>
																</div>
															</form>
			                                        	</fieldset>
													</div>
												</div>
											</div>
										</div>

										<div class="modal fade" id="detailComment" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
			                                <div class="modal-dialog">
			                                    <div class="modal-content">
				                                	<div class="modal-header">
				                                		<div class="row" style="padding:0px 20px;">
													        <button type="button" class="close" data-dismiss="modal">&times;</button>
													        <h4 class="modal-title" style="color:white;"><span data-ng-bind="showCase.comment.DATE"></span> by <span data-ng-bind="showCase.comment.USER"></span></h4>
				                                		</div>
												    </div>
			                                        <div class="modal-body">
														<div class="row" style="max-height:60vh; overflow-y:scroll;" id="contentComment">
															<!--- {{showCase.comment.patternnode}} --->
														</div>
													</div>
												</div>
											</div>
										</div>

										<div class="form-group margin-top-10">
											<div class="col-md-12 text-right" style="margin-top:5px;">
												<button class="btn bg-color-blueDark txt-color-white" id="save_order" ng-click="showCase.addComment()">&nbsp;Add Comment
												</button>
											</div>
										</div>

										<div class="form-group">
											<div class="table-responsive col-md-12"  style="margin-top: 15px !important;">
												<table id="datatable_notes" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions2" dt-columns="showCase.dtColumns2" dt-instance="showCase.dtInstance2">
												</table>
											</div>
										</div>


										<!--- <div ckeditor="options" ng-model="content" ready="onReady()"></div> --->


									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->

			</div>
			<!-- end widget -->

		</article>

	</div>
</section>
<cfoutput>
<script src="/includes/js/jquery.dataTables.min.js?v=#application.version#"></script>
<script src="/includes/js/angular-datatables.min.js?v=#application.version#"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js?v=#application.version#"></script>
<script src="/includes/js/views/pattern.list.js?v=#application.version#"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js?v=#application.version#"></script>

<script src="/includes/js/plugin/ckeditor/ckeditor.js?v=#application.version#"></script>
<script src="/includes/js/plugin/ckeditor/angular-ckeditor.min.js?v=#application.version#"></script>
</cfoutput>