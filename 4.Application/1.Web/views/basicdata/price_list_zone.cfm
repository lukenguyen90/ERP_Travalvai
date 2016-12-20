<style type="text/css">
    .select2-container{
        width:100%;
    }
    .dt-toolbar{
        padding-left:0px;
        padding-right:0px;
    }
    .modal-lg {
        width: 100%;
    }
    .modal-dialog{
        width: 670px;
    }

    input.label1{
        background-color: #fff !important;
        border: 0px;
    }
    label.boldFont{
        font-weight: bold;
    }
    span.inverseNumber{
        background-color: #f2f2f2;
        border: 0 none;
        margin-top: -14px;
    }

    th.th-text-left{
        text-align: left !important;
    }
</style>
<section id="widget-grid" class="" ng-app='price.List.zone' ng-controller="BindAngularDirectiveCtrl as showCase">
    <div class="row">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
                <header>
                    <span class="widget-icon"> <i class="fa fa-table"></i> </span>
                    <h2>Price List Zone</h2>
                </header>
                <div>
                    <div class="widget-body" >
                        <div class="row">
                            <div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                            <button type="button" class="close" id="close" data-dismiss="modal" style="display:none;float:right;">&times;</button>
                                            <legend class="fcollapsible" id="titleID">Create</legend>
                                            <div class="fcontent">
                                                <form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
                                                    <input type="hidden" id="id_plz" value="0">
                                                    <div class="form-group" ng-class="{'has-error':userForm.code.$invalid && !userForm.code.$pristine}">
                                                        <label class="col-md-3 control-label boldFont text-left">Code</label>
                                                        <div class="col-md-9">
                                                            <input class="form-control" placeholder="" type="text" name="code" id="code" ng-model="showCase.user.code" ng-pattern="showCase.regex"  required>
                                                            <p ng-show="userForm.code.$error.required && !userForm.code.$pristine" class="help-block">Code is required</p>
                                                            <p ng-show="userForm.code.$error.pattern  && !userForm.code.$pristine" class="help-block">Can not enter special char</p>
                                                        </div>
                                                    </div>
                                                    <div class="form-group" ng-class="{'has-error':userForm.description.$invalid && !userForm.description.$pristine}">
                                                        <label class="col-md-3 control-label boldFont text-left">Description</label>
                                                        <div class="col-md-9">
                                                            <input class="form-control" placeholder="" type="text" name="description" id="description" ng-model="showCase.user.description" required>
                                                            <p ng-show="userForm.description.$error.required && !userForm.description.$pristine" class="help-block">Description is required</p>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group" ng-class="{'has-error':userForm.season.$invalid && !userForm.season.$pristine}">
                                                                <label class="control-label boldFont col-md-6 text-left">Season</label>
                                                                <div class="col-md-6">
                                                                    <select  ui-select2 id="add_sourceseason" name="add_sourceseason" ng-model="showCase.user.season" ng-required="true" ng-change="showCase.changeSourceSeasonAddNew()">
                                                                        <option value="">Choose</option>
                                                                        <option ng-repeat="lang in showCase.newseasons" value="{{lang.season}}">{{lang.season}}</option>
                                                                    </select>
                                                                    <p ng-show="userForm.season.$error.required && !userForm.season.$pristine" class="help-block">Season is required</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group" ng-class="{'has-error':userForm.plf.$invalid && !userForm.plf.$pristine}">
                                                                <label class="col-md-6 control-label boldFont text-left">P.L. Factory</label>
                                                                <div class="col-md-6">
                                                                    <select  ui-select2 id="plf" name="plf" ng-model="showCase.user.plf" ng-required="true" ng-change="showCase.getftycurrency()" ng-disabled="showCase.plfDisabled">
                                                                        <option value="">Choose</option>
                                                                        <option ng-repeat="lang in showCase.plfs" value="{{lang.id_plf}}">{{lang.plf_code}}</option>
                                                                    </select>
                                                                    <p ng-show="userForm.plf.$error.required && !userForm.plf.$pristine" class="help-block">Required</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="col-md-6 control-label boldFont text-left">P.L. Factory Currency</label>
                                                                <div class="col-md-6">
                                                                    <input type="text" class="form-control label1" id="ftycurrency" name="ftycurrency" ng-model="showCase.user.ftycurrency" disabled>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                             <div class="form-group">
                                                                <label class="col-md-6 control-label boldFont text-left">Ex. Rate (USD/<span data-ng-bind="showCase.user.ftycurrency"></span>)</label>
                                                                <div class="col-md-6">
                                                                    <input type="text" class="form-control label1" id="plfex_rate" name="plfex_rate" ng-model="showCase.user.plfEx_RateShow" disabled>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group" ng-class="{'has-error':userForm.currency.$invalid && !userForm.currency.$pristine}">
                                                                <label class="col-md-6 control-label boldFont text-left">P.L. Zone Currency</label>
                                                                <div class="col-md-6">
                                                                    <select  ui-select2 id="currency" name="currency" ng-model="showCase.user.currency" ng-required="true" ng-change="showCase.changePLC()">
                                                                        <option value="">Choose</option>
                                                                        <option ng-repeat="lang in showCase.currencylist" value="{{lang.id_currency}}">{{lang.curr_code}}</option>
                                                                    </select>
                                                                    <p ng-show="userForm.currency.$error.required  && !userForm.currency.$pristine" class="help-block">Required</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="cc_value" class="col-md-6 control-label boldFont text-left">Ex. Rate (USD/<span data-ng-bind="showCase.user.plzcurrencytext"></span>)</label>
                                                                <div class="col-md-6">
                                                                    <input type="text" class="form-control label1" id="cc_value" name="cc_value" ng-model="showCase.currency_convert.cc_valueShow" disabled>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="cc_value" class="col-md-6 control-label boldFont text-left">Ex. Rate (<span data-ng-bind="showCase.user.ftycurrency"></span>/<span data-ng-bind="showCase.user.plzcurrencytext"></span>)</label>
                                                                <div class="col-md-6">
                                                                    <input type="text" class="form-control label1" id="cc_value" name="cc_value" ng-model="showCase.user.plz_ex_rateShow" disabled>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group" ng-class="{'has-error':userForm.ex_rate.$invalid && !userForm.ex_rate.$pristine}">
                                                                <label class="col-md-6 control-label boldFont text-left">Manual Ex. Rate</label>
                                                                <div class="col-md-6">
                                                                    <input class="form-control" placeholder="" type="text" name="ex_rate" id="ex_rate" ng-pattern="showCase.regexNumber" ng-model="showCase.user.ex_rate" ng-change="showCase.changeManualExRate()" ng-min="0" required>
                                                                    <p ng-show="userForm.ex_rate.$error.required  && !userForm.ex_rate.$pristine" class="help-block">Required</p>
                                                                     <p ng-show="userForm.ex_rate.$error.pattern  && !userForm.ex_rate.$pristine" class="help-block">Numeric only</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="col-md-6"></label>
                                                                <label class="col-md-6">
                                                                    <span data-ng-bind="showCase.user.convertCc_ex_rateShow" class="form-control inverseNumber"></span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="col-md-6"></label>
                                                                <label class="col-md-6"><span  data-ng-bind="showCase.user.convertplz_ex_rateShow" class="form-control inverseNumber"></span></label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <!--- <div class="col-md-6">
                                                            <div class="form-group" ng-class="{'has-error':userForm.correction.$invalid && !userForm.correction.$pristine}">
                                                                <label class="col-md-6 control-label boldFont text-left">Correction (%)</label>
                                                                <div class="col-md-6">
                                                                    <input class="form-control" placeholder="" type="text" name="correction" id="correction" ng-pattern="showCase.regexNumber" ng-model="showCase.user.correction" ng-min="0" ng-max="100" required>
                                                                    <p ng-show="userForm.correction.$error.required  && !userForm.correction.$pristine" class="help-block">Correction is required</p>
                                                                    <p ng-show="userForm.correction.$error.pattern  && !userForm.correction.$pristine" class="help-block">It must contain numeric character only</p>
                                                                </div>
                                                            </div>
                                                        </div> --->
                                                        <div class="col-md-6">
                                                            <div class="form-group" ng-class="{'has-error':userForm.commission.$invalid && !userForm.commission.$pristine}">
                                                                <label class="col-md-6 control-label boldFont text-left">Commission (%)</label>
                                                                <div class="col-md-6">
                                                                    <input class="form-control" placeholder="" type="text" name="commission" id="commission" ng-pattern="showCase.regexNumber" ng-model="showCase.user.commission" required>
                                                                    <p ng-show="userForm.commission.$error.required  && !userForm.commission.$pristine" class="help-block">Commission is required</p>
                                                                    <p ng-show="userForm.commission.$error.pattern  && !userForm.commission.$pristine" class="help-block">It must contain numeric character only</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group" ng-class="{'has-error':userForm.freight.$invalid && !userForm.freight.$pristine}">
                                                                <label class="col-md-6 control-label boldFont text-left">Freight ( <span data-ng-bind="showCase.currency_freight"></span>/Kg )</label>
                                                                <div class="col-md-6">
                                                                    <input class="form-control" placeholder="" type="text" name="freight" id="freight" ng-pattern="showCase.regexNumber" ng-model="showCase.user.freight" required>
                                                                    <p ng-show="userForm.freight.$error.required  && !userForm.freight.$pristine" class="help-block">Freight is required</p>
                                                                    <p ng-show="userForm.freight.$error.pattern  && !userForm.freight.$pristine" class="help-block">It must contain numeric character only</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                             <div class="form-group" ng-class="{'has-error':userForm.taxes.$invalid && !userForm.taxes.$pristine}">
                                                                <label class="col-md-6 control-label boldFont text-left">Taxes (%)</label>
                                                                <div class="col-md-6">
                                                                    <input class="form-control" placeholder="" type="text" name="taxes" id="taxes" ng-pattern="showCase.regexNumber" ng-model="showCase.user.taxes" required>
                                                                    <p ng-show="userForm.taxes.$error.required  && !userForm.taxes.$pristine" class="help-block">Taxes is required</p>
                                                                    <p ng-show="userForm.taxes.$error.pattern  && !userForm.taxes.$pristine" class="help-block">It must contain numeric character only</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group" ng-class="{'has-error':userForm.margin.$invalid && !userForm.margin.$pristine}">
                                                                <label class="col-md-6 control-label boldFont text-left">Margin (%)</label>
                                                                <div class="col-md-6">
                                                                    <input class="form-control" placeholder="" type="text" name="margin" id="margin" ng-pattern="showCase.regexNumber" ng-model="showCase.user.margin" required>
                                                                    <p ng-show="userForm.margin.$error.required  && !userForm.margin.$pristine" class="help-block">Margin is required</p>
                                                                    <p ng-show="userForm.margin.$error.pattern  && !userForm.margin.$pristine" class="help-block">It must contain numeric character only</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                             <div class="form-group" ng-class="{'has-error':userForm.language.$invalid && !userForm.language.$pristine}">
                                                                <label class="control-label boldFont col-md-6 text-left">Language</label>
                                                                <div class="col-md-6">
                                                                    <select  ui-select2 id="language" name="language" ng-model="showCase.user.language" ng-required="true">
                                                                        <option value="">Choose</option>
                                                                        <option ng-repeat="lang in showCase.languages" value="{{lang.id_language}}">{{lang.lg_name}}</option>
                                                                    </select>
                                                                    <p ng-show="userForm.language.$invalid && !userForm.language.$pristine" class="help-block">Please choose language</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>


                                                    <div class="form-group text-right">
                                                        <!--- <div class="col-md-3"></div> --->
                                                        <div class="col-md-12">
                                                            <button class="btn bg-color-blueDark txt-color-white" id="btnAddRow"  ng-click="showCase.addRow()" ng-disabled="userForm.$invalid">
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
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                            <button type="button" class="close" id="close" data-dismiss="modal" style="float:right;">&times;</button>
                                            <legend class="fcollapsible" id="titleID">Create by Copy</legend>
                                            <div class="fcontent">
                                                <form class="form-horizontal" name="copyForm" ng-submit="showCase.submitForm()" novalidate>
                                                    <div class="form-group">
                                                        <div class="col-md-3 text-right"><strong>Source</strong></div>
                                                        <div class="col-md-3" ng-class="{'has-error':copyForm.plzSourceseason.$invalid && !copyForm.plzSourceseason.$pristine}">
                                                            <select  ui-select2 id="plzSourceseason" name="plzSourceseason" ng-change="showCase.changeSourceSeasonCopy()" ng-model="showCase.user.plzSourceseason" ng-required="true">
                                                                <option value="">Choose</option>
                                                                <option ng-repeat="plzsourceseason in showCase.plzSourceSeasons" value="{{plzsourceseason.ID}}">{{plzsourceseason.SEASON}}</option>
                                                            </select>
                                                            <p ng-show="copyForm.plzSourceseason.$error.required && !copyForm.plzSourceseason.$pristine" class="help-block">Required</p>
                                                        </div>
                                                        <div class="col-md-6"  ng-class="{'has-error':copyForm.sourceplz.$invalid && !copyForm.sourceplz.$pristine}">
                                                            <select  ui-select2 id="sourceplz" name="sourceplz" ng-model="showCase.user.sourceplz" ng-required="true">
                                                                <option value="">Choose</option>
                                                                <option ng-repeat="plzcopy in showCase.plzsCopy" value="{{plzcopy.id_plz}}">{{plzcopy.plz_code}}</option>
                                                            </select>
                                                            <p ng-show="copyForm.sourceplz.$error.required && !copyForm.sourceplz.$pristine" class="help-block">Required</p>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="col-md-3 text-right"><strong>Destination</strong></div>
                                                        <div class="col-md-9">
                                                            <div class="row">
                                                                <div class="col-md-4">Code</div>
                                                                <div class="col-md-8" ng-class="{'has-error':copyForm.codeCopy.$invalid && copyForm.codeCopy.$dirty}">
                                                                    <input class="form-control" placeholder="" type="text" name="codeCopy" id="codeCopy" ng-model="showCase.user.codeCopy" required>
                                                                    <p class="help-block appendafter" style="color:red;" ng-show="showCase.CodeExist">Code is already exist</p>
                                                                    <p ng-show="copyForm.codeCopy.$error.required  && !copyForm.codeCopy.$pristine" class="help-block">Required</p>
                                                                </div>
                                                            </div>
                                                            <div class="row margin-top-5">
                                                                <div class="col-md-4">Description</div>
                                                                <div class="col-md-8"  ng-class="{'has-error':copyForm.descriptionCopy.$invalid && !copyForm.descriptionCopy.$pristine}">
                                                                    <input class="form-control" placeholder="" type="text" name="descriptionCopy" id="descriptionCopy" ng-model="showCase.user.descriptionCopy" required>
                                                                    <p ng-show="copyForm.descriptionCopy.$error.required  && !copyForm.descriptionCopy.$pristine" class="help-block">Required</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group text-right">
                                                        <div class="col-md-12">
                                                            <div class="btn bg-color-blueDark txt-color-white pull-right" id="btnCopyData"  ng-click="showCase.CopyData()" ng-disabled="copyForm.$invalid">
                                                                <i class="fa fa-save"></i>
                                                                &nbsp;Create
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div>
                                        <legend class="col-md-7 fcollapsible">Price List Zone</legend>
                                        <div class="btn col-md-2 bg-color-blueDark txt-color-white" id="btnCopyData" ng-click="showCase.showCopyData()">
                                            <i class="fa fa-save"></i>&nbsp;Create By Copy
                                        </div>
                                        <div class="col-md-1"></div>
                                        <div class="btn col-md-2 bg-color-blueDark txt-color-white" id="btnAddNew" ng-click="showCase.showAddNew()">
                                            <i class="fa fa-save"></i>&nbsp;Create
                                        </div>
                                        <div class="fcontent col-md-12">
                                            <div class="table-responsive">
                                                <table id="datatable_fixed_column_1" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance" style="display:none;">
                                                    <thead>
                                                        <tr>
                                                            <th rowspan="2">CODE</th>
                                                            <th rowspan="2">DESCRIPTION</th>
                                                            <th rowspan="2">SEASON</th>
                                                            <th colspan="2"  style="text-align:center;">PRICE LIST FACTORY</th>
                                                            <th rowspan="2">P.L. CURRENCY</th>
                                                            <th rowspan="2">EX. RATE</th>
                                                            <th rowspan="2">DATE</th>
                                                            <th rowspan="2">UPDATE</th>
                                                            <th rowspan="2">CORRECTION</th>
                                                            <th rowspan="2">COMMISSION</th>
                                                            <th rowspan="2">FREIGHT</th>
                                                            <th rowspan="2">TAXES</th>
                                                            <th rowspan="2">MARGIN</th>
                                                            <th rowspan="2">LANGUAGE</th>
                                                            <th rowspan="2">DETAIL</th>
                                                        </tr>
                                                        <tr class="fix_header">
                                                            <th></th>
                                                            <th style="border-right-width: 1px;"></th>
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
<cfoutput>
<script src="/includes/js/jquery.dataTables.min.js?v=#application.version#"></script>
<script src="/includes/js/dataTables.select.min.js?v=#application.version#"></script>
<script src="/includes/js/angular-datatables.min.js?v=#application.version#"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js?v=#application.version#"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js?v=#application.version#"></script>
<script src="/includes/js/views/price_list_zone.js?v=#application.version#"></script>
</cfoutput>
