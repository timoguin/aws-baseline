variable "vars" {
  description = "Resource configuration as a structured object"

  type = object({
    bucket        = string
    acl           = string
    force_destroy = bool
    policy        = string
    region        = string
    tags          = map(string)

    versioning = object({
      enabled = bool
    })

    logging = object({
      target_bucket = string
      target_prefix = string
    })

    lifecycle_rule = object({
      prefix  = string
      enabled = bool

      noncurrent_version_transition = list(
        object({
          days          = number
          storage_class = string
        })
      )

      noncurrent_version_expiration = object({
        days = number
      })
    })

    replication_configuration = object({
      role = string

      rules = list(
        object({
          id       = string
          prefix   = string
          priority = number
          status   = string
  
          destination = object({
            bucket             = string
            storage_class      = string
            replica_kms_key_id = string
            account_id         = number
  
            access_control_translation = object({
              owner = string
            })
  
            source_selection_criteria = object({
              sse_kms_encrypted_objects = object({
                enabled = bool
              })
            })
  
            filter = object({
              prefix = string
              tags   = map(string)
            })
          })
        })
      )
    })

    object_lock_configuration = object({
      object_lock_enabled = bool

      rule = object({
        default_retention = object({
          mode  = string
          days  = number
          years = number
        })
      })
    })

    server_side_encryption_configuration = object({
      rule = object({
        apply_server_side_encryption_by_default = object({
          kms_master_key_id = string
          sse_algorithm     = string
        )}
      )}
    )}
  })
}
