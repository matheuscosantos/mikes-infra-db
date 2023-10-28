provider "aws" {
  region = "us-west-2"
}

resource "aws_db_instance" "database" {
  allocated_storage    = 20
  db_name              = "mikes-db"
  engine               = "postgres"
  engine_version       = "11.5"
  instance_class       = "db.t2.micro"
  username             = "change-it"
  password             = "change-it"
  parameter_group_name = "default.postgres11"
  skip_final_snapshot  = true
}