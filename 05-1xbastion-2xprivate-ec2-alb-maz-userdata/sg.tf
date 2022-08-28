locals {
  ingress_rules_bastion = [{
      name        = "SSH"
      port        = 22
      description = "Ingress rules for port 22"
  }]

  ingress_rules_http = [{
      name        = "SSH"
      port        = 22
      description = "Ingress rules for port 22"
  },
  {
      name        = "HTTP"
      port        = 80
      description = "Ingress rules for port 80"
  }]
}

#############################################
# SG Bastion:
#############################################

resource "aws_security_group" "sgbastion" {

  name        = "SGBastion"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.custom_vpc.id
  egress = [
    {
      description      = "for all outgoing traffics"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  dynamic "ingress" {
    for_each = local.ingress_rules_bastion

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = "AWS security group dynamic block"
  }

}

#############################################
# SG Private instances:
#############################################

resource "aws_security_group" "sghttp" {

  name        = "SGHTTP"
  description = "Allow HTTP e SSH inbound traffic"
  vpc_id      = aws_vpc.custom_vpc.id
  egress = [
    {
      description      = "for all outgoing traffics"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  dynamic "ingress" {
    for_each = local.ingress_rules_http

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = "AWS security group dynamic block"
  }

}

