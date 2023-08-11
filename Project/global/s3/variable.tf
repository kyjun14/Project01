variable "bucket_name" {
	type		  = string
	default		  = "project01-terraform-state"
}

variable "dynamodb_name" {
	type			= string
	default			= "project01-terraform-locks"
}