# Projeto Infraestrutura AWS - BIA

Este projeto utiliza [Terraform](https://www.terraform.io/) para provisionar e gerenciar a infraestrutura AWS necessária para a aplicação BIA, incluindo EC2, ECS, RDS, ALB, ECR, IAM, Auto Scaling, Security Groups e outros componentes essenciais.

## Estrutura do Projeto

- **EC2**: Instância para desenvolvimento (`bia-dev`), com Docker, Node.js, Python e ferramentas essenciais instaladas.
- **ECS**: Cluster, Capacity Provider, Service e Task Definition para orquestração de containers.
- **RDS**: Banco de dados PostgreSQL com gerenciamento de senha via Secrets Manager.
- **ALB**: Application Load Balancer para distribuir o tráfego HTTP/HTTPS.
- **ECR**: Repositório de imagens Docker para a aplicação BIA.
- **IAM**: Perfis, roles e policies para acesso seguro aos recursos.
- **CloudWatch**: Log Group para monitoramento dos containers ECS.
- **Auto Scaling**: Grupo de Auto Scaling para as instâncias do ECS.
- **Security Groups**: Regras de firewall para controle de acesso entre os componentes.

## Pré-requisitos

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- AWS CLI configurado com o perfil `desafio-agosto`
- Permissões adequadas na AWS para criar e gerenciar os recursos

## Como usar

1. **Clone o repositório:**
   ```sh
   git clone <url-do-repo>
   cd desafio-02
   ```

2. **Inicialize o Terraform:**
   ```sh
   terraform init
   ```

3. **Visualize o plano de execução:**
   ```sh
   terraform plan
   ```

4. **Aplique as mudanças:**
   ```sh
   terraform apply
   ```

## Variáveis

- `instance_name`: Nome da instância EC2 de desenvolvimento (default: `bia-dev`).

## Outputs

- ID, tipo e security group da instância EC2
- Endpoint do RDS
- URL do repositório ECR
- Nome do segredo do banco de dados no Secrets Manager
- URL do ALB

## Organização dos arquivos

- Recursos AWS separados por tipo em arquivos `.tf`
- Variáveis em [`variable.tf`](variable.tf)
- Outputs em [`outputs.tf`](outputs.tf)
- Configuração do backend remoto S3 em [`state_config.tf`](state_config.tf)
- Security Groups em [`sucurity_groups.tf`](sucurity_groups.tf)
- IAM em [`out_iam.tf`](out_iam.tf), [`aws_iam_ecs_role.tf`](aws_iam_ecs_role.tf), [`aws_iam_ecs__task_role.tf`](aws_iam_ecs__task_role.tf)

## Observações

- O projeto utiliza backend remoto S3 para o estado do Terraform.
- Certifique-se de atualizar os IDs de VPC e Subnets em [`locals.tf`](locals.tf) conforme seu ambiente.
- As imagens Docker devem ser publicadas no ECR provisionado.

---

> Projeto para fins educacionais e de formação AWS.
