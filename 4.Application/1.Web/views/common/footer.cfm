<!-- PAGE FOOTER -->
<!-- IMPORTANT: APP CONFIG -->
<script src="/includes/js/app.config.js"></script>

<!-- JS TOUCH : include this plugin for mobile drag / drop touch events-->
<script src="/includes/js/plugin/jquery-touch/jquery.ui.touch-punch.min.js"></script>

<!-- BOOTSTRAP JS -->
<script src="/includes/js/bootstrap/bootstrap.min.js"></script>

<!-- CUSTOM NOTIFICATION -->
<script src="/includes/js/notification/SmartNotification.min.js"></script>

<!-- JARVIS WIDGETS -->
<script src="/includes/js/smartwidgets/jarvis.widget.min.js"></script>

<!-- EASY PIE CHARTS -->
<script src="/includes/js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js"></script>

<!-- SPARKLINES -->
<script src="/includes/js/plugin/sparkline/jquery.sparkline.min.js"></script>

<!-- JQUERY VALIDATE -->
<script src="/includes/js/plugin/jquery-validate/jquery.validate.min.js"></script>

<!-- JQUERY MASKED INPUT -->
<script src="/includes/js/plugin/masked-input/jquery.maskedinput.min.js"></script>

<!-- JQUERY SELECT2 INPUT -->
<script src="/includes/js/plugin/select2/select2.min.js"></script>

<!-- JQUERY UI + Bootstrap Slider -->
<script src="/includes/js/plugin/bootstrap-slider/bootstrap-slider.min.js"></script>

<!-- browser msie issue fix -->
<script src="/includes/js/plugin/msie-fix/jquery.mb.browser.min.js"></script>

<!-- FastClick: For mobile devices -->
<script src="/includes/js/plugin/fastclick/fastclick.min.js"></script>

<!--[if IE 8]>

<h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>

<![endif]-->

<!-- Demo purpose only -->
<script src="/includes/js/demo.min.js"></script>

<!-- MAIN APP JS FILE -->
<script src="/includes/js/app.min.js"></script>

<!-- ENHANCEMENT PLUGINS : NOT A REQUIREMENT -->
<!-- Voice command : plugin -->
<script src="/includes/js/speech/voicecommand.min.js"></script>

<!-- SmartChat UI : plugin -->
<script src="/includes/js/smart-chat-ui/smart.chat.ui.min.js"></script>
<script src="/includes/js/smart-chat-ui/smart.chat.manager.min.js"></script>

<!-- PAGE RELATED PLUGIN(S)
<script src="..."></script>-->
<script src="/includes/js/plugin/datatables/jquery.dataTables.min.js"></script>
<script src="/includes/js/plugin/datatables/dataTables.colVis.min.js"></script>
<script src="/includes/js/plugin/datatables/dataTables.tableTools.min.js"></script>
<script src="/includes/js/plugin/datatables/dataTables.bootstrap.min.js"></script>
<script src="/includes/js/plugin/datatable-responsive/datatables.responsive.min.js"></script>
<script src="/includes/js/plugin/x-editable/x-editable.min.js"></script>
<script src="/includes/js/plugin/lightbox/lightbox.min.js"></script>
<script src="//cdn.jsdelivr.net/webshim/1.14.5/polyfiller.js"></script>
<script src="/includes/js/select2.js"></script>



<script>
    webshims.setOptions('forms-ext', {types: 'date'});
	webshims.polyfill('forms forms-ext');
</script>
<script type="text/javascript">

	$(document).ready(function() {

		 pageSetUp();

		$('legend').click(function(){
	        $(this).parent().find('.fcontent').slideToggle();

	        $(this).parent().find('.fcollapsible').toggleClass('selected')
	    });

	    $('.inputDate').datepicker({
	    	prevText: '<i class="fa fa-chevron-left"></i>',
			nextText: '<i class="fa fa-chevron-right"></i>',
			dateFormat: 'dd-mm-y'
	    });

	    $('[data-toggle="popover"]').popover({
	        placement : 'top',
	        trigger : 'hover'
	    });
	});

	function noticeSuccess(message)
	{

			$.smallBox({
							title : "Notification",
							content : "<i class='fa fa-clock-o'></i> <i>"+message+".</i>",
							color : "##659265",
							iconSmall : "fa fa-check fa-2x fadeInRight animated",
							sound: 'off',
							timeout : 4000
						});

	}

	function noticeFailed(message)
	{
		$.smallBox({
							title : "Notification",
							content : "<i class='fa fa-clock-o'></i> <i>"+message+"</i>",
							color : "##C46A69",
							iconSmall : "fa fa-check fa-2x fadeInRight animated",
							timeout : 4000
						});
	}
</script>

<!-- Your GOOGLE ANALYTICS CODE Below -->
<script type="text/javascript">
	var _gaq = _gaq || [];
		_gaq.push(['_setAccount', 'UA-XXXXXXXX-X']);
		_gaq.push(['_trackPageview']);

	(function() {
		var ga = document.createElement('script');
		ga.type = 'text/javascript';
		ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0];
		s.parentNode.insertBefore(ga, s);
	})();
</script>