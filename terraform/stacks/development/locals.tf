locals {
  common_labels = {
    team        = "sre"
    terrafrom   = "true"
    app_id      = "infra"
    environment = var.environment
  }
}
