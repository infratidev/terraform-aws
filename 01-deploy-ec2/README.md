
# 📋 infratidev
### Processo seguindo a documentação
*Objetivo: Usando free tier da aws, provisionar algumas instancias t2.micro, depois removê-las*
*SO: Debian Buster*
##### Documentação Terraform
`https://learn.hashicorp.com/collections/terraform/aws-get-started`
#### Instalação do terraform
##### Baixando pacote
*Site: https://www.terraform.io/downloads.html*
```
wget https://releases.hashicorp.com/terraform/0.15.3/terraform_0.15.3_linux_amd64.zip
```
##### Unzip no pacote
`unzip terraform_0.15.3_linux_amd64.zip`
##### Movendo binário para o $PATH
`mv terraform /usr/local/bin/`
##### Testando o binário
`terraform -help`

```
Usage: terraform [-version] [-help] <command> [args]
The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.
##...
```

##### Habilitando tab completion no zsh
` touch ~/.zshrc` 
`terraform -install-autocomplete`

##### Na console de gerenciamento da AWS, IAM
- *Foi criado um novo usuario, com permissao para instancias EC2*
- *Para esse usuário foi gerada um Access key ID e uma Secret Access Key*

##### Instalando aws cli
`python3 -m pip install awscli`

##### Configurando Access Key ID and Secret Access Key na Região us-east-1
`aws configure`
`aws_access_key_id =`
`aws_secret_access_key =`

##### Arquivos terraform (Terraform irá processar todos os arquivos .tf)
*Files:*
```
main.tf => *aws provider*
instec2.tf   => *aws_instance*
vars.tf      => *variaveis*
output.tf => *exibir na tela o estado da instancia / endereco ip public e dns publico*
```

##### Inicializando o diretório, baixando e instalando o provider da aws
`terraform init`
*Terraform has been successfully initialized!*

##### Acertar identação do terraform
`terraform fmt`

##### Validando configuração
`terraform validate`

##### Plano de configuração
`terraform plan`

##### Aplicando plano
`terraform apply`

*Output:* 
```
instance_state = "running"
public_dns = "X.amazonaws.com"
public_ip = "XX.XX.XX.XX"
```

##### Verificando o estado atual
`terraform show`

##### Destruindo ambiente
`terraform destroy`
