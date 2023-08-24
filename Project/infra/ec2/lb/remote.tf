data "terraform_remote_state" "project01_vpc" {
    backend = "s3"
    config = {
        bucket = "project01-terraform-state"
        key    = "infra/network/vpc/terraform.tfstate"
        region = "ap-northeast-2"
    }
}

data "terraform_remote_state" "project01_sg" {
    backend = "s3"
    config = {
        bucket = "project01-terraform-state"
        key    = "infra/network/sg/terraform.tfstate"
        region = "ap-northeast-2"
    }
}