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
    - /etc/jenkins_pipeline/1build/Dockerfile
    - /etc/jenkins_pipeline/1build/build.sh - скрипт сборщика
  - #### Запуск:
    - /etc/jenkins_pipeline/1build/build.sh [ nexus_ip ] [ nexus_pass ] [version (optional)]




## Сервер prod:
  - #### Подготовка инфраструктуры:
    - настройка возможности входа по паролю для root по сети (для jenkins)
    - sudo apt install git -y
    - sudo apt install docker.io -y
    - cd /etc
    - git clone https://github.com/spring108/jenkins_ssh.git
    - cd /etc/jenkins_ssh
  - #### Файлы для build:
    - bash /etc/jenkins_ssh/prod.sh - скрипт прода (с параметром), должен запускаться jenkins

## Сервер jenkins:
    - шаг 1: запуск "bash /etc/jenkins_ssh/build.sh $myver" на сервере build
    - шаг 2: запуск "bash /etc/jenkins_ssh/prod.sh $myver" на сервере prod

## Смотрим http://prod_ip:80/index.html