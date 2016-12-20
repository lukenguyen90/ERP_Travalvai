<style type="text/css">	
	.select2-container{
		width:100%;
	}
	.bold{
		font-weight: bold;
	}
	.price_list .form-control[disabled], fieldset[disabled] .form-control{
   		font-size: 11px;
	}
	.price_list .form-control {
		font-size: 11px;
	}
</style>
<section id="widget-grid" class="" ng-app="product.edit" ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
	<div class="row">
		<article class="col-sm-12 col-md-12 col-lg-12">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-arrow-left" style="cursor:pointer !important;" ng-click="showCase.backState()" title="Back to Product List"></i> </span>
					<h2> Product Information </h2>
				</header>
				<div>
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->
					</div>
					<div class="widget-body">

						<ul id="myTab1" class="nav nav-tabs">
							<li class="active">
								<a href="#s1" data-toggle="tab">Product General</a>
							</li>
							<li>
								<a href="#s3" data-toggle="tab">Product Custom</a>
							</li>
							<li>
								<a href="#s2" data-toggle="tab">Price</a>
							</li>
							<!--- <li>
								<a href="#s5" data-toggle="tab">Contract</a>
							</li> --->
						</ul>

						<div id="myTabContent1" class="tab-content padding-10">
							<div class="tab-pane fade in active" id="s1">
								<form class="form-horizontal col-md-12" name="userForm" ng-submit="showCase.submitForm()" role="form" id="product_infomation" style="background-color:white;" novalidate>
									<fieldset>
										<legend class="fcollapsible">General</legend>
										<div class="fcontent">
											<div class="row">
												<div class="col-md-4">
													<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">Project</label>
												    	<div class="col-sm-8" ng-class="{'has-error':userForm.project.$invalid && !userForm.project.$pristine}">
												      		<select ui-select2 data-placeholder="Choose" id="project" name="project" ng-model="showCase.prd.project" ng-required="true" ng-change="showCase.changeProject();">
												      			<option ng-repeat="prje in showCase.projects" value={{prje.id_Project}}>{{prje.pj_description}}</option>
															</select>
															<p ng-show="userForm.project.$invalid && !userForm.project.$pristine" class="help-block">Please choose project</p>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">Product</label>
												    	<div class="col-sm-8">
												      		<input class="form-control" id="product" name="product" ng-model="showCase.prd.id_product" disabled required>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">Pattern</label>
												    	<div class="col-sm-8" ng-class="{'has-error':userForm.pattern.$invalid && !userForm.pattern.$pristine}">
												      		<select ui-select2 id="pattern" name="pattern"  ng-model="showCase.prd.pattern" ng-change="showCase.changePattern();" ng-required="true"  >
																<option value="">Choose</option>
																 <option ng-repeat="p in showCase.patterns" value="{{p.IDPATTERN}}">{{p.CODE}}{{p.DESCRIPTION != '' ? ' - ' + p.DESCRIPTION : ''}}</option>
															</select>
															<p ng-show="userForm.pattern.$invalid && !userForm.pattern.$pristine" class="help-block">Please choose pattern</p>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">P. Variation</label>
												    	<div class="col-sm-8" ng-class="{'has-error':userForm.pattern_var.$invalid && !userForm.pattern_var.$pristine}">
												      		<select ui-select2 id="pattern_var" name="pattern_var" ng-model="showCase.prd.pattern_var" required>
																<option value="">Choose</option>
																<option ng-repeat="pv in showCase.pattern_vars" value="{{pv.id_pattern_var}}">{{pv.pv_code}}</option>
															</select>
															<p ng-show="userForm.pattern_var.$invalid && !userForm.pattern_var.$pristine" class="help-block">Please choose pattern Variation</p>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">Version</label>
												    	<div class="col-sm-8" ng-class="{'has-error':userForm.pr_version.$invalid && !userForm.pr_version.$pristine}">
												      		<input class="form-control" type="number" name="pr_version" id="pr_version" ng-model="showCase.prd.pr_version" required ng-pattern="showCase.regexNumber">
												      		<p ng-show="userForm.pr_version.$error.required && !userForm.pr_version.$pristine" class="help-block">Version of product is required</p>
                                    						<p ng-show="userForm.pr_version.$error.pattern  && !userForm.pr_version.$pristine" class="help-block">Can not enter special char</p>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">Description</label>
												    	<div class="col-sm-8">
												      		<input type="text" class="form-control" id="pr_description" name="pr_description" ng-model="showCase.prd.pr_description" placeholder="">
												    	</div>
												  	</div>
												  	<div class="form-group" ng-class="{'has-error':userForm.plz_id.$invalid && !userForm.plz_id.$pristine}" id="divPrlz">
						                                <label class="control-label col-md-4 text-left bold">Price List</label>
						                                <div class="col-md-8">
						                                    <label class="control-label" style="padding-left:10px;">{{showCase.plz_des}}</label>
						                                </div>
						                            </div>
												</div>
												<div class="col-md-4">
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">Cost Code</label>
												    	<div class="col-sm-8" ng-class="{'has-error':userForm.cost.$invalid && !userForm.cost.$pristine}">
												      		<select ui-select2 id="cost" name="cost" ng-model="showCase.prd.cost" ng-required="true" ng-change="showCase.changecost_season();">
												      			<option value="">Choose</option>
																<option ng-repeat="icost in showCase.costs" value="{{icost.id_cost}}" >{{icost.cost_code}}</option>
															</select>
															<p ng-show="userForm.cost.$invald && !userForm.cost.$pristine" class="help-block">Please choose costing</p>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">Cost Code Ver</label>
												    	<div class="col-sm-8" ng-class="{'has-error':userForm.cost_version.$invalid && !userForm.cost_version.$pristine}">
												      		<select ui-select2 id="cost_version" name="cost_version" ng-model="showCase.prd.cost_version" required >
																<option value="">Choose</option>
																<option ng-repeat="c_v in showCase.cost_vs" value="{{c_v.id_cost_version}}">{{c_v.cv_version}}</option>
															</select>
															<p ng-show="userForm.cost_version.$invalid && !userForm.cost_version.$pristine" class="help-block">Please choose costing version</p>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">Sizes</label>
												    	<div class="col-sm-8" ng-class="{'has-error':userForm.sz.$invalid && !userForm.sz.$pristine}">
												      		<select ui-select2 id="sz" name="sz" ng-model="showCase.prd.sz"required>
																<option value="">Choose</option>
																<option ng-repeat="s in showCase.sizes" value="{{s.id_size}}">{{s.sz_description}}</option>
															</select>
															<p ng-show="userForm.sz.$invalid && !userForm.sz.$pristine" class="help-block">Please choose size</p>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">Date</label>
												    	<div class="col-sm-8">
												      		<input type="text" class="form-control dateInput" id="pr_date" name="pr_date" ng-model="showCase.prd.pr_date" placeholder="">
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">Update</label>
												    	<div class="col-sm-8">
												      		<input type="text" class="form-control dateInput" id="pr_date_update" name="pr_date_update" ng-model="showCase.prd.pr_date_update" placeholder="">
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">Contract</label>
												    	<div class="col-sm-8">
												    		<select ui-select2 id="prdContract" name="prdContract" ng-model="showCase.prd.contract" ng-change="showCase.getFinalPrice()" >
																<option value="0"> None </option>
																<option ng-repeat="con in showCase.contract" value="{{con.id_contract}}">{{con.id_contract}} - {{con.c_description}}</option>
															</select>
												    	</div>
												  	</div>
												</div>
												<div class="col-md-4">
													<div class="form-group" ng-class="{'has-error':userForm.pr_web.$invalid && !userForm.pr_web.$pristine}">
												    	<label class="control-label col-sm-4 text-left bold">Web</label>
												    	<div class="col-sm-8">
												    		<select ui-select2 id="pr_web" name="pr_web" ng-model="showCase.prd.pr_web" required>
																<option value="0">NO</option>
																<option value="1">YES</option>
															</select>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">Zone</label>
												    	<div class="col-sm-8">
												      		<input type="text" class="form-control" id="z_description" name="z_description" ng-model="showCase.prd.z_description" disabled>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">Agent</label>
												    	<div class="col-sm-8">
												      		<input type="text" class="form-control" id="ag_description" name="ag_description" ng-model="showCase.prd.ag_description" disabled>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">Customer</label>
												    	<div class="col-sm-8">
												      		<input type="text" class="form-control" id="cs_name" name="cs_name" ng-model="showCase.prd.cs_name" disabled>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left bold">Section</label>
												    	<div class="col-sm-8">
												      		<input type="text" class="form-control" id="pr_section" name="pr_section" ng-model="showCase.prd.pr_section">
												    	</div>
												  	</div>
												  	<div class="form-group" ng-class="{'has-error':userForm.product_status.$invalid && !userForm.product_status.$pristine}">
												    	<label class="control-label col-sm-4 text-left bold">Status</label>
												    	<div class="col-sm-8">
												    		<select ui-select2 id="product_status" name="product_status" ng-model="showCase.prd.product_status" required>
																<option value="">Choose</option>
																<option ng-repeat="pst in showCase.PrStts" value="{{pst.ID}}">{{pst.DES}}</option>
															</select>
															<p ng-show="userForm.product_status.$invalid && !userForm.product_status.$pristine" class="help-block">Please choose product status</p>
												    	</div>
												  	</div>
												</div>
											</div>
										</div>
									</fieldset>
									<fieldset>
										<legend class="fcollapsible">Images</legend>
										<div class="fcontent">
											<div class="row">
												<div class="col-md-6">
													<div class="form-group">
														<div class="col-md-12">
															<label class="col-md-2 control-label text-left bold">Sketch</label>
															<div class="col-md-10">
																<input style="width: 60%"type="file" accept="image/*" class="btn btn-default btn-block" multiple onchange="angular.element(this).scope().uploadFileSketch(this.files)" id="pr_sketch" name="pr_sketch">
															</div>
														</div>
														<div>&nbsp;</div>
														<div class="col-md-12">
															<label class="col-md-2 control-label text-left bold">&nbsp;</label>
															<div class="col-md-10">
																<a href="/includes/img/ao/{{showCase.prd.pr_sketch}}" data-lightbox="gallery_sketch">
																<img class="img-responsive" src="/includes/img/ao/{{showCase.prd.pr_sketch}}" width="60%" height="50%">
																</a>
															</div>
														</div>
													</div>
												</div>

												<div class="col-md-6">
													<div class="form-group">														
														<div class="col-md-12">
															<label class="col-md-2 control-label text-left bold">Picture</label>
															<div class="col-md-10">
																<input style="width: 60%" type="file" accept="image/*" class="btn btn-default btn-block" id="pr_picture" name="pr_picture" multiple onchange="angular.element(this).scope().uploadFilePicture(this.files)">
															</div>
														</div>
														<div>&nbsp;</div>
														<div class="col-md-12">
															<label class="col-md-2 control-label text-left bold">&nbsp;</label>
															<div class="col-md-10">
																<a href="/includes/img/ao/{{showCase.prd.pr_picture}}" data-lightbox="gallery_picture">
																	<img class="img-responsive" src="/includes/img/ao/{{showCase.prd.pr_picture}}" width="60%" height="50%">
																</a>
															</div></div>
													</div>
												</div>
											</div>
										</div>
									</fieldset>
									<div class="row form-actions" style="margin:0px;">
										<div class="col-md-12 text-right">
											<button class="btn bg-color-blueDark txt-color-white" id="btnAddRow"  ng-click="showCase.saveProduct()" ng-disabled="userForm.$invalid">
												<i class="fa fa-save"></i>
												&nbsp;Save
											</button>
										</div>
									</div>
								</form>
							</div>
							<div class="tab-pane fade" id="s2">
								<form class="form-horizontal col-md-12" name="priceForm" ng-submit="showCase.submitForm()" role="form" id="product_infomation" style="background-color:white;" novalidate>
									<fieldset>
										<div class="fcontent">
											<div class="row price_list">
												<div class="col-md-3">
													<div class="form-group">
												    	<label class="control-label col-sm-6 text-left bold">&nbsp;</label>
												    	<label class="control-label col-sm-6 text-left bold">On Price List</label>
												  	</div>
												  	<div class="form-group" id="factoryPriceList">
												    	<label class="control-label col-sm-5 text-left bold">Factory Price</label>
												    	<div class="col-sm-7 pull-right" style="width: 55.6%;">
												      		<span class="form-control" id="fty_sell_4" name="fty_sell_4" min="0" ng-bind="formatNumberThousand(showCase.prd.fty_sell_4) + ' - ' + showCase.plf_currency" disabled></span>
												    	</div>
												  	</div>
												  	<div class="form-group" id="agentPriceList">
												    	<label class="control-label col-sm-5 text-left bold">Agent Price</label>
												    	<div class="col-sm-7 pull-right" style="width: 55.6%;">
												      		<span class="form-control" id="plzd_zone_sell_6" name="plzd_zone_sell_6" min="0" ng-bind="formatNumberThousand(showCase.prd.plzd_zone_sell_6)+ ' - ' + showCase.plz_currency" disabled></span>

												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-5 text-left bold">Final Price</label>
												    	<div class="col-sm-7 pull-right" style="width: 55.6%;">
												      		<span class="form-control" id="plzd_pvpr_8" name="plzd_pvpr_8" min="0" ng-bind="formatNumberThousand(showCase.prd.plzd_pvpr_8)+ ' - ' + showCase.plz_currency" disabled></span>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-5 text-left bold">Club Price</label>
												    	<div class="col-sm-7 pull-right" style="width: 55.6%;">
												      		<!--- <input type="text" class="form-control" id="" placeholder=""> --->
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-5 text-left bold">Web Price</label>
												    	<div class="col-sm-7 pull-right" style="width: 55.6%;">
												      		<!--- <input type="text" class="form-control" id="" placeholder=""> --->
												    	</div>
												  	</div>
												</div>
												<div class="col-md-9">
													<div class="form-group">
												    	<label class="control-label col-sm-3 text-center bold">Manual</label>
												    	<label class="control-label col-sm-3 text-center bold">Custom</label>
												    	<label class="control-label col-sm-3 text-center bold">Total Price</label>
												    	<label class="control-label col-sm-3 text-center bold">Commission</label>
												  	</div>
												  	<div class="form-group" id="factoryPriceManual_Valid">
												    	<div class="col-sm-3" ng-class="{'has-error':priceForm.pr_fty_sell_9.$invalid && !priceForm.pr_fty_sell_9.$pristine}">
												      		<input type="number" class="form-control" id="pr_fty_sell_9" name="pr_fty_sell_9" ng-model="showCase.prd.pr_fty_sell_9" ng-pattern="showCase.regexNumber" ng-change="showCase.onChangeFactoryPriceManual()" min="0">
                                    						<p ng-show="priceForm.pr_fty_sell_9.$error.pattern  && !priceForm.pr_fty_sell_9.$pristine" class="help-block">Can not enter special char</p>
												    	</div>
												    	<div class="col-sm-3">
												      		<span class="form-control" id="plFactoryCus" name="plFactoryCus" min="0" ng-bind="formatNumberThousand(showCase.prd.plFactoryCus)+ ' - ' + showCase.plf_currency" disabled></span>
												    	</div>
												    	<div class="col-sm-3">
												      		<span class="form-control" id="pr_9_valid" name="pr_9_valid" min="0" ng-bind="formatNumberThousand(showCase.prd.pr_9_valid)+ ' - ' + showCase.plf_currency" disabled></span>
												    	</div>
												  	</div>
												  	<div class="form-group" id="agentPriceManual_Valid">
												    	<div class="col-sm-3">
												      		<input type="number" class="form-control" id="pr_zone_sell_10" name="pr_zone_sell_10" ng-model="showCase.prd.pr_zone_sell_10" ng-pattern="showCase.regexNumber" ng-change="showCase.onChangeAgentPriceManual()" min="0">
												    	</div>
												    	<div class="col-sm-3">
												      		<span class="form-control" id="plZoneCus" name="plZoneCus" min="0" ng-bind="formatNumberThousand(showCase.prd.plZoneCus)+ ' - ' + showCase.plz_currency" disabled></span>
												    	</div>
												    	<div class="col-sm-3">
												      		<span class="form-control" id="pr_10_valid" name="pr_10_valid" min="0" ng-bind="formatNumberThousand(showCase.prd.pr_10_valid) + ' - ' + showCase.plz_currency" disabled></span>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<div class="col-sm-3" ng-class="{'has-error':priceForm.pr_fty_sell_9.$invalid && !priceForm.pr_fty_sell_9.$pristine}">
												      		<input type="number" class="form-control" id="pr_pvpr_11" name="pr_pvpr_11" ng-model="showCase.prd.pr_pvpr_11"  ng-pattern="showCase.regexNumber" ng-change="showCase.onChangeFinalPriceManual()" min="0">
												      		<p ng-show="priceForm.pr_pvpr_11.$error.pattern  && !priceForm.pr_pvpr_11.$pristine" class="help-block">Can not enter special char</p>
												    	</div>
												    	<div class="col-sm-3">
												      		<span class="form-control" id="plFinalCus" name="plFinalCus" min="0" ng-bind="formatNumberThousand(showCase.prd.plFinalCus)+ ' - ' + showCase.plz_currency" disabled></span>
												    	</div>
												    	<div class="col-sm-3">
												      		<span class="form-control" id="pr_11_valid" name="pr_11_valid" min="0" ng-bind="formatNumberThousand(showCase.prd.pr_11_valid)+ ' - ' + showCase.plz_currency" disabled></span>
												    	</div>
												    	<div class="col-sm-3">
												      		<input type="number" class="form-control col-sm-2" id="pr_commission" name="pr_commission" ng-model="showCase.prd.pr_commission" ng-pattern="showCase.regexNumber" min="0" style="width: 82%">
												      		<span class="col-sm-1" style="margin-top: 17px;">%</span>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<div class="col-sm-3">
												      		<input type="number" class="form-control" id="pr_club_12" name="pr_club_12" ng-model="showCase.prd.pr_club_12" ng-pattern="showCase.regexNumber" ng-change="showCase.onChangeFinalPriceClub()" min="0">
												      		<p ng-show="priceForm.pr_club_12.$error.pattern  && !priceForm.pr_club_12.$pristine" class="help-block">Can not enter special char</p>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<div class="col-sm-3">
												      		<input type="number" class="form-control" id="pr_web_13" name="pr_web_13" ng-model="showCase.prd.pr_web_13" ng-pattern="showCase.regexNumber" ng-change="showCase.onChangeFinalPriceWeb()" min="0">
												      		<p ng-show="priceForm.pr_web_13.$error.pattern  && !priceForm.pr_web_13.$pristine" class="help-block">Can not enter special char</p>
												    	</div>
												  	</div>
												</div>												
											</div>
											<div class="row">
												<div class="col-md-1">
													<label class="control-label text-left bold">Comment</label>
												</div>
												<div class="col-md-11">
												     <input type="text" class="form-control" name="pr_comment" id="pr_comment" ng-model="showCase.prd.pr_comment" style="width: 97.2%; margin-left: 26px; margin-bottom: 25px;">
												</div>
											</div>	
										</div>
									</fieldset>
									<div class="row form-actions" style="margin:0px;">
										<div class="col-md-12 text-right">
											<button class="btn bg-color-blueDark txt-color-white" id="btnAddRow"  ng-click="showCase.saveProduct()" ng-disabled="priceForm.$invalid">
												<i class="fa fa-save"></i>
												&nbsp;Save
											</button>
										</div>
									</div>
								</form>
							</div>
							<div class="tab-pane fade" id="s3">
								<div class="row">
									<div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-body">
													<legend class="fcollapsible" id="titleID">Create</legend>
													<div class="fcontent">
														<form class="form-horizontal" role="form" id="product_cust" name="productCustForm" ng-submit="showCase.submitForm()" novalidate>
															<input type="hidden" id="id_prdcust" value="0">
															<div class="form-group">
																<label class="control-label col-md-3 text-left bold">Price List</label>
								                                <div class="col-md-5" ng-class="{'has-error':productCustForm.plz_id_cus.$invalid && !productCustForm.plz_id_cus.$pristine}">
								                                    <select  ui-select2 id="plz_id_cus" name="plz_id_cus" ng-model="showCase.product_custom.plz_id" data-placeholder="Choose" ng-change="showCase.changePriceListZoneCus();" ng-disabled="showCase.isDisPriceCus" required>
								                                        <option value="">Choose</option>
								                                        <option ng-repeat="pj in showCase.plz_id" value="{{pj.id_plz}}">{{pj.des}}</option>
								                                    </select>
								                                    <p ng-show="productCustForm.plz_id_cus.$error.required && !productCustForm.plz_id_cus.$pristine" class="help-block">Price list is required</p>
																</div>
															</div>
															<div class="form-group">
																<label class="col-md-3 control-label text-left bold">Code</label>
																<div class="col-md-5" ng-class="{'has-error':productCustForm.costsCST_Id.$invalid && !productCustForm.costsCST_Id.$pristine}">
																	<select ui-select2 id="costsCST_Id" name="costsCST_Id" ng-model="showCase.product_custom.costsCSTid" data-placeholder="Choose" required ng-change="showCase.changeCost_prdCus();">
																		<option value="">Choose</option>
																	    <option ng-repeat="cost in showCase.costsCST" value="{{cost.id_cost}}">{{cost.cost_code}}</option>
																	</select>
																	<p ng-show="productCustForm.costsCST_Id.$error.required && !productCustForm.costsCST_Id.$pristine" class="help-block">Code is required</p>
																</div>
															</div>
															<div class="form-group display-none">
																<label class="col-md-3 control-label text-left bold">Version</label>
																<div class="col-md-5" ng-class="{'has-error':productCustForm.cv_CST_id.$invalid && !productCustForm.cv_CST_id.$pristine}">
																	<select ui-select2 id="cv_CST_id" name="cv_CST_id" ng-model="showCase.product_custom.cvCSTid" data-placeholder="Choose" required>
																		<option value="">Choose</option>
																	    <option ng-repeat="costvs in showCase.costsVS_CST" value="{{costvs.id_cost_version}}">{{costvs.cv_version}}</option>
																	</select>
																	<p ng-show="productCustForm.cv_CST_id.$error.required && !productCustForm.cv_CST_id.$pristine" class="help-block">Version is required</p>
																</div>
															</div>
															<div class="form-group">
														    	<label class="control-label col-md-3 text-left bold">QTTY</label>
														    	<div class="col-md-5" ng-class="{'has-error':productCustForm.quantity_cus.$invalid && !productCustForm.quantity_cus.$pristine}">
														      		 <input class="form-control" placeholder="" min="1" type="number" name="quantity_cus" id="quantity_cus" ng-pattern="showCase.regexNumber" ng-model="showCase.product_custom.quantity_cus" ng-disabled="showCase.isDisPriceQuantity" required>
														      		 <p ng-show="productCustForm.quantity_cus.$error.required && !productCustForm.quantity_cus.$pristine" class="help-block">QTTY is required</p>
					                                                <p ng-show="productCustForm.quantity_cus.$error.pattern && !productCustForm.quantity_cus.$pristine" class="help-block">Can not enter special char</p>
														    	</div>
															</div>
															<div class="form-group">
														  		<label class="control-label col-md-3 text-left bold">Description</label>
														    	<div class="col-md-5">
														      		<input type="text" class="form-control" id="description_cus" name="description_cus" ng-model="showCase.product_custom.description_cus" placeholder="Description" ng-disabled="showCase.isDisDescription">
														    	</div>
															</div>	
															<div class="form-group text-center">
																<button class="btn bg-color-blueDark txt-color-white" id="save_prd_cust" ng-click="showCase.addPrdCus()" ng-disabled="productCustForm.$invalid">
																	<i class="fa fa-save"></i>
																	&nbsp;Save
																</button>
														      	<button class="btn btn-default" id="btnRefresh" ng-click="showCase.refreshCus()">
																	<i class="fa fa-refresh"></i>
																	&nbsp;Refresh
																</button>
															</div>
														</form>		
													</div>
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
											<table id="datatable_cus" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptionsCus" dt-columns="showCase.dtColumnsCus" dt-instance="showCase.dtInstanceCus">
											</table>
										</div>
									</fieldset>
								</div>	

								<div class="modal fade" id="showDelete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
									<div class="modal-dialog" id="modalForm">
										<div class="modal-content">
											<div class="modal-header alert-info">
												<h3 class="modal-title" id="myModalLabel">Are you sure you want to delete this item?</h3>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
												<button type="submit" id="butsubmit" class="btn btn-info" ng-click="showCase.deleteProductCus()">Yes</button>
											</div>
										</div>
									</div>
								</div>	
								<!--- <input type="hidden" id="id_prdcust" value="0">
								<form class="form-horizontal" role="form" id="product_cust" name="productCustForm" ng-submit="showCase.submitForm()" novalidate>
									<div class="fcontent">
										<div class="row">
											<div class="form-group">
												<div class="col-md-4">
													<label class="control-label col-md-4 col-sm-4 text-left bold">Price List</label>
					                                <div class="col-md-8 col-sm-8" ng-class="{'has-error':productCustForm.plz_id_cus.$invalid && !productCustForm.plz_id_cus.$pristine}">
					                                	<label>{{showCase.plz_des}}</label>
					                                </div>
												</div>

												<div class="col-md-4">
													<label class="col-md-4 col-sm-4 control-label text-left bold">Code</label>
													<div class="col-md-8 col-sm-8" ng-class="{'has-error':productCustForm.costsCST_Id.$invalid && !productCustForm.costsCST_Id.$pristine}">
														<select ui-select2 id="costsCST_Id" style="width: 200px !important;" name="costsCST_Id" ng-model="showCase.product_custom.costsCSTid" data-placeholder="Choose" required ng-change="showCase.changeCost_prdCus();">
															<option value="">Choose</option>
														    <option ng-repeat="cost in showCase.costsCST" value="{{cost.id_cost}}">{{cost.cost_code}}</option>
														</select>
														<p ng-show="productCustForm.costsCST_Id.$error.required && !productCustForm.costsCST_Id.$pristine" class="help-block">Code is required</p>
													</div>
												</div>

												<div class="col-md-4 display-none">
													<label class="col-md-4 col-sm-4 control-label text-left bold">Version</label>
													<div class="col-md-8 col-sm-8" ng-class="{'has-error':productCustForm.cv_CST_id.$invalid && !productCustForm.cv_CST_id.$pristine}">
														<select ui-select2 id="cv_CST_id" name="cv_CST_id" style="width: 200px !important;" ng-model="showCase.product_custom.cvCSTid" data-placeholder="Choose" required>
															<option value="">Choose</option>
														    <option ng-repeat="costvs in showCase.costsVS_CST" value="{{costvs.id_cost_version}}">{{costvs.cv_version}}</option>
														</select>
														<p ng-show="productCustForm.cv_CST_id.$error.required && !productCustForm.cv_CST_id.$pristine" class="help-block">Version is required</p>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="col-md-4">
											    	<label class="control-label col-md-4 col-sm-4 text-left bold">QTTY</label>
											    	<div class="col-md-8 col-sm-8" ng-class="{'has-error':productCustForm.quantity_cus.$invalid && !productCustForm.quantity_cus.$pristine}">
											      		 <input class="form-control" placeholder="" min="1" type="number" style="width: 200px !important;" name="quantity_cus" id="quantity_cus" ng-pattern="showCase.regexNumber" ng-model="showCase.product_custom.quantity_cus" required>
											      		 <p ng-show="productCustForm.quantity_cus.$error.required && !productCustForm.quantity_cus.$pristine" class="help-block">QTTY is required</p>
		                                                <p ng-show="productCustForm.quantity_cus.$error.pattern && !productCustForm.quantity_cus.$pristine" class="help-block">Can not enter special char</p>
											    	</div>
											  	</div>
											  	<div class="col-md-4">
											  		<label class="control-label col-md-4 col-sm-4 text-left bold">Description</label>
											    	<div class="col-sm-8 col-md-8">
											      		<input type="text" class="form-control" id="description_cus" name="description_cus" ng-model="showCase.product_custom.description_cus" placeholder="Description">
											    	</div>
											  	</div>
											</div>
									</div>
									<div class="row">
										<div class="col-sm-12 text-right">
									      	<div class="btn bg-color-blueDark txt-color-white" id="save_prd_cust" ng-click="showCase.addPrdCus()" ng-disabled="productCustForm.$invalid">
												<i class="fa fa-save"></i>
												&nbsp;Add/Update
											</div>
									      	<div class="btn btn-default" id="" ng-click="showCase.refreshCus()">
												<i class="fa fa-refresh"></i>
												&nbsp;Refresh
											</div>
									    </div>
									</div>
									<fieldset>
										<legend class="fcollapsible">Product Custom List</legend>
										<div class="fcontent">
											<div class="table-responsive">
												<table id="datatable_cus" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptionsCus" dt-columns="showCase.dtColumnsCus" dt-instance="showCase.dtInstanceCus">
												</table>
											</div>
										</div>
									</fieldset>
								</form> --->
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
<script src="/includes/js/jquery-ui.js?v=#application.version#"></script>
<script src="/includes/js/jquery.dataTables.min.js?v=#application.version#"></script>
<script src="/includes/js/angular-datatables.min.js?v=#application.version#"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js?v=#application.version#"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js?v=#application.version#"></script>
<script src="/includes/js/views/product.edit.js?v=#application.version#"></script>

</cfoutput>

<script type="text/javascript">
	$(document).ready(function() {
		$(".dateInput").datepicker({
    dateFormat:'dd/mm/yy'
});
	})
</script>