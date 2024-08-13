## Микросервисы: принципы



1. [API Gateways](https://nordicapis.com/6-open-source-api-gateways/):

|| Kong Gateway (Open Source)  | Tyk Open-Source API Gateway  |  KrakenD Open-Source  |  Gravitee OpenSource API Management |  Apinto Microservice Gateway | Apache APISIX API Gateway  |
|---|---|---|---|---|---|---|
|  routing          | + | + | + | + | + | + |
| authentication    | + | + | + | + | + | + |
|  https            | + | + | + | + | + | + |


Вообще не имею понятия какой выбирать. Они все имеют заявленные требования. Ни с одним не было опыта - сложно дать совет.

---
2. [Брокеры сообщений](https://ru.wikipedia.org/wiki/%D0%91%D1%80%D0%BE%D0%BA%D0%B5%D1%80_%D1%81%D0%BE%D0%BE%D0%B1%D1%89%D0%B5%D0%BD%D0%B8%D0%B9):


|   | Apache ActiveMQ | Apache Artemis  | Apache Kafka  | RabbitMQ |
|---|---|---|---|---|
|  cluster              | + | + | + | + |
| authentication queu   | + | + | + | + |
|  data store           | + | + | + | + |

Отдал бы предпочтение Apache ActiveMQ -- имеет все необходимые функции. Имею опыт работы. Брокер удаляет сообщения из очереди, после успешной обработки клиентом. Тем замым не занимает место на диске постоянно. Можно настроить очистку.