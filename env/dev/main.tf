module "aws-infra" {
    source = "../../infra"
    instancia = "t2.micro"
    regiao_aws = "sa-east-1"
    chave = "iac-dev"
}