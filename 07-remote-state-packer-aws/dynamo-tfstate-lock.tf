################################################
#Create DynamoDB Table Packer Network
################################################

resource "aws_dynamodb_table" "tf-state-packer-network-lock" {
    name           = "infrati-tfstate-packer-network-lock"
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
    Name        = "terraform-state-packer-network"
    Environment = "Development"        
    }
}


################################################
#Create DynamoDB Table Packer Deploy
################################################

resource "aws_dynamodb_table" "tf-state-packer-deploy-lock" {
    name           = "infrati-tfstate-packer-deploy-lock"
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
    Name        = "terraform-state-packer-deploy"
    Environment = "Development"        
    }
}