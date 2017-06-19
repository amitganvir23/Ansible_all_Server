#!/bin/bash

if [ `whoami` == "vsb" ];then echo;else echo -e "\n\e[31mUser Error... Please Login with vsb User\e[m\n";exit 0;fi

export release="$2"
export release_dir=/share/release/$release
export app=$1

echo Release: $release
echo App Name: $app
echo Release dir: $release_dir

if [ -z != $release ] && [ -z != $app ] && [ -d $release_dir ];then

#echo NOT Null
#exit 0

cd /etc/ansible/playbooks
case $1 in
smh)
ansible-playbook  smh_deploy.yml -i "app_hosts/all" -e "myrelease=${release}"
;;

c2)
ansible-playbook c2_deploy.yml -i "app_hosts/all" -e "myrelease=${release}"
;;

sml)
ansible-playbook sml_deploy.yml -i "app_hosts/all" -e "myrelease=${release}"
;;

ngtpa)
ansible-playbook ngtpa_deploy.yml -i "app_hosts/all" -e "myrelease=${release}"
;;


facade)
ansible-playbook facade_deploy.yml -i "app_hosts/all" -e "myrelease=${release}"
;;

em1)
ansible-playbook em1_deploy.yml -i "app_hosts/all" -e "myrelease=${release}"
;;

em2)
ansible-playbook em2_deploy.yml -i "app_hosts/all" -e "myrelease=${release}"
;;

all-app)
ansible-playbook all_app_deploy.yml -i "app_hosts/all" -e "myrelease=${release}"
;;

*)
echo -e "\n\e[31mEnter valid app name: smh,c2,sml,ngtpa,facade,em1,em2 or all-app, See the below example:\n$0 all-app OR $0 smh\e[m\n"
;;

esac

else
 echo -e "\n\e[31mPlease Enter valid Build Name example:\n$0 all-app <release_num> OR $0 smh <release_num>\e[m"
 echo -e "\e[31mValid Apps are: smh,c2,sml,ngtpa,facade,em1,em2 or all-app \e[m\n"
 exit 0
fi

### Script created by Amit Ganvir
