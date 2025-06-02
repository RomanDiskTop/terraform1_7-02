variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "token" {
  description = "Yandex Cloud OAuth token"
  type        = string
  sensitive   = true
}

variable "ssh_key" {
  description = "SSH public key for VM access"
  type        = string
}

variable "vm_resources" {
  description = "Virtual machine resources configuration"
  type = object({
    cores     = number
    memory    = number
    disk_size = number
  })
}

variable "app1_password" {  # Переименовано с radmin_password
  description = "Password admin access"
  type        = string
  sensitive   = true
}

variable "enable_nat" {
  description = "Enable NAT"
  type        = bool
  default     = true
}