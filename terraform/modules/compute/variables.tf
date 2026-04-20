variable "project_name" {
  description = "Nombre del proyecto, usado como prefijo en todos los recursos"
  type        = string
  default     = "p01-webha"
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "Region de AWS"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "ID de la VPC donde se despliegan los recursos"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs de las subnets publicas para el ALB"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "IDs de las subnets privadas para el ASG"
  type        = list(string)
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}

variable "asg_min_size" {
  description = "Numero minimo de instancias en el ASG"
  type        = number
  default     = 2
}

variable "asg_desired_size" {
  description = "Numero deseado de instancias en el ASG"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Numero maximo de instancias en el ASG"
  type        = number
  default     = 6
}