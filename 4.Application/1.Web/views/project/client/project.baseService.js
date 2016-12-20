(function() {
    'use strict';
    angular
        .module('project.services', [])
        .factory('baseService', baseService);

    function baseService($http, $q) {
        var API_KEY = "apiKey";
        //var API_URL = "/api";
        var API_URL = "/index.cfm/project";
        var LOCAL_DATA_URL = "../../views/project/data";
        var BASE_URL = API_URL;

        return {
            makeRequest: makeRequest
        };


        /**
         * Export function
         * 
         * @param {any} url
         * @param {any} params
         * @returns
         */
        function makeRequest(url, params) {
            return makeRealRequest(url, params);
        }


        /**
         * Make request to server to get data 
         * 
         * @param {any} url: name of API
         * @param {any} params: parameters that is passed to API in JSON format
         * @returns
         */
        function makeRealRequest(url, params) {
            var requestUrl = BASE_URL + "/" + url + '?';

            var deferred = $q.defer();

            if (!hasInternet()) {

                var data = { returnCd: 4, errorMessage: "Connection error, please check your internet" };

                deferred.resolve(data);

                return deferred.promise;
            }

            $http.post(requestUrl,
                    JSON.stringify(params), {
                        headers: {
                            'Content-Type': 'application/json'
                        }
                    }
                )
                .success(function(data, status) {
                    deferred.resolve(data);
                })
                .error(function(reason) {

                    deferred.reject(reason);
                });

            return deferred.promise;
        }

        function makeFakeRequest(url, params) {
            var requestUrl = BASE_URL + '/' + url + ".json" + '?api_key=' + API_KEY;
            angular.forEach(params, function(value, key) {
                requestUrl = requestUrl + '&' + key + '=' + value;
            });

            var deferred = $q.defer();

            $http.get(requestUrl)
                .success(function(data) {

                    deferred.resolve(data);
                })
                .error(function() {
                    console.log("Error while making HTTP call.");
                    deferred.reject();
                });

            return deferred.promise;
        }

        function hasInternet() {
            return navigator.onLine;
        }
    }
})();