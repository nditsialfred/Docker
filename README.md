## Docker ChurchCRM

This is the Docker Installation of ChurchCRM. This image is the latest release ChurchCRM for Docker. It is installed on Alpine Linux, Apache, PHP7 & is using MariaDB in a separate Alpine container.

### How To Use

* Clone this repository.
* Change your desired database info and **passwords** in the /secrets files (*MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD, MYSQL_USER*).
* From the command line run docker-compose to build and run ChurchCRM
    - `docker-compose build`
    - `docker-compose up`
* You can then visit ChurchCRM by going to http://localhost (or your server's IP address) in a browser.
* Enter the default login information:
    - Username: `admin`
    - Password: `changeme`
- Once in, you will be prompted to change your password to something more secure.
