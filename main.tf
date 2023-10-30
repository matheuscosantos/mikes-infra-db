provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = var.states_bucket
    key            = var.states_file
    region         = var.region
    encrypt        = var.states_bucket_encrypt
  }
}

resource "aws_db_subnet_group" "database" {
  name       = var.aws_db_subnet_group_name
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "database" {
  identifier                    = var.db_identifier
  allocated_storage             = var.db_allocated_storage
  db_name                       = var.db_name
  engine                        = "postgres"
  engine_version                = "14"
  instance_class                = "db.t3.micro"
  username                      = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)["username"]
  password                      = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)["password"]
  skip_final_snapshot           = true
  allow_major_version_upgrade   = true
  db_subnet_group_name          = aws_db_subnet_group.database.name
  apply_immediately             = true
  vpc_security_group_ids        = var.vpc_security_group_ids
}

data "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = var.db_credentials_arn
}