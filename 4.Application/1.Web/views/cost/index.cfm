<style type="text/css">
    .select2-container {
        width: 100% !important;
    }
    .modal-lg {
        width: 750px;
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
    label.text-bold{
        font-weight: bold;
    }
    tr > th{
       background-color: #F4F4F4 !important;
    }

    tr > th.th-align-left {
        text-align: left !important;
    }
    td span, td a{
        padding-right: 0px !important;
    }
    
    div .required {
        margin-top: -15px;
        color: #f00 !important;
    }

</style>
<section id="widget-grid" class="" ng-app="costing.main" ng-controller="BindAngularDirectiveCtrl as showCase">
	<div class="row">
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-check"></i> </span>
					<h2> Costing Infomation </h2>
				</header>
				<div>
					<div class="jarviswidget-editbox">
					</div>
					<div class="widget-body">
                        <div class="row">
                            <div class="col-md-6 col-xs-12 display-none pull-right">
                                <div class="row" style="margin-right:10px;">
                                    <div class="col-md-4"></div>
                                    <div class="btn col-md-3 margin-bottom-10 col-xs-12 bg-color-blueDark txt-color-white" id="btnCopyData" ng-click="showCase.showCopyData()">
                                        <i class="fa fa-save"></i>&nbsp;Create By Copy
                                    </div>
                                    <div class="col-md-2"></div>
                                    <div class="btn col-md-3 margin-bottom-10 col-xs-12 bg-color-blueDark txt-color-white" id="btnAddNew" ng-click="showCase.showAddNew()">
                                        <i class="fa fa-save"></i>&nbsp;Create
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-xs-12 pull-left">
                                <ul id="myTab1" class="nav nav-tabs">
                                    <li class="active">
                                        <a href="#s1" data-toggle="tab">Text View</a>
                                    </li>
                                    <li>
                                        <a href="#s2" data-toggle="tab">Images View</a>
                                    </li>
                                </ul>
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
                                                <form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
                                                    <input type="hidden" id="id_cost" value="0">
                                                    <div class="form-group" ng-class="{'has-error':userForm.cost_code.$invalid && !userForm.cost_code.$pristine}">
                                                        <label class="col-md-3 control-label text-left text-bold">Code</label>
                                                        <div class="col-md-5">
                                                            <input class="form-control" placeholder="" type="text" name="cost_code" id="cost_code" ng-model="showCase.user.cost_code" autocomplete="off" ng-pattern="showCase.regex"  required ng-readonly="showCase.isReadOnly">
                                                            <p ng-show="userForm.cost_code.$error.required && !userForm.cost_code.$pristine" class="help-block">Code is required</p>
                                                            <p ng-show="userForm.cost_code.$error.pattern  && !userForm.cost_code.$pristine" class="help-block">Can not enter special char</p>
                                                        </div>
                                                    </div>

                                                    <div class="form-group" ng-class="{'has-error':userForm.cost_season.$invalid && !userForm.cost_season.$pristine}">
                                                        <label class="control-label col-md-3 text-left text-bold">Season</label>
                                                        <div class="col-md-5">
                                                            <select  ui-select2 id="cost_season" name="cost_season" ng-model="showCase.user.cost_season" data-placeholder="Choose" ng-required="true">
                                                                <option value="">Choose Season</option>
                                                                <option ng-repeat="lang in showCase.newseasons" value="{{lang}}">{{lang}}</option>
                                                            </select>
                                                            <p ng-show="userForm.cost_season.$error.required && !userForm.cost_season.$pristine" class="help-block">Please, choose season</p>
                                                        </div>
                                                    </div>
                                                    <div class="form-group" ng-class="{'has-error':userForm.cost_pl.$invalid && !userForm.cost_pl.$pristine}">
                                                        <label class="col-md-3 control-label text-left text-bold">Price List</label>
                                                        <div class="col-md-5">
								            				<input type="checkbox" ng-model="showCase.user.cost_pl" id="cost_pl" name="cost_pl">
                                                        </div>
                                                    </div>
                                                    <div class="form-group" ng-class="{'has-error':userForm.tp_code.$invalid && !userForm.tp_code.$pristine}">
                                                        <label class="col-md-3 control-label text-left text-bold">Type of Product</label>
                                                        <div class="col-md-5">
                                                            <select ui-select2 id="tp_code" name='tp_code' ng-model="showCase.user.tp_code" data-placeholder="Choose" ng-required="true">
                                                                <option value="">Choose Type of Product</option>
                                                                <option ng-repeat="lang in showCase.tpList" value="{{lang.id_type_products}}">{{lang.tp_code}}</option>
                                                            </select>
                                                            <p ng-show="userForm.tp_code.$error.required && !userForm.tp_code.$pristine" class="help-block">Please, choose type of product</p>
                                                        </div>
                                                    </div>
                                                    <div class="form-group" ng-class="{'has-error':userForm.customer.$invalid && !userForm.customer.$pristine}">
                                                        <label class="col-md-3 control-label text-left text-bold">Customers</label>
                                                        <div class="col-md-5">
                                                            <select ui-select2 id="customer" name='customer' ng-model="showCase.user.customer" data-placeholder="Choose">
                                                                <option value="">Choose Customer</option>
                                                                <option ng-repeat="lang in showCase.customers" value="{{lang.ID}}">{{lang.NAME}}</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="form-group" ng-class="{'has-error':userForm.cost_weight.$invalid && !userForm.cost_weight.$pristine}">
                                                        <label class="col-md-3 control-label text-left text-bold">Weight (gr)</label>
                                                        <div class="col-md-5">
                                                            <input class="form-control" placeholder="" type="text" name="cost_weight" id="cost_weight" ng-pattern="showCase.regexNumber" autocomplete="off" ng-model="showCase.user.cost_weight" required>
                                                            <p ng-show="userForm.cost_weight.$error.pattern && !userForm.cost_weight.$pristine" class="help-block">It must contains only numberic</p>
                                                        </div>
                                                    </div>
                                                    <div class="form-group" ng-class="{'has-error':userForm.cost_volume.$invalid && !userForm.cost_volume.$pristine}">
                                                        <label class="col-md-3 control-label text-left text-bold">Volume (cm3)</label>
                                                        <div class="col-md-5">
                                                            <input class="form-control" placeholder="" type="text" name="cost_volume" id="cost_volume" ng-pattern="showCase.regexNumber" autocomplete="off" ng-model="showCase.user.cost_volume" required>
                                                            <p ng-show="!userForm.cost_volume.$pristine && userForm.cost_volume.$error.pattern" class="help-block">It must contains only numberic</p>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label text-left text-bold">Sketch</label>
                                                        <div class="col-md-5">
                                                            <input type="file" id="pr_sketch" accept="image/*" name="pr_sketch"  onchange="angular.element(this).scope().uploadFile(this.files)"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-group"><label class="col-md-3 control-label text-left"><strong>Description</strong></label></div>
                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <ul class="nav nav-tabs">
                                                                    <li ng-repeat="item in showCase.newDes" ng-class="{'active':$first}"><a data-toggle="tab" href="#{{item.lg_code}}">{{item.lg_name}}</a></li>
                                                                </ul>
                                                                <div class="tab-content">
                                                                    <div ng-repeat="item in showCase.newDes" id="{{item.lg_code}}" class="tab-pane fade" ng-class="{'in active':$first}">
                                                                        <textarea class="form-control" placeholder="in {{item.lg_name}}" name="{{item.lg_code}}" id="{{item.lg_code}}{{item.id_language}}" ng-model="item.description"></textarea>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group text-center">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-7">
                                                            <button class="btn bg-color-blueDark txt-color-white" id="btnAddRow"  ng-click="showCase.addRow()" ng-disabled="userForm.$invalid" >
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
                            <div class="modal fade" id="copydata" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                                <div class="modal-dialog modal-width">
                                    <div class="modal-content modal-lg">
                                        <div class="modal-body">
                                            <button type="button" class="close" id="close" data-dismiss="modal" style="float:right;">&times;</button>
                                            <legend class="fcollapsible" id="">Create by Copy</legend>
                                            <div class="fcontent">
                                                <form class="form-horizontal" name="userForm1" ng-submit="showCase.submitForm()" novalidate>
                                                    <div class="form-group">
                                                        <div class="col-md-2">
                                                            <strong>Source:</strong>
                                                        </div>
                                                         
                                                        <div class="col-md-10 row">
                                                            <div class="col-md-4 row">
                                                                <div class="col-md-4 row">
                                                                    <input type="radio" name="radiobutton" ng-model="showCase.kindOfCopy.type" id="type_product" value="type_product" ng-change="showCase.typeProductAction();">
                                                                </div>  
                                                                <div class="col-md-8 row"> <div style="width:115%"> Type of Product </div></div>                                                                                                                
                                                            </div>
                                                            <div class="col-md-1 row">&nbsp;</div>
                                                            <div class="col-md-5 row">
                                                                <div class="col-md-3 row">
                                                                    <input  type="radio" name="radiobutton" ng-model="showCase.kindOfCopy.type" id="costing" value="costing" ng-change="showCase.typeCostingAction();">
                                                                </div>

                                                                <div class="col-md-9 row" ng-class="{'has-error' : userForm1.oseason.$invalid && !userForm1.oseason.$pristine}">
                                                                    
                                                                    <select ui-select2 id="oseason" name='oseason' ng-model="showCase.user.oseason" data-placeholder="Choose Season" ng-required="showCase.isRequiredSourceSeason" ng-change="showCase.onChangeSourceSeason();" ng-disabled="showCase.sourceSeasonIsDisable">
                                                                        <option value="">Season</option>
                                                                        <option ng-repeat="lang in showCase.oseasons" value="{{lang.SEASON}}">{{lang.SEASON}}</option>
                                                                    </select>
                                                                    
                                                                </div> 
                                                            </div>

                                                            <div class="col-md-3 row" ng-class="{'has-error' : userForm1.oCode.$invalid && !userForm1.oCode.$pristine}">
                                                                <div style="width:127%">
                                                                <select ui-select2 id="oCode" name='oCode' ng-model="showCase.user.oCode" data-placeholder="Choose" ng-required="showCase.isRequiredCostingCode" ng-disabled="showCase.oCodeIsDisable" ng-change="showCase.onChangeCostingCode();" placeholder="Costing Code">
                                                                        <option value="">Costing Code</option>
                                                                        <option value="all">All</option>
                                                                        <option ng-repeat="code in showCase.oCodes" value="{{code.ID_COST}}">{{code.COST_CODE}}</option>
                                                                    </select>
                                                                   </div>
                                                            </div>
                                                        </div>                                                     

                                                    </div>

                                                    <div class="form-group required">
                                                        <div class="col-md-2">
                                                            &nbsp;
                                                        </div>
                                                         
                                                        <div class="col-md-10 row">
                                                            <div class="col-md-4 row">
                                                                    &nbsp;                                                                                                        
                                                            </div>
                                                            <div class="col-md-1 row">&nbsp;</div>
                                                            <div class="col-md-5 row">
                                                                <div class="col-md-3 row">
                                                                    &nbsp;
                                                                </div>
                                                                <div class="col-md-9 row">
                                                                    <p ng-show="userForm1.oseason.$invalid && !userForm1.oseason.$pristine">Required</p>
                                                                </div>
                                                                 
                                                            </div>

                                                            <div class="col-md-3 row" ng-class="{'has-error' : userForm1.oCode.$invalid && !userForm1.oCode.$pristine}">
                                                                <p ng-show="userForm1.oCode.$invalid && !userForm1.oCode.$pristine">Required</p>
                                                            </div>
                                                        </div>                                                     

                                                    </div>

                                                    <div class="form-group">
                                                        <div class="col-md-2">
                                                            <strong>Destination:</strong>
                                                        </div>
                                                        
                                                        <div class="col-md-10 row">
                                                            <div class="col-md-4 row" ng-class="{'has-error' : userForm1.newSeason.$invalid && !userForm1.newSeason.$pristine}">
                                                                <div style="width:90%">
                                                                    <select  ui-select2 id="newSeason" name="newSeason" ng-model="showCase.user.newSeason" data-placeholder="Choose" ng-required="true">
                                                                        <option value="">Season</option>
                                                                        <option ng-repeat="lang in showCase.newseasons" value="{{lang}}">{{lang}}</option>
                                                                    </select>                                                                     
                                                                </div>                                                                                                             
                                                            </div>
                                                            <div class="col-md-1 row">&nbsp;</div>
                                                            <div class="col-md-5 row" ng-class="{'has-error' : userForm1.sameCode.$invalid && !userForm1.sameCode.$pristine}">
                                                                 <input class="form-control" placeholder="Cost Code" style="width:77%" type="text" name="sameCode" id="sameCode" ng-model="showCase.user.sameCode" ng-required="showCase.isRequiredSameCode" ng-disabled="showCase.sameCodeIsDisable" ng-change="showCase.onChangeSameCode();">
                                                                
                                                            </div>
                                                           
                                                            <div class="col-md-4 row">
                                                                <div class="col-md-7 row" ng-class="{'has-error':userForm1.increase.$invalid && !userForm1.increase.$pristine}">
                                                                    <input class="form-control" type="number" name="increase" id="increase" ng-pattern="showCase.regexNumber" ng-model="showCase.user.increase" min="0" ng-disabled="showCase.increaseIsDisabled" ng-required="showCase.isRequiredIncrease">
                                                                </div>
                                                                <div class="col-md-6"  style="background-color:#fff; height:100%">
                                                                    <div style="width:115%; padding-top: 7px;">% Increase</div>
                                                                </div>
                                                            </div>   
                                                                    
                                                        </div>  
                                                    </div>

                                                    <div class="form-group required">
                                                        <div class="col-md-2">
                                                            &nbsp;
                                                        </div>
                                                        
                                                        <div class="col-md-10 row">
                                                            <div class="col-md-4 row" ng-class="{'has-error' : userForm1.newSeason.$invalid && !userForm1.newSeason.$pristine}">
                                                               <p ng-show="userForm1.newSeason.$invalid && !userForm1.newSeason.$pristine">Required</p>                                                                                                        
                                                            </div>
                                                            <div class="col-md-1 row">&nbsp;</div>
                                                            <div class="col-md-5 row" ng-class="{'has-error' : userForm1.sameCode.$invalid && !userForm1.sameCode.$pristine}">
                                                                 <p ng-show="userForm1.sameCode.$invalid && !userForm1.sameCode.$pristine">Required</p>
                                                                
                                                            </div>
                                                           
                                                            <div class="col-md-4 row">
                                                                <p ng-show="userForm1.increase.$invalid && !userForm1.increase.$pristine">Required</p>
                                                            </div>   
                                                                    
                                                        </div>  
                                                    </div>


                                                    <div class="form-group">
                                                        <label class="col-md-12  control-label text-left">
                                                            <input class="form-control" placeholder="" type="hidden" name="code_season" id="code_season" ng-model="showCase.user.code_season" ng-required="true">
                                                            <p ng-show="showCase.isExist" class="help-block" style="color: red">Season and code have already existed!</p>
                                                        </label>
                                                    </div>
                                                    <div class="form-group text-center">
                                                        <div class="col-md-12">
                                                            <div class="btn bg-color-blueDark txt-color-white pull-right" id="btnCopyData"  ng-click="showCase.CopyData()" ng-disabled="userForm1.$invalid">
                                                                <i class="fa fa-save"></i>
                                                               Create
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
						</div>

						<div id="myTabContent1" class="tab-content padding-10">
							<div class="tab-pane fade in active" id="s1">
								<div class="table-responsive">
									<table id="datatable_fixed_column_1" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns1" dt-instance="showCase.dtInstance1">
                                    </table>
								</div>
							</div>
							<div class="tab-pane fade" id="s2">
								<div class="table-responsive">
									<table id="datatable_fixed_column_2" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns2" dt-instance="showCase.dtInstance2">
                                    </table>
								</div>
							</div>
						</div>
					</div><!-- end widget content -->
				</div>
				<!-- end widget div -->
			</div>
			<!-- end widget -->
		</article>
	</div>
</section>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/dataTables.select.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/costing.main.js"></script>
<script src="/includes/js/jquery-ui.js"></script>
