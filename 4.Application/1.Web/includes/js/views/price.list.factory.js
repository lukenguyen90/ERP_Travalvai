(function(){
  'use strict';
  angular.module('price.List.factory', ['datatables', 'datatables.light-columnfilter', 'ui.select2'])
    .controller("BindAngularDirectiveCtrl", BindAngularDirectiveCtrl);

  function BindAngularDirectiveCtrl($scope, $filter,$http ,$compile, DTOptionsBuilder, DTColumnBuilder, $window)
  {
     
     var vm              = this;
     vm.message          = '';
     vm.deleteRow        = deleteRow;
     vm.insertPLF        = insertPLF;
     vm.refresh          = refresh;
     vm.refreshCopy      = refreshCopy;
     vm.showAddNew       = showAddNew;
     vm.showUpdate       = showUpdate;
     vm.clickItem        = clickItem;
     vm.showCopyData     = showCopyData;
     vm.CopyData         = CopyData;
     vm.currency_convert = {};
     vm.currFtyCurrencyExRate = {};
     vm.dtInstance       = {};
     vm.persons          = {};
     vm.user             = {};
     vm.user.sourcePriceListCurrency = '...';
     vm.user.sourcePriceListExRate   = '...';
     vm.regex            = "[a-z A-Z 0-9-\_\.]+";
     vm.regexNumber      = /^[0-9]+([\.][0-9]+)?$/;
     var original        = angular.copy(vm.user);
     vm.newseasons       = [];
     vm.isAddNew         = true;
     vm.isShowTextCode   = false;
     vm.isCreateByCopy   = false;
     vm.userInfo         = {};
     vm.PListCurrencyCode    = 'USD';
     vm.exRateUSDToPListCurrency = '';
     vm.exRatePListFtyToFtyCurrency = '';

     vm.isDisableSourceZone   = true;
     vm.isDisableSourcePList  = true;
     vm.isDisableDestinationZone  = true;
     vm.isDisableDestinationPList = true;
     vm.changeSourceSeason     = changeSourceSeason;
     vm.changeSourceZone       = changeSourceZone;
     vm.changeSourcePList      = changeSourcePList;
     vm.changeexrate           = changeexrate;         
     vm.priceListFactoryDetail = priceListFactoryDetail;         
     vm.checkPlfExist          = checkPlfExist;    
     
     
     getOldSeason();

      $.ajax({
        async: false,
        type: 'GET',
        url: '/index.cfm/basicdata/getUserLevel',
        success: function(data) {
          vm.userInfo = data;
          //if it is factory admin
          if( vm.userInfo.TYPEUSER == 1 ){
            $scope.isShowCreateBtn = true;
          }
          else {
            $scope.isShowCreateBtn = false;
          }
        }
      });


     vm.dtOptions  = DTOptionsBuilder.fromSource('/index.cfm/price_list_factory/getPLF')
          .withPaginationType('full_numbers')
          .withLightColumnFilter({
            '0' : {
                type : 'text'
            },
            '1' : {
                type : 'text'
            },
            '2' : {
                type : 'text'
            },
            '3' : {
                type : 'text'
            },
            '4' : {
                type : 'text'
            },
            '5' : {
                type : 'text'
            },
            '6' : {
                type : 'text'
            },
            '7' : {
                type : 'text'
            },
            '8' : {
                type : 'text'
            },
            '9' : {
                type : 'text'
            }
          })
          .withOption('createdRow', createdRow)
          .withOption('order', [8, 'desc'])
          .withOption('stateSave', true)
          .withOption('select', { style: 'single' });

          
     vm.dtColumns  = [
          DTColumnBuilder.newColumn('CODE').withTitle('CODE'),
          DTColumnBuilder.newColumn('DES').withTitle('DESCRIPTION').withOption('width', '20%'),
          DTColumnBuilder.newColumn('ZCODE').withTitle('ZONE'),
          DTColumnBuilder.newColumn('SEASON').withTitle('SEASON').withClass("text-right th-align-left"),
          DTColumnBuilder.newColumn('FTYCURRENCY').withTitle('FTY CURRENCY'),
          DTColumnBuilder.newColumn('CURRPL').withTitle('P.LIST. CURRENCY'),
          DTColumnBuilder.newColumn('EX_RATE').withTitle('EX. RATE').renderWith(formatNumber).withClass("text-right th-align-left"),
          DTColumnBuilder.newColumn('CORRECTION').withTitle('CORRECTION').renderWith(formatNumber).withClass("text-right th-align-left"),
          DTColumnBuilder.newColumn('PLFDATE').withTitle('DATE').withOption('width', '6%').withClass("text-right th-align-left"),
          DTColumnBuilder.newColumn('PLFUPDATE').withTitle('UPDATE').withOption('width', '6%').withClass("text-right th-align-left"),
          DTColumnBuilder.newColumn('ID').withTitle('DETAIL').notSortable().renderWith(actionsHtmlDetail).withOption('width', '3%').withClass("text-center th-align-left").notSortable(),
          DTColumnBuilder.newColumn('ID').withTitle('ACTIONS').notSortable().renderWith(actionsHtml).withOption('width', '8%').withClass("text-center th-align-left")
      ];

     

      var perform = performance.navigation.type;
      if(perform === 0 || perform === 1) {
        $window.localStorage.removeItem('DataTables_mytable_/index.cfm/basicdata.price_list_factory');
      }
      (function () {
        $(document).ready(function() {
          var stateColumns = JSON.parse($window.localStorage.getItem('DataTables_mytable_/index.cfm/basicdata.price_list_factory'));
          if(stateColumns) {
            window.setTimeout(function() {
              $("#mytable thead tr:last-child").children('th').each(function(index) {
                 if(!$(this).is(':empty')) {
                    $(this).children().val(stateColumns.columns[index].search.search);
                 }
              });
            }, 100);
          }
        })
      })();
    
      $scope.formatNumberThousand = function (value, places) { 
          return formatNumberThousand(value, places); 
      };

      function formatNumber(data, type, full, meta){
        
        return formatNumberThousand(data, 2);
      }
    
      

      function getOldSeason() {
        $.ajax({
            async: false,
            type: 'GET',
            url: '/index.cfm/price_list_factory/getSeasonForCopy',
            success: function(data) {
                vm.old_seasons = data;
            }
        });
      }

      $("#currency").change(function(){
        var theSelection = $('#currency').select2('data').text;       
        $scope.$apply();
        $.ajax({
          async:false,
          type: 'POST',
          url: '/index.cfm/price_list_factory/getCurr_convert',
          data: {
            currency : $(this).val(),
            plzCurrencyID : 0
          },
          success: function(data){
            vm.currency_convert = data;
            
            vm.exRateUSDToPListCurrency = data.cc_value;
            vm.PListCurrencyCode = theSelection;
            vm.exRateWithPriceCurrencyLabel = '('+vm.ftycurrency+'/'+ vm.PListCurrencyCode+')';
            vm.exRateUSDWithPriceCurrencyLabel = '('+'USD'+'/'+ vm.PListCurrencyCode+')';
            var exRatePListFtyToFtyCurrency = vm.currFtyCurrencyExRate.cc_value / data.cc_value;
            vm.exRatePListFtyToFtyCurrency = formatNumberThousand(exRatePListFtyToFtyCurrency,2);
            vm.dividedExRatePListFtyToFtyCurrency = formatNumberThousand(1 / exRatePListFtyToFtyCurrency, 2);

            vm.user.ex_rate = roundDecimalPlaces(exRatePListFtyToFtyCurrency, 2);
            vm.user.devidedManualExRate = vm.dividedExRatePListFtyToFtyCurrency;
          }
        });
      });

      $.ajax({
        async: false,
        type: 'GET',
        url: '/index.cfm/price_list_factory/getNewSeason',
        success: function(data) {
          vm.newseasons = data.arrnewseason;
        }
      });


      vm.allexistzone = [];
      $.ajax({
        async: false,
        type: 'GET',
        url: '/index.cfm/price_list_factory/getallZone',
        success: function(data) {
          vm.allexistzone = data.arrzone;
        }
      });


      $.ajax({
        async: false,
        type: 'GET',
        url: '/index.cfm/price_list_factory/getExRateUSDToFtyCurrency',
        success: function(data) {
          vm.currFtyCurrencyExRate = data;
          vm.currFtyCurrencyExRate.cc_value = roundDecimalPlaces(data.cc_value,6);
        }
      })

      function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $('td', row).unbind('dblclick');
        $('td', row).bind('dblclick', function() {
            $scope.$apply(function() {
                vm.clickItem(data.ID);
            });
        });

        $compile(angular.element(row).contents())($scope);
        return row;
       }

      function actionsHtml(data, type, full, meta) {
          if( vm.userInfo.TYPEUSER == 1){
            return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.showUpdate(' + data + ')">' +
                '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
                '</span>&nbsp;' +
                '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.deleteRow(' + data + ')">' +
                '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
                '</span>';
          }else{
            return '';
          }
      }
      function priceListFactoryDetail(id_plf) {
        window.location.href = "/index.cfm/basicdata.price_list_factory_detail?id=" + id_plf;
      }
      function actionsHtmlDetail(data, type, full, meta){
        return '<span class="txt-color-green btngotoplfdetail" title="Go to price list factory detail" ng-click="showCase.priceListFactoryDetail(' + data + ')">' +
          '<i class="ace-icon bigger-130 fa fa-sign-out"></i></span>';
      }

      vm.counter = 1;
      vm.search = {};

      $http.get("/index.cfm/price_list_factory/getFactoryCurrency").success(function(dataResponse){
        vm.ftycurrency = dataResponse.CURRENCY;
        vm.ftyid = dataResponse.IDFACTORY;
        vm.exRateWithPriceCurrencyLabel = '('+vm.ftycurrency+'/'+'...'+')';
        vm.exRateUSDWithPriceCurrencyLabel = '('+'USD' +'/'+'...'+')';
      });

      $http.get("/index.cfm/basicdata/getZone").success(function(dataResponse){
        vm.zones = dataResponse;
      });

      $http.get("/index.cfm/basicdata/getlanguage").success(function(dataResponse){
        vm.languages = dataResponse;
      });

      $http.get("/index.cfm/basicdata/getcurrency").success(function(dataResponse){
        vm.currencylist = dataResponse;
      });

      function clickItem (param) {
        var path = '/index.cfm/basicdata.price_list_factory_detail?id='+ param;
        $window.location.href = path;
      }

    function deleteRow(id_plf) {
      var result = window.confirm("Do you want to delete this Price List Factory?");
      if(result){
        $.ajax({
          type: "POST",
          url: "/index.cfm/price_list_factory/delete",
          async: false,
          data:{
            'id_plf'    : id_plf,
          },
          success: function( data ) {
            if(data.success == true) {
              noticeSuccess(data.message);
            }
            else {
              noticeFailed(data.message);
            }
            vm.dtInstance.reloadData();
          }
        });
      }
    }

    function showAddNew() {
      // body...
        refresh();
        vm.isCreateByCopy   = false;
        advanceShow(true);
        document.getElementById("titleID").innerHTML="Create";
        $(".highlight").removeClass("highlight");
        $('#btnRefresh').css('display','inline-block');
        $('#close').css('display','block');

        $('#modalUpdatePLF').modal('show');
        $(document).ready(function(){
          $("#modalUpdatePLF").on('shown.bs.modal', function(){
            $(this).find('#code').focus();
          });
        });
    }

    function showUpdate(id_plf) {
      refresh();
      advanceShow(false);
      document.getElementById("titleID").innerHTML="Edit";
      $('#btnRefresh').css('display','none');
      $(".highlight").removeClass("highlight");
      $.ajax({
        type: "POST",
        url: "/index.cfm/price_list_factory/getPlfById",
        async: false,
        data:{
          'id_plf'    : id_plf,
        },
        success: function( data ) {
            if(data.success) {
              $('#id_plf').val(id_plf);
              vm.user.code                 = data.plf.plf_code;
              vm.user.description          = data.plf.plf_description;
              vm.user.correction           = data.plf.plf_correction;
              vm.user.season               = data.plf.plf_season;
              vm.user.plfdate              = new Date(data.plf.plf_date);
              vm.currency_convert.cc_value = data.plf.cc_value;
              vm.user.ex_rate              = data.plf.plf_Ex_Rate;
              vm.user.currency             = data.plf.id_currency;
              vm.user.zone                 = data.plf.id_Zone;

              // vm.user.devidedManualExRate = roundDecimalPlaces(( 1 / vm.user.ex_rate) *100000) / 100000;
              vm.user.devidedManualExRate = roundDecimalPlaces(1 / vm.user.ex_rate,2);
              vm.exRateUSDToPListCurrency = data.plf.cc_value;
              vm.PListCurrencyCode = data.plf.curr_code;
              var exRatePListFtyToFtyCurrency = vm.currFtyCurrencyExRate.cc_value / vm.exRateUSDToPListCurrency;
              vm.exRatePListFtyToFtyCurrency =  formatNumberThousand(exRatePListFtyToFtyCurrency,2);
              vm.dividedExRatePListFtyToFtyCurrency =  formatNumberThousand(1/exRatePListFtyToFtyCurrency,2);
              $('#modalUpdatePLF').modal('show');
            }
        }
      });

    }

    function showCopyData(){      
      refreshCopy();
      getOldSeason();
      vm.user.sourcePriceListCurrency = '...';
      vm.user.sourcePriceListExRate = '...';
      vm.isCreateByCopy = true;
      $('#copydata').modal('show');
      // $(document).ready(function(){
      //     $("#copydata").on('shown.bs.modal', function(){
      //       $(this).find('#code').focus();
      //     });
      // });
    }

    function refreshCopy(){
      vm.user= angular.copy(original);
      console.log(vm.user);
      $scope.copyForm.$setPristine();
      vm.isDisableSourceZone  = true;
      vm.isDisableSourcePList = true;
      vm.isDisableDestinationPList = true;
      $('#text_destinationplf').val('');
    }

    function CopyData() {
        var check = checkPlfExist();
        if(!check.isExist){
          $.ajax({
            type: "POST",
            url: "/index.cfm/price_list_factory/CopyDataBlank",
            async: false,
            data:{
              'sourceseason' : vm.user.sourceseason,
              'desseason'    : vm.user.destinationseason,
              'idfactory'    : vm.ftyid,
              'sourcezone'   : vm.user.sourcezone,
              'deszone'      : vm.user.destinationzone,
              'sourceplf'    : vm.user.sourceplf,
              'desplf'       : vm.user.destinationplf,
              'text_desplf'  : $('#text_destinationplf').val(),
              'new_description' : vm.user.priceListDescription
            },
            success: function( data ) {
                if(data.success) {
                  vm.dtInstance.reloadData();
                  $('#copydata').modal('hide');
                  noticeSuccess(data.message);
                  priceListFactoryDetail(data.new_id_plf);
                }
                else {
                  noticeFailed(data.message);
                }
                refreshCopy();
            }
          });
        }else{
          noticeFailed(check.message);
        }
    }

    function checkPlfExist(){  
      var isExist = {};
      $.ajax({
          type: "POST",
          url: "/index.cfm/price_list_factory/checkPlfExist",
          async: false,
          data:{
            'desseason'    : vm.user.destinationseason,
            'text_desplf'  : $('#text_destinationplf').val(),
          },
          success: function( data ) {
            isExist = {'isExist':data.isExist, 'message':data.message};
          }
        });
      return isExist;
    }

    function insertPLF() {
        $.ajax({
             type: "POST",
             url: "/index.cfm/price_list_factory/insertPLF",
             async: false,
             data: {
                'code'           : vm.user.code,
                'description'    : vm.user.description,
                'correction'     : vm.user.correction,
                'season'         : vm.user.season,
                'ex_rate'        : vm.user.ex_rate,
                'plfdate'        : $filter('date')(vm.user.plfdate, "yyyy-MM-dd"),
                'idfactory'      : vm.ftyid,
                'idzone'         : vm.user.zone,
                'idcurrency'     : vm.user.currency,
                'isCreateByCopy' : vm.isCreateByCopy?true:false,
                'sourceseason'   : vm.user.sourceseason,
                'id_plf'         : $('#id_plf').val()
            },
            success: function( data ) {
              if(data.success)
              {
                noticeSuccess(data.message);
                if(vm.isAddNew == true) {
                  clickItem(data.plfid);
                }
              }
              else
              {
                noticeFailed(data.message);
              }
              vm.dtInstance.reloadData();
              refresh();
              $('#modalUpdatePLF').modal('hide');
            }
         });
    }



      function refresh () {
        $('#id_plf').val(0);
        vm.isCreateByCopy   = false;
        vm.currency_convert = {};
        vm.user= angular.copy(original);
        $scope.userForm.$setPristine();
        vm.PListCurrencyCode = 'USD';
        vm.exRatePListFtyToFtyCurrency =  '';
        vm.dividedExRatePListFtyToFtyCurrency = '';
        vm.exRateUSDToPListCurrency = '';
        vm.exRateWithPriceCurrencyLabel = '('+vm.ftycurrency+'/'+'...'+')';
        vm.exRateUSDWithPriceCurrencyLabel = '('+'USD' +'/'+'...'+')';
      }

      vm.rangeseason = function(count){
        var seasons = [];
        for (var i = 2010; i <= count; i++) {
          seasons.push(i)
        }
        return seasons;
      }

      function advanceShow(isAddNew) {
        vm.isShowTextCode = isAddNew;
        vm.isAddNew = isAddNew;
      }

      vm.arrzone = [];
      function changeSourceSeason() {
        $.ajax({
            async: false,
            type: 'POST',
            data: {
              'season': $('#sourceseason').val()
            },
            url: '/index.cfm/price_list_factory/getZoneBySeason',
            success: function(data) {
                vm.arrzone = data.arrzone;
                vm.isDisableSourceZone = false;
            }
        });
      }
      vm.arrPlist = [];

      function changeSourceZone() {

        var theSelection = $('#sourcezone').val();
        $.ajax({
            async: false,
            type: 'POST',
            data: {
              'season': $('#sourceseason').val(),
              'id_zone': theSelection
            },
            url: '/index.cfm/price_list_factory/getPlistBySeasonZone',
            success: function(data) {
                vm.arrPlist = data.arrPlist;
                vm.isDisableSourcePList = false;
                if(theSelection !== undefined) {
                  vm.isDisableDestinationZone = false;
                  vm.user.destinationzone = theSelection;
                  vm.user.destinationzonecode = $('#sourcezone').select2('data').text;
                }
            }
        });
      }

      function changeSourcePList() {
        var theSelection = $('#sourceplf').val();
        if(theSelection !== undefined) {
          if(theSelection == "allplf") {
            vm.isDisableDestinationPList = true;
            vm.user.destinationplf = null;
            vm.user.sourcePriceListCurrency = '...';
            vm.user.sourcePriceListExRate = '';
            vm.user.priceListDescription = '';
          }
          else {
            $.ajax({
              async: false,
              type: 'POST',
              data: {
                'id_plf': $("#sourceplf option:selected").val()
              },
              url: '/index.cfm/price_list_factory/getPriceListInfo',
              success: function(data) {
                vm.isDisableDestinationPList = false;
                $('#text_destinationplf').val($("#sourceplf option:selected").text());
                vm.user.destinationplf = theSelection[0];
                vm.user.sourcePriceListCurrency = data.currency;
                vm.user.sourcePriceListExRate = formatNumber(data.exrate);
                vm.user.priceListDescription = data.des;
              }
            });
          }
        }
      }

      function changeexrate() {
        var temp = roundDecimalPlaces(1/vm.user.ex_rate,2);
        if(temp === "NaN" || temp === "Infinity") {
          vm.user.devidedManualExRate = '';
        }
        else {
          vm.user.devidedManualExRate = temp;
        }
      }
  }
})();
