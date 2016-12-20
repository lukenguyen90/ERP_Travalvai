<cfscript>
	public string function getImage(
			required string path,
			required numeric w, 
			required numeric h, 
			string st = "scaleToFit",
			boolean wtm = false
			) 
		cachedwithin="#createTimeSpan(0, 1, 0, 0)#"
	{
		return "/helpers/get.cfc?method=image&path=#path#&w=#w#&h=#h#&st=#st#&wtm=#wtm#";
	}
</cfscript>