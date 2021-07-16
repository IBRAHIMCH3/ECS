terraform {
  backend "s3" {
    
    # S3 Bucket name
    
    bucket         = "digital-lending-abfl/terraform"
    key            = "global/ecs/terraform.tfstate"
    region         = "ap-south-1"
    
    #DynamoDB table name!
    
    dynamodb_table = "abfl-digital-infra-statefile-lock"
    encrypt        = true
  }
}
