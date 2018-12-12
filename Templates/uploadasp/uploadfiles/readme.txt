**********************************************
The files are : 

uploadform.asp			the form for displaying files etc
config.asp			an include file which contains the configuration information
upload.asp			the file up loader class code
upload.css			a stylesheet
uploadfile.asp			the upload code

The config.inc file requires your paticular set up to identify files, directories etc. 
as follows :

strFolder = "D:\uploadasp\files"  'the name of the folder (note there is no / at end)

httpRef = "http://localhost/uploadasp/files" 'the name of folder in http format (note there is no / at end)

lngFileSize = 10000 'the max size of file which can be uploaded, 0 will give unlimited file size

strExcludes = ""   
         the files to be excluded (must be in format ".aaa;.bbb")
         and must be set to blank ("") if none are to be excluded

strIncludes = ".gif;.jpg"
         the files to be included (must be in format ".aaa;.bbb")
         and must be set to blank ("") if none are to be excluded

**********************************************



