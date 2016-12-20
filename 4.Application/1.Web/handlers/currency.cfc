/**
*
* @file  /E/projects/source/handlers/currency.cfc
* @author
* @description
*
*/

component output="false" displayname=""  {
	property name='currencyService' inject='entityService:Currency';
	property name='userService' inject='userService';

	public function init(){
		return this;
	}

	public any function addNew(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id==0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();

				var newCurr = currencyService.new({curr_code:rc.code,curr_description:rc.description,updated:created,created:created,user_created:user_created,user_updated:user_created});
				var result = currencyService.save(newCurr);
				if(result)
					event.renderData(type="json", data={ 'success' : true , 'message' : 'Add new Currency successfully' , 'currId' : newCurr.getid_currency(),'code_Curr': newCurr.getcurr_code()});
				else
					event.renderData(type="json", data={ 'success' : false , 'message' : 'Add new Currency failed !' });
			}
			else
			{
				var curr = currencyService.get(rc.id);
				var user_updated = userService.getLoggedInUser();
				var updated = now();

				curr.setUser_Updated(user_updated);
				curr.setUpdated(updated);
				curr.setcurr_code(rc.code);
				curr.setcurr_description(rc.description);
				curr.setupdated(#LSDateTimeFormat(Now(),'yyyy-mm-dd HH:nn:ss')#);
				curr.setuser_updated(userService.get(SESSION.loggedInUserID));
				var result = currencyService.save(curr);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update Currency success','code_Curr': curr.getcurr_code()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update Currency failed !' });
			}
		}
	}

	function delete(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			var getCurr = currencyService.get(rc.id);
			currencyService.delete(getCurr,true);
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete Currency successfully' });
		}
	}
}