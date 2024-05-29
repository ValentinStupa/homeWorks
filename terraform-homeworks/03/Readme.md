#   Весь закомментированный код оставлен для личных целей.
### Задание 1:
Security groups:
![security](./screenshots/secure_group_YC_id.png)
Assign the security group to VM:
![assign](./screenshots/security_group_console.png)
![vm_DB](./screenshots/secure_group_DB-YC.png)
----
### Задание 2:
1. Cout VM:
[count_mv](./src/count-vm.tf)
2. For each:
[for_each](./src/for_each-vm.tf)\
2.2. Local variable:
[locals](./src/locals.tf)
----
### Задание 3:
1. Create disks:
![disks](./screenshots/secondary_disk-3.2.png)
2. Attache new disk to the fresh 'storage' VM:
[storage](./src/disk_vm.tf)
![storage_YC](./screenshots/storage_disks-YC.png)
![storage_state](./screenshots/storage_disks-state.png)
----
### Задание 4:
1. Ansible inventory:
[host_cfg](./src/hosts.tftpl)
3. Fqdn:\
![console](./screenshots/fqdn_console.png)
![vscode](./screenshots/fqdn_vscode.png)

