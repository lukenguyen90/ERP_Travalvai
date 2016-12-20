/**
*
* @file  /E/projects/source/handlers/currency_convert.cfc
* @author  Vo Hanh Tan
* @description 20/04/2016
*
*/

component output="false" displayname=""  {
	property name='currency_convertService' inject='entityService:currency_convert';
	property name='currencyService' inject='entityService:Currency';
	property name='userService' inject='userService';

	public function init(){
		return this;
	}

	public any function addNew(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_Convert== 0)
			{
				var newConvert = currency_convertService.new({cc_date:#LSDATEFORMAT(rc.date,'yyyy-mm-dd')#, cc_value:rc.convention, currency:rc.currencyID,created:#LSDateTimeFormat(Now(),'yyyy-mm-dd HH:nn:ss')#, user_created:SESSION.loggedInUserID});
				var result = currency_convertService.save(newConvert);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new currency convert successfully' , 'groupId' : newConvert.getid_curr_conv()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add currency convert failed !' });
			}else{
				var convert = currency_convertService.get(rc.id_Convert);
				convert.setcc_date(rc.date);
				convert.setcc_value(rc.convention);
				convert.setcurrency(currencyService.get(rc.currencyID));
				convert.setuser_updated(userService.get(SESSION.loggedInUserID));
				var result = currency_convertService.save(convert);

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update currency convert status successfully' });
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update currency convert status failed !' });
			}
		}
	}

	function delete(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			var getConvert = currency_convertService.get(rc.currencyID);
			currency_convertService.delete(getConvert,true);
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete currency convert successfully' });
		}
	}
}