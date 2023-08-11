terraform {
backend "s3" {
    bucket = "project01-terraform-state"
    key = "infra/ec2/target/terraform.tfstate"
    region = "ap-northeast-2"

    #이전에 생성한 다이나모DB 테이블 이름으로 변경
    dynamodb_table = "project01-terraform-locks"
    encrypt = true
    }
}