variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "token" {
  type = string
  sensitive = true
}

variable "ssh_key" {
  type = string
}

variable "vm_resources" {
  type = object({
    cores     = number
    memory    = number
    disk_size = number
  })
}

variable "radmin_password" {
  type = string
  sensitive = true
}

variable "enable_nat" {
  type = bool
}
