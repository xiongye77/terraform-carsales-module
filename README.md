
git clone https://github.com/xiongye77/terraform-carsales-module.git

my terraform version as following 

[ec2-user@ip-192-168-23-47 terraform-carsales-module]$ terraform --version
Terraform v0.15.5
on linux_amd64
+ provider registry.terraform.io/hashicorp/aws v3.45.0
+ provider registry.terraform.io/hashicorp/local v2.1.0
+ provider registry.terraform.io/hashicorp/random v3.1.0
+ provider registry.terraform.io/hashicorp/tls v3.1.0

Your version of Terraform is out of date! The latest version
is 1.0.0. You can update by downloading from https://www.terraform.io/downloads.html



run "tree" command to check its directory 


Make sure you change modules/route53/data.tf  "aconex.design" to your route53 registered domain

Make sure you change modules/route53/route53.tf  "myapps-test" to what you want for ALB alias or just keep it for 

I use "aws_region" "current" {} to get region  it will be set by export AWS_DEFAULT_REGION 

terraform init 
terraform apply -auto-approve 

It will save terraform state file locally, however check my another repo for use S3 to save it https://github.com/xiongye77/terraform-carsales.git

the outputs.tf will include ALB DNS name and Route53 alias 


Outputs:

alb_dns_addr = "myapps-test.aconex.design"
alb_url_addr = "carsales-alb-600746898.ap-southeast-2.elb.amazonaws.com"

use http://myapps-test.aconex.design  to verify http to https redirect
