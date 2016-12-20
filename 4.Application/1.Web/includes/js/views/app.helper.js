$(document).ready( function() {    
    //run after 16 minutes
    setInterval(utils().http().checkSessionTimeout, 57600000);
});

function roundDecimalPlaces(value, places) {

    if (typeof(value) === 'undefined' || value === null)
        return 0.00;
    value = value.toString().replace(',', '');

    value = parseFloat(value);

    if (typeof(places) === 'undefined' || places <= 0)
        return value;

    if (value == 0) return value;

    //Positive number
    if (Math.abs(value) >= 1)
        return Number(value).toFixed(places);

    places = places - 1;

    var isNagative = value < 0;

    value = isNagative ? (value * -1) : value;

    var log10 = parseInt(Math.floor(Math.log10(value)));

    var exp = (Math.pow(10, log10));

    value /= exp;

    value = Number(value).toFixed(places);

    value = (value * exp).toPrecision(places + 1);

    value = isNagative ? (value * -1) : value;

    return value;
}

function formatNumberThousand(value, places) {
    var filter = angular.injector(["ng"]).get("$filter")("number");
    if (value < 1) return roundDecimalPlaces(value, places);
    return filter(roundDecimalPlaces(value, places), places);
}


/**
 * 
 * 
 * @param {any} dateStr: dd/mm/yyyy
 * @param {any} separator
 * @returns
 */
function toDate(dateStr, separator) {
    var parts = dateStr.split(separator);
    return parts[2] + "/" + parts[1] + "/" + parts[0];
}

function formatDate(date) {
    var year = date.getFullYear(),
        month = date.getMonth() + 1, // months are zero indexed
        day = date.getDate();

    return day + "/" + month + "/" + year;

}

function utils() {
    return {
        http: http,
        dataTable: dataTable,
        dateTime: dateTime,
        notification: notification,
        user: user,
        getOrderStatus:getOrderStatus,
        allowUpdateProduct:allowUpdateProduct
    };

    function getOrderStatus(fty_confirm, zone_confirm){
        var status = "Open";
        if(fty_confirm != "None")
            status = "On production";
        if(fty_confirm == "None" && zone_confirm != "None")
            status = "To Factory";
        return status;
    }

    function allowUpdateProduct(orderStatus, userType){
        if(userType == "customer"){
            return false;
        }
        if(orderStatus == "To Factory"){
            if(userType == "agent"){
                return false;
            }
        }
        if(orderStatus == "On production"){
            if(userType == "zone" || userType == "agent"){
                return false;
            }
        }

        return true;
    }

    function http() {

        return {
            queryString: queryString,
            checkSessionTimeout: checkSessionTimeout
        }


        function queryString(variable) {
            var query = window.location.search.substring(1);
            var vars = query.split('&');
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split('=');
                if (decodeURIComponent(pair[0]) == variable) {
                    return decodeURIComponent(pair[1]);
                }
            }
        }

        function checkSessionTimeout(){

            $.ajax({
                async: false,
                type: 'GET',
                url: '/index.cfm/session_info/getInfo',
                success: function(data) {
                    if(data != null && typeof(data.timeout) != 'undefined' && data.timeout === true)
                        window.location.href = window.location.href;
                },
                error:function() {
                    window.location.href = window.location.href;
                }
            });
            
        }

    };

    function dataTable() {

        return {
            getColumnSummary: getColumnSummary,
            getColumnValue: getColumnValue,
            getButtonsConfiguration: getButtonsConfiguration
        };

        function getColumnSummary(api, columnIndex) {
            // Remove the formatting to get integer data for summation
            var intVal = function(i) {
                return typeof i === 'string' ?
                    i.replace(/[\$,]/g, '') * 1 :
                    typeof i === 'number' ?
                    i : 0;
            };

            var sumValue = api
                .column(columnIndex, { page: 'current' })
                .data()
                .reduce(function(a, b) {
                    return intVal(a) + intVal(b);
                }, 0);
            return sumValue;
        }

        function getColumnValue(api, columnIndex) {
            var columnValue = api.column(columnIndex, { page: 'current' }).data()[0];
            if (typeof(columnValue) === 'undefined') {
                return "";
            }
            return columnValue;
        }

        function getButtonsConfiguration() {
            var buttonCommon = {
                exportOptions: {
                    format: {
                        body: function(data, row, column, node) {
                            // Strip $ from salary column to make it numeric
                            console.log(column + ':' + data);
                            return column === 1 ?
                                data.replace('<hr>', 'test') :
                                data;
                        }
                    },
                    columns: ':visible'
                }
            };
            return [{
                    extend: 'pdfHtml5',
                    orientation: 'landscape',
                    pageSize: 'LEGAL',
                    title: 'Order List',
                    message: '',
                    exportOptions: {
                        columns: ':visible'
                    }
                },
                {
                    extend: 'excelHtml5',
                    title: 'Order List',
                    message: 'Order List',
                    exportOptions: {
                        columns: ':visible'
                    }

                }
            ];
        }

    };

    function dateTime() {

        return {
            formatDate: formatDate
        }

        function formatDate(objDate) {
            var date = new Date(objDate);
            var year = date.getFullYear(),
                month = date.getMonth() + 1, // months are zero indexed
                day = date.getDate();

            return day + "/" + month + "/" + year;

        }
    }

    function notification() {
        return {
            showSuccess: showSuccess,
            showFail: showFail
        }

        function showSuccess(message, closeCallBack) {
            $.notify({
                // options
                message: message
            }, {
                // settings
                type: 'success',
                timer: 500,
                onClose: closeCallBack,
                onClosed: closeCallBack
            });
        }

        function showFail(message, closeCallBack) {
            $.notify({
                // options
                message: message
            }, {
                // settings
                type: 'danger',
                timer: 500,
                onClose: closeCallBack,
                onClosed: closeCallBack
            });
        }
    }

    function user() {
        var userType = {
            factory: 'factory',
            zone: 'zone',
            agent: 'agent',
            customer: 'customer'
        };
        return {
            userType: userType
        }
    }
}

String.prototype.format = String.prototype.f = function() {
    var s = this,
        i = arguments.length;

    while (i--) {
        s = s.replace(new RegExp('\\{' + i + '\\}', 'gm'), arguments[i]);
    }
    return s;
};