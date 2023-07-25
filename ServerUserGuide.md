# Server User Guide
## Anduril/Narsil
We have a workstation `anduril` and `narsil` at MGH with four Nvidia RTX 8000 GPUs (`anduril`) and three RTX A6000 GPUs (`narsil`). This machine is for working with PHI. NVIDIA driver for `anduril` has re-installed 09/07/22 due to NVIDIA-SMI failed error through the command `sudo apt install nvidia-driver-470`. 
To access `anduril` and `narsil`, you must be onboarded at MGH, have VPN access, and be added to the appropriate IRB.

Ridwan and Hyewon are the admin for `anduril`. Message them on Slack with a screenshot from Insight (MGH IRB website) demonstrating you are covered by an IRB, and ask them to create an account for you.

### ssh access
To access `anduril`, first connect to the Partner's VPN. Then `ssh username@anduril`. 

Likewise, to access `narsil`, first connect to the Partner's VPN. Then `ssh username@narsil`.

Please change your default password when you log in for the first time.

### environment
Due to storage issuse, please *do not install conda* into `anduril` and `narsil`. Instead, use the command `source /home/stultzlab/miniconda3/bin/activate` to activate the miniconda environment and create your environment under this miniconda3. Below is information copied from [Aguirre Lab environment info page](https://github.com/aguirre-lab/aguirre-lab/blob/master/miniconda.md). 

Your console prompt should now be prepended by (base).
Create an environment from your environment.yml config file. My `dotfiles` repo contains an example `environment.yml` named `er`. It contains Python 3.8, Numpy, Pandas, h5py, Jupyter Lab, and other packages I use across projects. You are free to copy and use it as helpful.
Project repos may contain an `environment.yml`, or you can create an environment with commands.
```
$ conda env create -f environment.yml
$ conda activate er
```

Your prompt should now be prepended by the environment name; if you use my `environment.yml`, the prompt is now prepended by `(er)`.
Update your `zsh` shell config `.zshrc` so new shell instances have the path to Conda:
```
(er) $ conda init zsh
```

Check to ensure your path has the miniconda environment version of Python, and that the version is correct:
```
(er) $ which python
/home/aguirrelab/miniconda3/envs/er/bin/python
  
(er) $ python --version
Python 3.8.5
```

### Storage
The `home` directory on `anduril` is not meant for data storage.
Data should be put in `/storage` (14TB SSD) or `/storage2` (12TB HDD)
For cold storage, we have a NAS mounted under `/media/nebula-storage/`

### Dropbox
The first time using dropbox ever, run:
- `dropbox start -i`\
to install the dropbox daemon.

After that run `dropbox start` and click the link to sign in to dropbox. This will start downloading the entire dropbox directory which will fill up all storage on the server so run:
- `dropbox exclude add *`\
to remove everything from downloading. Then run:
- `dropbox exclude remove YOUR_FOLDER_PATH`\
to make your dropbox folder of interest download!

If running `dropbox start` has an error message "Dropbox isn't running! Dropbox is already running!", you need to restart your dropbox daemon. run:
- `ps aux | grep dropbox`\
to find the dropbox processes and kill the ones for your user using:
- `kill <pid>`\
Now run `dropbox start`!

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
	- First set the [Kerberos Authentication](https://tig.csail.mit.edu/accounts-authentication/kerberos/) on your local machine
	- Then follow guide here 
		- Mac OS (https://tig.csail.mit.edu/operating-systems/macos/ssh-on-macos/)
		- Windows (https://tig.csail.mit.edu/operating-systems/windows/ssh-on-windows/)
		- Linux (https://tig.csail.mit.edu/operating-systems/csail-ubuntu/kerberos-gnu-linux/)

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
