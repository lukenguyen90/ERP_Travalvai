(function() {
    'use strict';
    angular.module('order.ctrls', ['datatables', 'datatables.light-columnfilter', 'ui.select2',
            'nya.bootstrap.select', 'ui.bootstrap', 'ngResource', 'ui.router', 'ngCsvImport', 'datatables.buttons'
        ])
        .controller('baseCtrl', [baseCtrl]);

    function baseCtrl() {}
})();