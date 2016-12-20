component output="false" displayname=""  {
	 property  name='zoneService'      inject="entityService:Zone";
	 property  name='agentService'     inject='entityService:Agent';
	 property  name='customerService'  inject='entityService:customer';
	 property  name='contractService'  inject='entityService:contract';

	public function init(){
		return this;
	}

	public any function getContracts(event,rc,prc) {
		var result = [];
		var contractList = contractService.list(asQuery=false);
		for(item in contractList){
			var customer = item.getcustomer();
			var agent    = item.getagent();
			var zone     = item.getzone();
			var contract ={
				"id_Contract"    = item.getId_Contract()
				, "id_Customer"  = isNull(customer)?"":customer.getId_Customer()
				, "cs_name"      = isNull(customer)?"":customer.getCs_name()
				, "id_Agent"     = isNull(agent)?"":agent.getId_Agent()
				,"agent_des"  	 = isNull(agent)?"":agent.getag_description()
				, "ag_Code"      = isNull(agent)?"":agent.getAg_code()
				, "id_Zone"      = isNull(zone)?"":zone.getId_zone()
				, "z_code"       = isNull(zone)?"":zone.getZ_code()
				, "zone_des"     = isNull(zone)?"":zone.getz_description()
				, "startDate"    = dateformat(item.getC_date_i(),"dd/mm/yyyy")
				, "noofyear"     = val(numberFormat(item.getC_no_of_years(),"9.99"))
				, "increaseYear" = val(numberFormat(item.getC_increase_year(),"9.99"))
				, "description"  = isNull(item.getc_description)?"":item.getc_description()
			};
			arrayAppend(result,contract)
		}
		event.renderData(type="json",data=result);
	}

	function addEditContract(event,prc,rc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_Contract== 0)
			{
				var customer = customerService.get(id=rc.customer);
				// var checkcontract = entityload("contract",{customer=customer},true);
				// if(isNull(checkcontract)){
					var newContract = contractService.new({
						  "c_date_i" = rc.startDate
						, "c_no_of_years" = rc.noofyear
						, "c_increase_year" = rc.increaseYear
						, "c_description" = rc.description
						});

					newContract.setCustomer(customer);

					var agent = customer.getAgent();
					newContract.setAgent(agent);

					var zone = agent.getZone();
					newContract.setzone(zone);

					var result = contractService.save(newContract);
					event.renderData(type="json",data={ 'success' : result != 0 , 'message' : result!= 0?'Add new contract successfully':'Add new contract failed !'});
				// }else{
				// 	event.renderData(type="json",data={ 'success' : false , 'message' : 'contract of customer is already exist!' });
				// }
			}else{
				try {
					var customer 	= customerService.get(id=rc.customer);
					// var checkcontract = entityload("contract",{customer=customer},true);
					var Contract = contractService.get(id=rc.id_Contract);
					// if(isNull(checkcontract) or Contract.getId_Contract() == checkcontract.getId_Contract()){
						Contract.setC_date_i(rc.startDate);
						Contract.setC_no_of_years(rc.noofyear);
						Contract.setC_increase_year(rc.increaseYear);
						Contract.setc_description(rc.description);
						var customer = customerService.get(id=rc.customer);
						Contract.setCustomer(customer);

						var agent = customer.getAgent();
						Contract.setAgent(agent);

						var zone = agent.getZone();
						Contract.setzone(zone);

						var result = contractService.save(Contract);

						event.renderData(type="json",data={ 'success' : result!= 0 , 'message' : result!= 0?'Update contract successfully':'Update contract failed !'});

					// }else{
					// 		event.renderData(type="json",data={ 'success' : false , 'message' : 'contract of Customer is already!' });
					// }

				}
				catch(any ex) {
				}
			}
		}
	}
	function delete(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			try {
				var contract = contractService.get(id=rc.id_Contract);
				contractService.delete(contract,true);
				event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete contract successfully' });
			}
			catch(any ex) {
				event.renderData(type="json",data={ 'success' : failed , 'message' : 'Can not delete contract' });
			}
		}
	}
}