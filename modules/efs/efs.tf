resource "aws_efs_file_system" "efs_volume" {
  creation_token = "efs-carsales-demo"
  encrypted = true
  performance_mode = "generalPurpose"

  lifecycle_policy {
    transition_to_ia = "AFTER_7_DAYS"
  }
 
}

resource "aws_efs_access_point" "efs_access_point" {
  file_system_id = aws_efs_file_system.efs_volume.id
  posix_user {
    gid = 1000
    uid = 1000
  }
  root_directory {
    path = "/mnt/efs"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = 755
    }
  }
  tags = {
    Name    = "EFS_For_ECS"
  }
}
resource "aws_security_group" "carsales_efs_sg" {
  name = "CarSales EFS Security Group"
  vpc_id = var.vpc_id
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    security_groups = [
     var.ecs_sg_id
    ]
  }
  tags = {
    Name        = "EFS Security Group"
    Terraform   = "true"
  }
}
resource "aws_efs_mount_target" "ecs_temp_space_az0" {
  file_system_id = "${aws_efs_file_system.efs_volume.id}"
  subnet_id      =  var.vpc_subnets[0]
  security_groups = [aws_security_group.carsales_efs_sg.id]
}

resource "aws_efs_mount_target" "ecs_temp_space_az1" {
  file_system_id = "${aws_efs_file_system.efs_volume.id}"
  subnet_id      =  var.vpc_subnets[1]
  security_groups = [aws_security_group.carsales_efs_sg.id]
}
