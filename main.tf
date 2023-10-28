provider "aws" {
  region = "us-west-2"
}

resource "aws_db_instance" "database" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "11.6"
  instance_class       = "db.t2.micro"
  name                 = "mikes-db"
  username             = ""
  password             = ""
  parameter_group_name = "default.postgres11"
  skip_final_snapshot  = true
}

data "aws_secretsmanager_secret" "db_username" {
  name = "db_username"
}

data "aws_secretsmanager_secret_version" "db_username" {
  secret_id = data.aws_secretsmanager_secret.db_username.id
}

data "aws_secretsmanager_secret" "db_password" {
  name = "db_password"
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}