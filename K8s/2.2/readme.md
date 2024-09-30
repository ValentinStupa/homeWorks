# Решение к домашнему заданию: «Хранение в K8s -- Part 2»
1. [Local PV](./pv-local.yml)\
[Deployment](./deployment_multitool.yml)\
Local Store:\
![localStore](./screenshots/1-local_store.png)\
Delete PVC:\
![PVC](./screenshots/1-local_store-delete-pvc.png)\
Delete PV:\
![PV](./screenshots/1-local_store-delete-pv.png)\
Все файлы остаются на рабочей ноде из-за параметра: "hostPath" + политики "Retain" описанные в [Local PV](./pv-local.yml)
---
2. [Pod](./pod-multitool.yml)\
StorageClass:\
![StorageClass](./screenshots/2-StorageClass.png)\
StorageClass Remove:\
![StorageClassRemove](./screenshots/2-StorageClass-Remove.png)\
После удаления пода запрошенное место освобождается с удалением данных.



