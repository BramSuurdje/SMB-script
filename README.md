## script.sh

This is a script for Linux systems.

### Description

`script.sh` is a bash script that adds a new user to a Samba server and creates a home folder for them.

### Usage

To run the script, navigate to the directory containing `script.sh` and use the following command:

```bash
sudo ./script.sh
```
This script must be run as root.

### Inputs
The script will prompt you for the following inputs:

`username`: The username for the new user.
`password`: The password for the new user.

### Outputs
The script will output messages indicating the progress of the user creation process. It will also create a new directory for the user in `/public/files/homefolder/`