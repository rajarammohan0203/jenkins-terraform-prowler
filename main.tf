provider "aws" {
  region     = "us-east-2"
  access_key = "AKIA425NFYHJT3QH4HW2"
  secret_key = "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"
}

#1 -this will create a S3 bucket in AWS
resource "aws_s3_bucket" "terraform_state_s3" {
  #make sure you give unique bucket name
  bucket = "awsraja2003-terraform" 
  force_destroy = true
# Enable versioning to see full revision history of our state files
  versioning {
         enabled = true
        }

# Enable server-side encryption by default
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# 2 - this Creates Dynamo Table
resource "aws_dynamodb_table" "terraform_locks" {
# Give unique name for dynamo table name
  name         = "TerraFom1-up-and-run-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
        attribute {
         name = "LockID"
         type = "S"
      }
}
