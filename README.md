## Setup

### Ubuntu

* Install ubuntu.
* Log in as user.
* Open a terminal and run the following commands.
	* This script will brick/delete the graphical user interface (GUI).
	* The script will reboot the computer.
	* **NOTE:** After reboot, switching to another TTY might be necessary (CTRL+ALT+[1..9])S.

```sh
wget https://raw.githubusercontent.com/moledoc/molenew/main/brick
chmod +x brick
./brick
```

* After reboot, log as a user in a TTY.
* Run the following script (downloading and `chmod` is done in the `brick` script).
	* Script is in the \$HOME directory.
	* This script installs necessary software and sets up privilege escalation
	* The script will reboot the computer, after which a graphical login is provided.

```sh
./setup
```

* Log in as user and open a terminal.
* Run the following script (downloading and `chmod` is done in the `setup` script).
	* Script is located in the \$HOME directory.
	* This script sets up programs and installs additional software.

```sh
./post-setup
```

### Debian

* Install debian with only system utilities (TTY login).
* Log in as user
* Run the following commands.
	* This script installs necessary software and sets up privilege escalation
	* The script will reboot the computer, after which a graphical login is provided.

```sh
wget https://raw.githubusercontent.com/moledoc/molenew/main/setup
chmod +x setup
./setup
```

* Log in as user and open a terminal.
* Run the following script (downloading and `chmod` is done in the `setup` script).
	* Script is located in the \$HOME directory.
	* This script sets up programs and installs additional software.

```sh
./post-setup
```
