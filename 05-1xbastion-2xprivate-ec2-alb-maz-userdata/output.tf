
#############################################
# Instances Private IP:
#############################################

output "instance_private_ip" {
  value = aws_instance.instance.*.private_ip
}

#############################################
# Instance Bastion Public IP:
#############################################

output "bastion_public_ip" {
  value = aws_instance.instance_bastion.*.public_ip[0]
}

#############################################
# EIPs:
#############################################

output "eip_public_ip" {
  value = aws_eip.eip.*.public_ip
}

#############################################
# DNS EIPs:
#############################################

output "eip_public_dns" {
  value = aws_eip.eip.*.public_dns
}

#############################################
# DNS Private Instances
#############################################

output "instance_private_dns" {
  value = aws_instance.instance.*.private_dns
}

#############################################
# DNS Bastion Instances
#############################################

output "bastion_public_dns" {
  value = aws_instance.instance_bastion.*.private_dns
}

#############################################
# DNS ALB
#############################################

output "alb_id" {
  value = aws_lb.lb.dns_name
}

