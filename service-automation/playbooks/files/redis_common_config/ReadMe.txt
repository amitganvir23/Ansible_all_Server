
# To populate the application specific configuration properites
#java -jar vsb-cm.jar -h 172.18.14.114 -p 6379 -c loadConfig -f app-prop-files-list.properties -d full
java -jar vsb-cm.jar -h 172.18.14.111 -p 8000 -c loadConfig -f app-prop-files-list.properties -d partial 
