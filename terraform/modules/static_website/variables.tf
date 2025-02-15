variable "environment" {
  type    = string
  default = "development"
}

variable "region" {
  type        = string
  description = "Default Region"
}

variable "dns_zone_name" {
  type        = string
  description = "Name of the DNS Zone"
}

variable "subdomain" {
  type        = string
  description = "Subdomain name for the website | Without root domain"
}

variable "common_labels" {
  type        = map(any)
  description = "List of common tags"
}

