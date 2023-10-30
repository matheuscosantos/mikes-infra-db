terraform {
  backend "s3" {
    bucket         = var.states_bucket
    key            = var.states_file
    region         = var.region
    encrypt        = var.states_bucket_encrypt
  }
}