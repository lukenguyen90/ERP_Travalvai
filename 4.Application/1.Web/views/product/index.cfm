<style type="text/css">
.modal-dialog {
    width: 500px;
}
.select2-container{
    width: 100%;
}
.modal-content {
    width: 500px !important;
}
tr > th{
   background-color: #F4F4F4 !important; 
}
tr > th.th-align-left {
    text-align: left !important;
}
.bold{
    font-weight: bold;
}
</style>
<section id="widget-grid"  ng-app='product.List' ng-controller="BindAngularDirectiveCtrl as showCase">
    <div class="row">
        <article class="col-sm-12 col-md-12 col-lg-12">
            <!-- Widget ID (each widget will need unique ID)-->
            <div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
                <header>
                    <span class="widget-icon"> <i class="fa fa-check"></i> </span>
                    <h2> Product Information </h2>
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
                                <a href="##s1" data-toggle="tab">Text View</a>
                            </li>
                            <li>
                                <a href="##s2" data-toggle="tab">Text & Images View</a>
                            </li>
                            <li>
                                <a href="##s4" data-toggle="tab">Prices View</a>
                            </li>
                            <cfoutput>
                                <cfif application.userType != 'customer'>
                                <div class="btn col-md-offset-2 bg-color-blueDark txt-color-white pull-right" id="btnAddNew" ng-click="showCase.showModalAddNew()">
                                New Product
                                </div>
                                    
                                </cfif>
                                
                            </cfoutput>
                            
                        </ul>

                        <div id="myTabContent1" class="tab-content padding-10">
                            <div class="tab-pane fade in active" id="s1">
                                <div class="table-responsive">
                                    <table id="textviewTable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptionsTextViewTable" dt-columns="showCase.dtColumnsTextViewTable" dt-instance="showCase.dtInstance1">
                                         <!--- <thead>
                                            <tr>
                                                <th rowspan="2">PRODUCT</th>
                                                <th rowspan="2" class="text-center">GARMENT</th>
                                                <th rowspan="2" class="text-center">COSTING</th>
                                                <th rowspan="2">DESCRIPTION </th>
                                                <th rowspan="2">SIZES</th>
                                                <th rowspan="2">ZONE</th>
                                                <th rowspan="2">AGENT</th>
                                                <th rowspan="2">CUSTOMER</th>
                                                <th rowspan="2">SECTION</th>
                                                <th rowspan="2">STATUS</th>
                                                <th rowspan="2">ACTIONS</th>
                                                <th rowspan="2">DETAIL</th>
                                            </tr>                                            
                                            <tr>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                            </tr>                                          
                                        </thead> --->
                                    </table>
                                </div>

                            </div>
                            <div class="tab-pane fade" id="s2">
                                <div class="table-responsive">
                                    <table id="textimagesviewTable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptionsTextViewTable" dt-columns="showCase.dtColumnsTextImagesViewTable" dt-instance="showCase.dtInstance2">
                                        <!--- <thead>
                                            <tr>
                                                <th rowspan="2">PRODUCT</th>
                                                <th rowspan="2" class="text-center">GARMENT</th>
                                                <th rowspan="2" class="text-center">COSTING</th>
                                                <th rowspan="2">DESCRIPTION </th>
                                                <th rowspan="2">SIZES</th>
                                                <th rowspan="2">ZONE</th>
                                                <th rowspan="2">AGENT</th>
                                                <th rowspan="2">CUSTOMER</th>
                                                <th rowspan="2">SECTION</th>
                                                <th rowspan="2">STATUS</th>
                                                <th rowspan="2">SKETCH</th>
                                                <th rowspan="2">PICTURE</th>
                                                <th rowspan="2">ACTIONS</th>
                                                <th rowspan="2">DETAIL</th>
                                            </tr>                                            
                                            <tr>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                            </tr> 
                                        </thead> --->
                                    </table>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="s4">
                                <div class="table-responsive">
                                    <table id="pricesviewTable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptionsTextViewTable" dt-columns="showCase.dtColumnsTextPricesViewTable" dt-instance="showCase.dtInstance3">
                                        <thead>
                                            <tr>
                                                <th rowspan="2">PRODUCT</th>
                                                <th rowspan="2" class="text-center">GARMENT</th>
                                                <th rowspan="2" class="text-center">COSTING</th>
                                                <th rowspan="2">DESCRIPTION </th>
                                                <th rowspan="2">CUSTOMER</th>
                                                <th rowspan="2">STATUS</th>
                                                <th rowspan="2">WEB</th>
                                                <th colspan="4" class="text-center">PRICE</th>                                             
                                                <th rowspan="2">PRICE CLUB</th>
                                                <th rowspan="2">PRICE WEB</th>
                                                <th rowspan="2">SKETCH</th>
                                                <th rowspan="2">PICTURE</th>
                                                <th rowspan="2">CONTRACT</th>
                                                <th rowspan="2">ACTIONS</th>
                                                <th rowspan="2">DETAIL</th>
                                            </tr>                                            
                                            <tr>
                                                <th>PRICE</th>
                                                <th>MANUAL</th>
                                                <th>CUSTOM</th>
                                                <th style="border-right-width: 1px;">FINAL</th>
                                            </tr> 
                                        </thead>
                                    </table>
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

    <div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-body">
                    <button type="button" class="close" id="close" data-dismiss="modal" style="display:none;float:right;">&times;</button>
                    <legend class="fcollapsible" id="titleID">Create</legend>
                    <div class="fcontent">
                        <form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
                            <input type="hidden" id="id_cost" value="0">  
                            <div class="form-group display-none" id="divTagZone"ng-class="{'has-error':userForm.zoneID.$invalid && !userForm.zoneID.$pristine}">
                                <label class="control-label col-md-3 text-left bold small">Zone</label>
                                <div class="col-md-7">
                                    <select  ui-select2 id="zoneID" name="zoneID" ng-model="showCase.user.zoneID" data-placeholder="Choose" ng-required="showCase.zoneRequired" ng-change="showCase.changeZone();">
                                        <option value="">Choose</option>
                                        <option ng-repeat="pj in showCase.zone" value="{{pj.id_zone}}">{{pj.z_code}}</option>
                                    </select>
                                    <p ng-show="userForm.zoneID.$error.required && !userForm.zoneID.$pristine" class="help-block">Required</p>
                                </div>
                            </div>

                            <div class="form-group display-none" id="divTagAgent"ng-class="{'has-error':userForm.agentID.$invalid && !userForm.agentID.$pristine}">
                                <label class="control-label col-md-3 text-left bold small">Agent</label>
                                <div class="col-md-7">
                                    <select  ui-select2 id="agentID" name="agentID" ng-model="showCase.user.agentID" data-placeholder="Choose" ng-required="showCase.agentRequired" ng-change="showCase.changeAgent();">
                                        <option value="">Choose</option>
                                        <option ng-repeat="pj in showCase.agent" value="{{pj.id_agent}}">{{pj.ag_code}}</option>
                                    </select>
                                    <p ng-show="userForm.agentID.$error.required && !userForm.agentID.$pristine" class="help-block">Required</p>
                                </div>
                            </div> 

                            <div class="form-group" id="divTagCustomer" ng-class="{'has-error':userForm.customerid.$invalid && !userForm.customerid.$pristine}">
                                <label class="control-label col-md-3 text-left bold small">Customer</label>
                                <div class="col-md-7">
                                    <select  ui-select2 id="customerid" name="customerid" ng-model="showCase.user.customerid" data-placeholder="Choose" ng-change="showCase.changeCustomer();" required>
                                        <option value="">Choose</option>
                                        <option ng-repeat="cus in showCase.custs" value="{{cus.ID}}">{{cus.ID}} - {{cus.NAME}}</option>
                                    </select>
                                    <p ng-show="userForm.customerid.$error.required && !userForm.customerid.$pristine" class="help-block">Required</p>
                                </div>
                            </div> 

                            <div class="form-group" ng-class="{'has-error':userForm.project.$invalid && !userForm.project.$pristine}">
                                <label class="control-label col-md-3 text-left bold small">Project</label>
                                <div class="col-md-7">
                                    <select  ui-select2 id="project" name="project" ng-model="showCase.user.project" data-placeholder="Choose" ng-required="true">
                                        <option value="">Choose</option>
                                        <option ng-repeat="pj in showCase.projects" value="{{pj.id_Project}}">{{pj.pj_description}}</option>
                                    </select>
                                    <p ng-show="userForm.project.$error.required && !userForm.project.$pristine" class="help-block">Rrequired</p>
                                </div>
                            </div>                           

                            <div class="form-group" ng-class="{'has-error':userForm.plz_id.$invalid && !userForm.plz_id.$pristine}" id="divPrlz">
                                <label class="control-label col-md-3 text-left bold small">Price List</label>
                                <div class="col-md-7">
                                    <label>{{showCase.plz.des}}</label>
                                </div>
                            </div>

                            <div class="form-group" ng-class="{'has-error':userForm.pattern.$invalid && !userForm.pattern.$pristine}">
                                <label class="col-md-3 control-label text-left bold small">Pattern</label>
                                <div class="col-md-7">
                                    <select ui-select2 id="pattern" name='pattern' ng-model="showCase.user.pattern" data-placeholder="Choose" ng-required="true" ng-change="showCase.changepattern()">
                                        <option value="">Choose</option>
                                        <option ng-repeat="lang in showCase.patterns" value="{{lang.id_pattern}}">{{lang.pt_code}}</option>
                                    </select>
                                    <p ng-show="userForm.pattern.$error.required && !userForm.pattern.$pristine" class="help-block">Required</p>
                                </div>
                            </div>

                            <div class="form-group" ng-class="{'has-error':userForm.pattern_var.$invalid && !userForm.pattern_var.$pristine}">
                                <label class="col-md-3 control-label text-left bold small">Pattern Variantion</label>
                                <div class="col-md-7">
                                    <select ui-select2 id="pattern_var" name='pattern_var' ng-model="showCase.user.pattern_var" data-placeholder="Choose" ng-required="true" ng-disabled="showCase.isDisabledPatVar">
                                        <option value="">Choose</option>
                                        <option ng-repeat="lang in showCase.pattern_vars" value="{{lang.id_pattern_var}}">{{lang.pv_code}}</option>
                                    </select>
                                    <p ng-show="userForm.pattern_var.$error.required && !userForm.pattern_var.$pristine" class="help-block">Required</p>
                                </div>
                            </div> 
                            
                            <div class="form-group" ng-class="{'has-error':userForm.cost_code.$invalid && !userForm.cost_code.$pristine}">
                                <label class="control-label col-md-3 text-left bold small">Cost Code</label>
                                <div class="col-md-7">
                                    <select  ui-select2 id="cost_code" name="cost_code" ng-model="showCase.user.cost_code" data-placeholder="Choose" ng-required="true" ng-change="showCase.changecost_season()">
                                        <option value="">Choose</option>
                                        <option ng-repeat="cost in showCase.cost_codes" value="{{cost.id_cost}}">{{cost.cost_code}}</option>
                                    </select>
                                    <p ng-show="userForm.cost_code.$error.required && !userForm.cost_code.$pristine" class="help-block">Required</p>
                                </div>
                            </div>
                            <div class="form-group" ng-class="{'has-error':userForm.cost_version.$invalid && !userForm.cost_version.$pristine}">
                                <label class="control-label col-md-3 text-left bold small">Cost Version</label>
                                <div class="col-md-7">
                                    <select  ui-select2 id="cost_version" name="cost_version" ng-model="showCase.user.cost_version" data-placeholder="Choose" ng-required="true" ng-disabled="showCase.isDisabledVer">
                                        <option value="">Choose</option>
                                        <option ng-repeat="lang in showCase.versions" value="{{lang.id_cost_version}}">{{lang.cv_version}}</option>
                                    </select>
                                    <p ng-show="userForm.cost_version.$error.required && !userForm.cost_version.$pristine" class="help-block">Required</p>
                                </div>
                            </div>

                            <!--- <div class="form-group" ng-class="{'has-error':userForm.tp_id.$invalid && !userForm.tp_id.$pristine}">
                                <label class="col-md-3 control-label text-left bold">Type of Product</label>
                                <div class="col-md-7">
                                    <select ui-select2 id="tp_id" name='tp_id' ng-model="showCase.user.tp_id" data-placeholder="Choose" ng-required="true" ng-disabled="true">
                                        <option value="">Choose</option>
                                        <option ng-repeat="lang in showCase.tpList" value="{{lang.tp_id}}">{{lang.des}}</option>
                                    </select>
                                    <p ng-show="userForm.tp_id.$error.required && !userForm.tp_id.$pristine" class="help-block">Type of product is required</p>
                                </div>
                            </div> --->
                            
                            
                            <div class="form-group" ng-class="{'has-error':userForm.size.$invalid && !userForm.size.$pristine}">
                                <label class="control-label col-md-3 text-left bold small">Size</label>
                                <div class="col-md-7">
                                    <select  ui-select2 id="size" name="size" ng-model="showCase.user.size" data-placeholder="Choose" ng-required="true" >
                                        <option value="">Choose</option>
                                        <option ng-repeat="size in showCase.sizes" value="{{size.id_size}}">{{size.sz_description}}</option>
                                    </select>
                                    <p ng-show="userForm.size.$error.required && !userForm.size.$pristine" class="help-block">Required</p>
                                </div>
                            </div>
                            <div class="form-group" style="display:none;">
                                <label class="col-md-3 control-label text-left bold small">Factory</label>
                                <div class="col-md-7">
                                    <select class="form-control" id="factory" name="factory" ng-model="showCase.user.factory" ng-options="factory.ID as factory.CODE for factory in showCase.factories">
                                        <option value="">Choose</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label text-left bold small">Section</label>
                                <div class="col-md-7">
                                    <input class="form-control" placeholder="" type="text" name="section" id="section" ng-model="showCase.user.section">
                                     <p ng-show="userForm.section.$error.required && !userForm.section.$pristine" class="help-block">Required</p>
                                </div>
                            </div>
                            <div class="form-group" ng-class="{'has-error':userForm.pr_version.$invalid && !userForm.pr_version.$pristine}">
                                <label class="col-md-3 control-label text-left bold small">Product Version</label>
                                <div class="col-md-7">
                                    <input class="form-control" placeholder="" type="number" name="pr_version" id="pr_version" ng-model="showCase.user.pr_version" required ng-pattern="showCase.regex"  min="1">
                                    <p ng-show="userForm.pr_version.$error.required && !userForm.pr_version.$pristine" class="help-block">Required</p>
                                    <p ng-show="userForm.pr_version.$error.pattern  && !userForm.pr_version.$pristine" class="help-block">Can not enter special char</p>
                                </div>
                            </div> 
                            <div class="form-group">
                                <label class="col-md-3 control-label text-left bold small">Sketch</label>
                                <div class="col-md-7">
                                    <input type="file" id="cost_sketch" accept="image/*" name="cost_sketch" multiple onchange="angular.element(this).scope().uploadFile(this.files)"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label text-left bold small">Picture</label>
                                <div class="col-md-7">
                                    <input type="file" id="cost_picture" accept="image/*" name="cost_picture" multiple onchange="angular.element(this).scope().uploadPicture(this.files)"/>
                                </div>
                            </div>
                            <div class="form-group" ng-class="{'has-error':userForm.pr_des.$invalid && !userForm.pr_des.$pristine}">
                                <label class="col-md-3 control-label text-left bold small">Description</label>
                                <div class="col-md-7">
                                    <textarea class="form-control" name="pr_des" id="pr_des" ng-model="showCase.user.pr_des"></textarea>
                                </div>
                            </div>
                            <div class="form-group text-right">
                                <div class="col-md-9">
                                    <button class="btn bg-color-blueDark txt-color-white" id="btnAddRow"  ng-click="showCase.addNewProduct()" ng-disabled="userForm.$invalid" >
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
    <div class="modal fade" id="editProduct" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-body">
                    <button type="button" class="close" id="close" data-dismiss="modal" style="display:none;float:right;">&times;</button>
                    <legend class="fcollapsible" id="titleID">Update</legend>
                    <div class="fcontent">
                        <form class="form-horizontal" name="editform" ng-submit="showCase.submitForm()" novalidate>
                            <input type="hidden" id="edit_prId" ng-model="showCase.user.prId">
                            <div class="form-group" ng-class="{'has-error':editform.pr_version.$invalid && !editform.pr_version.$pristine}">
                                <label class="col-md-3 control-label text-left">Product Version</label>
                                <div class="col-md-5">
                                    <input class="form-control" placeholder="" type="number" name="pr_version" id="pr_version" ng-model="showCase.user.pr_version" required ng-pattern="showCase.regex">
                                    <p ng-show="editform.pr_version.$error.required && !editform.pr_version.$pristine" class="help-block">Version of product is required</p>
                                    <p ng-show="editform.pr_version.$error.pattern  && !editform.pr_version.$pristine" class="help-block">Can not enter special char</p>
                                </div>
                            </div>
                            <div class="form-group" ng-class="{'has-error':editform.pr_des.$invalid && !editform.pr_des.$pristine}">
                                <label class="col-md-3 control-label text-left">Description</label>
                                <div class="col-md-5">
                                    <textarea class="form-control" name="pr_des" id="pr_des" ng-model="showCase.user.pr_des"></textarea>
                                </div>
                            </div>
                            <div ng-show="showCase.isFullEdit" class="form-group" ng-class="{'has-error':editform.pricefty.$invalid && !editform.pricefty.$pristine}">
                                <label class="col-md-3 control-label text-left">Price factory</label>
                                <div class="col-md-5">
                                    <input class="form-control" placeholder="" type="number" name="pricefty" id="pricefty" ng-model="showCase.user.pricefty">
                                </div>
                            </div>
                             <div ng-show="showCase.isFullEdit" class="form-group" ng-class="{'has-error':editform.pricezone.$invalid && !editform.pricezone.$pristine}">
                                <label class="col-md-3 control-label text-left">Price Zone</label>
                                <div class="col-md-5">
                                    <input class="form-control" placeholder="" type="number" name="pricezone" id="pricezone" ng-model="showCase.user.pricezone">
                                </div>
                            </div>
                             <div ng-show="showCase.isFullEdit" class="form-group" ng-class="{'has-error':editform.pricecustomer.$invalid && !editform.pricecustomer.$pristine}">
                                <label class="col-md-3 control-label text-left">Price Customer</label>
                                <div class="col-md-5">
                                    <input class="form-control" placeholder="" type="number" name="pricecustomer" id="pricecustomer" ng-model="showCase.user.pricecustomer">
                                </div>
                            </div>
                             <div ng-show="showCase.isFullEdit" class="form-group" ng-class="{'has-error':editform.priceclub.$invalid && !editform.priceclub.$pristine}">
                                <label class="col-md-3 control-label text-left">Price club</label>
                                <div class="col-md-5">
                                    <input class="form-control" placeholder="" type="number" name="priceclub" id="priceclub" ng-model="showCase.user.priceclub">
                                </div>
                            </div>
                             <div ng-show="showCase.isFullEdit" class="form-group" ng-class="{'has-error':editform.priceweb.$invalid && !editform.priceweb.$pristine}">
                                <label class="col-md-3 control-label text-left">Price web</label>
                                <div class="col-md-5">
                                    <input class="form-control" placeholder="" type="number" name="priceweb" id="priceweb" ng-model="showCase.user.priceweb">
                                </div>
                            </div>
                            <div class="form-group text-center">
                                <div class="col-md-3"></div>
                                <div class="col-md-7">
                                    <button class="btn bg-color-blueDark txt-color-white" id="btnAddRow"  ng-click="showCase.saveUpdateProduct()" ng-disabled="editform.$invalid" >
                                        <i class="fa fa-save"></i>
                                        &nbsp;Update
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

    <div class="modal fade" id="showDelete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
        <div class="modal-dialog" id="modalForm">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="fcontent">
                        <label>Do you want to delete this product?</label>
                        <div class="form-group pull-right">
                            <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                            <button type="submit" id="butsubmit" class="btn btn-info" ng-click="showCase.deleteProduct()">Yes</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<cfoutput>
    <script src="/includes/js/jquery.dataTables.min.js?v=#application.version#"></script>
    <script src="/includes/js/dataTables.select.min.js?v=#application.version#"></script>
    <script src="/includes/js/angular-datatables.min.js?v=#application.version#"></script>
    <script src="/includes/js/dataTables.lightColumnFilter.min.js?v=#application.version#"></script>
    <script src="/includes/js/angular-datatables.light-columnfilter.min.js?v=#application.version#"></script>
    <script src="/includes/js/views/product.js?v=#application.version#"></script>
</cfoutput>