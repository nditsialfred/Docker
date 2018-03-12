## Docker ChurchCRM

This is the Docker Installation of ChurchCRM. This will build the latest release of ChurchCRM for Docker. It is made with Apache/PHP7, ChurchCRM and MariaDB in 3 separate containers that work together.

### How To Use

It is necessary to have Docker installed on your system for this to work. See https://www.docker.com/community-edition#/download...

* Clone this repository.
* Change your desired **database info** and **passwords** in the /secrets files.
    - **MYSQL_ROOT_PASSWORD** = set this for the MYSQL root password in your installation **PLEASE CHANGE!!!**
    - **MYSQL_USER** = set this as the churchcrm database username (Default: churchcrm)
    - **MYSQL_PASSWORD** = set this for the churchcrm database user password **PLEASE CHANGE!!!**
* From the command line, navigate to the root folder of your local repository and use docker-compose to build and run ChurchCRM. Run the following commands.
    - `docker-compose build`
    - `docker-compose up`
* You can view your installation of ChurchCRM on Docker by going to http://localhost (or your server's IP address) in a browser.
* Enter the default login information:
    - Username: `admin`
    - Password: `changeme`
- Once in, you will be prompted to change your password to something more secure.
