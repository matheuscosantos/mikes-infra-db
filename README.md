# Banco de dados - RDS - PostgreSQL

Este é um exemplo de como configurar e implantar uma instância de banco de dados AWS RDS PostgreSQL usando GitHub Actions e Terraform.

## Github Actions

O código a seguir cria uma instância de banco de dados AWS RDS usando o provedor AWS e o módulo RDS do Terraform. Ele também configura uma ação do GitHub para implantar a instância de banco de dados quando qualquer alteração é feita na branch principal.

``` xml
name: Deploy AWS RDS PostgreSQL

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Configure AWS Credentials
      uses: aws-actions/configure-aws-credentials@v1
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: us-east-2

    - name: Set up Terraform
      uses: hashicorp/setup-terraform@v1

    - name: Initialize Terraform
      run: terraform init

    - name: Plan Terraform
      run: terraform plan

    - name: Deploy RDS
      run: terraform apply -auto-approve

    - name: Capture Outputs
      id: outputs
      run: echo "::set-output name=rds_endpoint::$(terraform output -raw rds_endpoint)"

    - name: Store RDS Endpoint as Environment Variable
      run: |
        echo "RDS_ENDPOINT=${{ steps.outputs.outputs }}" >> $GITHUB_ENV
```

## Detalhes da configuração

Aqui estão os detalhes das configurações do RDS:

- Nome da instância do banco de dados (**DB Instance Identifier**): mikes-db
- Nome do banco de dados (**DB Name**): mikesdb
- Versão do mecanismo (**Engine Version**): 14
- Classe da instância (**Instance Class**): db.t3.micro
- Nome do grupo de sub-redes do DB (**DB Subnet Group Name**): mikes-db-subnet-group
- IDs do grupo de segurança da VPC (**VPC Security Group IDs**): sg-01f81ec455ea45da9
  
## Uso

Para usar este exemplo, você precisa ter o Terraform instalado em sua máquina. Você pode baixar o Terraform aqui.

Depois de instalar o Terraform, você pode inicializar este exemplo executando terraform init no diretório que contém este exemplo. Depois de inicializado, você pode criar o plano de execução com terraform plan e aplicar o plano com terraform apply.

Você também precisará configurar suas credenciais da AWS como segredos em seu repositório do GitHub. Você pode fazer isso navegando até a página do seu repositório no GitHub, clicando em “Settings”, depois em “Secrets”, e adicionando seus segredos lá.

Os segredos que você precisa configurar são:

- **AWS_ACCESS_KEY_ID**: Sua chave de acesso da AWS.
- **AWS_SECRET_ACCESS_KEY**: Sua chave secreta de acesso da AWS.

Depois de configurar seus segredos, qualquer merge para a branch main acionará a ação do GitHub para implantar sua instância de banco de dados.

## Justificativa para o uso do PostgreSQL

- **Integridade de dados**: Os bancos de dados relacionais garantem a integridade dos dados através de restrições, chaves estrangeiras e transações.
- **Padrão SQL**: A linguagem SQL é universalmente aceita e usada, tornando mais fácil encontrar desenvolvedores qualificados.
- **Suporte a junções**: Os bancos de dados relacionais permitem junções complexas de tabelas, o que pode ser difícil em bancos de dados não relacionais.
- **ACID Compliance**: Os bancos de dados relacionais são ACID (Atomicidade, Consistência, Isolamento, Durabilidade) compatíveis, garantindo que as transações de banco de dados sejam processadas de maneira confiável.
- **Maturidade**: Os bancos de dados relacionais existem há décadas, portanto, têm uma base sólida, muitos recursos e uma grande comunidade de suporte.

## Justificativa para o uso do Amazon RDS com PostgreSQL

- **Gerenciamento Simplificado**: O serviço automatiza tarefas de administração, como provisionamento, backup e atualizações, liberando tempo para se concentrar no desenvolvimento da aplicação.

- **Alta Disponibilidade**: Configurações multi-zona garantem que seu banco de dados permaneça acessível, mesmo em caso de falhas, assegurando a continuidade dos serviços.

- **Escalabilidade Flexível**: Permite escalonar verticalmente (mais recursos) e horizontalmente (réplicas de leitura), adaptando-se às variações na demanda de tráfego.

- **Segurança Avançada**: Oferece opções de segurança robustas, incluindo controle de acesso, criptografia de dados em repouso e em trânsito, além de gestão de chaves.

- **Integração com AWS**: Facilita a construção de aplicativos escaláveis e altamente disponíveis, sendo integrado a outros serviços da AWS, como EC2, CloudWatch e IAM.



## Diagrama

![Diagrama do banco de dados](/doc/diagrama.JPG)
