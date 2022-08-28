[![Blog](https://img.shields.io/website?down_color=blue&down_message=infrati.dev&label=Blog&logo=ghost&logoColor=green&style=for-the-badge&up_color=blue&up_message=infrati.dev&url=https%3A%2F%2Finfrati.dev)](https://infrati.dev)

##### Provisionado uma ec2 utilizando o userdata para instalar um servidor web utilizando remote state com S3 e DynamoDB para locking .

##### Estrutura provisionada

![Estrutura](../images/WebServer-Remote-State-AWS.png)

##### Requirements

* Terraform instalado, nesse caso utilizado v1.2.6
* Credenciais de acesso já criadas no IAM com as permissões necessárias para o S3 e Dynamodb
* aws_access_key_id e aws_secret_access_key geradas.

##### Instalando aws cli
`python3 -m pip install awscli`

##### Configurando Access Key ID and Secret Access Key na Região us-east-1
`aws configure`
`aws_access_key_id =`
`aws_secret_access_key =`

##### Arquivos terraform (Terraform irá processar todos os arquivos .tf)

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


[![Blog](https://img.shields.io/website?down_color=blue&down_message=infrati.dev&label=Blog&logo=ghost&logoColor=green&style=for-the-badge&up_color=blue&up_message=infrati.dev&url=https%3A%2F%2Finfrati.dev)](https://infrati.dev)


