<style type="text/css">
	.dt-toolbar, .dt-toolbar-footer{
		display:none;
	}
</style>
<section id="widget-grid" class="" ng-app="project.status" ng-cloak>
	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Project Status</h2>
				</header>
				<div>
					<!-- widget content -->
					<div class="widget-body" ng-controller="BindAngularDirectiveCtrl as showCase">
						<div class="row">
							<div class="col-md-6">
								<legend class="fcollapsible">Project Status Detail</legend>
								<div class="fcontent">
									<form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
										<input type='hidden' name="id_Stt" id="id_Stt" value="0">
										<div class="form-group" ng-class="{'has-error':userForm.projectStatus.$invalid && !userForm.projectStatus.$pristine}">
											<label class="col-md-3 control-label text-left"><strong>Project Status</strong></label>
											<div class="col-md-4">
												<input class="form-control" placeholder="" type="text" name="projectStatus" ng-model="showCase.user.projectStatus" id="projectStatus" ng-pattern="showCase.regex" required>
												<p ng-show="userForm.projectStatus.$error.required && !userForm.projectStatus.$pristine" class="help-block">This field is required</p>
												<p ng-show="userForm.projectStatus.$error.pattern  && !userForm.projectStatus.$pristine" class="help-block">Can not enter special char</p>
											</div>
											<!--- <div class="col-md-1">
									      		<input type="text" class="form-control color-picker" name="duplicated-name-2" data-palette='[{"Aqua": "#00FFFF"},{"BlueViolet": "#8A2BE2"},{"Chocolate": "#D2691E"},{"Crimson ": "#DC143C"},{"DarkGreen": "#006400"},{"DarkOrange": "#FF8C00"},{"DeepPink ": "#FF1493"},{"Gold":"#FFD700"},{"Green ":"#008000"},{"Indigo":"#4B0082"},{"LawnGreen":"#7CFC00"},{"LightSeaGreen ":"#20B2AA"},{"Purple ":"#800080"},{"Pink ":"#FFC0CB"},{"MediumBlue ":"#0000CD"},{"MediumSpringGreen ":"#00FA9A"},{"OrangeRed ":"#FF4500"},{"Orchid ":"#DA70D6"},{"Red ":"#FF0000"},{"SeaGreen ":"#2E8B57"},{"Teal ":"#008080"},{"Yellow ":"#FFFF00"},{"YellowGreen ":"#9ACD32"},{"SlateBlue ":"#6A5ACD"},{"Salmon ":"#FA8072"},{"RebeccaPurple":"#663399"}]' value="" style="display:none;">
									    	</div> --->
									    	<div  class="col-md-3 btn bg-color-blueDark txt-color-white" id="addProjectStatus" ng-click="showCase.addRow()" ng-disabled="userForm.$invalid">
												<i class="fa fa-save"></i>
												&nbsp;Add/Update
											</div>
										</div>

									</form>
								</div>
							</div>
							<div class="col-md-6">
								<fieldset>
									<legend class="fcollapsible">Project Status List</legend>
									<div class="fcontent">
										<table id="myTable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance">
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
</section>
<div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
	<div class="modal-dialog" id="modalForm">
		<div class="modal-content">
			<div class="modal-header alert-info">
				<h3 class="modal-title" id="myModalLabel">Are you sure you want to delete this item?</h3>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
				<button type="submit" id="butsubmit" class="btn btn-info">Yes</button>
			</div>
		</div>
	</div>
</div>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/angular-datatables.columnfilter.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/project.status.js"></script>
<script src="/includes/js/palette-color-picker.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="/includes/css/palette-color-picker.css">
<script type="text/javascript">
$(document).ready(function(){
	$('[name="duplicated-name-2"]').paletteColorPicker({
	    clear_btn: 'last',
	    insert: 'after'
	  });
})

<!--- ["#D50000","#304FFE","#00B8D4","#00C853","#FFD600","#FF6D00","#FF1744","#3D5AFE","#00E5FF","#00E676","#FFEA00","#FF9100","#FF5252","#536DFE","#18FFFF","#69F0AE","#FFFF00","#FFAB40"] --->
</script>
