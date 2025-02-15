module "static_website" {
  source        = "../../modules/static_website"
  common_labels = local.common_labels
  environment   = var.environment
  subdomain     = "mywebsite"
  dns_zone_name = "website-online"
  region        = var.region
}



