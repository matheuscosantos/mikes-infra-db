terraform {
  backend "s3" {
    bucket         = "mikes-terraform-state"
    key            = "mikes-db.tfstate"
    region         = "us-east-2"
    encrypt        = "true"
  }
}