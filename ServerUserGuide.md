# Server User Guide
## Anduril
We have a workstation `anduril` at MGH with four Nvidia RTX 8000 GPUs. This machine is for working with PHI.
To access `anduril`, you must be onboarded at MGH, have VPN access, and be added to the appropriate IRB.
Ridwan and Hyewon are the admin for `anduril`. Message them on Slack with a screenshot from Insight (MGH IRB website) demonstrating you are covered by an IRB, and ask him to create an account for you.
### ssh access
To access `anduril`, first connect to the Partner's VPN. Then `ssh username@anduril`.
Please change your default password when you log in for the first time.
### Storage
The `home` directory on `anduril` is not meant for data storage.
Data should be put in `/storage` (14TB SSD) or `/storage2` (12TB HDD)
For cold storage, we have a NAS mounted under `/media/nebula-storage/`
### Dropbox
To set up Dropbox, follow the instructions at
https://github.com/aguirre-lab/aguirre-lab/blob/master/dropbox.md

## Quanta
Our main computing environment is the Quanta server at MIT. Quanta has three independent but connected servers that are used mainly for storage, training and inference
- The storage server
   - host name `stultzlab01.csail.mit.edu`
   - mainly used for cold storage of large datasets
   - 12 * 14 TB HHD for storage
- The inference server
   - host name `stultzlab02.csail.mit.edu`
   - 4 * Tesla T4 16GB
- The training server
   - host name `stultzlab03.csail.mit.edu`
   - used for most training tasks
   - 8 * Tesla V100 32GB

Quanta machines use CSAIL Ubuntu system, read [CSAIL TIG Page](https://tig.csail.mit.edu/operating-systems/csail-ubuntu/) for instructions regarding [SSH Access](https://tig.csail.mit.edu/network-wireless/ssh/) and [Kerberos Authentication](https://tig.csail.mit.edu/accounts-authentication/kerberos/)

Quanta machines are maintained by the Techsquare group (stultzlab-admin@techsquare.com) and Hyewon. Message her on slack for questions regarding to the server.

### ssh access
By default, CSAIL rejects all incoming ssh traffic. 
There are two ways to ssh into the server
1. Log into an MIT VPN first then ssh into the server
2. Use the jump host (recommended)
	- First set about the Kerberos Authentication on your local machine
	- Then follow guide here 
		- Mac OS (https://tig.csail.mit.edu/operating-systems/macos/ssh-on-macos/)
		- Windows (https://tig.csail.mit.edu/operating-systems/windows/ssh-on-windows/)
		- Linux (https://tig.csail.mit.edu/operating-systems/csail-ubuntu/kerberos-gnu-linux/)

### Home Directories

The home directories `/storage/user_name` of the training and inference server are shared. (The home directory on the training server is mounted to the infernece server with NFS)

You can define your own `.bashrc` in your home directory (e.g. for aliases)

There's no home directories on the storage server. The storage server is mounted to the training and inference servers at `/storage/remote/`.

### Other User Guide

**Jupyter Notebook**

There is an alias to run jupyter notebook on all Quanta servers: `jpt $port_num`. E.g. type `jpt 8880` will open a jupyter notebook at port 8880. You can listen to the port from your local machine with ssh

`ssh -N -f -L localhost:8880:localhost:8880 user_name@host_name`.

To make life easier, you can define a local alias function (syntax might be different if you're not using bash for your shell.)
```
function jptt(){
   # Forwards port $1 into port $2 and listens to it, specify which server in $3
   # e.g. jptt 8880 8880 3 would forward port 8880 on stultzlab03 to local port 8880
   ssh -N -f -L localhost:$2:localhost:$1 user_name@stultzlab0$3.csail.mit.edu
}
```
This trick can also be used for tensorboard.

**Conda**

There is a miniconda installed in `/opt/miniconda`, all users in the group `data` have write permissions to it. Environments created here will be accessible to all users. To check if you are in the `data` group, type `id`.

You can also install your own conda in your home directory and add it to `PATH` in your `.bashrc`.

**Other tips**

Use `screen` or `tmux` to keep processes running after ending the ssh session.

Use `sshfs` to mount the remote filesystem to a local machine. Read more about [sshfs](https://github.com/libfuse/sshfs)

`gpustat` and `htop` give gpu, cpu and memory usage.

**Solving Common Problems on CSAIL Server**
I cannot access to server and seems like it is down:
Whoever spotted this first should email [techsquare stultzlab admin](stultzlab-admin@techsquare.com) to reboot the server and let others know about this (message on slack cluster-issues channel)

Other Problems: Check if a solution can be found at the following resources:
  * Storage problems:
       * https://tig.csail.mit.edu/data-storage/nfs/faq/
       * https://tig.csail.mit.edu/data-storage/afs/
* Access problems:
   * https://tig.csail.mit.edu/network-wireless/ssh/
* Email help@csail.mit.edu