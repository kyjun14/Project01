variable "vpc_cidr" {
    default = "10.1.0.0/16"
}
variable "public_subnet" {
    type = list
    default = ["10.1.1.0/24", "10.1.16.0/24"]
}

variable "private_subnet" {
    type = list
    default = ["10.1.128.0/24", "10.1.144.0/24"]
}

variable "azs" {
    type = list
    default = ["ap-northeast-2a", "ap-northeast-2c"]
}