FROM ubuntu:16.04
RUN apt-get update \
	&& apt-get install -y python-pip unzip curl nano less openssh-client \
	&& pip install awscli \
	&& curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64 \
 	&& chmod +x kops-linux-amd64 \
 	&& mv kops-linux-amd64 /usr/local/bin/kops \
 	&& curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
	&& chmod +x ./kubectl \
	&& mv ./kubectl /usr/local/bin/kubectl \
 	&& rm -rf /var/lib/apt/lists/* 

ENV KOPS_CLUSTER_NAME=wg.k8s.local
ENV KOPS_STATE_STORE=s3://wg-kops-state-store
ENV EDITOR=nano
ENV SSH_KEYNAME=webadmin

RUN curl -LO https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
ADD clusterconf.yaml conf.yaml
ADD run.sh run.sh
RUN chmod +x run.sh