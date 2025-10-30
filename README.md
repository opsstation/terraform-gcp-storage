# 🏗️ Terraform-Google-Storage

[![OpsStation](https://img.shields.io/badge/Made%20by-OpsStation-blue?style=flat-square&logo=terraform)](https://www.opsstation.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Terraform](https://img.shields.io/badge/Terraform-1.13%2B-purple.svg?logo=terraform)](#)
[![CI](https://github.com/OpsStation/terraform-multicloud-labels/actions/workflows/ci.yml/badge.svg)](https://github.com/OpsStation/terraform-multicloud-labels/actions/workflows/ci.yml)
[![Latest Release](https://img.shields.io/github/release/opsstation/terraform-gcp-storage.svg)](https://github.com/opsstation/terraform-gcp-storage/releases/latest)

> 🌩️ **A production-grade, reusable GCP Storage module by [OpsStation](https://www.opsstation.com)**
> Designed for **reliability**, **security**, and **performance** — following Google Cloud best practices.

---

## 🏢 About OpsStation

**OpsStation** delivers **Cloud & DevOps excellence** for modern teams:
- 🚀 **Infrastructure Automation** with Terraform, Ansible & Kubernetes
- 💰 **Cost Optimization** via scaling & right-sizing
- 🛡️ **Security & Compliance** baked into CI/CD pipelines
- ⚙️ **Fully Managed Operations** across GCP, Azure, and AWS

> 💡 Need enterprise-grade DevOps automation?
> 👉 Visit [**www.opsstation.com**](https://www.opsstation.com) or email **hello@opsstation.com**

---

## 🌟 Features

✅ Creates **Google Cloud Storage (GCS) Buckets** with full configuration options (versioning, encryption, logging, and lifecycle rules)  
✅ Supports **Uniform Bucket-Level Access (UBLA)** and **Public Access Prevention**  
✅ Integrated with **Google IAM** for role-based access control  
✅ Automatically creates **folders** inside buckets  
✅ Supports **Custom Placement Configs** for multi-region redundancy  
✅ Optional **HMAC key generation** for programmatic access  
✅ Enables **CORS**, **website hosting**, and **retention policies**  
✅ Integrated with [OpsStation Multicloud Labels](https://registry.terraform.io/modules/opsstation/labels/multicloud/latest)  
✅ Modular and reusable for multiple environments (dev, stage, prod)

---

## ⚙️ Usage Example

### Example: bucket

```hcl
module "bucket" {
  source      = "opsstation/storage/gcp"
  version     = "1.0.1"
  name        = "bucket"
  environment = "test"
  location    = "us"
  lifecycle_rules = [{
    action = {
      type = "Delete"
    }
    condition = {
      age            = 365
      with_state     = "ANY"
      matches_prefix = "test12"
    }
  }]

  custom_placement_config = {
    data_locations : ["US-EAST4", "US-WEST1"]
  }

  iam_members = [{
    role   = "roles/storage.objectViewer"
    member = "group:test-gcp-ops@test.blueprints.joonix.net"
  }]

  autoclass                = true
  set_hmac_access          = true
  public_access_prevention = "enforced"
}
```

### Example: bucket_with_encryption

```hcl
module "bucket" {
  source      = "opsstation/storage/gcp"
  version     = "1.0.1"
  name        = "bucket-encryption"
  environment = "test"
  location    = "US"
  encryption = {
    kms_key = module.kms_key.key_id
  }

  lifecycle_rules = [{
    action = {
      type = "Delete"
    }
    condition = {
      age            = 365
      with_state     = "ANY"
      matches_prefix = "test12"
    }
  }]

  custom_placement_config = {
    data_locations = ["US-EAST4", "US-WEST1"]
  }

  iam_members = [
    {
      role   = "roles/storage.admin"
      member = "group:test-gcp-ops@test.blueprints.joonix.net"
    }
  ]
  autoclass = true
}
```

---

## 🧩 Resources Created

| Resource | Description |
|-----------|-------------|
| `google_storage_bucket` | Creates a new Google Cloud Storage bucket with the given configuration. |
| `google_storage_bucket_object` | Creates folder placeholders inside the bucket. |
| `google_storage_bucket_iam_member` | Assigns IAM roles to users/service accounts. |
| `google_storage_hmac_key` | Generates HMAC keys for service accounts (if enabled). |
| `random_id.bucket_suffix` | Optionally appends a random suffix to bucket names for uniqueness. |
| `data.google_client_config.current` | Retrieves the current GCP project configuration. |

---

## ☁️ Outputs

| Name                       | Description                                                                                                                                                |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **hmac_keys**              | List of HMAC keys generated for accessing the Google Cloud Storage buckets. Useful for programmatic access using HMAC authentication. *(Sensitive output)* |
| **bucket_id**              | The ID of the created Google Cloud Storage bucket. This can be used to reference the bucket in other resources.                                            |
| **bucket_name**            | The name(s) of the created Google Cloud Storage bucket(s).                                                                                                 |
| **bucket_url**             | The full URL(s) for accessing the Google Cloud Storage bucket(s). Example: `https://storage.googleapis.com/<bucket-name>`                                  |
| **bucket_encryption_keys** | The encryption keys (self-links) used to encrypt data stored in the Google Cloud Storage bucket(s).                                                        |
| **bucket_self_links**      | The self-link URI(s) of the Google Cloud Storage bucket(s), useful for API operations or cross-references.                                                 |

---

## 🧱 Input Highlights

| Name | Type | Default | Description |
|------|------|----------|-------------|
| `location` | `string` | n/a | The location/region of the GCS bucket. |
| `storage_class` | `string` | `"STANDARD"` | The storage class for the bucket (e.g., STANDARD, NEARLINE, COLDLINE). |
| `versioning` | `bool` | `false` | Enables versioning for bucket objects. |
| `autoclass` | `bool` | `false` | Enables automatic object storage class management. |
| `force_destroy` | `bool` | `false` | Force bucket deletion even if not empty. |
| `bucket_policy_only` | `bool` | `true` | Enables Uniform Bucket-Level Access (UBLA). |
| `encryption` | `object` | `{ kms_key = null }` | Configures default KMS encryption for the bucket. |
| `iam_members` | `list(object)` | `[]` | Assigns IAM roles to users or service accounts. |
| `lifecycle_rules` | `list(object)` | `[]` | Defines lifecycle policies for bucket objects. |
| `folders` | `map(list(string))` | `{}` | Creates initial folder structure in the bucket. |
| `set_hmac_access` | `bool` | `false` | Enables creation of HMAC keys for service accounts. |
| `hmac_service_accounts` | `map(string)` | `{}` | Defines service accounts and their HMAC key states. |

---

### ☁️ Tag Normalization Rules (GCP)

| Cloud | Case      | Allowed Characters | Example                            |
|--------|-----------|------------------|------------------------------------|
| **GCP** | TitleCase | Any              | `Name`, `Environment`, `CostCenter` |

---

## 🔒 Security Notes

- **UBLA (Uniform Bucket-Level Access)** is recommended for production.
- Avoid assigning public roles such as `allUsers` or `allAuthenticatedUsers`.
- Treat **HMAC keys** as secrets — avoid printing them in pipelines or logs.
- Use **KMS encryption** for additional data protection.

---

## 🧑‍💻 Maintainers

This module is maintained by [OpsStation](https://www.opsstation.com).