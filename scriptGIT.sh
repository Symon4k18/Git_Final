#!/bin/bash

# Affichage de l'adresse IP avant login

	echo IP : \4{eth0} >> /etc/issue

# Creation du user nomEtu pass:tge243

	#Script pour ajouter un nouvel utilisateur
		newUser=simon
	        useradd -m --comment "ETU $newUser" --shell /bin/bash --skel /etc/skel $newUser
	#Change le mot de passe
	        echo -e "tge243\ntge243" | passwd $newUser
	#Permet le mode Sudo
	        usermod -aG sudo $newUser
	#Permet d'acceder au mode Sudo sans mot de passe
	        echo "$newUser ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
	#Creation des cles SSH
		apt-get install ssh-client     #pas necessairement utiles (client & server ) puisqu'on sait que ssh est deja installe sur les pine64
        	apt-get install ssh-server
        	echo -e "\n" | sudo -u $newUser ssh-keygen -t rsa -N "" -f /home/$newUser/.ssh/id_rsa

# Modification des configurations SSH

	#Refus de connexion en Root
		sed -i -e 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
	#Seul le nouvel utilisateur peux se connecter
		touch /home/$newUser/.ssh/authorized_keys
		echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCU9OxK+zEBHT4hN15OqoHZheKEzXOxb5id1tqEcsX7mu5CKkhbbeZzUteo034GjGV7lkS7LcnuLzxyI9AK1aPXZ6TErN27cHVJ3CAfv//UZ4w/827Tc4QmtOSjOd99/1FrKQRckRL8F1ot3U6FvSwGQAv1eV6SPPmlAGTISwYPGpmGmc7oVT1ysDg/Bj6ewCDpRNVt7/4f7ujP3F1Hq1+gzjpBAXY9OsmHw0jlbMgHa67cl/2S7ZERCRpzV08p2P1wD/ZlfzJ13R4zsB9w5KCRqfc5L9p+zx58cSGHKwBpALrENdIA93K8fZ3WJyp8BXuijzp4okZHCsCf6wSo8Nmn symon4k@LearningMachine18k" > /home/$newUser/.ssh/authorized_keys
	#Empeche connexion avec mots de passe
		sed -i -e 's/ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
                sed -i -e 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

