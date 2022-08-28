##########################################################################################
# Creating 1 EC2 Instances Private:
##########################################################################################

resource "aws_instance" "instance" {
  depends_on           = [aws_instance.instance_bastion]
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

  provisioner "local-exec" {
    command = "sleep 150 && scp -i ${var.ssh_private_key} -o 'StrictHostKeyChecking=no' -o ProxyCommand='ssh -i ${var.ssh_private_key} -W %h:%p -o 'StrictHostKeyChecking=no' admin@${aws_instance.instance_bastion.*.public_ip[0]}' ${var.ssh_userdata} admin@${self.private_ip}:~ &&  ssh -tt -i ${var.ssh_private_key} -o 'StrictHostKeyChecking=no' -o ProxyCommand='ssh -i ${var.ssh_private_key} -W %h:%p -o 'StrictHostKeyChecking=no' admin@${aws_instance.instance_bastion.*.public_ip[0]}' admin@${self.private_ip} ${var.ssh_path_userdata}"        
  }

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

