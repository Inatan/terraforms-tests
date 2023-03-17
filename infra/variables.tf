variable "regiao_aws" {
  type        = string
  default     = ""
  description = "região da aws"
}

variable "chave" {
  type        = string
  default     = ""
  description = "chave de par"
}

variable "instancia" {
  type        = string
  default     = ""
  description = "qual tipo de instancia EC2"
}

variable "grupo_seguranca" {
  type        = string
  default     = ""
  description = "grupo de segurança"
}

variable "nome_grupo" {
  type        = string
  default     = ""
  description = "nome do auto scalling group"
}
variable "max" {
  type        = string
  default     = ""
  description = "máximo de instâncias"
}
variable "min" {
  type        = string
  default     = ""
  description = "minimo de Instâncias"
}