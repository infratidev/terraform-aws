output "instance_state" {
  value = aws_instance.ec2server.instance_state
}

output "public_ip" {
  value = aws_instance.ec2server.public_ip
}

output "public_dns" {
  value = aws_instance.ec2server.public_dns
}


