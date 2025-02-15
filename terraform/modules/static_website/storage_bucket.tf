# Creating a Google Cloud Storage bucket for hosting a static website
resource "google_storage_bucket" "website" {
  name          = "gcp-static-website-bucket-${var.environment}"
  location      = var.region
  force_destroy = true
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  labels = var.common_labels
}

# Uploading all files to storage bucket
resource "google_storage_bucket_object" "website_files" {
  for_each = fileset("${path.root}/website", "**") # Get all files recursively

  name   = each.value
  source = "${path.root}/website/${each.value}"
  bucket = google_storage_bucket.website.name
}

# # Uploading the main homepage (index.html)
# resource "google_storage_bucket_object" "index_page" {
#   name   = "index.html"
#   source = "${path.root}/website/index.html"
#   bucket = google_storage_bucket.website.name
# }

# # Uploading a custom 404 error page
# resource "google_storage_bucket_object" "page_not_found" {
#   name   = "404.html"
#   source = "${path.root}/website/404.html"
#   bucket = google_storage_bucket.website.name
# }

# Granting public read access to all objects in the bucket
resource "google_storage_bucket_iam_binding" "public_read" {
  bucket = google_storage_bucket.website.name
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}
