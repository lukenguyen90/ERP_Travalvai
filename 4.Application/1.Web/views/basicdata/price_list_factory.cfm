<style type="text/css">
	.modal-lg {
	    width: 50%;
	}
	.select2-container{
        width:100%;
    }
    label.text-bold{
    	 font-weight: bold;
    }
    input.label1{
        background-color: #fff !important;
        border: 0px;
    }

    span.exRate{
        background-color: #fff !important;
        border: 0px;
    }
	span.inverseNumber{
        background-color: #f2f2f2;
        border: 0 none;
        margin-top: -14px;
    }
	
    tr > th.th-align-left {
        text-align: left !important;
    }

	label.exRate{

	}

	label.inverseNumber {
		background-color: #f2f2f2;
	}

</style>
<section id="widget-grid" class="" ng-app='price.List.factory' ng-controller="BindAngularDirectiveCtrl as showCase">
	<div class="row">
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Price List Fatory</h2>
				</header>
				<div>
					<div class="widget-body" >
						<div class="row">
							<div class="modal fade" id="modalUpdatePLF" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                                <fieldset class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                        	<button type="button" class="close" id="close" data-dismiss="modal" style="display:none;float:right;">&times;</button>
											<legend class="fcollapsible" id="titleID">Create</legend>
											<div class="fcontent">
												<form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
													<input type="hidden" id="id_plf" value="0">
													<div class="form-group" ng-class="{'has-error':userForm.code.$invalid && !userForm.code.$pristine}">
					                                        <label class="col-md-3 control-label text-left text-bold">Code</label>
					                                        <div class="col-md-9">
					                                            <input class="form-control" placeholder="" type="text" name="code" id="code" ng-model="showCase.user.code" ng-pattern="showCase.regex" required>
				                                                <p ng-show="userForm.code.$error.required && !userForm.code.$pristine" class="help-block">Required</p>
				                                                <p ng-show="userForm.code.$error.pattern  && !userForm.code.$pristine" class="help-block">Can not enter special char</p>
					                                        </div>
				                                    </div>
				                                    <div class="form-group" ng-class="{'has-error':userForm.description.$invalid && !userForm.description.$pristine}">
					                                        <label class="col-md-3 control-label text-left text-bold">Description</label>
					                                        <div class="col-md-9">
					                                            <input class="form-control" placeholder="" type="text" name="description" id="description" ng-model="showCase.user.description" required>
				                                                <p ng-show="userForm.description.$error.required && !userForm.description.$pristine" class="help-block">Required</p>
					                                        </div>
				                                    </div>
													<div class="form-group">
														<div class="col-md-6 col-xs-12 no-padding" ng-class="{'has-error':userForm.season.$invalid && !userForm.season.$pristine}">
															<label class="control-label col-md-6 text-left text-bold">Season</label>
															<div class="col-md-6">
																<select ui-select2 id="season" name="season" ng-model="showCase.user.season" data-placeholder="Choose" ng-required="true">
																	<option value="">Choose</option>
																	<option ng-repeat="lang in showCase.newseasons" value="{{lang.season}}">{{lang.season}}</option>
																</select>
				                                                <p ng-show="userForm.season.$error.required && !userForm.season.$pristine" class="help-block">Please choose season</p>
															</div>
														</div>
														<div class="col-md-6 col-xs-12 no-padding" ng-class="{'has-error':userForm.zone.$invalid && !userForm.zone.$pristine}">
															<label class="control-label col-md-6 text-left text-bold">Zone</label>
															<div class="col-md-6">
																<select ui-select2 id="zone" name="zone" ng-model="showCase.user.zone" data-placeholder="Choose" ng-required="true">
																	<option value="">Choose</option>
																	<option ng-repeat="lang in showCase.zones" value="{{lang.ID}}">{{lang.DES}}</option>
																</select>
																<p ng-show="userForm.zone.$invalid && !userForm.zone.$pristine" class="help-block">Required</p>
															</div>
														</div>
													</div>
													<div class="form-group">
														<div class="col-md-6 col-xs-12 no-padding">
															<label class="col-md-6 control-label text-left text-bold">Factory Currency</label>
															<div class="col-md-6">
																<input type="hidden" id="ftyid" name="ftyid" ng-model="showCase.ftyid">
																<input class="form-control label1" readonly placeholder="" type="text" name="ftycurrency" id="ftycurrency" ng-model="showCase.ftycurrency">
															</div>
														</div>
														<div class="col-md-6 col-xs-12 no-padding">
															<label class="col-md-6 control-label text-left text-bold">Ex. Rate (USD/{{showCase.ftycurrency}})</label>
															<div class="col-md-6">
																<span  class="form-control exRate"  ng-bind="formatNumberThousand(showCase.currFtyCurrencyExRate.cc_value, 6)"></span>
															</div>
														</div>
													</div>
													<div class="form-group">
														<div class="col-md-6 col-xs-12 no-padding" ng-class="{'has-error':userForm.currency.$invalid && !userForm.currency.$pristine}">
															<label class="col-md-6 control-label text-left text-bold">Price List Currency</label>
															<div class="col-md-6">
																<select ui-select2 id="currency" name="currency" ng-model="showCase.user.currency" data-placeholder="Choose" required>
																	<option value="">Choose</option>
																	<option ng-repeat="lang in showCase.currencylist" value="{{lang.id_currency}}">{{lang.curr_code}}</option>
																</select>
																<p ng-show="userForm.currency.$invalid && !userForm.currency.$pristine" class="help-block">Please choose Price List Currency</p>
															</div>
														</div>
														<div class="col-md-6 col-xs-12 no-padding">
															<label class="col-md-6 control-label text-left text-bold">Ex. Rate {{showCase.exRateUSDWithPriceCurrencyLabel}}<!--- (USD/{{showCase.PListCurrencyCode}}) ---></label>
															<div class="col-md-6">

																<span class="form-control exRate" ng-bind="formatNumberThousand(showCase.exRateUSDToPListCurrency,6)"></span>
															</div>

														</div>

													</div>
													<div class="form-group">
														<div class="col-md-6 col-xs-12 no-padding">
															<label class="col-md-6 control-label text-left text-bold">Ex. Rate {{showCase.exRateWithPriceCurrencyLabel}}</label>
															<div class="col-md-6">
																<span data-ng-bind="showCase.exRatePListFtyToFtyCurrency" class="form-control exRate"></span>																																
															</div>
														</div>
														<div class="col-md-6 col-xs-12 no-padding">
															<label class="col-md-6 control-label text-left text-bold">Manual Ex. Rate</label>
															<div class="col-md-6" ng-class="{'has-error':userForm.ex_rate.$invalid && !userForm.ex_rate.$pristine}">
																<input class="form-control" placeholder="" type="text" ng-pattern="showCase.regexNumber" name="ex_rate" id="ex_rate" ng-model="showCase.user.ex_rate" required  ng-change="showCase.changeexrate()">
																<p ng-show="userForm.ex_rate.$error.required  && !userForm.ex_rate.$pristine" class="help-block">Required</p>
																<p ng-show="userForm.ex_rate.$error.pattern  && !userForm.ex_rate.$pristine" class="help-block">Numeric only</p>
															</div>
														</div>
													</div>
													<div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="col-md-6"></label>
                                                                <label class="col-md-6">
                                                                    <span data-ng-bind="showCase.dividedExRatePListFtyToFtyCurrency" class="form-control inverseNumber"></span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="col-md-6"></label>
                                                                <label class="col-md-6"><span  data-ng-bind="showCase.user.devidedManualExRate" class="form-control inverseNumber"></span></label>
                                                            </div>
                                                        </div>
                                                    </div>
													<div class="form-group">
														<div class="col-md-6 col-xs-12 no-padding" ng-class="{'has-error':userForm.correction.$invalid && !userForm.correction.$pristine}">
															<label class="col-md-6 control-label text-left text-bold">Correction (%)</label>
															<div class="col-md-6">
																<input class="form-control" placeholder="" type="text" ng-pattern="showCase.regexNumber" name="correction" id="correction" ng-model="showCase.user.correction" min ="0" required>
																<p ng-show="userForm.correction.$error.required  && !userForm.correction.$pristine" class="help-block">Required</p>
																<p ng-show="userForm.correction.$error.pattern  && !userForm.correction.$pristine" class="help-block">Numeric only</p>
															</div>
														</div>
														<div class="col-md-6 col-xs-12 no-padding"></div>
													</div>
													<!--- <div class="form-group" id="sSeason" ng-show="showCase.isCreateByCopy">
														<div class="col-md-6 col-xs-12 no-padding" ng-class="{'has-error':userForm.sourceseason.$invalid && !userForm.sourceseason.$pristine}" >
															<label class="col-md-4 control-label text-left">Source Season</label>
															<div class="col-md-8">
																<select ui-select2 id="sourceseason" name="sourceseason" ng-model="showCase.user.sourceseason" data-placeholder="Choose" ng-show="showCase.isCreateByCopy">
																	<option value="">Choose Source Season</option>
																	<option ng-repeat="season in showCase.old_seasons" value="{{season}}">{{season}}</option>
																</select>
															</div>
														</div>
														<div class="col-md-6 col-xs-12 no-padding"></div>
													</div> --->
													<div class="form-group">
														<div class="col-md-12 text-right">
															<button class="btn bg-color-blueDark txt-color-white" id="btninsertPLF"  ng-click="showCase.insertPLF()" ng-disabled="userForm.$invalid">
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
								</fieldset>
							</div>
							<div class="modal fade" id="copydata" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                        	<button type="button" class="close" id="close" data-dismiss="modal" style="display:none;float:right;">&times;</button>
											<legend class="fcollapsible" id="">Create by Copy</legend>
											<div class="fcontent">
												<form class="form-horizontal" name="copyForm" ng-submit="showCase.submitForm()" novalidate>
                                                    <div class="col-md-4">
														<div class="form-group" ng-class="{'has-error' : copyForm.sourceseason.$invalid && !copyForm.sourceseason.$pristine}">
															<label class="col-md-5 control-label text-left"><strong>Source</strong></label>
															<div class="col-md-7">
																<select ui-select2 id="sourceseason" name="sourceseason" ng-model="showCase.user.sourceseason" data-placeholder="Choose"  ng-change="showCase.changeSourceSeason()" required>
																	<option value="">Choose...</option>
																	<option ng-repeat="season in showCase.old_seasons" value="{{season}}">{{season}}</option>
																</select>
																<p ng-show="copyForm.sourceseason.$error.required && !copyForm.sourceseason.$pristine" class="help-block">Required</p>
															</div>
	                                                    </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                    	<div class="form-group" ng-class="{'has-error' : copyForm.sourcezone.$invalid && !copyForm.sourcezone.$pristine}">
	                                                        <div class="col-md-12">
	                                                        	<select ng-disabled="showCase.isDisableSourceZone" ui-select2 id="sourcezone" name="sourcezone" ng-model="showCase.user.sourcezone" data-placeholder="Choose" ng-required="true" ng-change="showCase.changeSourceZone()">
	                                                                <option ng-repeat="lang in showCase.arrzone" value="{{lang.id_zone}}">{{lang.z_code}}</option>
	                                                            </select>
	                                                             <p ng-show="copyForm.sourcezone.$error.required && !copyForm.sourcezone.$pristine" class="help-block">Required</p>
	                                                        </div>
	                                                    </div>
                                                    </div>
                                                    <div class="col-md-5">
                                                    	<div class="form-group" ng-class="{'has-error' : copyForm.sourceplf.$invalid && !copyForm.sourceplf.$pristine}">
	                                                        <div class="col-md-12">
	                                                        	<select ng-disabled="showCase.isDisableSourcePList" ui-select2 id="sourceplf" name="sourceplf" ng-model="showCase.user.sourceplf" data-placeholder="Choose" ng-required ng-change="showCase.changeSourcePList()">
	                                                                <option ng-repeat="lang in showCase.arrPlist" value="{{lang.id_plf}}">{{lang.plf_code}}</option>
	                                                            </select>
	                                                             <p ng-show="copyForm.sourceplf.$error.required && !copyForm.sourceplf.$pristine" class="help-block">Required</p>
	                                                        </div>
	                                                    </div>
                                                    </div>
                                                    <div class="col-md-2">&nbsp;</div>
                                                    <div class="col-md-2"><label class="control-label pull-right"><strong>Currency</strong></label></div>
                                                    <div class="col-md-3">
                                                    	<label class="control-label" name="sourcePriceListCurrency">{{showCase.user.sourcePriceListCurrency}}</label>
                                                    </div>
                                                    <div class="col-md-5">
                                                    	<div class="form-group">
	                                                    	<label class="col-md-6 control-label text-left"><strong>Manual Ex. Rate</strong></label>
	                                                    	<div class="col-md-6">
	                                                    		<label class="control-label" name="sourcePriceListExRate">{{showCase.user.sourcePriceListExRate}}</label>
	                                                    	</div>
	                                                    </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                    	<div class="form-group" ng-class="{'has-error' : copyForm.destinationseason.$invalid && !copyForm.destinationseason.$pristine}">
                                                        	<label class="col-md-5 control-label text-left" style="font-weight: bold">Destination</label>
	                                                        <div class="col-md-7">
	                                                        	<select  ui-select2 id="destinationseason" name="destinationseason" ng-model="showCase.user.destinationseason" data-placeholder="Choose" ng-required="true">
	                                                        		<option value="">Choose...</option>
	                                                                <option ng-repeat="lang in showCase.newseasons" value="{{lang.season}}">{{lang.season}}</option>
	                                                            </select>
	                                                            <p ng-show="copyForm.destinationseason.$error.required && !copyForm.destinationseason.$pristine" class="help-block">Required</p>
	                                                        </div>
	                                                    </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                    	<div class="form-group">
	                                                        <div class="col-md-12">
	                                                        	<input type="hidden" id="destinationzone" name="destinationzone" ng-model="showCase.user.destinationzone"/>
	                                                        	<input type="text" class="form-control" ng-disabled="true" id="destinationzonecode" name="destinationzonecode" ng-model="showCase.user.destinationzonecode"/>
	                                                        </div>
	                                                    </div>
                                                    </div>
                                                    <div class="col-md-5">
                                                    	<div class="form-group">
	                                                        <div class="col-md-12">
	                                                            <input ng-readonly="showCase.isDisableDestinationPList" type="text" name="text_destinationplf" id="text_destinationplf" class="form-control" ng-model="showCase.user.text_destinationplf">
	                                                            <input type="hidden" name="destinationplf" id="destinationplf" class="form-control" ng-model="showCase.user.destinationplf">
	                                                        </div>
	                                                    </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                    	<div class="form-group">
	                                                    	<label class="col-md-4 control-label "><strong>Description</strong></label>
	                                                    	<div class="col-md-8">
	                                                    		<input class="form-control" name="priceListDescription" type="text" ng-model="showCase.user.priceListDescription"/>
	                                                    	</div>
	                                                    </div>
                                                    </div>
													<div class="form-group text-center">
														<div class="col-md-3"></div>
														<div class="col-md-9 row">
															<button class="btn bg-color-blueDark txt-color-white pull-right" id="btnCopyData"  ng-click="showCase.CopyData()" ng-disabled="copyForm.$invalid">
																<i class="fa fa-save"></i>
																&nbsp;Create
															</button>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row width-table-content" style="width:100%;">
								<fieldset style="padding:5px;">
									<legend class="fcollapsible col-md-7">Price List Factory</legend>
									<div class="btn col-md-2 col-xs-12 margin-bottom-10 bg-color-blueDark txt-color-white" id="btnCopyData" ng-click="showCase.showCopyData()" ng-show="{{isShowCreateBtn}}">
                                        CREATE BY COPY
                                    </div>
                                    <div class="col-md-1"></div>
									<div class="btn col-md-2 col-xs-12 bg-color-blueDark txt-color-white" id="btnAddNew" ng-click="showCase.showAddNew()" ng-show="{{isShowCreateBtn}}">
                                        NEW
                                    </div>
									<div class="fcontent">
                                        <table id="mytable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance">
                                        	<thead>
                                                <tr>
                                                    <th>CODE</th>
                                                    <th>DESCRIPTION</th>
                                                    <th>ZONE</th>
                                                    <th>SEASON</th>
                                                    <th>FTY CURRENCY</th>
                                                    <th>P.LIST. CURRENCY</th>
                                                    <th>EX. RATE</th>
                                                    <th>CORRECTION</th>
                                                    <th>DATE</th>
                                                    <th>UPDATE</th>
                                                    <th style="width: 45px;"></th>
                                                    <th></th>
                                                </tr>
                                            </thead>
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
	<div class="modal fade" id="showDelete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
        <div class="modal-dialog" id="modalForm">
            <div class="modal-content">
                <div class="modal-header alert-info">
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
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/dataTables.select.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/price.list.factory.js"></script>
