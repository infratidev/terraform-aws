##########################################################################################
# Creating 3 EC2 Instances:
##########################################################################################

resource "aws_instance" "instance" {
  count                = length(aws_subnet.public_subnet.*.id)
  ami                  = data.aws_ami.debian.id 
  instance_type        = var.instance_type
  subnet_id            = element(aws_subnet.public_subnet.*.id, count.index)
  security_groups      = [aws_security_group.sg.id, ]
  key_name             = "InfraTILab"
  

  tags = {
    "Name"        = "Instance-${count.index}"
    "Environment" = "Test"
    "CreatedBy"   = "Terraform"
  }

  timeouts {
    create = "10m"
  }

}

resource "null_resource" "null" {
  count = length(aws_subnet.public_subnet.*.id)

  provisioner "file" {
    source      = "./userdata.sh"
    destination = "/home/admin/userdata.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/admin/userdata.sh",
      "sh /home/admin/userdata.sh",
    ]
    on_failure = continue
  }

  connection {
    type        = "ssh"
    user        = "admin"
    port        = "22"
    host        = element(aws_eip.eip.*.public_ip, count.index)
    private_key = file(var.ssh_private_key)
  }

}


############################################################################################
# Creating 3 Elastic IPs:
############################################################################################

resource "aws_eip" "eip" {
  count            = length(aws_instance.instance.*.id)
  instance         = element(aws_instance.instance.*.id, count.index)
  public_ipv4_pool = "amazon"
  vpc              = true

  tags = {
    "Name" = "EIP-${count.index}"
  }
}

############################################################################################
# Creating EIP association with EC2 Instances:
############################################################################################

resource "aws_eip_association" "eip_association" {
  count         = length(aws_eip.eip)
  instance_id   = element(aws_instance.instance.*.id, count.index)
  allocation_id = element(aws_eip.eip.*.id, count.index)
}