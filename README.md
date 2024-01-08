## DevOps \ Домашнее задание №11 - Jenkins with Pipeline

С помощью Jenkins pipeline собрать и задеплоить Java приложение. 
Сборка должна происходить в сборочном контейнере. 
Артефактом сборки должен быть Docker образ с приложением.



## Сервер build создаёт контейнер для сборки приложения внутри него:
  - #### Подготовка инфраструктуры:
    - настройка возможности входа по паролю для root по сети (для jenkins)
    - sudo apt install git -y
    - sudo apt install docker.io -y
    - cd /etc
    - git clone https://github.com/spring108/jenkins_pipeline.git
    - cd /etc/jenkins_pipeline
  - #### Файлы:
    - /etc/jenkins_pipeline/build/Dockerfile
    - /etc/jenkins_pipeline/build/build.sh - скрипт сборщика
  - #### Запуск:
    - bash /etc/jenkins_pipeline/build/build.sh [ nexus_ip ] [ nexus_pass ] [version (optional)]



## Сервер prod:
  - #### Подготовка инфраструктуры:
    - настройка возможности входа по паролю для root по сети (для jenkins)
    - sudo apt install docker.io -y



## Сервер jenkins:
  - #### Подготовка инфраструктуры:
    - sudo apt-get install jenkins
    - sudo apt install docker.io -y
    - nano /etc/hosts , добавить/редактировать:
      - 158.160.112.32 nexus-srv
      - 1.1.1.3 prod-srv
    - echo '{"insecure-registries" : ["nexus-srv:8123"]}' > /etc/docker/daemon.json
    - service docker restart
    - sudo usermod -aG docker jenkins //добавить пользователя Jenkins в группу Docker - не помогло
    - в интерфейсе jenkins
      - для agent docker установить два плагина: "Docker" и "Docker Pipeline"
      - для авторизации в Nexus добавить: Настройка Jenkins \ Security \ Credentials \ New credentials \ "nexus_admin"
  - #### Запуск сборки проекта и вынос на ПРОД:
    - запуск pipeline-скрипта из репозитория https://github.com/spring108/jenkins_pipeline.git файл <b>jenkins/pipeline.jenkins</b>
    - необходим проброс сокета docker по статье https://habr.com/ru/companies/ua-hosting/articles/488536/ (args '-v /var/run/docker.sock:/var/run/docker.sock')



## Смотрим http://prod_ip:8080/hello