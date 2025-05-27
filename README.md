# Ligne-rouge

# 🔐 Système de Sauvegarde et Restauration Multi-VM

Ce projet met en place un système de sauvegarde/restauration réparti entre trois machines virtuelles (VM1, VM2, VM3) utilisant des scripts Bash.  
Les sauvegardes sont réparties de manière redondante pour garantir la restauration même en cas de panne d'une machine.

## 🧰 Prérequis

- [Oracle VirtualBox](https://www.virtualbox.org/) soit être installé
- Fichier `.ova` des VMs (Appareil virtuel (appliance).ova)
- Accès SSH configuré entre les VMs (clé publique/privée sans ou avec mot de passe)
- Connexion réseau en **réseau privé hôte** pour permettre les échanges

## 📦 Importation des VMs `.ova`

1. Ouvrir **Oracle VirtualBox**
2. Aller dans `Fichier > Importer un appareil virtuel`
3. Importer successivement le fichier :
   - `Appareil virtuel (appliance).ova`
4. Démarrer chaque VM et vérifier leur bon fonctionnement

## 🌐 Configuration réseau

Pour assurer la communication entre les VMs :
1. Accédez à `Paramètres > Réseau` de chaque VM
2. Assurez-vous que l’adaptateur réseau est configuré sur :
   - Mode : **Réseau privé hôte**
3. Attribuez manuellement les adresses IP suivantes dans chaque VM :
   - VM1 : `192.168.56.101`
   - VM2 : `192.168.56.102`
   - VM3 : `192.168.56.103`

---

## 🔑 Configuration SSH sans ou avec mot de passe (optionnel)

Si les clés SSH ne sont pas configurées, alors réaliser les étapes suivantes :

1. Depuis chaque VM, générer une clé SSH :
   ```bash
   ssh-keygen -t rsa

2. Puis, copier la clé publique sur les autres VMs :
ssh-copy-id vboxuser@192.168.56.101
ssh-copy-id vboxuser@192.168.56.102
ssh-copy-id vboxuser@192.168.56.103
   
