terraform {
backend "s3" {
    bucket = "project01-terraform-state"
    key = "infra/ec2/lb/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "project01-terraform-locks"
    encrypt =true
  }
}