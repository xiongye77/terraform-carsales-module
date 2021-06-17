
git clone https://github.com/xiongye77/terraform-carsales-module.git


run "tree" command to check its directory 


Make sure you change modules/route53/data.tf  "aconex.design" to your route53 registered domain
Make sure you change modules/route53/route53.tf  "myapps-test" to what you want for ALB alias or just keep it for 
I use "aws_region" "current" {} to get region 

terraform init 
terraform apply -auto-approve 

the outputs.tf will include ALB DNS name and Route53 alias 
