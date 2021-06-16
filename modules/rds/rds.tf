# CREATE RDS SECURITY GROUP

resource "aws_security_group" "carsales_db_sg" {
  name = "CarSales RDS Security Group"
  vpc_id = var.vpc_id
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [
     var.ecs_sg_id
    ]
  }
  tags = {
    Name        = "RDS Security Group"
    Terraform   = "true"
  }
}

# Create CarSales Database Subnet Group

resource "aws_db_subnet_group" "carsales-db-subnet" {
  name = "carsales-database-subnet-group"
  subnet_ids = var.vpc_subnets

  tags = {
    Name        = "DB Subnet Group"
    Terraform   = "true"
  }
}

# Create CarSales Database Instance 

resource "aws_db_instance" "carsales-db" {
  allocated_storage       = "10"
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "11.5"
  multi_az                = "true"
  instance_class          = "db.t2.micro"
  name                    = "magento"
  # Set the secrets from AWS Secrets Manager
  username = local.db_creds.username
  password = "${random_string.password.result}"  
  identifier              = "carsales-database"
  skip_final_snapshot     = "true"
  backup_retention_period = "7"
  # DB Instance class db.t2.micro does not support encryption at rest
  storage_encrypted       = "false"
  db_subnet_group_name    = aws_db_subnet_group.carsales-db-subnet.name
  vpc_security_group_ids  = [aws_security_group.carsales_db_sg.id]
   tags = {
    Name        = "CarSales Database"
    Terraform   = "true"
  }
}

resource "random_string" "password" {
  length  = 16
  special = false
}

resource "aws_ssm_parameter" "rdspassword" {
  name = "/production/myapp/rds-password"
  type        = "SecureString"
  value = "${random_string.password.result}"
}
data "aws_secretsmanager_secret_version" "creds" {
  # Fill in the name you gave to your secret
  depends_on = [aws_secretsmanager_secret_version.secretmanager-version]
  secret_id = aws_secretsmanager_secret.RDS-postgres-username.id
}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}
resource "aws_ssm_parameter" "db_host" {
  name  = "/production/myapp/db-host"
  type  = "String"
  value = aws_db_instance.carsales-db.endpoint
}

resource "aws_secretsmanager_secret" "RDS-postgres-username" {
   recovery_window_in_days = 0
   name = "carsales-rds-postgres-admin"
}

resource "aws_secretsmanager_secret_version" "secretmanager-version" {
  secret_id = aws_secretsmanager_secret.RDS-postgres-username.id
  secret_string = <<EOF
  {
    "username": "adminaccount"
  }
  EOF
}

