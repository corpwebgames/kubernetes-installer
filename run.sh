#!/bin/bash
set -e
kops replace cluster --name ${KOPS_CLUSTER_NAME} -f "conf.yaml" --force

openssl rsa -in /root/.ssh/${SSH_KEYNAME}.pem -pubout > ${SSH_KEYNAME}2.pub
ssh-keygen -f ${SSH_KEYNAME}2.pub -i -mPKCS8 > ${SSH_KEYNAME}.pub

kops create secret --name ${KOPS_CLUSTER_NAME} sshpublickey admin -i ${SSH_KEYNAME}.pub

kops update cluster ${KOPS_CLUSTER_NAME} --yes

set +e 

while [ "$(kops validate cluster --name ${KOPS_CLUSTER_NAME}  2>&1  | grep 'ready')" == "" ]
do 
   kops validate cluster --name ${KOPS_CLUSTER_NAME}
   sleep 30 
done

kubectl cluster-info

kubectl apply -f kubernetes-dashboard.yaml

kops get secrets kube --type secret -oplaintext