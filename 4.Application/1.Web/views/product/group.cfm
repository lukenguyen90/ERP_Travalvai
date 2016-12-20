<style type="text/css">
    th.th-text-left{
        text-align: left !important;
    }
</style>
<section id="widget-grid" class="" ng-app="product_group.List"  ng-controller="BindAngularDirectiveCtrl as showCase">
    <div class="row">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
                <header>
                    <span class="widget-icon"> <i class="fa fa-table"></i> </span>
                    <h2>Group of Product</h2>
                </header>
                <div>
                    <div class="widget-body">
                        <div class="row">
                            <div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                            <legend class="fcollapsible" id="titleID">Create</legend>
                                            <div class="fcontent">
                                                <form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
                                                    <input type='hidden' name="id_Group" id="id_Group" value="0">
                                                    <div class="form-group" ng-class="{'has-error' : userForm.code.$invalid && !userForm.code.$pristine}">
                                                        <label class="col-md-2 control-label text-left"><strong>Code</strong></label>
                                                        <div class="col-md-10">
                                                            <input class="form-control" style="width: 456px;" placeholder="" type="text" name="code" id="code" ng-model="showCase.user.code" ng-pattern="showCase.regex"  required>
                                                            <p ng-show="userForm.code.$error.required && !userForm.code.$pristine" class="help-block">Code is required</p>
                                                            <p ng-show="userForm.code.$error.pattern  && !userForm.code.$pristine" class="help-block">Can not enter special char</p>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 control-label text-left"><strong>Description</strong></label>
                                                    </div>
                                                    <div class="form-group">
                                                        <div ng-repeat="item in showCase.newDes" >
                                                            <div id="{{item.lg_code}}" class="col-md-12">
                                                                <label class="col-md-1 control-label text-left">{{item.lg_code}}</label>
                                                                <label class="col-md-1 control-label text-left"></label>
                                                                <div class="col-md-10" style="padding: 6px">
                                                                    <textarea class="form-control" placeholder="in {{item.lg_name}}" name="{{item.lg_code}}" id="{{item.lg_code}}{{item.id_language}}" rows="1" ng-model="item.description"></textarea>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="col-md-2"></div>
                                                        <div class="col-md-10">
                                                            <input type="checkbox" id="checkboxdes" name="checkboxdes" checked> Use English for empty descriptions
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="col-md-12 text-center">
                                                            <button class="btn bg-color-blueDark txt-color-white" id="btnAddRow" ng-click="showCase.addRow()" ng-disabled="userForm.$invalid">
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
                                    <legend class="fcollapsible col-md-10">Group of Product</legend>
                                    <div class="btn col-md-2 bg-color-blueDark txt-color-white" id="btnCreate" style="display:none;" ng-click="showCase.showAddNew()">
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
<script src="/includes/js/views/product.group.js?v=#application.version#"></script>
</cfoutput>
