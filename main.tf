provider "aws" {
  region = "us-east-2"
}

resource "aws_ssm_parameter" "db_username" {
  name  = "/mikes-app/db_username"
  type  = "SecureString"
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/mikes-app/db_password"
  type  = "SecureString"
}

resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "db-subnet-group"
  subnet_ids = ["subnet-08b040edf682e0f26", "subnet-08b040edf682e0f26", "subnet-0926c91b917672f40"]
}

resource "aws_db_instance" "mikes_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "12.6"
  instance_class       = "db.t2.micro"
  name                 = "mikes-db"
  parameter_group_name = "default.postgres12"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.mikes.id]
  db_subnet_group_name = aws_db_subnet_group.db-subnet-group.name
  iam_database_authentication_enabled = true
}

resource "aws_security_group" "mikes" {
  name_prefix = "sg-"
  
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Aberto para o mundo; ajuste conforme necessário
  }
}