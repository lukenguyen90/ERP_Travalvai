<style type="text/css">
	.select2-container {
	    width: 100%;
	}
	.fc-border-separate thead tr, .table thead tr {
		font-size: 10px;
	}



	.jarviswidget > div {
		font-size: 11px;

	}

	.jarviswidget > div table tbody{
		font-size: 12px;

	}

	label {
	    	font-weight: bold;
	    }

	.inverseNumber {
		 background-color: #f2f2f2;
	        border: 0 none;
	        margin-top: -14px;

	}
	.date {
		margin-top: 14px;
	}
	input.label1{
	        background-color: #fff !important;
	        border: 0px;
	    }

	th.th-align-left {
		text-align: left !important;
	}
	th.th-align-center {
		text-align: center !important;
	}
	tr > th{
	   background-color: #F4F4F4 !important;
	}
</style>
<section id="widget-grid" class="" ng-app="price_list_zone_detail" ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
    <div class="row">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
                <header >
                    <span class="widget-icon"> <i class="fa fa-arrow-left" style="cursor:pointer !important;" title="Back to Price List Zone" ng-click="showCase.backState()"></i> </span>
                    <h2>Price List Zone Detail</h2>
                </header>
                <div>
                    <div class="widget-body">
                        <div class="row">
                        	<fieldset>
                            	<legend class="fcollapsible" style="padding-left:10px;">General Information</legend>
                            	<div class="fcontent">
									<form class="form-horizontal col-md-12" name="userForm" id="userForm" ng-submit="showCase.submitForm()" novalidate>
										<input type="hidden" id="id_plz" name="id_plz" value="0" />
										<div class="row">
				                            <div class="col-md-3">
				                            	<div class="form-group">
											    	<label class="control-label  col-sm-6 text-left">P.L. CODE</label>
											    	<div class="col-sm-6">
											    		<input class="form-control" type="text" name="plz_code" id="plz_code" ng-model="showCase.user.plz_code">
										    		</div>
									    		</div>
									    		<div class="form-group">
											    	<label class="control-label col-sm-6 text-left">DESCRIPTION</label>
											    	<div class="col-sm-6">
											    		<input class="form-control" type="text" name="plz_description" id="plz_description" ng-model="showCase.user.plz_description">
										    		</div>
									    		</div>
									    		<div class="form-group" ng-class="{'has-error':userForm.plz_season.$invalid && !userForm.plz_season.$pristine}">
											    	<label class="control-label col-sm-6 text-left">SEASON</label>
											    	<div class="col-sm-6">
											    		<select ui-select2 id="plz_season" name="plz_season" ng-model="showCase.user.plz_season" data-placeholder="Choose" ng-required="true">
											    			<option value="">Choose</option>
															<option ng-repeat="season in showCase.seasons" value="{{season}}">{{season}}</option>
														</select>
			                                            <p ng-show="userForm.plz_season.$invalid && !userForm.plz_season.$pristine" class="help-block">Please choose Season</p>
										    		</div>
									    		</div>
									    		<div class="form-group" ng-class="{'has-error':userForm.plf_code.$invalid && !userForm.plf_code.$pristine}">
											    	<label class="control-label col-sm-6 text-left">P.L. FACTORY</label>
											    	<div class="col-sm-6">
											    		<input class="form-control" type="text" name="plf_code" id="plf_code" ng-model="showCase.user.plf_code" disabled>
			                                           <!---  <select ui-select2 id="plf_code" name="plf_code" ng-model="showCase.user.plf_code" data-placeholder="Choose" ng-required="true" disabled>
															<option ng-repeat="lang in showCase.plftys" value="{{lang.ID}}">{{lang.CODE}}</option>
														</select>
			                                            <p ng-show="userForm.plf_code.$invalid && !userForm.plf_code.$pristine" class="help-block">Please choose PL factory</p> --->
										    		</div>
									    		</div>
									    		<div class="form-group" ng-class="{'has-error':userForm.language.$invalid && !userForm.language.$pristine}">
											    	<label class="control-label col-sm-6 text-left">LANGUAGE</label>
											    	<div class="col-sm-6">
			                                            <select ui-select2 id="language" name="language" ng-model="showCase.user.language" data-placeholder="Choose" ng-required="true">
															<option ng-repeat="lang in showCase.languages" value="{{lang.id_language}}">{{lang.lg_name}}</option>
														</select>
			                                            <p ng-show="userForm.language.$error.required && !userForm.language.$pristine" class="help-block">Please choose language</p>
			                                        </div>
									    		</div>
				                            </div>
				                            <div class="col-md-6">
				                            	<div class="row">
					                            	<div class="col-md-6">
						                            	<div class="form-group">
													    	<label class="control-label col-sm-6 text-left">P.L.F. CURRENCY</label>
													    	<div class="col-sm-6">
													    		<input class="form-control label1" type="text" name="plf_curr_code" id="plf_curr_code" ng-model="showCase.user.plf_curr_code" disabled="disabled">
												    		</div>
											    		</div>
											    		<div class="form-group" ng-class="{'has-error':userForm.plz_curr.$invalid && !userForm.plz_curr.$pristine}">
													    	<label class="control-label col-sm-6 text-left">P.L.Z. CURRENCY</label>
													    	<div class="col-sm-6">
					                                            <select ui-select2 id="plz_curr" name="plz_curr" ng-model="showCase.user.plz_curr" data-placeholder="Choose" ng-required="true" ng-change="showCase.changePLC()">
																	<option ng-repeat="lang in showCase.currencylist" value="{{lang.id_currency}}">{{lang.curr_code}}</option>
																</select>
					                                            <p ng-show="userForm.plz_curr.$invalid && !userForm.plz_curr.$pristine" class="help-block">Please choose Currency</p>
												    		</div>
											    		</div>
											    		<div class="form-group" ng-class="{'has-error':userForm.plz_ex_rate_1.$invalid && !userForm.plz_ex_rate_1.$pristine}">
													    	<label class="control-label col-sm-6 text-left">EX. RATE (<span data-ng-bind="showCase.user.plf_curr_code"></span>/<span data-ng-bind="showCase.user.plz_curr_code"></span>)</label>
													    	<div class="col-sm-6">
													    		<input class="form-control label1" type="text" name="plz_ex_rate_1" id="plz_ex_rate_1" 	 ng-model="showCase.user.plz_ex_rate_1" disabled>
												    		</div>
											    		</div>
											    		<div class="form-group">
											    			<div class="col-sm-6 col-sm-offset-6">


													    		<label class="form-control inverseNumber" style="border:0px; font-weight:normal" data-ng-bind="showCase.user.convert_plz_ex_rate_1"></label>
												    		</div>
											    		</div>

														<div class="form-group">
															<div class="date">
														    	<label class="control-label col-sm-6 text-left">CREATION DATE</label>
														    	<div class="col-sm-6">
														    		<input class="form-control label1" type="text" name="plz_date" id="plz_date" ng-model="showCase.user.plz_date" disabled>
													    		</div>
												    		</div>
											    		</div>

					                            	</div>
					                            	<div class="col-md-6">
					                            		<div class="form-group" ng-class="{'has-error':userForm.plf_cc_ex_rate.$invalid && !userForm.plf_cc_ex_rate.$pristine}">
													    	<label class="control-label col-sm-6 text-left">EX. RATE (USD/<span data-ng-bind="showCase.user.plf_curr_code"></span>)</label>
													    	<div class="col-sm-6">
													    		<input class="form-control label1" type="text" name="plf_cc_ex_rate" id="plf_cc_ex_rate" ng-model="showCase.user.plf_cc_ex_rateShow" disabled>
												    		</div>
											    		</div>
											    		<div class="form-group">
													    	<label class="control-label col-sm-6 text-left">EX. RATE (USD/<span data-ng-bind="showCase.user.plz_curr_code"></span>)</label>
													    	<div class="col-sm-6">
													    		<input class="form-control label1" type="text" name="cc_value" id="cc_value" ng-model="showCase.user.cc_valueShow" disabled>
												    		</div>
											    		</div>
											    		<div class="form-group" ng-class="{'has-error':userForm.plz_ex_rate.$invalid && !userForm.plz_ex_rate.$pristine}">
													    	<label class="control-label col-sm-6 text-left">MANUAL EX. RATE</label>
													    	<div class="col-sm-6">
													    		<input class="form-control" type="text" name="plz_ex_rate" id="plz_ex_rate" ng-pattern="showCase.regexNumber"	 ng-model="showCase.user.plz_ex_rate" required>
													    		 <p ng-show="userForm.plz_ex_rate.$error.pattern && !userForm.plz_ex_rate.$pristine" class="help-block">It must contain numeric character only</p>
												    		</div>
											    		</div>
											    		<div class="form-group">
											    			<div class="col-sm-6 col-sm-offset-6">
													    		<label class="form-control inverseNumber" style="border:0px; font-weight:normal" data-ng-bind="showCase.user.convert_plz_ex_rate"></label>
												    		</div>
											    		</div>

											    		<div class="form-group">
											    			<div class="date">
														    	<label class="control-label col-sm-6 text-left">LAST UPDATE </label>
														    	<div class="col-sm-6">
														    		<input class="form-control label1" type="text" name="plz_update" id="plz_update" ng-model="showCase.user.plz_update" disabled>
													    		</div>
													    	</div>
											    		</div>
					                            	</div>
				                            	</div>

				                            </div>
				                            <div class="col-md-3">
				                            	<!--- <div class="form-group" ng-class="{'has-error':userForm.plz_correction.$invalid && !userForm.plz_correction.$pristine}">
											    	<label class="control-label col-sm-7 text-left">CORRECTION ( % )</label>
											    	<div class="col-sm-5">
											    		<input class="form-control" type="text" name="plz_correction" id="plz_correction" ng-model="showCase.user.plz_correction" ng-pattern="showCase.regexNumber" required>
											    		<p ng-show="userForm.plz_ex_rate.$error.required && !userForm.plz_ex_rate.$pristine" class="help-block">Correction is required</p>
											    		<p ng-show="userForm.plz_correction.$error.pattern" class="help-block">It must contains only numberic</p>
										    		</div>
									    		</div> --->
									    		<div class="form-group" ng-class="{'has-error':userForm.plz_commission.$invalid && !userForm.plz_commission.$pristine}">
											    	<label class="control-label col-sm-7 text-left">COMMISSION ( % )</label>
											    	<div class="col-sm-5">
											    		<input class="form-control" type="text" ng-pattern="showCase.regexNumber" name="plz_commission" id="plz_commission" ng-model="showCase.user.plz_commission" required>
											    		<p ng-show="userForm.plz_commission.$error.required && !userForm.plz_commission.$pristine" class="help-block">Commission is required</p>
											    		<p ng-show="userForm.plz_commission.$error.pattern" class="help-block">It must contains only numberic</p>
										    		</div>
									    		</div>
									    		<div class="form-group" ng-class="{'has-error':userForm.plz_freight.$invalid && !userForm.plz_freight.$pristine}">
											    	<label class="control-label col-sm-7 text-left">FREIGHT <span>( <span data-ng-bind="showCase.user.plz_curr_code"></span>/Kg )</span></label>
											    	<div class="col-sm-5">
											    		<input class="form-control" type="text" ng-pattern="showCase.regexNumber" name="plz_freight" id="plz_freight" ng-model="showCase.user.plz_freight" required>
											    		<p ng-show="userForm.plz_freight.$error.required && !userForm.plz_freight.$pristine" class="help-block">Freight is required</p>
											    		<p ng-show="userForm.plz_freight.$error.pattern" class="help-block">It must contains only numberic</p>
										    		</div>
									    		</div>
									    		<div class="form-group" ng-class="{'has-error':userForm.plz_taxes.$invalid && !userForm.plz_taxes.$pristine}">
											    	<label class="control-label col-sm-7 text-left">TAXES ( % )</label>
											    	<div class="col-sm-5">
											    		<input class="form-control" type="text" ng-pattern="showCase.regexNumber" name="plz_taxes" id="plz_taxes" ng-model="showCase.user.plz_taxes" required>
											    		<p ng-show="userForm.plz_taxes.$error.required && !userForm.plz_taxes.$pristine" class="help-block">Taxes is required</p>
											    		<p ng-show="userForm.plz_taxes.$error.pattern" class="help-block">It must contains only numberic</p>
										    		</div>
									    		</div>
									    		<div class="form-group" ng-class="{'has-error':userForm.plz_margin.$invalid && !userForm.plz_margin.$pristine}">
											    	<label class="control-label col-sm-7 text-left">MARGIN ( % )</label>
											    	<div class="col-sm-5">
											    		<input class="form-control" type="text" ng-pattern="showCase.regexNumber" name="plz_margin" id="plz_margin" ng-model="showCase.user.plz_margin" required>
											    		<p ng-show="userForm.plz_margin.$error.required && !userForm.plz_margin.$pristine" class="help-block">Margin is required</p>
											    		<p ng-show="userForm.plz_margin.$error.pattern" class="help-block">It must contains only numberic</p>
										    		</div>
									    		</div>
				                            </div>
										</div>
										<div class="row margin-top-20">
			                            	<div class="col-md-12 text-right">
				                            	<button class="btn bg-color-blueDark txt-color-white" id="btnAddNew" ng-click="showCase.UpdatePLZ()" ng-disabled="userForm.$invalid">
			                                    <i class="fa fa-save"></i>&nbsp;SAVE</button>
				                            </div>
										</div>
			                        </form>
                            	</div>
		                    </fieldset>
                        </div>
	                    <!--- <div class="modal fade" id="editRow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-body">
                                        <button type="button" class="close" id="close" data-dismiss="modal" style="display:none;float:right;">&times;</button>
                                        <legend class="fcollapsible" id="">Edit Row</legend>
                                        <div class="fcontent">
											<input type="hidden" id="id_plz_det" name="id_plz_det" value="0" />
                                            <form class="form-horizontal" name="editRowForm" ng-submit="showCase.submitForm()" novalidate>
                                                <!--- <div class="form-group">
                                                    <label class="col-md-4 control-label text-left">WEIGHT</label>
                                                    <div class="col-md-8">
                                                    	<input class="form-control" type="text" ng-pattern="showCase.regexNumber" name="plzd_weight" id="plzd_weight" ng-pattern="showCase.regexNumber" ng-model="showCase.plz_dets.plzd_weight" required>
                                                    	<p ng-show="userForm.plzd_weight.$error.required && !userForm.plzd_weight.$pristine" class="help-block">Weight is required</p>
                                                        <p ng-show="userForm.plzd_weight.$error.pattern  && !userForm.plzd_weight.$pristine" class="help-block">Can not enter special char</p>
                                                    </div>
                                                </div> --->
                                                <div class="form-group">
                                                    <label class="control-label col-md-4 text-left">AGENT SELL PRICE</label>
                                                    <div class="col-md-8">
                                                    	<input class="form-control" type="text" ng-pattern="showCase.regexNumber" name="plzd_zone_sell_6" id="plzd_zone_sell_6" ng-pattern="showCase.regexNumber" ng-model="showCase.plz_dets.plzd_zone_sell_6" required>
                                                    	<p ng-show="userForm.plzd_zone_sell_6.$error.required && !userForm.plzd_zone_sell_6.$pristine" class="help-block">Agent Sell Price is required</p>
                                                        <p ng-show="userForm.plzd_zone_sell_6.$error.pattern  && !userForm.plzd_zone_sell_6.$pristine" class="help-block">It must contains only numberic</p>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-4 text-left">RECOMENDED PRICE</label>
                                                    <div class="col-md-8">
                                                    	<input class="form-control" type="text" ng-pattern="showCase.regexNumber" name="plzd_pvpr_8" id="plzd_pvpr_8" ng-pattern="showCase.regexNumber" ng-model="showCase.plz_dets.plzd_pvpr_8">
                                                    	<p ng-show="userForm.plzd_pvpr_8.$error.required && !userForm.plzd_pvpr_8.$pristine" class="help-block">Recomended Price is required</p>
                                                        <p ng-show="userForm.plzd_pvpr_8.$error.pattern  && !userForm.plzd_pvpr_8.$pristine" class="help-block">It must contains only numberic</p>
                                                    </div>
                                                </div>
                                                <div class="form-group text-center">
                                                    <div class="col-md-3"></div>
                                                    <div class="col-md-7">
                                                        <div class="btn bg-color-blueDark txt-color-white" id="btnUpdate"  ng-click="showCase.UpdatePLZD()" ng-disabled="editRowForm.$invalid">
                                                            <i class="fa fa-save"></i>
                                                            &nbsp;Update
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
	                    </div> --->
                        <div class="row">
                        	<legend class="fcollapsible" style="padding-left:10px;">Detailed Prices</legend>
                            <div class="fcontent padding-10">
                            	<div>
                            		<ul id="myTab1" class="nav nav-tabs" style="font-size:16px;">
			                            <li class="active">
			                                <a href="#s1" data-toggle="tab">General</a>
			                            </li>
			                            <li>
			                                <a href="#s2" data-toggle="tab">Detail</a>
			                            </li>
			                        </ul>
			                        <div id="myTabContent1" class="tab-content">
			                        	<div class="tab-pane fade in active" id="s1">
		                                	<div class="table-responsive">
			                                    <table id="mytable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions_detail_gerneral" dt-columns="showCase.dtColumns_detail_gerneral" dt-instance="showCase.dtInstance_g">
			                                    	<thead>
			                                    		<tr>
			                                    			<th colspan="2" class="text-center">COSTING</th>

															<th colspan="2" class="text-center">VERSION</th>
															<th rowspan="2">AGENT SELL PRICE</th>
			                                    		</tr>
			                                    		<tr style="text-align:center;">
			                                    			<th>CODE</th>
															<th>DESCRIPTION</th>
															<th>No.</th>
															<th style="border-right-width: 1px;">DESCRIPTION</th>
			                                    		</tr>
			                                    	</thead>
			                                    </table>
		                                	</div>
		                                </div>
		                                <div class="tab-pane fade" id="s2">
		                                	<div class="table-responsive">
			                                    <table id="mytable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions_detail" dt-columns="showCase.dtColumns_detail" dt-instance="showCase.dtInstance">
			                                    	<thead>
			                                    		<tr>
			                                    			<th colspan="2" class="text-center">COSTING</th>

															<th colspan="2" class="text-center">VERSION</th>
															<th rowspan="2">AGENT SELL PRICE</th>
															<th rowspan="2">RECOMENDED PRICE CALC</th>
															<th rowspan="2">AGENT MARGIN</th>
			                                    		</tr>
			                                    		<tr style="text-align:center;">
			                                    			<th>CODE</th>
															<th>DESCRIPTION</th>
															<th>No.</th>
															<th style="border-right-width: 1px;">DESCRIPTION</th>
			                                    		</tr>
			                                    	</thead>
			                                    </table>
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
	<script src="/includes/js/angular-route.min.js?v=#application.version#"></script>
	<script src="/includes/js/jquery.dataTables.min.js?v=#application.version#"></script>
	<script src="/includes/js/dataTables.select.min.js?v=#application.version#"></script>
	<script src="/includes/js/angular-datatables.min.js?v=#application.version#"></script>
	<script src="/includes/js/views/price-list-zone/detail_agent.js?v=#application.version#"></script>
	<script src="/includes/js/dataTables.lightColumnFilter.min.js?v=#application.version#"></script>
	<script src="/includes/js/angular-datatables.light-columnfilter.min.js?v=#application.version#"></script>
</cfoutput>
<script type="text/javascript">
	$("plz_date").change({
		changeMonth: true,
	    changeYear: true,
	    dateFormat: "dd/mm/yy"
	});
	$("plz_update").change({
		changeMonth: true,
        changeYear: true,
        dateFormat: "dd/mm/yy"
	});
</script>