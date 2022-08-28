data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-10-amd64-20210208-542"]
  }

  owners = ["136693071363"] # Debian 10

}

resource "aws_instance" "ec2server" {
  ami           = data.aws_ami.debian.id
  instance_type = var.instance_type

  tags = {
    Name        = var.name
    Environment = var.env
    Provisioner = "Terraform"
  }
}
