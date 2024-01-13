# EKS deployment in Supermario
To deploy docker image to EKS cluster implemented infrastructure through terraform

## Create Instance with Ubuntu and terraform backend S# storage
```
aws configure 
#Provide secret access key and secrey key id, default region, format

aws ec2 run-instances --image-id ami-0c7217cdde317cfec --count 1 --instance-type t2.medium --key-name awsuseast1 --security-group-ids jegan-sec-grp --subnet-id <subnet-id>

aws s3api create-bucket --bucket jegankumard-ekssupermario --region us-east-1
```
create a role and assign to EC2 > Modify IAM role

Login to instance
```
ssh -i awsuseast1.pem ubuntu@<public-ip>
git clone https://github.com/Jegankumard/EKS_supermario.git

```
Execute shell script to install docker, awscli, kubectl, terraform
```
cd EKS_supermario
sudo chmod +x script.sh
./script.sh

docker --version
aws --version
kubectl version --client
terraform --version
```
Execute terraform to create cluster
```
cd terraform
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
 
##or
eksctl create cluster EKS_supermario --zones us-east-1a,us-east-1b

eksctl create cluster EKS_supermario --region us-east-1
aws eks update-kubeconfig --name EKS_supermario --region us-east-1
```

![alt text](https://raw.githubusercontent.com/Jegankumard/EKS_supermario/main/terraform_resource_created.JPG)

Deployment and service creation
``` 
##docker image - jegankumard/supermario:latest
kubectl apply -f deployment.yaml
kubectl get all

kubectl apply -f service.yaml
kubectl get all

kubectl describe service supermario-service
```

Access LoadBalancer ingress url and wait for few mins

![alt text](https://raw.githubusercontent.com/Jegankumard/EKS_supermario/main/Mario_deployment.JPG)

Dont forget to delete
```
kubectl delete -f service.yaml
kubectl delete -f deployment.yaml
terraform destroy -auto-approve
Remove S3 bucket and EC2 instance
```
