# Fetching an existing Cloud DNS managed zone
data "google_dns_managed_zone" "web_domain_zone" {
  name = var.dns_zone_name
}

# Creating a DNS record for the static website
resource "google_dns_record_set" "static_web" {
  managed_zone = data.google_dns_managed_zone.web_domain_zone.name
  name         = "${var.subdomain}.${data.google_dns_managed_zone.web_domain_zone.dns_name}"
  rrdatas      = [google_compute_global_address.static_ip.address]
  type         = "A"
  ttl          = 300
}
