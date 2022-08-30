################################################
#Create DynamoDB Table Packer Network
################################################

resource "aws_dynamodb_table" "tf-state-infracost" {
    name           = "infrati-tfstate-infracost-locking"
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
    Name        = "terraform-tfstate-infracost-locking"
    Environment = "Development"        
    }
}

