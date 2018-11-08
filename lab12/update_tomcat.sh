#!/bin/sh -x
#please note that you must run this as root
# make a backup copy of the tomcat users file
if [ ! -f /opt/tomcat/conf/tomcat-users.xml.bak ]; then
    cp /opt/tomcat/conf/tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml.bak
fi

# list the backup copy to make certain it is succesful
ls -l /opt/tomcat/conf/tomcat-users.xml.bak 
#Update the tomcat-users with our new file
cp -f tomcat-users.xml /opt/tomcat/conf/
#make the file owned by the tomcat user
chown tomcat /opt/tomcat/conf/tomcat-users.xml
#Change the group to the tomcat uers
chgrp tomcat /opt/tomcat/conf/tomcat-users.xml
# check the contents of tomcat-users.xml to ensure it matches what I want
cat /opt/tomcat/conf/tomcat-users.xml 
#make sure the myuniversity webapp directory is clear
rm -rf /opt/tomcat/webapps/myuniversity
#copy the directory to the tomcat webapps
cp -r myuniversity /opt/tomcat/webapps/
#change the ownder to tomcat
chown -R tomcat /opt/tomcat/webapps/myuniversity
#change the group to tomcat
chgrp -R tomcat /opt/tomcat/webapps/myuniversity
#top level list of the web app to see if it made it, more or less
ls -l /opt/tomcat/webapps/myuniversity 

#restart tomcat so it can read the tomcat-users.xml file
service tomcat restart
