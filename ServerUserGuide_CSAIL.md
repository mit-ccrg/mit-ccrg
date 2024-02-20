# Server User Guide
## Quanta
We have three computing environment at MIT CSAIL which we call Quanta server. Quanta has three independent but connected servers that are used mainly for storage, training and inference
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
	- First set the [Kerberos Authentication](https://tig.csail.mit.edu/accounts-authentication/kerberos/) on your local machine
	- Then follow guide here 
		- Mac OS (https://tig.csail.mit.edu/operating-systems/macos/ssh-on-macos/)
		- Windows (https://tig.csail.mit.edu/operating-systems/windows/ssh-on-windows/)
		- Linux (https://tig.csail.mit.edu/operating-systems/csail-ubuntu/kerberos-gnu-linux/)


#### Configuring SSH Aliases for Quanta Machines on macOS and Linux local machines:
After setting up Kerberos Authentication, you can streamline your SSH access to Quanta machines by adding aliases to your SSH configuration. Your local machines SSH configuration is usually located in the file `~/.ssh/config`. Open the config file with your preferred text editor. You will add several entries under specific hosts to define your SSH aliases and use the CSAIL jump host (as recommended by TIG). Below is the content you should add. Be sure to replace `<USERNAME>` with your actual Quanta username.
```bash
Host jump.csail.mit.edu
  GSSAPIAuthentication yes
  VerifyHostKeyDNS yes
  User <USERNAME>
Host *.csail.mit.edu !jump.csail.mit.edu 128.52.* 128.30.* 128.31.*
  ProxyCommand ssh -W %h:%p jump.csail.mit.edu
  GSSAPIAuthentication yes
  GSSAPIDelegateCredentials yes
  User <USERNAME>
Host *stultz *healthyml
  ProxyCommand ssh -W %h:%p jump.csail.mit.edu
  GSSAPIAuthentication yes
  GSSAPIDelegateCredentials yes
Host stultzlab01
  HostName stultzlab01.csail.mit.edu
  User <USERNAME>
Host stultzlab02
  HostName stultzlab02.csail.mit.edu
  User <USERNAME>
Host stultzlab03
  HostName stultzlab03.csail.mit.edu
  User <USERNAME>
```

Once you've added the above configuration, you can SSH into stultzlab machines using a simplified command. For example, to connect to stultzlab01, run: `ssh stultzlab01`

**Debugging ssh error**
- `ping` the servers to see if they are off
- `ssh` into `login.csail.mit.edu` to see if there's a problem with your csail account
- `ssh` into the servers from the csail login node to see if there's a problem with the server allow list

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

Please do not install your own miniconda in your own home, conda takes a lot of space and Quanta machine is lack of plenty of storage. There is a miniconda installed in `/opt/miniconda`, all users in the group `data` have write permissions to it. Environments created here will be accessible to all users. To check if you are in the `data` group, type `id`. To activate conda environment, run `source /opt/miniconda/bin/activate` and set up your own conda environment. 

You can also install your own conda in your home directory and add it to `PATH` in your `.bashrc`, but we encourage you not to do this.

- Conda setup tip

You can use `environment.yml` file if you have it. 
```
$ conda env create --name yourenvname -f environment.yml
$ conda activate yourenvname
```

Or you can use requirements.txt if the installed modules are in txt file:

```
$ conda create -n yourenvname python=x.x anaconda
$ conda activate yourenvname
$ pip install -r requirements.txt
```
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
