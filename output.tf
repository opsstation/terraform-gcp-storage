output "id" {
  value = join("", google_storage_bucket.bucket.*.id)
}

output "name" {
  value = join("", google_storage_bucket.bucket.*.name)
}

output "self_link" {
  value = join("", google_storage_bucket.bucket.*.self_link)
}

output "url" {
  value = join("", google_storage_bucket.bucket.*.url)
}



