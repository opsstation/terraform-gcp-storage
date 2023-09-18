variable "name" {
  type    = string
  default = "test"
}

variable "environment" {
  type    = string
  default = ""
}

variable "label_order" {
  type    = list(any)
  default = ["name", "environment"]
}

variable "enabled" {
  type    = bool
  default = true
}

variable "project_id" {
  type    = string
  default = "xxxxxxxxxxx"
}

variable "labels" {
  type    = map(any)
  default = {}
}

variable "location" {
  type    = string
  default = "US"
}

variable "force_destroy" {
  type    = bool
  default = true
}

variable "uniform_bucket_level_access" {
  type    = bool
  default = false
}

variable "storage_class" {
  type    = string
  default = "STANDARD"
}

variable "default_event_based_hold" {
  type    = bool
  default = null
}

variable "public_access_prevention" {
  type    = string
  default = "inherited"
}

variable "requester_pays" {
  type    = bool
  default = false
}

variable "default_kms_key_name" {
  type    = string
  default = null
}

variable "logging" {
  type    = any
  default = null
}

variable "retention_policy" {
  type    = any
  default = null
}

variable "cors" {
  type    = any
  default = []
}

variable "versioning" {
  type    = bool
  default = true
}

variable "lifecycle_rules" {
  type    = any
  default = []
}

variable "google_storage_bucket_iam_member_enabled" {
  type    = bool
  default = true
}

variable "bucket_id" {
  type    = string
  default = ""
}

variable "website" {
  type    = map(any)
  default = null
}

