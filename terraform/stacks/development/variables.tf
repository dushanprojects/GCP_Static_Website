variable "environment" {
  type    = string
  default = "development"
}

variable "gcp_svc_key" {
  type        = string
  description = "Get GCP cred file path"
  default     = "../../../secrets/development/gcp_sa_cred.json"
  sensitive   = true
}

variable "project_id" {
  type        = string
  description = "Get Google Project ID value from terrafrom.auto.tfvars"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "Default Region"
  default     = "us-east1"
}


