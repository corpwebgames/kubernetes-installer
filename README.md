# Docker for install kubernetes on aws

Run: docker run --rm -ti -v ${path_to_ssh_keys}/:/root/.ssh/ -v ${path_to_aws_credentials}:/root/.aws/ webgames/kubernetes-installer /run.sh

see https://medium.com/containermind/how-to-create-a-kubernetes-cluster-on-aws-in-few-minutes-89dda10354f4

