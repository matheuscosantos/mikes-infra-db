provider "aws" {
  region = "us-east-2"
}

resource "aws_db_instance" "database" {
  allocated_storage    = 20
  db_name              = "mikesdb"
  engine               = "postgres"
  engine_version       = "14"
  instance_class       = "db.t3.micro"
  username             = data.aws_secretsmanager_secret.db_credentials.secret_string["username"]
  password             = data.aws_secretsmanager_secret.db_credentials.secret_string["password"]
  skip_final_snapshot  = true
  allow_major_version_upgrade = true
}

data "aws_secretsmanager_secret" "db_credentials" {
  name = "myapp/db_credentials"
}