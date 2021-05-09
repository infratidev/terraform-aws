variable "region" {
  description = "Região que será utilizada"
  default     = "us-east-2"
}

variable "instance_type" {
  description = "Tipo da instancia na AWS usando o free tier"
  default     = "t2.micro"
}

variable "name" {
  description = "Nome da aplicação"
  default     = "ec2server01"
}

variable "env" {
  description = "Ambiente"
  default     = "dev"
}





