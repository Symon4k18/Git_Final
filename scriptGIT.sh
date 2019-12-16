#!/bin/bash

# Affichage de l'adresse IP avant login

#	echo IP : \4{eth0} >> /etc/issue

# Creation du user nomEtu pass:tge243

	#Script pour ajouter un nouvel utilisateur
		newUser=TEST
	        useradd -m --comment "ETU $newUser" --shell /bin/bash --skel /etc/skel $newUser
	#Change le mot de passe
	        echo -e "tge243\ntge243" | passwd $newUser
	#Permet le mode Sudo
	        usermod -aG sudo $newUser
	#Permet d'acceder au mode Sudo sans mot de passe
	        echo "$newUser ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
	#Creation des cles SSH
		#apt-get install ssh-client     #pas necessairement utiles (client & server ) puisqu'on sait que ssh est deja installe sur les pine64
        	#apt-get install ssh-server
        	echo \n | sudo -u $newUser ssh-keygen -t rsa -N "" -f /home/$newUser/.ssh/id_rsa
		#sudo -u $newUser ssh-copy-id -i /home/$newUser/.ssh/id_rsa.pub symon4k@learningmachine(ip)	#pour envoyer la cle publique sur vm Ubuntu
# Modification des configurations SSH

	#Refus de connexion en Root
		sed -i -e 's/PermitRootLogin without-password/PermitRootLogin no/' /etc/ssh/sshd_config
	#Seul le nouvel utilisateur peux se connecter
		echo AllowUsers simon >> /etc/ssh/sshd_config
		
	#Empeche connexion avec mots de passe
		sed -i -e 's/ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
                sed -i -e 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

