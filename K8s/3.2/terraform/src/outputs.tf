#--------First option--------

# output "instance_information" {
#   value = [
#     { web = ["${yandex_compute_instance.platform.network_interface[0].nat_ip_address}"] },
#     { db = ["${yandex_compute_instance.platform-b.network_interface[0].nat_ip_address}"] }

#   ]
# }

# output "instance_names" {
#   value = [
#     { web = ["${yandex_compute_instance.platform.name}"] },
#     { db = ["${yandex_compute_instance.platform-b.name}"] }

#   ]
# }

# output "fqdn" {
#   value = [
#     { web = ["${yandex_compute_instance.platform.fqdn}"] },
#     { db = ["${yandex_compute_instance.platform-b.fqdn}"] }

#   ]
# }
#--------Second option--------

output "instance_information" {
  value = [
    {
      master = [
        yandex_compute_instance.vm_1.network_interface[0].nat_ip_address,
        yandex_compute_instance.vm_1.network_interface[0].ip_address,
        #yandex_compute_instance.platform.name,
        #yandex_compute_instance.platform.fqdn,
      ]
      worker-1 = [
        yandex_compute_instance.vm_2.network_interface[0].nat_ip_address,
        yandex_compute_instance.vm_2.network_interface[0].ip_address,
        #yandex_compute_instance.platform.name,
        #yandex_compute_instance.platform.fqdn,
      ]
      worker-2 = [
        yandex_compute_instance.vm_3.network_interface[0].nat_ip_address,
        yandex_compute_instance.vm_3.network_interface[0].ip_address,
        #yandex_compute_instance.platform.name,
        #yandex_compute_instance.platform.fqdn,
      ]
      worker-3 = [
        yandex_compute_instance.vm_4.network_interface[0].nat_ip_address,
        yandex_compute_instance.vm_4.network_interface[0].ip_address,
        #yandex_compute_instance.platform.name,
        #yandex_compute_instance.platform.fqdn,
      ]
      worker-4 = [
        yandex_compute_instance.vm_5.network_interface[0].nat_ip_address,
        yandex_compute_instance.vm_5.network_interface[0].ip_address,
        #yandex_compute_instance.platform.name,
        #yandex_compute_instance.platform.fqdn,
      ]
    }
  ]
}
