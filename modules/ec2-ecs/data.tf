data "aws_caller_identity" "current" { }
data "aws_region" "current" {}
#  aws ssm get-parameters --names /aws/service/ecs/optimized-ami/amazon-linux-2/recommended
data "aws_ami" "aws_optimized_ecs" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["591542846629"] # AWS
}
