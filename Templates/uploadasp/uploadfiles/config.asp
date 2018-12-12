	
	<%	
	'-----------------------------------------------
	'name of folder (note there is no / at end)
	strFolder = "c:\files\web\jobs\attachments" 
	'name of folder in http format (note there is no / at end)
	httpRef = "http://localhost/jobs/attachments" 
	'the max size of file which can be uploaded, 0 will give unlimited file size
	lngFileSize = 10000
	'the files to be excluded (must be in format ".aaa;.bbb")
	'and must be set to blank ("") if none are to be excluded
	strExcludes = ""
	'the files to be included (must be in format ".aaa;.bbb")
	'and must be set to blank ("") if none are to be excluded
	strIncludes = ".gif;.jpg"
	'-----------------------------------------------
	%>
	