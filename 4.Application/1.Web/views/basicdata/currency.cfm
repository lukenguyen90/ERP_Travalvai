<section id="widget-grid" class="" ng-app="currency" ng-controller="BindAngularDirectiveCtrl as showCase">
    <!-- row -->
    <div class="row">
        <!-- NEW WIDGET START -->
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <!-- Widget ID (each widget will need unique ID)-->
            <div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
                <header>
                    <span class="widget-icon"> <i class="fa fa-table"></i> </span>
                    <h2>Currency Detail</h2>
                </header>
                <!-- widget div-->
                <div>
                    <!-- widget content -->
                    <div class="widget-body">
                        <div class="row">
                            <div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                            <legend class="fcollapsible" id="titleID">Create</legend>
                                            <div class="fcontent">
                                                <form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
                                                    <input type='hidden' name="id_Stt" id="id_Stt" value="0">
                                                    <div class="form-group" ng-class="{'has-error' : userForm.code.$invalid && !userForm.code.$pristine}">
                                                        <label class="col-md-2 control-label text-left"><b>Code</b></label>
                                                        <div class="col-md-10">
                                                            <input class="form-control" placeholder="" type="text" name="code" id="code" ng-model="showCase.user.code" ng-pattern="showCase.regex" required>
                                                             <p ng-show="userForm.code.$error.required && !userForm.code.$pristine" class="help-block">Code is required</p>
                                                            <p ng-show="userForm.code.$error.pattern  && !userForm.code.$pristine" class="help-block">Can not enter special char</p>
                                                        </div>
                                                    </div>
                                                    <div class="form-group" ng-class="{'has-error' : userForm.description.$invalid && !userForm.description.$pristine}">
                                                        <label class="col-md-2 control-label text-left"><b>Description</b></label>
                                                        <div class="col-md-10">
                                                            <input class="form-control" placeholder="" type="text" name="description" id="description" ng-model="showCase.user.description" required>
                                                            <p ng-show="userForm.description.$error.required && !userForm.description.$pristine" class="help-block">Description is required</p>
                                                        <!---     <p ng-show="userForm.description.$error.pattern  && !userForm.description.$pristine" class="help-block">Can not enter special char</p> --->
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
                                    <div class="btn col-md-2 col-md-offset-10 bg-color-blueDark txt-color-white" id="btnAddRow" ng-click="showCase.showAddNew()">
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
                    <!--- <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">#getLabel('Close')#</span></button> --->
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
<script src="/includes/js/views/currency.list.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>