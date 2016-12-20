(function() {
    'use strict';

    angular.module('project.services').factory('models', models);

    function models($q, baseService) {

        var delivery = {
            confirmationDate: "",
            deliveryDate: "",
            value: 0,
            delivered: 0,
            toDeliver: 0,
            priceList: ""
        }

        var user = {
            id: 0,
            code: "",
            description: ""
        };

        var orderCondition = {
            id: 0,
            name: ""
        };

        var orderType = {
            id: 0,
            name: ""
        };

        var orderStatus = {
            id: 0,
            name: ""
        };

        var payment = {
            id: 0,
            name: ""
        };

        var size = {
            id_size_det: -1,
            szd_size: "",
            name: "",
            number: 0,
            quantity: 0
        };

        var project = {
            id: 0,
            name: ""
        };

        var order = {
            id: 0,
            description: "",
            date: formatDate(new Date()),
            discount1: "0",
            discount2: "0",
            zone: null,
            agent: null,
            customer: null,
            type: null,
            condition: null,
            status: null,
            payment: null,
            ag_commission: "",
            offer: "",
            units: 0,
            deliveryFactory: delivery,
            deliveryZone: delivery,
            deliveryAgent: delivery,
            product: null,
            sizeType: 0
        };

        var product = {
            id: 0,
            code: "",
            group: "",
            units: 0,
            project: project,
            garment: { id: 0, code: "", version: 0 },
            price: {
                hasContract: false,
                isContractExpired: true,
                priceList: { factory: 0, zone: 0, agent: 0 },
                manual: { factory: 0, zone: 0, agent: 0 },
                order: { factory: 0, zone: 0, agent: 0 },
                custom: { factory: 0, zone: 0, agent: 0 },
                total: { factory: 0, zone: 0, agent: 0 },
                grandTotal: { factory: 0, zone: 0, agent: 0 }
            },
            sizes: []
        };


        return {
            order: order,
            product: product,
            size: size,
            project: project
        };


    }
})();