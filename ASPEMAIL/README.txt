Note that it is not necessary to run the setup to install AspEmail. If the component file aspemail.dll has already been extracted, you can move it to another machine and register it using the regsvr32 command-line utility. If you are running IIS and already have an older version of AspEmail installed on that machine, you should remove it from memory prior to installing a new one by executing the following commands at your MS DOS prompt: 

net stop iisadmin /y
net start w3svc 


Notice that by executing these commands you are also stopping other IISAdmin-related services such as FTP, SMTP, etc. To restart them, you may use the Services control panel. 
