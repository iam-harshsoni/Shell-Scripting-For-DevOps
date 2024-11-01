#!/bin/bash
#

<< task

deploy django app
and handle the code for error

task

# Clones the application from Git Repo
code_clone(){

        echo "Cloning the Django app..."
        git clone https://github.com/LondheShubham153/django-notes-app.git

}

# Installs required dependencies to run the application
install_requirements(){

        echo "Insatlling dependencies"
        sudo apt-get update
        sudo apt-get install docker.io nginx -y docker-compose 
	
	#one good point about docker-compose is that if you want to restart, you can allocate that using  up and down 
}

# This function restarts docker and nginx 
required_restarts(){

        sudo chown "$USER" /var/run/docker.sock
        #sudo systemctl enable docker
        #sudo systemctl enable nginx
        #sudo systemctl restart docker

}

# This function deploys the applicaiton
deploy(){

        docker build -t notes-app .
        #docker run -d -p 8000:8000 notes-app:latest
	

	#this project will run using docker-compose
	docker-compose up -d

}

echo "***** Deployment Started ********"

if ! code_clone; then
        echo "the code directoy already exists"
        cd django-notes-app
fi

if ! install_requirements; then
        echo "Installation Failed"
        exit 1
fi

if ! required_restarts; then
        echo "System fault identified"
        exit 1
fi

if ! deploy; then 
	echo "Deployment Failed, mailing the admin"
	#sendmail 
	exit 1
fi

echo "***** Deployment Done ********"



