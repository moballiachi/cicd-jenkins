
variable "region" {
  default  = "us-east-1"
  description = "AWS region"
}

variable "access_key" {
  default  = "HEREYOURACCESSKEY"
  description = "AWS credentials file path"
}

variable "secret_key" {
  default  = "HEREYOURSECRETKEY"
  description = "AWS credentials file path"
}

variable "jenkins_user_name" {
  description = "jenkins"
  default = "jenkins"
}

variable "jenkins_user_password" {
  description = "jenkins"
  default = "jenkins"
}

variable "jenkins_name" {
  description = "Jenkins name"
  default = "jenkins"
}

variable "jenkins_instance_type" {
  default = "t2.micro"
}

variable "jenkins_key_name" {
  default = "key-pair"
  description = "SSH key located in tyour AWS account."
}

variable "amis" {
  description = "ami to spawn."
  default = { 
    us-east-1 = "ami-0c94855ba95c71c99"
  }
}