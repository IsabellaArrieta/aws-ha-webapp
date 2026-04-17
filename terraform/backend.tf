# Backend remoto — se configurará cuando el bucket S3 esté listo
# terraform {
#   backend "s3" {
#     bucket         = "aws-ha-webapp-tfstate"
#     key            = "dev/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "aws-ha-webapp-tflock"
#     encrypt        = true
#   }
# }
