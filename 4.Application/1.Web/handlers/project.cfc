/**
*
* @file  /E/projects/source/handlers/project.cfc
* @author
* @description
*
*/

component output="false" displayname=""  {
	 property  name='projectService'          inject='entityService:Project';
	 property  name='customerService'         inject='entityService:Customer';
	 property  name='project_statusService'   inject="entityService:Project_status";
	 property  name='project_commentService'  inject="entityService:Project_comment";
	 property  name='userService'             inject='userService';

	public function init(){
		return this;
	}

	public any function addNew(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_Project== 0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();
				var newProject = projectService.new({
												  id_display:rc.display
												, pj_description:rc.description
												, pj_date:rc.date
												, pj_act_1:rc.groupWaitingFD_VN
												, pj_act_5:rc.groupWaitingFD_local
												, pj_act_2:rc.groupUrgent
												, pj_act_3:rc.groupVUrgent
												, pj_act_6:rc.groupDesignProcess
												, pj_act_4:rc.groupSentTCom
												, pj_act_7:rc.groupWaitingFC
												, pj_act_8:rc.groupSentTCus
												, pj_act_9:rc.pj_act_9
												, pj_act_10:rc.pj_act_10
												, project_status:rc.status
												, customer:rc.customer
												, updated:created
												, created:created
												, user_created:user_created
												, user_updated:user_created
											});

				var result = projectService.save(newProject);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new project successfully' , 'projectId' : newProject.getid_Project()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new project failed !' });
			}else{
				var project = projectService.get(rc.id_Project);
				var user_updated = userService.getLoggedInUser();
				var updated = now();

				project.setUser_Updated(user_updated);
				project.setUpdated(updated);
				project.setid_display(rc.display);
				project.setpj_description(rc.description);
				project.setpj_date(rc.date);
				project.setpj_act_1(rc.groupWaitingFD_VN);
				project.setpj_act_2(rc.groupUrgent);
				project.setpj_act_3(rc.groupVUrgent);
				project.setpj_act_6(rc.groupDesignProcess);
				project.setpj_act_4(rc.groupSentTCom);
				project.setpj_act_5(rc.groupWaitingFD_local);
				project.setpj_act_7(rc.groupWaitingFC);

				project.setpj_act_8(rc.groupSentTCus);
				project.setpj_act_9(rc.pj_act_9);
				project.setpj_act_10(rc.pj_act_10);
				project.setproject_status(project_statusService.get(rc.status));
				project.setcustomer(customerService.get(rc.customer));
				var result = projectService.save(project);

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update project successfully' });
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update project failed !' });
			}
		}
	}

	function createProject(event, rc, prc){
		var data = deserializeJSON(GetHttpRequestData().content);
		writedump(data);
		var customer = EntityLoadByPK("customer", data.customer.ID);
		var status = EntityLoadByPK("project_status", data.status.id_pj_Status);
		var user_created = userService.getLoggedInUser();
		var created = now();
		try{
			//create project
			var project = projectService.new();
			project.setid_display(data.display == "" ? JavaCast("null", "") : data.display);
			project.setpj_description(data.description == "" ? JavaCast("null", "") : data.description);
			project.setpj_date(data.date == "" ? JavaCast("null", "") : data.date);
			project.setcustomer(!structKeyExists(data.customer, "ID") ? JavaCast("null", "") : customer);
			project.setproject_status(!structKeyExists(data.status, "id_pj_Status") ? JavaCast("null", "") : status);
			project.setuser_created(user_created);
			project.setcreated(created);
			//save project
			projectService.save(project);
			event.renderData(type = "json", data = {"success" : true, 'id_project' : project.getid_Project()});
		}
		catch(any e){
			event.renderData(type = "json", data = {"success" : false});
		}
	}

	public any function addNewComment(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_Comment == 0)
			{
				var userlogged = userService.getLoggedInUser();
				var newComment = project_commentService.new({pj_com_comment:rc.comment, pj_com_date:ParseDateTime(rc.date), project:rc.project,user_created:userlogged,user_updated:userlogged});
				var result = project_commentService.save(newComment);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new comment successfully' , 'projectId' : newComment.getid_pj_comment()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new comment failed !' });
			}else{
				var comment = project_commentService.get(rc.id_Comment);
				var userlogged = userService.getLoggedInUser();
				comment.setUser_Updated(userlogged);
				comment.setpj_com_comment(rc.comment);
				comment.setUpdated(rc.date);
				comment.setproject(projectService.get(rc.project));
				var result = project_commentService.save(comment);

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update comment successfully' });
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update comment failed !' });
			}
		}
	}


	public any function getzoneagent(event,rc,prc) {
		var customer = customerService.get(rc.idcus);
		var agent = isNull(customer.getagent())?javaCast("null",""):customer.getagent();
		var zone = isNull(agent.getZone())?javaCast("null",""):agent.getZone();
		project.id_agent = isNull(agent)?"":agent.getid_Agent();
		project.name_agent = isNull(agent)?"":agent.getag_code()& " - "& agent.getAg_description();
 		project.name_zone = isNull(zone)?"":zone.getZ_code()& " - "& zone.getZ_description();
   		project.id_zone = isNull(zone)?"":zone.getid_Zone();
		event.renderData(type="json",data={ 'success' : true , 'id_agent' : project.id_agent, 'name_agent' : project.name_agent, 'name_zone' : project.name_zone, 'id_zone' :  project.id_zone});
	}

	function index()
	{
		prc.projects =[];
		var usertype = userService.getUserLevel();
		switch(usertype){
			case 0:
				var projectList={};
			break;
			case 1:
				var projectList=entityLoad('project',{},"id_Project desc");
			break;
			case 2:
				var customers = entityLoad('customer',{zone = userService.getLoggedInUser().getZone()});
				var projectList = [];
				for(item in customers){
					projects = entityLoad('project',{customer = item});
					if(isEmpty(projectList)){
						arrayAppend(projectList,projects,true);
					}else{
						for(var j=1; j<=arrayLen(projectList);j++){
							if(isEmpty(projects)) {
								break;
							}
							if(projectList[j].getId_Project() < projects[1].getId_Project() or arraylen(projectList) == j){
								for(pro in projects){
									ArrayInsertAt(projectList, j, pro);
								}
								break;
							}
						}
					}
				}
			break;
			case 3:
				var customers = entityLoad('customer',{agent = userService.getLoggedInUser().getAgent()});
				var projectList = [];
				for(item in customers){
					var projects = entityLoad('project',{customer = item},"id_Project desc");
					if(isEmpty(projectList)){
						arrayAppend(projectList,projects,true);
					}else{
						for(var j=1; j<=arrayLen(projectList);j++){
							if(isEmpty(projects)) {
								break;
							}
							if(projectList[j].getId_Project() < projects[1].getId_Project() or arraylen(projectList) == j){
								for(pro in projects){
									ArrayInsertAt(projectList, j, pro);
								}
								break;
							}
						}
					}
				}

			break;
			case 4:
				var cust = userService.getLoggedInUser().getCustomer();
				var projectList = entityLoad('project',{customer = cust},"id_Project desc");
			break;

			default:
				var projectList={};
			break;
		}

		for(item in projectList) {
		 	var project = {};
		 	var customer = isNull(item.getcustomer())?javaCast("null",""):item.getcustomer();
		 	var agent = isNull(customer)?javaCast("null",""):customer.getAgent();
		 	var zone = isNull(agent)?javaCast("null",""):agent.getZone();
		 	project.id_project = item.getid_Project();
		 	project.id_display = item.getid_Display();
		 	project.pj_description = isNull(item.getpj_description())?"":item.getpj_description();
		 	project.id_customer = isNull(item.getcustomer())?"":customer.getid_customer();
		 	project.cs_name =isNull(item.getcustomer())?"":customer.getcs_name();
		 	project.id_agent = isNull(item.getcustomer())?"":customer.getagent().getid_Agent();
		   	project.agent = isNull(agent)?javaCast("null",""):agent.getag_code()&" - "&agent.getAg_description();
		 	project.id_zone = isNull(zone)?"":zone.getid_Zone();
		   	project.zone = isNull(zone)?"":zone.getZ_code() &" - "& zone.getZ_description();
		 	project.date = isNull(item.getpj_date())?"":item.getpj_date();
		 	project.id_pj_status = isnull(item.getproject_status())?"":item.getproject_status().getid_pj_Status();
		   	project.name_status = isNull(item.getproject_status())?"": item.getproject_status().getpj_stat_desc();

		 	project.status = [];
		 	if(item.getpj_act_1()) ArrayAppend(project.status,{'color':'yellow','char':'WD'});
		 	if(item.getpj_act_2()) ArrayAppend(project.status,{'color':'red','char':'U'});
		 	if(item.getpj_act_3()) ArrayAppend(project.status,{'color':'orange','char':'VC'});
		 	if(item.getpj_act_4()) ArrayAppend(project.status,{'color':'blueViolet','char':'SC'});
		 	if(item.getpj_act_5()) ArrayAppend(project.status,{'color':'blue','char':'STC'});
		 	if(item.getpj_act_6()) ArrayAppend(project.status,{'color':'green','char':'SD'});
		 	if(item.getpj_act_7()) ArrayAppend(project.status,{'color':'pink','char':'WC'});

		 	ArrayAppend(prc.projects,project);
		}
	}

	function getListProjects()
	{
		prc.projects =[];
		var usertype = userService.getUserLevel();
		switch(usertype){
			case 0:
				var projectList={};
			break;
			case 1:
				var projectList=entityLoad('project',{},"id_Project desc");
			break;
			case 2:
				var customers = entityLoad('customer',{zone = userService.getLoggedInUser().getZone()});
				var projectList = [];
				for(item in customers){
					projects = entityLoad('project',{customer = item});
					if(isEmpty(projectList)){
						arrayAppend(projectList,projects,true);
					}else{
						for(var j=1; j<=arrayLen(projectList);j++){
							if(isEmpty(projects)) {
								break;
							}
							if(projectList[j].getId_Project() < projects[1].getId_Project() or arraylen(projectList) == j){
								for(pro in projects){
									ArrayInsertAt(projectList, j, pro);
								}
								break;
							}
						}
					}
				}
			break;
			case 3:
				var customers = entityLoad('customer',{agent = userService.getLoggedInUser().getAgent()});
				var projectList = [];
				for(item in customers){
					var projects = entityLoad('project',{customer = item},"id_Project desc");
					if(isEmpty(projectList)){
						arrayAppend(projectList,projects,true);
					}else{
						for(var j=1; j<=arrayLen(projectList);j++){
							if(isEmpty(projects)) {
								break;
							}
							if(projectList[j].getId_Project() < projects[1].getId_Project() or arraylen(projectList) == j){
								for(pro in projects){
									ArrayInsertAt(projectList, j, pro);
								}
								break;
							}
						}
					}
				}

			break;
			case 4:
				var cust = userService.getLoggedInUser().getCustomer();
				var projectList = entityLoad('project',{customer = cust},"id_Project desc");
			break;

			default:
				var projectList={};
			break;
		}

		for(item in projectList) {
		 	var project = {};
		 	var customer = isNull(item.getcustomer())?javaCast("null",""):item.getcustomer();
		 	var agent = isNull(customer)?javaCast("null",""):customer.getAgent();
		 	var zone = isNull(agent)?javaCast("null",""):agent.getZone();
		 	project.id_project = item.getid_Project();
		 	project.id_display = "PJ-" & item.getid_Display();
		 	project.pj_description = isNull(item.getpj_description())?"":item.getpj_description();
		 	project.id_customer = isNull(item.getcustomer())?"":customer.getid_customer();
		 	project.cs_name =isNull(item.getcustomer())?"":customer.getid_customer() & "-" & customer.getcs_name();
		 	project.id_agent = isNull(item.getcustomer())?"":customer.getagent().getid_Agent();
		   	project.agent = isNull(agent)?javaCast("null",""):agent.getag_code()&" - "&agent.getAg_description();
		 	project.id_zone = isNull(zone)?"":zone.getid_Zone();
		   	project.zone = isNull(zone)?"":zone.getZ_code() &" - "& zone.getZ_description();
		 	project.date = isNull(item.getpj_date())?"":dateformat(item.getpj_date(),"dd/mm/yyyy");
		 	project.id_pj_status = isnull(item.getproject_status())?"":item.getproject_status().getid_pj_Status();
		   	project.name_status = isNull(item.getproject_status())?"": item.getproject_status().getpj_stat_desc();

		 	project.status = [];
		 	if(item.getpj_act_1()) ArrayAppend(project.status,{'color':'yellow','char':'WD'});
		 	if(item.getpj_act_2()) ArrayAppend(project.status,{'color':'red','char':'U'});
		 	if(item.getpj_act_3()) ArrayAppend(project.status,{'color':'orange','char':'VC'});
		 	if(item.getpj_act_4()) ArrayAppend(project.status,{'color':'blueViolet','char':'SC'});
		 	if(item.getpj_act_5()) ArrayAppend(project.status,{'color':'blue','char':'STC'});
		 	if(item.getpj_act_6()) ArrayAppend(project.status,{'color':'green','char':'SD'});
		 	if(item.getpj_act_7()) ArrayAppend(project.status,{'color':'pink','char':'WC'});

		 	ArrayAppend(prc.projects,project);
		}
		var pr = {};
		pr = prc.projects;
		event.renderData(type = "json", data = pr);
	}
	
	function getProj_product(event,rc,prc){
		if(event.GETHTTPMETHOD()=="GET"){
			var project = entityload("project",{id_Project=rc.idproject},true);
			var proj_prod = entityload("product",{project = project});
			var pp = [];
			for(item in proj_prod){
				var newp = {
					  "id_product"             = item.getId_product()
					, "Garment_code"           = project.getId_display()&"-"&(isNull(item.getPattern())?"":item.getPattern().getpt_code())&"-"&(isNull(item.getPattern_variantion())?"":item.getPattern_variantion().getpv_code())
					, "pr_version"             = item.getPr_version()
					, "cost_code"                = isNull(item.getCosting())?"":item.getCosting().getcost_code()
					, "cv_version"		       = isNull(item.getCosting_versions())?"":item.getCosting_versions().getCv_version()
					, "pr_description"         = item.getPr_description()
					, "pr_status_desc"         = isNull(item.getProduct_status())?"":item.getProduct_status().getpr_stat_desc()
					, "pr_sketch"              = item.getPr_sketch()
					, "sizes"              	   = item.getSize().getsz_description()
					, "section"                = item.getPr_section()
				}
				arrayAppend(pp,newp);
			}

			event.renderData(type="json",data=pp);
		}
	}

	public any function getMaxOfProjectNumber(param) {
		var queryMax = QueryExecute("select Max(id_display) as maxnum from project");
		if(queryMax.recordcount !=0){
			event.renderData(type="json",data=queryMax.maxnum);
		}else{
			event.renderData(type="json",data=10000);
		}
	}

	function getCustomers(){

	}

	function getproject(event,rc,prc)
	{
		var listProject = projectService.List(asQuery=false);
		var listPro = [];
		for(item in listProject){
			var proj = {
				"id"          = item.getId_Project(),
				'display'     = "PJ-" & item.getId_display(),
				'description' = item.getPj_description(),
				"pj_act_1"    = item.getPj_act_1(),
				"pj_act_2"    = item.getPj_act_2(),
				"pj_act_3"    = item.getPj_act_3(),
				"pj_act_4"    = item.getPj_act_4(),
				"pj_act_5"    = item.getPj_act_5(),
				"pj_act_6"    = item.getPj_act_6(),
				"pj_act_7"    = item.getPj_act_7(),
				"pj_act_8"    = item.getPj_act_8(),
				"pj_act_9"    = item.getPj_act_9(),
				"pj_act_10"   = item.getPj_act_10()
			};
			arrayAppend(listPro,proj);
		}
		event.renderData(type="json",data=listPro);
	}

	function edit(event,rc,prc)
	{
		if(!structKeyExists(rc,"id")){
			setNextEvent("project.index");
		}
	}

	function getstatus(event,rc,prc)
	{
		var listStatus = project_statusService.List(asQuery=false);
		listSTT = [];
		for(item in listStatus){
			stt = {
				'id_pj_Status' = item.getId_pj_Status(),
				'pj_stat_desc' = item.getPj_stat_desc()
			};

			arrayAppend(listSTT,stt);
		}

		event.renderData(type="json",data=listSTT);
	}

	function getcomment(event,rc,prc)
	{
		if(structKeyExists(URL, "idproject")){
			var commentList = EntityLoad('project_comment', {project=EntityLoadByPK("project",URL.idproject)},"pj_com_date desc");
			var comments = [];
			var loggedInId = userService.getLoggedInUser().getId_user();

			for(item in commentList) {
			   var comment = {};
			   comment.id=item.getid_pj_comment();
			   comment.date = #DateTimeFormat(item.getpj_com_date(),'dd/mm/yyyy HH:nn:ss')#;
			   comment.dateformat = #LSDATEFORMAT(item.getpj_com_date(),'mm/dd/yyyy')#;
			   comment.user = isNull(item.getUser_created())?"":item.getUser_created().getUser_name();
			   comment.editable = item.getUser_created().getId_user() == loggedInId ;
			   comment.comment = item.getpj_com_comment();
			   comment.projectid = isNull(item.getproject())?"":item.getproject().getid_Project();

			   ArrayAppend(comments,comment);
			}

			event.renderData(type="json",data= comments);
		}else{
			var listStatus = project_commentService.List(asQuery=false);
			event.renderData(type="json",data=listStatus);
			var comments = [];
			var commentList = EntityLoad('project_comment');
			for(item in commentList) {
			   var comment = {};
			   comment.id=item.getid_pj_comment();
			   comment.date = item.getpj_com_date();
			   comment.dateformat = #LSDATEFORMAT(item.getpj_com_date(),'mm/dd/yyyy')#;
			   comment.user = isNull(comment.getUser_created())?"":comment.getUser_created().getUser_name();
			   comment.editable = item.getUser_created().getId_user() == loggedInId ;
			   comment.comment = item.getpj_com_comment();
			   comment.projectid = isNull(item.getproject())?"":item.getproject().getid_Project();
			   ArrayAppend(comments,comment);
			}

			event.renderData(type="json",data=comments);
		}
	}

	function getprojectforid(event,rc,prc)
	{
		var listStatus = projectService.get(rc.id_Project);
		var customer = isNull(listStatus)?javaCast("null",""):listStatus.getCustomer();
		var agent = isNull(customer)?javaCast("null",""): customer.getAgent();
		var ag_code = isNull(agent)?"":agent.getag_code();
		var ag_des = isNull(agent)?"":agent.getAg_description();
	   	var zone = isNull(agent)?javaCast("null",""): agent.getZone();
	   	var z_code = isNull(zone)?"":zone.getZ_code();
	   	var z_des = isNull(zone)?"":zone.getZ_description();
		var id_customer = isNull(customer)?"":customer.getid_customer();
		var id_pj_status = isnull(listStatus.getproject_status())?"":listStatus.getproject_status().getid_pj_Status();

		event.renderData(type="json",data={
			'id_display':listStatus.getid_Display()
			, 'pj_description':listStatus.getpj_description()
			, 'id_Customer':id_customer
			, 'pj_date':listStatus.getpj_date()
			, 'id_pj_Status':id_pj_status
			, 'zone':z_code
			, 'z_des':z_des
			, 'ag_des':ag_des
			, 'agent':ag_code
			, 'pj_act_1':listStatus.getpj_act_1()
			, 'pj_act_2':listStatus.getpj_act_2()
			, 'pj_act_3':listStatus.getpj_act_3()
			, 'pj_act_4':listStatus.getpj_act_4()
			, 'pj_act_5':listStatus.getpj_act_5()
			, 'pj_act_6':listStatus.getpj_act_6()
			, 'pj_act_7':listStatus.getpj_act_7()
			, 'pj_act_8':listStatus.getpj_act_8()
			, 'pj_act_9':listStatus.getpj_act_9()
			, 'pj_act_10':listStatus.getpj_act_10()
		});
	}

	function actionStatus(event,prc,rc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.sttId== 0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();

				var newPstt = project_statusService.new({pj_stat_desc:rc.stt,updated:created,created:created,user_created:user_created,user_updated:user_created});
				var result = project_statusService.save(newPstt);
				if(result){
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new project status successfully','idStt' : newPstt.getid_pj_Status() });
				}else{
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new project status failed !' });
				}
			}else{
				var pStt = project_statusService.get(rc.sttId);
				var user_updated = userService.getLoggedInUser();
				var updated = now();

				pStt.setUser_updated(user_updated);
				pStt.setUpdated(updated);

				pStt.setpj_stat_desc(rc.stt);
				var result = project_statusService.save(pStt);

				event.renderData(type="json",data={ 'success' : result , 'message' : result?'Update project status successfully':'Update project status failed !' });
			}
		}
	}

	function delProjectStt(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			var projectStt = project_statusService.get(rc.sttId);
			project_statusService.delete(projectStt,true);
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete project status successfully' });
		}
	}

	function deleteProject(event, rc, prc) {
		try {
			var project = entityLoad("project", {id_project: rc.id_project}, true);
			var project_comment = entityLoad("project_comment", {project : project});
			entityDelete(project_comment);
			entityDelete(project);
			ormflush();
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete project successfully' });
		}
		catch(any ex) {
			event.renderData(type="json",data={ 'success' : false , 'message' : 'Project in used. Can not delete' });
		}
	}
}