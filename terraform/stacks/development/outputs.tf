# Get FQDN of the website
output "website_fqdn" {
  value = module.static_website.website_fqdn
}

# Get storage bucket name
output "bucket_name" {
  value = module.static_website.bucket_name
}

# Get static IP address
output "static_ip" {
  value = module.static_website.static_ip
}
