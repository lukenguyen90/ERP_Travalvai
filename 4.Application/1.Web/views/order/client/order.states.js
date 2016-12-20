/**
 * Load states for application
 * more info on UI-Router states can be found at
 * https://github.com/angular-ui/ui-router/wiki
 */
angular.module('app.states', [])
    .config(configs);

function configs($stateProvider, $urlRouterProvider) {

    $stateProvider
       
        .state('order', {
            url: '/order/:userId/:role/:lastSync',
            abstract: true,
            templateUrl: 'client/views/order-list.view.html',
        })
        .state('order.order-list', {
            url: '/order-list/:userId/:memberId/:truckId/:licensePlate',            
            templateUrl: 'client/views/order-list.view.html'                          
        })

   

    // if none of the above states are matched, use this as the fallback
    $urlRouterProvider.otherwise('/order');
}

