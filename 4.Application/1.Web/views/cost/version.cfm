<style type="text/css">
    .table.no-border tr td, .table.no-border tr th {
      border-width: 0;
    }

    .dt-toolbar{
        padding-left: 0px;
        padding-right: 0px;
    }

    #mytable_length{
        float: right;
        display: inline;
    }
    #mytable_filter{
        float: left;
        display: inline;
    }

    caption {
      font-size: 16pt;
    }
    .jumbotron {
      padding: 5px inherit;
    }
    tr > th.th-align-left {
        text-align: left !important;
    }
</style>
<section id="widget-grid" class="" ng-app="costing.version" ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
	<div class="row">
		<article class="col-sm-12 col-md-12 col-lg-12">
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
                    <span class="widget-icon"> <i class="fa fa-arrow-left" style="cursor:pointer !important;" ng-click="showCase.backState()" title="Back to Cost List"></i> </span>
					<h2> Costing Version Information </h2>
				</header>
				<div class="widget-body">
					<div class="row">
						<div class="col-md-12">
							<legend class="fcollapsible">General</legend>
                            <div class="fcontent" style="margin-left: 10px;">
    							<div class="row">
									<div class ="col-md-9 col-sm-9 col-xs-12" style="border: thin dotted rgb(212, 212, 212);">
                                        <table class="table no-border text-left" style="margin-bottom: 0px;">
                                            <tbody>
                                                <tr>
                                                    <td  style="padding:5px; width:20%"><span style="font-weight:bolder;">CODE :</span></td>
                                                    <td  style="padding:5px;width:30%"><span data-ng-bind="showCase.costing.COST_CODE"></span></td>
                                                    <td  style="padding:5px; width:20%"><span style="font-weight:bolder;">PRICE LIST :</span></td>
                                                    <td  style="padding:5px;width:30%"><span data-ng-bind="showCase.costing.COST_PL"></span></td>
                                                </tr>
                                                <tr>
                                                    <td  style="padding:5px; width:20%"><span style="font-weight:bolder;">DESCRIPTION :</span></td>
                                                    <td  style="padding:5px;width:30%"><span data-ng-bind="showCase.costing.DESCRIPTION"></span></td>
                                                    <td  style="padding:5px; width:20%"><span style="font-weight:bolder;">CUSTOMER :</span></td>
                                                    <td  style="padding:5px;width:30%"><span data-ng-bind="showCase.costing.CS_NAME"></span></td>
                                                </tr>
                                                <tr>
                                                    <td  style="padding:5px; width:20%"><span style="font-weight:bolder;">TYPE PRODUCT :</span></td>
                                                    <td  style="padding:5px;width:30%"><span data-ng-bind="showCase.costing.TP_CODE"></span></td>
                                                    <td  style="padding:5px; width:20%"><span style="font-weight:bolder;">DATE :</span></td>
                                                    <td  style="padding:5px;width:30%"><span data-ng-bind="showCase.costing.COST_DATE"></span></td>
                                                </tr>
                                                <tr>
                                                    <td  style="padding:5px; width:20%"><span style="font-weight:bolder;">DESCRIPTION :</span></td>
                                                    <td  style="padding:5px;width:30%"><span data-ng-bind="showCase.costing.TP_DESCRIPTION"></span></td>
                                                    <td  style="padding:5px; width:20%"><span style="font-weight:bolder;">UPDATE :</span></td>
                                                    <td  style="padding:5px;width:30%"><span data-ng-bind="showCase.costing.COST_UPDATE"></span></td>
                                                </tr>
                                                <tr>
                                                    <td  style="padding:5px; width:20%"><span style="font-weight:bolder;">CURRENCY :</span></td>
                                                    <td  style="padding:5px;width:30%"><span data-ng-bind="showCase.costing.FCURRENCY"></span></span></td>
                                                    <td  style="padding:5px; width:20%"><span style="font-weight:bolder;">WEIGHT (gr) :</span></td>
                                                    <td  style="padding:5px;width:30%"><span data-ng-bind="showCase.costing.COST_WEIGHT"></span></td>

                                                </tr>
                                                <tr>
                                                    <td  style="padding:5px; width:20%"><span style="font-weight:bolder;">SEASON :</span></td>
                                                    <td  style="padding:5px;width:30%"><span data-ng-bind="showCase.costing.COST_SEASON"></span></td>
                                                    <td  style="padding:5px; width:20%"><span style="font-weight:bolder;">VOLUME (cm3) :</span></td>
                                                    <td  style="padding:5px;width:30%"><span data-ng-bind="showCase.costing.COST_VOLUME"></span></td>
                                                </tr>
                                            </tbody>
                                        </table>
									</div>
                                    <div ng-if="showCase.costing.COST_SKETCH.length > 0" class = "col-md-3 col-sm-3 col-xs-12">
                                        <a  rel="lightbox-mygallery" href="/includes/img/ao/{{showCase.costing.COST_SKETCH}}" title="{{showCase.costing.COST_CODE + ' - ' + showCase.costing.DESCRIPTION}}">
                                           <img ng-src="/includes/img/ao/{{showCase.costing.COST_SKETCH}}" alt="NO IMAGE" height="100%" width="100%">
                                       </a>
                                    </div>
    							</div>
                            </div>
						</div>
					</div>

					<div class="row width-table-content margin-top-20" style="width:100%;">
                        <div class="row">
                            <legend class="col-md-9 col-sm-9 col-xs-12 pull-left fcollapsible">Version List</legend>
                            <div class="col-md-3 col-sm-3 col-xs-12">
                                <div class="btn col-xs-12 col-sm-6 col-md-6 col-lg-6 btn-default bg-color-blueDark txt-color-white" style="float:right;" id="btnAddNew" ng-click="showCase.showAddNew()">
                                    &nbsp;Add Version
                                </div>
                            </div>
    						<div class="fcontent col-md-12">
                                <div class="table-responsive">
                                    <table id="mytable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance"></table>
                                </div>
    						</div>
                        </div>
					</div>
				</div>
			</div>
			<!-- end widget -->
		</article>
		<div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        <button type="button" class="close" id="close" data-dismiss="modal" style="display:none;float:right;">&times;</button>
                        <legend class="fcollapsible" id="titleID">Create</legend>
                        <div class="fcontent">
                            <form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
                                <input type="hidden" id="id_cost_version" value="0">
                                <input type="hidden" id="id_cost" value="0">
                                <div class="form-group" ng-class="{'has-error':userForm.cv_version.$invalid && !userForm.cv_version.$pristine}">
                                    <label class="col-md-3 control-label text-left"><strong>Version No.</strong></label>
                                    <div class="col-md-5">
                                        <input class="form-control" placeholder="" type="text" name="cv_version" id="cv_version" ng-model="showCase.user.cv_version" required>
                                        <p ng-show="userForm.cv_version.$error.pattern  && !userForm.cv_version.$pristine" class="help-block">please, enter number format.</p>
                                    </div>
                                </div>

                                <div class="form-group" ng-class="{'has-error':userForm.cv_waste.$invalid && !userForm.cv_waste.$pristine}">
                                    <label class="col-md-3 control-label text-left"><strong>Waste (%)</strong></label>
                                    <div class="col-md-5">
                                    	<input class="form-control" placeholder="" type="text" name="cv_waste" id="cv_waste" ng-model="showCase.user.cv_waste" ng-pattern="showCase.regex"  required  ng-min="0" ng-max="100">
                                        <p ng-show="userForm.cv_waste.$error.required && !userForm.cv_waste.$pristine" class="help-block">Waste is required</p>
                                        <p ng-show="userForm.cv_waste.$error.pattern  && !userForm.cv_waste.$pristine" class="help-block">please, enter number format.</p>
                                    </div>
                                </div>
                                <div class="form-group" ng-class="{'has-error':userForm.cv_margin.$invalid && !userForm.cv_margin.$pristine}">
                                    <label class="col-md-3 control-label text-left"><strong>Margin (%)</strong></label>
                                    <div class="col-md-5">
                                        <input class="form-control" placeholder="" type="text" name="cv_margin" id="cv_margin" ng-model="showCase.user.cv_margin" ng-pattern="showCase.regex"  required ng-min="0" ng-max="100">
                                        <p ng-show="userForm.cv_margin.$error.required && !userForm.cv_margin.$pristine" class="help-block">Margin is required</p>
                                        <p ng-show="userForm.cv_margin.$error.pattern  && !userForm.cv_margin.$pristine" class="help-block">please, enter number format.</p>
                                    </div>
                                </div>
                                <div class="form-group" ng-class="{'has-error':userForm.cv_fty_cost_0.$invalid && !userForm.cv_fty_cost_0.$pristine}">
                                    <label class="col-md-3 control-label text-left"><strong>Factory Cost</strong></label>
                                    <div class="col-md-5">
                                        <input class="form-control" placeholder="" type="text" name="cv_fty_cost_0" id="cv_fty_cost_0" ng-model="showCase.user.cv_fty_cost_0" ng-pattern="showCase.regex"  required>
                                        <p ng-show="userForm.cv_fty_cost_0.$error.required && !userForm.cv_fty_cost_0.$pristine" class="help-block">Factory cost is required</p>
                                        <p ng-show="userForm.cv_fty_cost_0.$error.pattern  && !userForm.cv_fty_cost_0.$pristine" class="help-block">please, enter number format.</p>
                                    </div>
                                </div>
                                <div class="form-group" ng-class="{'has-error':userForm.cv_weight.$invalid && !userForm.cv_weight.$pristine}">
                                    <label class="col-md-3 control-label text-left"><strong>Weight (gr)</strong></label>
                                    <div class="col-md-5">
                                        <input class="form-control" placeholder="" type="text" name="cv_weight" id="cv_weight" ng-model="showCase.user.cv_weight" ng-pattern="showCase.regex" ng-pattern="showCase.regex" required>
                                        <p ng-show="userForm.cv_weight.$error.required && !userForm.cv_weight.$pristine" class="help-block">Weight is required</p>
                                        <p ng-show="userForm.cv_weight.$error.pattern  && !userForm.cv_weight.$pristine" class="help-block">please, enter number format.</p>
                                    </div>
                                </div>
                                <div class="form-group" ng-class="{'has-error':userForm.cv_volume.$invalid && !userForm.cv_volume.$pristine}">
                                    <label class="control-label col-md-3 text-left"><strong>Volume (cm3)</strong></label>
                                    <div class="col-md-5">
                                        <input class="form-control" placeholder="" type="text" name="cv_volume" id="cv_volume" ng-model="showCase.user.cv_volume" required>
                                        <p ng-show="userForm.cv_volume.$error.required && !userForm.cv_volume.$pristine" class="help-block">Volume is required</p>
                                        <p ng-show="userForm.cv_volume.$error.pattern  && !userForm.cv_volume.$pristine" class="help-block">please, enter number format.</p>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3 text-left"><strong>Sketch</strong></label>
                                    <div class="col-md-5">
                                        <input class="form-control" type="file" accept="image/*" name="cv_sketch" id="cv_sketch" multiple onchange="angular.element(this).scope().uploadFile(this.files)">
                                    </div>
                                </div>
                                <div class="form-group"><label class="col-md-3 control-label text-left"><strong>Description</strong></label></div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <ul class="nav nav-tabs">
                                                <li ng-repeat="item in showCase.dataDes" ng-class="{'active':$first}"><a data-toggle="tab" href="#{{item.id_language}}{{item.lg_code}}">{{item.lg_name}}</a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div ng-repeat="item in showCase.dataDes" id="{{item.id_language}}{{item.lg_code}}" class="tab-pane fade" ng-class="{'in active':$first}">
                                                    <textarea class="form-control" placeholder="in {{item.lg_name}}" name="{{item.lg_code}}" id="{{item.lg_code}}{{item.id_language}}{{item.id_language}}" ng-model="item.description"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group text-center">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-7">
                                        <button class="btn bg-color-blueDark txt-color-white" id="btnAddRow"  ng-click="showCase.saveCostingVersion()" ng-disabled="userForm.$invalid" >
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
	</div>
</section>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/dataTables.select.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/costing.version.js"></script>