module "aws-infra" {
    source = "../../infra"
    instancia = "t2.micro"
    regiao_aws = "sa-east-1"
    chave = "iac-dev"
    grupo_seguranca = "DEV"
    min = 1
    max = 1
    nome_grupo = "DEV"
}

# output "IP"{
#     value = module.aws-infra.IP_Publico
# }