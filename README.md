## Docker ChurchCRM

This is the Docker Installation of ChurchCRM. This image is the latest release ChurchCRM for Docker. It is installed on Alpine Linux, Apache, PHP7 & is using MariaDB in a separate Alpine container.

### How To Use

To use, first change your desired database info and **passwords** in the **``.env``** file. *(Download that file from the main ChurchCRM/Docker repository directory)*

Once complete, Start ChurchCRM in Docker by using the Docker RUN command from the directory that your ``.env`` file resides or by building and starting with docker-compose.

#### Starting with Docker Run

For example, you can start MariaDB first with the following command. Make sure to **change the passwords** in the ``.env`` file first.

``docker run --name churchdb --env-file .env -d jaskipper/alpine-mariadb``

Then start the ChurchCRM container:

``docker run --name churchcrm -p 80:80 --link churchdb --env-file .env -d churchcrm/crm``

Visit your website and you will be up and running. Log in with the default username ``admin`` and password ``changeme`` and then change your admin password on the next screen.

#### Building and Starting with Docker-Compose

To build and run with Docker-Compose, you must have all of the files in the Github repo. Download the Github Docker repository and run ``docker-compose build`` and ``docker-compose up`` from the project folder. **Be SURE to Change Passwords in the .env file before starting your container**.

## Environment variables used in the container

It is recommended that you use the .env file to add your passwords, but you may also add those ENV's with the -e flag with ``docker run -e ...``.

### MYSQL_DB_HOST
This variable defines the host in order for ChurchCRM to be able to connect to the database.

	-e MYSQL_DB_HOST=database *(This is default and recommended to stay that way unless you know what you are doing)*

### MYSQL_ROOT_PASSWORD
This variable defines the password for the root user in the database, set it with

	-e MYSQL_ROOT_PASSWORD=secretpassword

add quotes if there is spaces or other special character in the password

	-e MYSQL_ROOT_PASSWORD='password with spaces'

### MYSQL_RANDOM_ROOT_PASSWORD
This variable generate a random password for the root user, add

	-e MYSQL_RANDOM_ROOT_PASSWORD=yes

the password can then be found by looking at the logoutput

	docker logs <container>

### MYSQL_ALLOW_EMPTY_PASSWORD
This allows the root password to be blank, THIS IS A MAJOR SECURITY RISK, add

	-e MYSQL_ALLOW_EMPTY_PASSWORD=yes

### MYSQL_REMOTE_ROOT
Normal the root user can only use localhost to access the databases adding

	-e MYSQL_REMOTE_ROOT=yes

allows root access from any host

### MYSQL_DATABASE
creates a database with the defined name

	-e MYSQL_DATABASE=databasename

### MYSQL_USER
creates a user with password defined with MYSQL_PASSWORD and full access to the database defined by MYSQL_DATABASE

	-e MYSQL_USER=username

### MYSQL_PASSWORD
The password for the user defined by MYSQL_USER

	-e MYSQL_PASSWORD=donottell

### CHURCHCRM_ADMIN

To come...

### CHURCHCRM_PASSWORD

To come...
