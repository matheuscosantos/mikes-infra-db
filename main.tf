provider "aws" {
  region = "us-east-2"
}

resource "aws_db_instance" "database" {
  allocated_storage    = 20
  db_name              = "mikesdb"
  engine               = "postgres"
  engine_version       = "14"
  instance_class       = "db.t3.micro"
  username             = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)["username"]
  password             = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)["password"]
  skip_final_snapshot  = true
  allow_major_version_upgrade = true
}

data "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
}

resource "aws_secretsmanager_secret" "db_credentials" {
  name = "db_credentials_v1"
  lifecycle {
    ignore_changes = all
  }
}