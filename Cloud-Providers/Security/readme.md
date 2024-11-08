# Решение к занятию: "Безопасность в облачных провайдерах"
* Создание bucket и kms ключа шифрования:
    - Результат выполнения кода(bucket|kms key):
    ![show](./screenshots/terrarom_show_bucket.kms.png)

    - Symetric Kms key(симметричный ключ):
    ![key](./screenshots/kms_key.png)

    - Secur bucket:
    ![secur_bucket](./screenshots/bucket.png)

    - Assign kms key for bucket:
    ![assign_key](./screenshots/assign-key_for_bucket.png)

---
### Проблемы с удалением kms ключа от лица сервисного аккаунта
Ошибка:
![delete_key](./screenshots/delete_kms_key.png)

Хотя набора прав достаточно для управления:
![service_id](./screenshots/service_account_roles.png)

