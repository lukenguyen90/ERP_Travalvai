<section id="widget-grid"  ng-app='sizedetail.List' ng-controller="BindAngularDirectiveCtrl as showCase">
	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Sizes Detail</h2>

				</header>

				<!-- widget div-->
				<div>
					<!-- widget content -->
					<div class="widget-body">
						<form class="form-horizontal">
							<div class="row">
								<div class="col-md-8 col-md-offset-2">
									<div class="table-responsive">
	                                    <table id="sizesviewTable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptionsSizesViewTable" dt-columns="showCase.dtColumnsSizesViewTable" dt-instance="showCase.dtInstance">
	                                    </table>
									</div>
								</div>
							</div>
							<div class="row form-actions">
								<div class="col-md-12 text-center">
									<button class="btn bg-color-blueDark txt-color-white" id="btnSave" ng-disabled="!showCase.editing" ng-click="showCase.saveDetail()">
										<i class="fa fa-save"></i>
										&nbsp;Save
									</button>
									<button class="btn btn-default" ng-click="showCase.quit()">
										<i class="fa fa-sign-out"></i>
										&nbsp;Quit
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</article>
	</div>
</section>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/size.detail.js"></script>