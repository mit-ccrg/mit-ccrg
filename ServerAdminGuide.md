# Server Admin Guide

## Anduril
### Admin
Hyewon, Ridwan
### Sudo access
There's a sudo account, ask Ridwan or Hyewon for details.
### Add new users
Login with the sudo account, then `sudo adduser $USERNAME`
After creating the new account, add the new user to `stultzlab` group 
`sudo usermod -a -G stultzlab username`
### Permission
For shared folders, e.g. `/storage/shared`, user and group owner should be `stultzlab`.
All users should be added to the `stultzlab` group
Deleting unused account
`sudo userdel -r $USERNAME`. This will also delete the home directory, so be careful.


## Quanta
### Admin
Hyewon, Techsquare (stultzlab-admin@techsquare.com)
### Sudo access
Hyewon, Aniruddh, Daphne has sudo access. For adding future sudoer, you can edit `/etc/sudoers.d/12_local_sudo` for sudo access

### User access
Individual user `/etc/csail/users.allow`
afs group '/etc/csail/groups.allow'

### Data group
`stultzlab` is the group owner of `/opt/miniconda` and `/storage/shared`

### Add new users
Edit the user acess files, then ask techsquare to create a new home directory for the new user.

### Global bash_profile
`/etc/profile.local`

### Data Backup
The training server (`/storage`) is backed up to the storage server weekly. 
The storage server is also backed up by MIT TSM service.
The contact person for the TSM service is Hyewon

## Dropbox installation and configuration on linux workstations

Since we connect via ssh to our linux workstations, we install and interact with dropbox via the command line.

### Install

The easiest way to install dropbox is through the dropbox management script. This is a python script that serves as the command line interface for dropbox.

To download the dropbox command line interface:
```bash
wget https://linux.dropbox.com/packages/dropbox.py
chmod +x dropbox.py
```

To make the dropbox interface available to all users, place the dropbox script in a location common to all user PATHs, like `/usr/local/bin`. This requires `sudo` access:
```bash
sudo mv dropbox.py /usr/local/bin/dropbox
```

To install the actual dropbox service, use the following command:
```bash
echo y | dropbox start -i
```