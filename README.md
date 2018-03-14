## Docker ChurchCRM

This is the Docker Installation of ChurchCRM. This will build the latest release of ChurchCRM for Docker. It is made with Apache/PHP7/ChurchCRM and MariaDB in 2 separate containers that work together.

### How To Use

It is necessary to have Docker installed on your system for this to work. See https://www.docker.com/community-edition#/download...

* Clone this repository.
* Change your desired **database info** and **passwords** in the /secrets files.
    - **MYSQL_ROOT_PWD** = set this for the MYSQL root password in your installation **PLEASE CHANGE!!!**
    - **MYSQL_USER** = set this as the churchcrm database username (Default: churchcrm)
    - **MYSQL_USER_PWD** = set this for the churchcrm database user password **PLEASE CHANGE!!!**
* From the command line, navigate to the root folder of your local repository and use docker-compose to build and run ChurchCRM. Run the following commands.
    - `docker-compose build`
    - `docker-compose up`
* You can view your installation of ChurchCRM on Docker by going to https://localhost (or your server's IP address) in a browser.
* Enter the default login information:
    - Username: `admin`
    - Password: `changeme`
- Once in, you will be prompted to change your password to something more secure.

### SSL

ChurchCRM for Docker is set to run by default using SSL encryption. When building the images, the build script will create Self-Signed Certificates and install them into Apache. When visiting the local site, browsers will prompt you with an error/warning that they don't recognize the Certificate Authority *(which is yourself in this case)*. When this occurs, allow the exception and continue to the site.

**NOTE:** PLEASE change the SSL config details under churchcrm/build/args section in the docker-compose.yml` file.

### Using a Domain Name instead of https://localhost

In order to access ChurchCRM via a domain name other than localhost, set an entry in your local computer's `/etc/hosts` file.

* See https://www.siteground.com/kb/how_to_use_the_hosts_file/ to see where your hosts file is located and how to update.
* Add an entry in your `hosts` file such as `127.0.0.1     local.churchcrm.io`
* Once saved you can access your installation by going to `https://local.churchcrm.io` or any domainname that you specified in the hosts file.

### Accessing ChurchCRM from another device

While on the same local network, you can access ChurchCRM by visiting the IP address of the computer running Docker. For example, if your machine's local ip is 192.168.1.3, visiting that address (https://192.168.1.3) from another device will allow you to access ChurchCRM.

### DATA STORAGE

Running the `docker-compose up` command will create 2 separate Docker data-volumes to store the database and ChurchCRM uploaded photos. When the database and ChurchCRM images and containers are destroyed, rebuilt or updated, the data-volumes will persist unless you remove those volumes.
