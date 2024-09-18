# Решение к домашнему заданию: "Запуск приложений в К8S"
1. Deployment one replica:\
![1replica](./screenshots/1-deployment.png)\
Deployment two replicas: [deployment](./nginx_multitool-deployment-serv.yml)\
![2replicas](./screenshots/deployment-2Replicas.png)\
Отдельный под multitool + curl + port-forward: [pod-multitool](./pod-multitool.yml)\
![curl](./screenshots/curl-pod-multitool.png)
---
2.
Init contaner: [init-pod](./init-deployment.yml) \
![init](./screenshots/2-pod-without-service.png)\
Deployment без сервиса:\
![without_service](./screenshots/2-pod-without-service.png)\
Deployment c сервисом: [service](./service.yml) \
![with_service](./screenshots/2-pod-with-service.png)\
Curl outside/inside container:\
![port-forward](./screenshots/2-port-forward.png)
