$(document).ready(function() {
	var responsiveHelper_datatable_fixed_column = undefined;
	var breakpointDefinition = {
		tablet : 1024,
		phone : 480
	};

	/* COLUMN FILTER  */
    var otable = $('.datatable_fixed_column').DataTable({

		"sDom": "<<'col-xs-12 col-sm-10 hidden-xs filter'><'col-sm-2 col-xs-12 hidden-xs'>r>"+
				"t"+
				"<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
		"bFilter": false,
		// "order": [[ 2, "desc" ], [ 3, "asc" ]],
		"autoWidth" : true,
		"preDrawCallback" : function() {
			// Initialize the responsive datatables helper once.
			if (!responsiveHelper_datatable_fixed_column) {
				responsiveHelper_datatable_fixed_column = new ResponsiveDatatablesHelper($('#datatable_fixed_column'), breakpointDefinition);
			}
		},
		"rowCallback" : function(nRow) {
			responsiveHelper_datatable_fixed_column.createExpandIcon(nRow);
		},
		"drawCallback" : function(oSettings) {
			responsiveHelper_datatable_fixed_column.respond();
		}

    });

    // Apply the filter
    $("#datatable_fixed_column thead th input[type=text]").on( 'keyup change', function () {

    	if ($(this).val().length < 3)	return false;
        otable
            .column( $(this).parent().index()+':visible' )
            .search( this.value )
            .draw();

    } );

   	var colvis = new $.fn.dataTable.ColVis( otable, {
	        buttonText: 'Select columns'
	    } );
    $('#showHideColumnid').append($( colvis.button() ));
})

</script>