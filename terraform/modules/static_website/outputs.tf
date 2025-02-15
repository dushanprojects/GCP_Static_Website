# Get FQDN of the website
output "website_fqdn" {
  value = google_dns_record_set.static_web.name
}

# Get storage bucket name
output "bucket_name" {
  value = google_storage_bucket.website.name
}

# Get static IP address
output "static_ip" {
  value = google_compute_global_address.static_ip.address
}
