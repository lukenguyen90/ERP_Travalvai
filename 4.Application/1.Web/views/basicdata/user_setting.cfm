<section id="widget-grid" class="" ng-app="user_setting"  ng-controller="BindAngularDirectiveCtrl as showCase">
    <div class="row">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
                <header>
                    <span class="widget-icon"> <i class="fa fa-table"></i> </span>
                    <h2>User Setting</h2>
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
                                                    <input type='hidden' name="id_Set" id="id_Set" value="0">
                                                    <div class="form-group" ng-class="{'has-error' : userForm.user.$invalid && !userForm.user.$pristine}">
                                                        <label class="control-label col-md-3 text-left">User</label>
														<div class="col-md-9">
															<select ui-select2 id="user" name="user" ng-model="showCase.user.user" data-placeholder="Choose" ng-required="true">
															    <option ng-repeat="lang in showCase.users" value="{{lang.ID}}">{{lang.NAME}}</option>
															</select>
														</div>
                                                    </div>
                                                    <div class="form-group" ng-class="{'has-error' : userForm.language.$invalid && !userForm.language.$pristine}">
                                                        <label class="control-label col-md-3 text-left">Language</label>
														<div class="col-md-9">
															<select ui-select2 id="language" name="language" ng-model="showCase.user.language" data-placeholder="Choose" ng-required="true">
															    <option ng-repeat="lang in showCase.languages" value="{{lang.id_language}}">{{lang.lg_name}}</option>
															</select>
														</div>
                                                    </div>
                                                    <div class="form-group text-center">
                                                    	<div class="col-md-3"></div>
                                                        <div class="col-md-7">
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
                                    <div class="col-md-10"><legend class="fcollapsible">User Setting List</legend></div>
                                    <div class="btn col-md-2 bg-color-blueDark txt-color-white" id="btnAddRow" ng-click="showCase.showAddNew()">
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

<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/user_setting.js"></script>
