resource "aws_s3_bucket" "deploy" {
	bucket = "project01-deploy"
	


		lifecycle {
			prevent_destroy = false
	}
	  force_destroy = true	
}

resource "aws_s3_bucket_versioning" "enabled-deploy" {
	bucket = aws_s3_bucket.deploy.id
		versioning_configuration {
			status = "Enabled"
		}
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default-deploy" {
	bucket = aws_s3_bucket.deploy.id
	
	rule{
		apply_server_side_encryption_by_default {
			sse_algorithm = "AES256"
		}
	}
}

resource "aws_s3_bucket_public_access_block" "public_access-deploy" {
	bucket 						= aws_s3_bucket.deploy.id
	block_public_acls 			= true
	block_public_policy 		= true
	ignore_public_acls 			= true
	restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks-deploy" {
	name			 = "project01-deploy-locks"
	billing_mode	 = "PAY_PER_REQUEST"
	hash_key		 = "LockID"

	attribute {
		name = "LockID"
		type = "S"
	}
}