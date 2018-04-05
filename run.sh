#!/bin/bash

kops replace cluster --name ${KOPS_CLUSTER_NAME} -f "conf.yaml" --force

openssl rsa -in /root/.ssh/${SSH_KEYNAME}.pem -pubout > ${SSH_KEYNAME}2.pub
ssh-keygen -f ${SSH_KEYNAME}2.pub -i -mPKCS8 > ${SSH_KEYNAME}.pub

kops create secret --name ${KOPS_CLUSTER_NAME} sshpublickey admin -i ~/.ssh/webadmin.pub

kops update cluster ${KOPS_CLUSTER_NAME} --yes

kubectl apply -f kubernetes-dashboard.yaml

kops get secrets kube --type secret -oplaintext