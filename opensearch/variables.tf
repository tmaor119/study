#vpc
variable "vpc_id" {
  type = string
  default = "vpc-66ec620d"
}

#proxy server
variable "proxy_subnet_id" {
  type = string
  default = "	subnet-989e26f3"
}

variable "proxy_inbound_cidr_blocks" {
  type = list
  default = ["0.0.0.0/0"]
}

#opensearch
variable "aos_domain_name" {
  type = string
  default = "test-opensearch"
}

variable "opensearch_version" {
  type = string
  default = "OpenSearch_1.3"
}

variable "aos_data_instance_count" {
  type = number
  default = 1
}

variable "aos_data_instance_type" {
  type = string
  default = "t3.small.elasticsearch"
}

variable "aos_data_instance_storage" {
  type = number
  default = 10
}