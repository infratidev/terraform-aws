##########################################################################################
# Creating 1 EC2 Instances Private:
##########################################################################################

resource "aws_instance" "instance" {
  depends_on           = [aws_instance.instance_bastion,aws_nat_gateway.ngw]
  count                = length(aws_subnet.private_subnet.*.id)
  ami                  = data.aws_ami.debian.id 
  instance_type        = var.instance_type
  subnet_id            = element(aws_subnet.private_subnet.*.id, count.index)
  security_groups      = [aws_security_group.sghttp.id, ]
  key_name             = "InfraTILab"
  

  tags = {
    "Name"        = "Instance-${count.index}"
    "Environment" = "Test"
    "CreatedBy"   = "Terraform"
  }

  timeouts {
    create = "10m"
  }

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  sudo echo "<h1> Welcome to my terraform InfraTI IP: $(ip route get 1.2.3.4 | awk '{print $7}') </h1>" | sudo tee "/var/www/html/index.html"
  echo "*** Completed Installing apache2"
  EOF

 

}

##########################################################################################
# Creating 1 EC2 Instances Public - Bastion Host:
##########################################################################################

resource "aws_instance" "instance_bastion" {
  ami                  = data.aws_ami.debian.id 
  count                = var.bastion_instances_count
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.public_subnet.*.id[0]
  security_groups      = [aws_security_group.sgbastion.id]
  key_name             = "InfraTILab"
  

  tags = {
    "Name"        = "Instance-Bastion"
    "Environment" = "Test"
    "CreatedBy"   = "Terraform"
  }

  timeouts {
    create = "10m"
  }


}

