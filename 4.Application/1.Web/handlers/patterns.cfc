component output="false" displayname=""  {
	property name='groupOfProductService' 	inject="entityService:group_of_products";
	property name='factoryService' 			inject="entityService:factory";
	property name='languagesService' 		inject="entityService:Languages";
	property name='patternsService'     	inject='patternsService';
	property name='patternsPartService'     inject='pattern_partService';
	property name='patternDesService' 		inject="entityService:pattern_description";
	property name='patternVariDesService' 	inject="entityService:pattern_var_des";
	property name='patternNoteService' 		inject="entityService:pattern_notes";
	property name='patternVariService' 		inject="pattern_variantionsService";
	property name='userService' 			inject='userService';

	public function init(){
		return this;
	}
	public function getPatternList(event, rc, prc){
		var userLevel = userService.getUserLevel();
		if(userLevel != 4){
			var factory = factoryService.get(id=userService.getFactoryID());
			var patterns = [];
			var patternsList = EntityLoad('patterns',{factory=factory},"id_pattern desc");

			var imageHelper = new helpers.ImageUtil();

			var thumbnailWidth = 150;
			var scale = 0.1;

			for(item in patternsList) {
			   var sPattern        = {};
			   //var aPnotes = patternsService.getFullNotes(item.getid_pattern());
			   if(item.getpt_Sketch() == ''){
			   		var sketch = 'NO IMAGES';
			   }else{
				    var sketchPath = expandPath("/includes/img/ao/" & item.getpt_Sketch());
				   	var sketchThumbnail = "";

				   	try{
						sketchThumbnail = imageHelper.convertImageToBase64(sketchPath, "png", scale);
				   	} catch(Any  ex){
						sketchThumbnail = "";
				   	}

			   		var sketch = '<a rel="lightbox-mygallery#item.getpt_code()#sketch" href="/includes/img/ao/#item.getpt_Sketch()#" title="#item.getpt_code()#">
                           			<img src="/includes/img/ao/#item.getpt_Sketch()#" width="#thumbnailWidth#" height="auto">
                    			  </a>';
			   }
			   if(item.getpt_Parts() == ''){
			   		var parts = 'NO IMAGES';
			   }else{

				   var partsPath = expandPath("/includes/img/ao/" & item.getpt_Parts());
				   var partsThumbnail = "";
				   try{
					   partsThumbnail = imageHelper.convertImageToBase64(partsPath, "png", scale);
				   } catch(Any  ex){
					   partsThumbnail = "";
				   }

			   		var parts = '<a rel="lightbox-mygallery#item.getpt_code()#parts" href="/includes/img/ao/#item.getpt_Parts()#" title="#item.getpt_code()#">
                           			<img src="data:image/png/;base64,#partsThumbnail#"  width="#thumbnailWidth#" height="auto">
                    			  </a>';
			   }
			   sPattern.idPattern  = item.getid_pattern();
			   sPattern.code       = item.getpt_code();
			   sPattern.createDate = dateformat(item.getpt_date(), "dd-mm-yyyy");
			   sPattern.updateDate = dateformat(item.getpt_update(), "dd-mm-yyyy");
			   sPattern.notes      = item.getpt_notes();
			   sPattern.sketch     = sketch;
			   sPattern.parts      = parts;
			   var gProductComponent = patternsService.getGroupProduct(item.getid_pattern());
			   sPattern.groupProductName 	= gProductComponent.gp_code& "-" &gProductComponent.description;
			   sPattern.groupProductID 		= gProductComponent.id_group_products;
			   sPattern.description 		= patternsService.getPatternDesByLangCurrent(item.getid_pattern());
			   //sPattern.notes 				= item.getpt_code();
			   ArrayAppend(patterns,sPattern);
			}
			event.renderData(type="json",data=patterns);
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function getPatternID(event, rc, prc) {
		if(structKeyExists(URL, "id")){
			var userLevel = userService.getUserLevel();
			if(userLevel != 4){
				var pattern = EntityLoadByPK('patterns', URL.id);
				var full_lang = EntityLoad('pattern_description', {pattern = pattern});
				var gProductListDes = {};
				var languages = entityload("languages");
				for(lang in languages){
					gProductListDes[lang.getId_language()] = lang;
				}
				var ldes = gProductListDes;
			   	for(page in full_lang){
					ldes[page.getLanguage().getId_language()]["description"] = page.getpd_description();
				}
				var full_language = SerializeJson(ldes);
				event.renderData(type="json",data={
												 'code':pattern.getpt_code()
												,'id':pattern.getid_pattern()
												,'internalNode':pattern.getpt_notes()
												,'groupID':pattern.getgroup_of_product().getid_group_products()
												,'craeateDate':DateFormat(pattern.getpt_date(),'dd/mm/yyyy')
												,'updateDate':DateFormat(pattern.getpt_update(),'dd/mm/yyyy')
												,'full_language':full_language
												,'sketch'	: "/includes/img/ao/#pattern.getpt_Sketch()#"
												,'parts'	: "/includes/img/ao/#pattern.getpt_parts()#"
											});
			}else{
				event.renderData(type="json",data={});
			}
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function getPatternVariData(event, rc, prc){
		if(structKeyExists(URL, "id")){
			var userLevel = userService.getUserLevel();
			if(userLevel != 4){
				var full_lang = patternVariService.getPatternVari(URL.id, rc.pv_code);
				var gProductListDes = {};
				var languages = QueryExecute("select * from languages");
				for(lang in languages){
					gProductListDes[lang.Id_language] = lang;
				}

				var parts = deserializeJSON(full_lang.pattern_part);
				var part_temp = {};
				var strpart = "";

				for(var part in parts){
					strpart &= parts[part].id & ",";
				}
				strpart = reReplace(strpart,"(,)$","","all");

				var listPart = QueryExecute("select id_pattern_part, pp_code from pattern_part  where id_pattern_part in (#strpart#)");
				for(var part in listPart){
					part_temp[part.id_pattern_part] = parts[part.id_pattern_part];
					part_temp[part.id_pattern_part]["code"] = part.pp_code;
				}

				var ldes = gProductListDes;
			   	for(page in full_lang){
					ldes[page.Id_language]["description"] = page.pv_description;
				}
				var full_language = SerializeJson(ldes);
				event.renderData(type="json",data={
												 'full_language_part':full_language
												, 'pvcode': full_lang.pv_code
												, 'id_pattern_var': full_lang.id_pattern_var
												, 'pvcomment' : full_lang.pv_comment
												, 'parts' : 	part_temp
												,'pv_sketch' : "#getImage("/includes/img/ao/#full_lang.pv_sketch#",600,300,'scaleToFit')#"
												});
			}else{
				event.renderData(type="json",data={});
			}
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function getPatternPart(event, rc, prc) {
		if(structKeyExists(URL, "id")){
			var IdLangDefault = userService.get(SESSION.loggedInUserID).getlanguage().getid_language();
			var userLevel = userService.getUserLevel();
			if(userLevel != 4){
				var pattern = EntityLoadByPK('patterns', URL.id);
				var full_lang = EntityLoad('pattern_part', {pattern = pattern});
				var list = [];
				for(item in full_lang){
					var str = {};
					str["id"] = item.getid_pattern_part();
					str["code"] = item.getpp_code();
					str["pp_vn"] = item.getpp_vn();
					str["code_des"] = item.getpp_code() & " " & item.getpp_en();
					str["pp_en"] = item.getpp_en()
					arrayAppend(list, str);
				}
				event.renderData(type="json",data=list);
			}
			else{
				event.renderData(type="json",data={});
			}
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function getPatternNotes(event, rc, prc){
		if(structKeyExists(URL, "id")){
			var userLevel = userService.getUserLevel();
			if(userLevel != 4){
				var pattern = patternsService.findwhere({id_pattern=URL.id});
				var ptnotes = patternsService.getFullNotes(pattern.getid_pattern());
				for(item in ptnotes){
					item.createDate = item.createDate;
				}
				event.renderData(type="json",data=ptnotes);
			}else{
				event.renderData(type="json",data={});
			}
		}else{
			event.renderData(type="json",data={});
		}
	}
	public function addNewNote(event, rc, prc){
		var userLevel = userService.getUserLevel();
		if(event.GETHTTPMETHOD() == "POST" and userLevel != 4 and rc.idpattern neq 0){
			if(val(rc.id_pattern_note) == 0){
				var createdDate = now();
				var user_created = userService.getLoggedInUser().getid_user();
				var pattern = EntityLoadByPK('patterns', rc.idpattern);
				var pnote 	= patternNoteService.new({
						pn_note 	: rc.patternnode
						,pn_date	: createdDate
						,pattern 	: pattern
						,user_created : user_created
				});
				var result = patternNoteService.save(pnote);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new pattern notes successfully!' });
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new pattern notes failed !' });
			}else{
				var pattern_notes = EntityLoad("pattern_notes", {pattern: EntityLoadByPK('patterns', rc.idpattern), id_pattern_note: val(rc.id_pattern_note)});
				pattern_notes[1].setpn_note(rc.patternnode);
				var result = patternNoteService.save(pattern_notes[1]);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Edit pattern notes successfully!' });
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Edit pattern notes failed !' });
			}
		}else{
			event.renderData(type="json",data={ 'success' : false , 'message' : 'Access denied !' });
		}
	}

	public function addNewPattern(event, rc, prc) {
		var userLevel = userService.getUserLevel();
		if(event.GETHTTPMETHOD() == "POST" and userLevel != 4){
			if(rc.id_pattern == 0){
				var user_created = userService.getLoggedInUser().getid_user();
				var factory = factoryService.get(id=userService.getFactoryID());
				var createdDate = DateFormat(now(),'dd/mm/yyyy');
				var newPattern 	= patternsService.new({
						pt_code				:UCase(rc.code)
						,pt_notes 			:rc.internalNode
						,group_of_product 	:groupOfProductService.get(rc.groupProduct)
						,pt_date 			:createdDate
						,pt_update 			:createdDate
						,user_created 		:user_created
						,user_updated 		:user_created
						,factory 			: factory
					});
				if(structKeyExists(rc,'sketch')){
					if(rc.sketch neq ''){
						var fileName = GenerateRandomString();
						var fileExtension = (rc.sketchName.split("/"));
						switch(fileExtension[2]){
				            case 'jpeg' :
				                var imageType	= 'jpg';
				            default:
				                var imageType	= fileExtension[2];
				            break;
				        }
						var fc1 = fileupload("#expandpath('/includes/img/ao/#GenerateRandomString()#.#imageType#')#", "#sketch#" ,"","makeunique");
						newPattern.setpt_Sketch(fc1.serverfile);
					}
				}
				if(structKeyExists(rc,'parts')){
					if(rc.parts neq ''){
						var fileName = GenerateRandomString();
						var fileExtension = (rc.partsName.split("/"));
						switch(fileExtension[2]){
				            case 'jpeg' :
				                var imageType	= 'jpg';
				            default:
				                var imageType	= fileExtension[2];
				            break;
				        }
						var fc2 = fileupload("#expandpath('/includes/img/ao/#GenerateRandomString()#.#imageType#')#", "#parts#" ,"","makeunique");
						newPattern.setpt_Parts(fc2.serverfile);
					}
				}
				var result = patternsService.save(newPattern);
				var dataDes = deserializeJSON(rc.des);
				for(item in dataDes){
					var pDescription = "";
					if(structKeyExists(item, "description")){
						pDescription = item.description;
					}
					var language = languagesService.get( item.id_language);
					var pdes = patternDesService.new({
							   pd_description  	: pDescription
							 , created         	: createdDate
							 , updated         	: createdDate
							 , user_created    	: user_created
							 , user_updated    	: user_created
							 , pattern 			: newPattern
							 , language        	: language
						});
					patternDesService.save(pdes);
				}
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new pattern successfully' , 'typeId' : newPattern.getid_pattern(), 'typecode' : newPattern.getpt_code()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new pattern failed !' });
			}else{				
				//edit pattern
				var updateDate = DateFormat(now(),'dd/mm/yyyy');
				var factory = factoryService.get(userService.getFactoryID());
				var pattern = patternsService.get(rc.id_pattern);
				pattern.setpt_notes(rc.internalNode);
				pattern.setpt_code(UCase(rc.code));
				pattern.setgroup_of_product(groupOfProductService.get(rc.groupProduct));
				pattern.setpt_update(updateDate);
				pattern.setuser_updated(userService.get(SESSION.loggedInUserID));
				pattern.setfactory(factory);
				if(structKeyExists(rc,'parts')){
					if(rc.parts neq ''){
						var oldImagesParts = expandpath('/includes/img/ao/')&pattern.getpt_sketch();
						if(fileExists(oldImagesParts)){
							FileDelete(oldImagesParts);
						}
						var fileExtension = (rc.partsName.split("/"));
						switch(fileExtension[2]){
				            case 'jpeg' :
				                var imageType	= 'jpg';
				            default:
				                var imageType	= fileExtension[2];
				            break;
				        }
						var fc2 = fileupload("#expandpath('/includes/img/ao/#GenerateRandomString()#.#imageType#')#", "#parts#" ,"","makeunique");
						pattern.setpt_Parts(fc2.serverfile);
					}
				}

				if(structKeyExists(rc,'sketch')){
					if(rc.sketch neq ''){
						var oldImagesSketch = expandpath('/includes/img/ao/')&pattern.getpt_sketch();
						if(FileExists(oldImagesSketch)){
							FileDelete(oldImagesSketch);
						}
						var fileExtension1 = (rc.sketchName.split("/"));
						switch(fileExtension1[2]){
				            case 'jpeg' :
				                var imageType	= 'jpg';
				            default:
				                var imageType	= fileExtension1[2];
				            break;
				        }
						var fc1 = fileupload("#expandpath('/includes/img/ao/#GenerateRandomString()#.#imageType#')#", "#sketch#" ,"","makeunique");
						pattern.setpt_Sketch(fc1.serverfile);
					}
				}

				var result = patternsService.save(pattern);
				var dataDes = deserializeJSON(rc.des);
				for(item in dataDes){
					var pDescription = "";
					var language = languagesService.get(dataDes[item].id_language);
					if(structKeyExists(dataDes[item], "description")){
						pDescription = dataDes[item].description;
					}
					var pdes = !isNull(patternDesService.findwhere({pattern=pattern, language=language}))?patternDesService.findwhere({pattern=pattern, language=language}):patternDesService.new();
					pdes.setpd_description(pDescription);
					pdes.setupdated(updateDate);
					pdes.setuser_updated(userService.get(SESSION.loggedInUserID));
					pdes.setpattern(pattern);
					patternDesService.save(pdes);
				}

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Edit pattern successfully' , 'typeId' : pattern.getid_pattern(), 'typecode' : pattern.getpt_code()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Edit pattern failed !' });
			}
		}else{
			event.renderData(type="json",data={ 'success' : false , 'message' : 'Access denied !' });
		}
	}

	public function addNewPatternPart(event, rc, prc){
		if(structKeyExists(URL, "id")){
			var userLevel = userService.getUserLevel();
			if(event.GETHTTPMETHOD() == "POST" and userLevel != 4){
				if(rc.pp_code == ""){
					var updateDate = DateFormat(now(),'dd/mm/yyyy');
					var pattern = patternsService.findwhere({id_pattern=URL.id});

					var part = patternsPartService.new({
						   pp_code : uCase(rc.partcode)
						 , pattern : pattern
						 , pp_vn : rc.pp_vn
						 , pp_en : rc.pp_en
					});

					patternsPartService.save(part);

					pattern.setpt_update(updateDate);
					pattern.setuser_updated(userService.get(SESSION.loggedInUserID));
					patternsService.save(pattern);

					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new pattern part successfully!' });
				}else{
					var updateDate = DateFormat(now(),'dd/mm/yyyy');
					var pattern = patternsService.findwhere({id_pattern=URL.id});
					var patternPart = entityload("pattern_part",{pattern=pattern,id_pattern_part: rc.pp_code},true);
					patternPart.setpp_code(uCase(rc.partcode));
					patternPart.setpp_vn(rc.pp_vn);
					patternPart.setpp_en(rc.pp_en);
					patternsPartService.save(patternPart);

					pattern.setpt_update(updateDate);
					pattern.setuser_updated(userService.get(SESSION.loggedInUserID));
					patternsService.save(pattern);
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Edit pattern part successfully!' });
				}
			}else{
				event.renderData(type="json",data={});
			}
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function getPatternVari(event, rc, prc) {
		if(structKeyExists(URL, "id")){
			var userLevel = userService.getUserLevel();
			if(userLevel != 4){
				var patternVari = patternsService.getPatternVari(URL.id);
				var list = [];
				for(item in patternVari){
					var str = {};
					str["id"] 	= item.id_pattern_var;
					str["code"] = item.pv_code;
					str["des"] 	= item.pv_description;

					var parts = deserializeJSON(item.pattern_part);
					var part_temp = {};
					var strpart = "";

					for(var part in parts){
						strpart &= parts[part].id & ",";
					}
					strpart = reReplace(strpart,"(,)$","","all");

					var listPart = QueryExecute("select id_pattern_part, pp_code from pattern_part  where id_pattern_part in (#strpart#)");
					for(var part in listPart){
						part_temp[part.id_pattern_part] = parts[part.id_pattern_part];
						part_temp[part.id_pattern_part]["code"] = part.pp_code;
					}

					str["parts"]  = part_temp;
					str["comment"]  = item.pv_comment;
					str["sketch"] = "<a rel='lightbox-mygallery#item.pv_code#sketch' href='/includes/img/ao/#item.pv_sketch#' title='#item.pv_code#'>
	                           			<img src=#getImage("/includes/img/ao/#item.pv_sketch#",80,40,'scaletofit')# alt='#item.pv_code#'/>
	                    			  </a>";
					arrayAppend(list, str);
				}
				event.renderData(type="json",data=list);
			}
			else{
				event.renderData(type="json",data={});
			}
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function delPatternPart(event, rc, prc){
		var userLevel = userService.getUserLevel();
		if(event.GETHTTPMETHOD() == "POST" and userLevel != 4)
		{
			patternsPartService.delPatternPart(rc.id_pattern, rc.pp_code);
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete Pattern Part successfully' });
		}
	}
	public function deletePatternVari(event, rc, prc){
		var userLevel = userService.getUserLevel();

		if(event.GETHTTPMETHOD() == "POST" and userLevel != 4)
		{
			var fullImage = patternVariService.getFullImage(rc.id_pattern, rc.pv_code);
			for(item in fullImage){
				var oldImagesSketch = expandpath('/includes/img/ao/')&item.pv_sketch;
				if(FileExists(oldImagesSketch)){
					FileDelete(oldImagesSketch);
				}
			}
			try {
				patternVariService.delPatternVari(rc.id_pattern, rc.pv_code);
				event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete Pattern Vari successfully' });
			}
			catch(any e) {
				event.renderData(type="json",data={ 'success' : false , 'message' : 'This pattern vari is using for product. If you want to delete this patter vari, please delete product first!' });
			}

		}
	}

	public function addNewPatternVari(event, rc, prc){
		if(structKeyExists(URL, "id")){
			var userLevel = userService.getUserLevel();
			if(event.GETHTTPMETHOD() == "POST" and userLevel != 4){
				rc.id_pattern_var = val(listremoveduplicates(rc.id_pattern_var, ",", true));
				if(rc.id_pattern_var == 0){
					var updateDate = DateFormat(now(),'dd/mm/yyyy');
					var pattern = patternsService.findwhere({id_pattern=URL.id});
					var dataDes = deserializeJSON(rc.des);					
					//set pattern_vari
					var patternVari = patternVariService.new({
								   pv_code 			: UCase(rc.varicode)
								 , pattern_part 	: rc.varipart
								 , pattern			: pattern
								 , pv_comment		: rc.pv_comment
								});
					if(structKeyExists(rc,'varisketch')){
						if(rc.varisketch neq ''){
							var fileName = GenerateRandomString();
							var fileExtension = (rc.variSketchName.split("/"));
							switch(fileExtension[2]){
					            case 'jpeg' :
					                var imageType	= 'jpg';
					            default:
					                var imageType	= fileExtension[2];
					            break;
					        }
							var fc2 = fileupload("#expandpath('/includes/img/ao/#GenerateRandomString()#.#imageType#')#", "#varisketch#" ,"","makeunique");
							patternVari.setpv_sketch(fc2.serverfile);
						}
					}
					var result = patternVariService.save(patternVari);
					//set pattern_var_des
					for(item in dataDes){
						var pDescription = "";
						if(structKeyExists(item, "description")){
							pDescription = item.description;
						}
						var language = languagesService.get( item.id_language);
						var pvdes = patternVariDesService.new({
								pv_description 		: pDescription
								,pattern_variantion : patternVari
								,language 			: language
							});
						patternVariDesService.save(pvdes);
					}
					//update pattern table
					pattern.setpt_update(updateDate);
					pattern.setuser_updated(userService.get(SESSION.loggedInUserID));
					patternsService.save(pattern);
					if(result){
						event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new pattern vari successfully!' });
					}else{
						event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new pattern vari failed !' });
					}
				}else{
					var updateDate = DateFormat(now(),'dd/mm/yyyy');
					var pattern = patternsService.findwhere({id_pattern=URL.id});
					var patternVari = patternVariService.findAllWhere({pattern=pattern, id_pattern_var=rc.id_pattern_var});
					//set code for pattern vari
					patternVari[1].setpv_code(rc.varicode);
					patternVariService.save(patternVari[1]);
					//end set
					var pdes = !isNull(patternVariService.findAllWhere({pattern=pattern, id_pattern_var=rc.id_pattern_var}))?patternVariService.findAllWhere({pattern=pattern, pv_code=rc.varicode}):patternVariService.new();
					if(structKeyExists(rc, "varipart")){
						pdes[1].setPattern_part(rc.varipart);
					}
					pdes[1].setPv_comment(rc.pv_comment);

					if(structKeyExists(rc,'varisketch')){
						if(rc.varisketch neq ''){
							var fileName = GenerateRandomString();
							var oldImagesSketch = expandpath('/includes/img/ao/')&patternVari[1].getpv_sketch();
							if(fileExists(oldImagesSketch)){
								FileDelete(oldImagesSketch);
							}
							var fileExtension = (rc.variSketchName.split("/"));
							switch(fileExtension[2]){
					            case 'jpeg' :
					                var imageType	= 'jpg';
					            default:
					                var imageType	= fileExtension[2];
					            break;
					        }
							var fc2 = fileupload("#expandpath('/includes/img/ao/#GenerateRandomString()#.#imageType#')#", "#varisketch#" ,"","makeunique");
							pdes[1].setpv_sketch(fc2.serverfile);
						}
					}

					var result = patternVariService.save(pdes[1]);

					var dataDes = deserializeJSON(rc.des);
					for(item in dataDes){
						var pDescription = "";
						var language = languagesService.get(dataDes[item].id_language);
						if(structKeyExists(dataDes[item], "description")){
							pDescription = dataDes[item].description;
						}
						var pdes = !isNull(patternVariDesService.findwhere({pattern_variantion=patternVari[1], language=language}))?patternVariDesService.findwhere({pattern_variantion=patternVari[1], language=language}):patternVariDesService.new();
						pdes.setpv_description(pDescription);
						patternVariDesService.save(pdes);

					}
					//update pattern table
					pattern.setpt_update(updateDate);
					pattern.setuser_updated(userService.get(SESSION.loggedInUserID));
					patternsService.save(pattern);
					if(result){
						event.renderData(type="json",data={ 'success' : true , 'message' : 'Edit pattern vari successfully!' });
					}else{
						event.renderData(type="json",data={ 'success' : false , 'message' : 'Edit pattern vari failed !' });
					}

				}
			}else{
				event.renderData(type="json",data={});
			}
		}else{
			event.renderData(type="json",data={});
		}
	}

	function getlanguage(event,prc,rc)
	{
		var listLang = QueryExecute("select * from languages")
		event.renderData(type="json",data=queryToArray(listLang));
	}

	private function queryToArray(required query inQuery) {
        result = arrayNew(1);
        for(row in inQuery) {
            item = {};
            for(col in queryColumnArray(inQuery)) {
                item[col] = row[col];
            }
            arrayAppend(result, item);
        }
        return result;
   	}

   	function getGroupOfProduct(event,prc,rc)
	{
		var list = [];
		var fullGP = patternsService.getFullGP();
		for(item in fullGP){
			if(item.description != ""){
				var des =  item.gp_code & ' - ' & item.description;
			}else{
				var des =  item.gp_code;
			}
			var code_group_prd_description = len(des) gt 20 ? left(des,20)&'...' : des;
			var str = {};
			str["id_group_products"] 	= item.id_group_products;
			str["gp_code"] 	= code_group_prd_description;
			str["created"] 	= item.created;
			str["updated"]  = item.updated;
			str["id_Factory"]  = item.id_Factory;
			arrayAppend(list, str);
		}

		event.renderData(type="json",data=list);
	}

	function deletePattern(event,rc,prc)
	{
		var userLevel = userService.getUserLevel();
		if(event.GETHTTPMETHOD() == "POST" and userLevel != 4)
		{
			var getCurr = patternsService.get(rc.id_pattern);
			patternsService.deleteFKPattern(rc.id_pattern);
			var oldImagesSketch = expandpath('/includes/img/ao/')&getCurr.getpt_sketch();
			if(FileExists(oldImagesSketch)){
				FileDelete(oldImagesSketch);
			}
			var oldImagesParts = expandpath('/includes/img/ao/')&getCurr.getpt_parts();
			if(FileExists(oldImagesParts)){
				FileDelete(oldImagesParts);
			}
			patternsService.delete(getCurr,true);
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete Pattern successfully' });
		}
	}

	function checkExistCode(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id==0){
				var factory = factoryService.get(id=userService.getFactoryID());
				var result = entityload("patterns",{pt_code=UCase(rc.code),factory=factory},true);
				event.renderData(type="json",data={ 'success' : !isNull(result),"pCode": rc.code });
			}else{
				var factory = factoryService.get(id=userService.getFactoryID());
				var listItem = entityload("patterns",{pt_code=UCase(rc.code),factory=factory});
				for(item in listItem){
					if(item.getId_pattern() != rc.id)
					{
						return event.renderData(type="json",data={ 'success' : true,"pCode": rc.code });
					}
				}
				event.renderData(type="json",data={ 'success' : false,"pCode": rc.code });
			}
		}
	}
	function checkExistPartCode(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST"){
			if(rc.id_pattern neq 0 and rc.pp_code eq ""){
				var pattern = patternsService.get(rc.id_pattern);
				var listItem = entityload("pattern_part",{pp_code=UCase(rc.part_code),pattern=pattern});
				if(arrayLen(listItem) gt 0)
				{
					return event.renderData(type="json",data={ 'exist' : true});
				}else{
					event.renderData(type="json",data={ 'exist' : false});
				}
			}else{
				event.renderData(type="json",data={ 'exist' : false});
			}
		}
	}
	function checkExistVariCode(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST"){
			var pattern = patternsService.get(rc.id_pattern);
			var listItem = entityload("pattern_variantions",{pv_code=UCase(rc.pv_code),pattern=pattern});
			if(arrayLen(listItem) gt 0)
			{
				if(rc.id_pattern_var == rc.id_pattern_var_temp and rc.pv_code == rc.varicode_temp)
					event.renderData(type="json",data={ 'exist' : false});
				else
					event.renderData(type="json",data={ 'exist' : true});
			}else{
				event.renderData(type="json",data={ 'exist' : false});
			}
		}
	}

	public string function GenerateRandomString(){
		var chars="0123456789abcdefghiklmnopqrstuvwxyz";
		var strLength = 30;
		var randout="";
		for( var i=1; i<=strLength; i=i+1){
			var rnum=ceiling(rand() * len(chars));
			if(rnum eq 0){
				rnum="1";
			}
			randout=randout & mid(chars, rnum, 1);
		}
		return  randout
	}


}