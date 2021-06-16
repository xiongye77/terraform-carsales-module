data "aws_ami" "amazon-linux-2-bastion" {
 most_recent = true
 filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
 owners = ["137112412989"] # AWS
}

