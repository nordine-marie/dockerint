# GO-Docker : Batch Scheduling with containers

## Sommaire
* Description
* Implementation
* A garder - point fort
* A changer - point faible

## Description
GO-Docker permet d'executer des travaux dans des containers Docker de manière isolé. 
En cas de multi-utilisateur il met en place une file d'attente.
Fonctionne avec divers système d'exploitation.
Plugin permettent ajout scripts authentification/autorisation.
Interface Web UI, CLI, REST

## Implementation
Docker Swarm ou Apache Mesos pour gestion noeud
Scheduler demon pour gestion tâche

## A garder - point fort
Gestion container docker

## A changer - point faible
L'interface trop complexe
