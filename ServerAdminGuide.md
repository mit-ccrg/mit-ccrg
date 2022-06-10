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
