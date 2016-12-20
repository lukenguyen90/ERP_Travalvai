'use strict';

function customButton() {


    return {
        updateButtonContainerStyle: updateButtonContainerStyle
    }

    function updateButtonContainerStyle() {
        var container = $('div.dt-buttons');
        var $childContainer = $("<div>", { id: "dt-buttons-container", "class": "pull-right" });
        var $buttonPdf = container.find('.buttons-pdf');
        var $buttonExcel = container.find('.buttons-excel');


        $('<i class="fa fa-file-pdf-o" aria-hidden="true"></i>&nbsp;&nbsp;').prependTo($buttonPdf);
        $('<i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;&nbsp;').prependTo($buttonExcel);

        $buttonPdf.addClass('btn-outline btn-sm');
        $buttonExcel.addClass('btn-outline btn-sm');

        container.addClass('col-md-12');
        container.css('padding-left', '0px');
        container.css('padding-right', '0px');
        container.css('padding-top', '2px');
        container.css('padding-bottom', '2px');

        container.css('background-color', 'rgb(220, 229, 239)');
        container.css('margin-top', '3px');

        $buttonPdf.detach().appendTo($childContainer);
        $('<span>&nbsp;</span>').appendTo($childContainer);
        $buttonExcel.detach().appendTo($childContainer);

        container.append($childContainer);

    }
}