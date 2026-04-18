terraform {
  backend "s3" {
    bucket         = "p01-webha-tfstate"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "p01-webha-tflock"
    encrypt        = true
  }
}