[![Blog](https://img.shields.io/website?down_color=blue&down_message=infrati.dev&label=Blog&logo=ghost&logoColor=green&style=for-the-badge&up_color=blue&up_message=infrati.dev&url=https%3A%2F%2Finfrati.dev)](https://infrati.dev)

#### Por padrão o terraform state files é armazenado localmente. Objetivo é criar uma estrutura para armazenar remotamente os state files no S3 com DynamoDB para  implementar o state locking para estrutura do infracost integrado ao github action com OIDC
 
#### Projeto consiste em:
- provisionar a estrutura base de backend do tfstate no S3 utilizando o 
DynamoDB para locking. 
- criar a estrutura do OIDC utilizada pelo github para assumir a role necessária na AWS para provisionar os recursos. 
- Essa base será utilizada para execução do ```terraform-infracost-aws-github-action``` localizada no link:
[terraform-infracost-aws-github-action-oidc](https://github.com/infratidev/terraform-infracost-aws-github-action-oidc)

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
*Files:*
```
data.tf                       => Configuração do IAM para assumir a role específica
dynamo-tfstate-lock.tf        => Criação e parametrização do DynamoDB para deploy e network
oidc-role.tf                  => Criação da role e policy
oidc-thumb.tf                 => Geração do thumbprint
output.tf                     => Saída com o domain name e arn do bucket e role
provider.tf                   => aws provider
s3-tfstate-infracost.tf       => Criação e parametrização do S3 para estrutura do infracost
variables.tf                  => variaveis

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


[![Blog](https://img.shields.io/website?down_color=blue&down_message=infrati.dev&label=Blog&logo=ghost&logoColor=green&style=for-the-badge&up_color=blue&up_message=infrati.dev&url=https%3A%2F%2Finfrati.dev)](https://infrati.dev)


