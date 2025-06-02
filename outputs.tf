output "vm_external_ip" {
  description = "Внешний IP-адрес виртуальной машины"
  value       = yandex_compute_instance.vm.network_interface[0].nat_ip_address
}

output "vm_internal_ip" {
  description = "Внутренний IP-адрес виртуальной машины"
  value       = yandex_compute_instance.vm.network_interface[0].ip_address
}

output "vm_id" {
  description = "ID виртуальной машины"
  value       = yandex_compute_instance.vm.id
}

output "ssh_command" {
  description = "Команда для подключения по SSH"
  value       = "ssh ubuntu@${yandex_compute_instance.vm.network_interface[0].nat_ip_address}"
}