(function() {
    'use strict';

    angular.module('shipment.services').factory('models', models);

    function models($q, baseService) {

        var delivery = {
            confirmationDate: "",
            deliveryDate: "",
            value: 0,
            delivered: 0,
            toDeliver: 0,
            priceList: ""
        };


        var shipment = {
            id: 0,
            openDate: utils().dateTime().formatDate(new Date()),
            freightCost: null,
            taxes: null,
            importDuty: null,
            estimateDelivery: null,
            delivery: null,
            estimatedArival: null,
            arival: null,
            forwarder: null,
            freight: null,
            incoterm: null,
            shipmentType: null,
            sender: "",
            zone: null,
            agent: null,
            customer: null
        };

        var box = {
            id_box: 0,
            type_box: {id_type_box: 0, tb_description: "" },
            bx_weight: null
        };



        return {
            shipment: shipment,
            box: box
        };


    }
})();