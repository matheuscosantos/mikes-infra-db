provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket         = "mikes-terraform-state"
    key            = "mikes-db.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }
}

resource "aws_db_subnet_group" "database" {
  name       = "mikes-db-subnet-group-v3"
  subnet_ids = ["subnet-02fade20759ea9048", "subnet-0476b7fa27309a259", "subnet-0476b7fa27309a259"]
}

resource "aws_db_instance" "database" {
  identifier                    = "mikes-db"
  allocated_storage             = 20
  db_name                       = "mikesdb"
  engine                        = "postgres"
  engine_version                = "14"
  instance_class                = "db.t3.micro"
  username                      = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)["username"]
  password                      = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)["password"]
  skip_final_snapshot           = true
  allow_major_version_upgrade   = true
  db_subnet_group_name          = aws_db_subnet_group.database.name
  apply_immediately             = true
  vpc_security_group_ids        = ["sg-098c8756d60c43c2d"]
}

data "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = "arn:aws:secretsmanager:us-east-2:644237782704:secret:mikes/db/db_credentials-6wQzyQ"
}