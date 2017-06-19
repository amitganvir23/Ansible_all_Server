#!/bin/bash
### Script created by Amit Ganvir
clear

#new
rm  /share/backup/test/succ.html /share/backup/test/succ.txt test_email_smh.retry 2> /dev/null

error_msg()
{

 echo -e "\e[35;01m======================================================\e[m"
 echo -e "Ex1 (For all App deployment) :- $0 <release_num> all-app "
 echo -e "Ex2 (For Single App deployment) :- $0 c2 <release_num> "
 echo -e "Ex3 (For Multiple App deployment) :- $0 <release_num> c2,em1,ngtpa "
 echo -e "Ex4 (Include Common and Meta Data with your App deployment) :- $0 <release_num> c2 common-conf "
 echo -e "\e[31mValid Apps are: smh,c2,sml,ngtpa,facade,em1,em2 or all-app \e[m"
}


if [ `whoami` == "vsb" ];then echo;else echo -e "\n\e[31mUser Error... Please Login with vsb User\e[m\n";exit 0;fi

export release="$1"
export release_dir=/share/release/$release
export app=$2
export cmd_meta=$3

export release_app="c2 sml smh facade em1 em2 ngtpa"
export release_all_apps="all-app"

echo -e "\e[32;01mRelease:\e[m $release"
echo -e "\e[32;01mApp Name:\e[m $app"
echo -e "\e[32;01mCommon Meta Data:\e[m $cmd_meta"
#echo Release dir: $release_dir
if [ "$cmd_meta" == "common-conf" ] || [ -z "$cmd_meta" ];then echo ;else echo "Error.. Please correct common-conf or keep it blank";error_msg;exit 0;fi


#--------------------
em1()
{
ansible-playbook em1_deploy.yml -i "app_hosts/all" -e "myrelease=${release} commonmetadata=${cmd_meta}"
unset cmd_meta
export ap=EM-1
export file=em1_deploy.retry
#export file=test_email_smh.retry
for i in `cat $file 2> /dev/null|tr '\n' ' '`;do echo -e "${ap} ;${i} ;Failed" >> /share/backup/test/succ.txt  ;done
#echo em1_deploy.yml ${release} #test
}

c2()
{
ansible-playbook  c2_deploy.yml -i "app_hosts/all" -e "myrelease=${release} commonmetadata=${cmd_meta}"
#ansible-playbook c2_test2.yml -i "app_hosts/all" -e "myrelease=${release} commonmetadata=${cmd_meta}" #test
unset cmd_meta
export ap=C2
export file=c2_deploy.retry
#export file=test_email_smh.retry
for i in `cat $file 2> /dev/null|tr '\n' ' '`;do echo -e "${ap} ;${i} ;Failed" >> /share/backup/test/succ.txt  ;done
#echo c2_deploy.yml ${release} #test
}

em2()
{
ansible-playbook em2_deploy.yml -i "app_hosts/all" -e "myrelease=${release} commonmetadata=${cmd_meta}"
unset cmd_meta
export ap=EM-2
export file=em2_deploy.retry
#export file=test_email_smh.retry
for i in `cat $file 2> /dev/null|tr '\n' ' '`;do echo -e "${ap} ;${i} ;Failed" >> /share/backup/test/succ.txt  ;done
#echo em2_deploy.yml ${release} #test
}

ngtpa()
{
ansible-playbook ngtpa_deploy.yml -i "app_hosts/all" -e "myrelease=${release} commonmetadata=${cmd_meta}"
unset cmd_meta
export ap=NGTPA
export file=ngtpa_deploy.retry
#export file=test_email_smh.retry
for i in `cat $file 2> /dev/null|tr '\n' ' '`;do echo -e "${ap} ;${i} ;Failed" >> /share/backup/test/succ.txt  ;done
#echo ngtpa_deploy.yml ${release} #test
}

facade()
{
ansible-playbook facade_deploy.yml -i "app_hosts/all" -e "myrelease=${release}"
unset cmd_meta
export ap=FACADE
export file=facade_deploy.retry
#export file=test_email_smh.retry
for i in `cat $file 2> /dev/null|tr '\n' ' '`;do echo -e "${ap} ;${i} ;Failed" >> /share/backup/test/succ.txt  ;done
#echo  facade_deploy.yml${release} #test
}

sml()
{
ansible-playbook sml_deploy.yml -i "app_hosts/all" -e "myrelease=${release} commonmetadata=${cmd_meta}"
unset cmd_meta
export ap=SML
export file=sml_deploy.retry
#export file=test_email_smh.retry
for i in `cat $file 2> /dev/null|tr '\n' ' '`;do echo -e "${ap} ;${i} ;Failed" >> /share/backup/test/succ.txt  ;done
#echo sml_deploy.yml ${release} #test
}

smh()
{
ansible-playbook  smh_deploy.yml -i "app_hosts/all" -e "myrelease=${release} commonmetadata=${cmd_meta}"  #orig
#ansible-playbook -v test_email_smh.yml -i app_hosts/smh_test -e "myrelease=${release} commonmetadata=${cmd_meta} all_app_email=$all_app_email"
unset cmd_meta
export ap=SMH
export file=smh_deploy.retry
#export file=test_email_smh.retry
for i in `cat $file 2> /dev/null|tr '\n' ' '`;do echo -e "${ap} ;${i} ;Failed" >> /share/backup/test/succ.txt  ;done
}

#---------------
all-app()
{
#export all_app_email=all-email
#echo $all_app_email
echo -e "\e[33m===========================================================================================\e[m:-> \e[32mDeployment Started for App: all-app\e[m"
echo
smh

#--------- send app status
#for i in `cat test_email_smh.retry`;do echo -e "SMH \t| $i \t| == Failed" >> /share/backup/test/succ.txt ;done
#echo "+++++++++++++++++++++++++"
#cat /share/backup/test/succ.txt
#ansible-playbook  email_app.yml -e "myrelease=${release}"

echo -e "\e[35m++++++++++++++++++++++++++++++++++++++++ Sending EMAIL ++++++++++++++++++++++++++++++++++++++++\e[m"
sleep 2
cat /share/backup/test/succ.txt
sleep 2
ansible-playbook  email_app.yml -e "myrelease=${release}"
echo -e "\e[35m++++++++++++++++++++++++++++++++++++++++  Email Sent  ++++++++++++++++++++++++++++++++++++++++\e[m"
}

#---------------
all-app2()
{
#ansible-playbook all_app_deploy.yml -i "app_hosts/all" -e "myrelease=${release}"
echo -e "\e[33m===========================================================================================\e[m:-> \e[32mDeployment Started for App: all-app\e[m"
echo
echo -e "\e[33m===========================================================================================\e[m:-> \e[32mDeployment Started for App: C2\e[m"
sleep 2
c2
echo

echo -e "\e[33m===========================================================================================\e[m:-> \e[32mDeployment Started for App: SML\e[m"
sleep 2
sml
echo

echo -e "\e[33m===========================================================================================\e[m:-> \e[32mDeployment Started for App: SMH\e[m"
sleep 2
smh
echo

echo -e "\e[33m===========================================================================================\e[m:-> \e[32mDeployment Started for App: NGTPA\e[m"
sleep 2
ngtpa
echo

echo -e "\e[33m===========================================================================================\e[m:-> \e[32mDeployment Started for App: EM-1\e[m"
sleep 2
em1
echo

echo -e "\e[33m===========================================================================================\e[m:-> \e[32mDeployment Started for App: EM-2\e[m"
sleep 2
em2
echo

echo -e "\e[33m===========================================================================================\e[m:-> \e[32mDeployment Started for App: FACADE\e[m"
sleep 2
facade

}

#--------------------

if [ -z != $release ] && [ -z != $app ] && [ -d $release_dir ];then

cd /etc/ansible/playbooks
echo -e "\e[35;01m======================================================\e[m"
my_app=`echo $app|tr ',' ' '`

#all app
all_result_app=`echo $release_all_apps |grep -wc $app`
if [ $all_result_app == 1 ];then
echo -e "\e[34;01mDo you want to continue with this Deployment [Y/n]:?\e[m \c"
read abc1
case $abc1 in
Y|yes|YES|Yes)
#echo -e "\e[33m===========================================================================================\e[m:-> \e[32mDeployment Started for App: $app\e[m"
#sleep 3
#echo -e "\e[32mDeployment Started for App: $i\e[m"
all-app
;;
N|n|NO|No|no)
echo -e "Exit from deployment"
exit 0
;;

*)
echo -e "\e[31mError... Enter Valid Option to start deployment..[Y/n]\e[m"
exit 0
;;

esac

exit 0
fi

#----------- single app
for i in $my_app;do
chk_app=`echo $release_app|grep -wc $i`
if [ $chk_app == 0 ];then
  echo -e "\n\e[31mErrro... Please Enter valid App Name Example:\n$0 <release_num> all-app OR $0 <release_num> smh \e[m"
  error_msg
  exit 0
fi
done

echo -e "\e[34;01mDo you want to continue with this Deployment [Y/n]:?\e[m \c"
read abc

case $abc in
Y|yes|YES|Yes)

for i in $my_app;do
echo -e "\e[33m===========================================================================================\e[m:-> \e[32mDeployment Started for App: $i\e[m"
sleep 3
$i
done
;;

N|n|NO|No|no)
echo -e "Exit from deployment"
exit 0
;;

*)
echo -e "\e[31mError... Enter Valid Option to start deployment..[Y/n]\e[m"
exit 0
;;

esac

else
 echo -e "\n\e[31mErrro... Please Enter valid Build Name example:\n$0 <release_num> all-app OR $0 <release_num> smh \e[m"
 error_msg
 exit 0
fi

echo -e "\e[35m++++++++++++++++++++++++++++++++++++++++ Sending EMAIL ++++++++++++++++++++++++++++++++++++++++\e[m"
cat /share/backup/test/succ.txt
sh /etc/ansible/playbooks/generateHTML.sh /share/backup/test/succ.txt 
ansible-playbook  email_app.yml -e "myrelease=${release}"
echo -e "\e[35m++++++++++++++++++++++++++++++++++++++++  Email Sent  ++++++++++++++++++++++++++++++++++++++++\e[m"
### Script created by Amit Ganvir
