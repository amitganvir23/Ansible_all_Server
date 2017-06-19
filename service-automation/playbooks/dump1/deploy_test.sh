#!/bin/bash
### Script created by Amit Ganvir
clear

if [ `whoami` == "vsb" ];then echo;else echo -e "\n\e[31mUser Error... Please Login with vsb User\e[m\n";exit 0;fi

export release="$2"
export release_dir=/share/release/$release
export app=$1

export release_app="c2 sml smh facade em1 em2 ngtpa"

echo -e "\e[32;01mRelease:\e[m $release"
echo -e "\e[32;01mApp Name:\e[m $app"
#echo Release dir: $release_dir

#--------------------
em1()
{
echo EM-1 Deployment started
}

c2()
{
echo C2 Deployment started
}

em2()
{
echo EM-2 Deployment started
}

#--------------------

if [ -z != $release ] && [ -z != $app ] && [ -d $release_dir ];then

#echo NOT Null
#exit 0
#echo "Deployment started"
cd /etc/ansible/playbooks
echo -e "\e[35;01m======================================================\e[m"
#echo -e "\n\e[31mEnter valid app name: smh,c2,sml,ngtpa,facade,em1,em2 or all-app, See the below example:\n$0 all-app OR $0 smh\e[m\n"
my_app=`echo $app|tr ',' ' '`
#echo App Selected $my_app

for i in $my_app;do
chk_app=`echo $release_app|grep -wc $i`
if [ $chk_app == 0 ];then
echo -e "\n\e[31mError.... Please Enter valid App Name: $i\e[m"
exit 0
fi
done

echo -e "\e[34;01mDo you want to continue with this Deployment [Y/n]:?\e[m \c"
read abc

case $abc in
Y|yes|YES|Yes)

for i in $my_app;do
#echo -e '\E[36;44m'"\033[1m==============================================================\033[0m"
echo -e "\e[33m===========================================================================================\e[m:-> Deployment Started for $i"
sleep 3
echo -e "\e[32mDeployment Started for App: $i\e[m"
$i
done
;;

N|n|NO|No|no)
echo -e "Exit from deployment"
exit 0
;;

*)
echo "Enter Valid Option to start deployment..[Y/n]"
exit 0
;;

esac

else
 echo -e "\e[35;01m======================================================\e[m"
 echo -e "\n\e[31mErrro... Please Enter valid Build Name example:\n$0 all-app <release_num> OR $0 smh <release_num>\e[m"
 echo -e "\e[31mValid Apps are: smh,c2,sml,ngtpa,facade,em1,em2 or all-app \e[m\n"
 exit 0
fi

### Script created by Amit Ganvir
