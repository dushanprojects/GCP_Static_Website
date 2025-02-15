# Reserving a static external IP address
resource "google_compute_global_address" "static_ip" {
  name   = "static-website-ip-${var.environment}"
  labels = var.common_labels
}

# Defining a backend bucket for Cloud CDN
resource "google_compute_backend_bucket" "cdn" {
  bucket_name = google_storage_bucket.website.name
  name        = "static-website-cdn-${var.environment}"
  description = "CDN for storage bucket website"
  enable_cdn  = true
}

# Configuring URL mapping for routing requests
resource "google_compute_url_map" "website" {
  name            = "static-website-url-map-${var.environment}"
  default_service = google_compute_backend_bucket.cdn.self_link

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_bucket.cdn.self_link
  }
}

# Defining an HTTP proxy for handling web traffic
resource "google_compute_target_http_proxy" "website" {
  name    = "static-website-proxy-${var.environment}"
  url_map = google_compute_url_map.website.self_link
}

# Configuring a global forwarding rule for HTTP requests
resource "google_compute_global_forwarding_rule" "global_forward_rule" {
  name                  = "static-website-forward-rule-${var.environment}"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.static_ip.address
  ip_protocol           = "TCP"
  port_range            = "80"
  target                = google_compute_target_http_proxy.website.self_link
  labels                = var.common_labels
}
