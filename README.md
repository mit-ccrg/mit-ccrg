# mit-ccrg
Onboarding and operations info for Stultz Lab at MIT

## Contents
- [github](#github)
- [meetings](#meetings)
- [data](#data)
- [compute](#compute)
- [logistics](#logistics)
- [office space](#office-space)
- [roster](#roster)

## github
### getting started
1. **NEVER push PHI to github**. Ever.
1. If you don't have a github account, make one so you can be added to our organization, [mit-ccrg](https://github.com/mit-ccrg).
1. Only share code via github.
1. Always document your code carefully.

## slack
1. Communication between members of the lab occur primarily over [slack](mit-ccrg.slack.com). Contact Daphne Schlesinger, or anyone else in the group, about getting a slack invite if you haven't received one.
1. Feel free to make channels for your projects, etc. as necessary.
## meetings
Weekly group meeting

## data

Data are documented in various sources. Here is a directory:

### [Apollo](https://github.com/mit-ccrg/apollo#data)

### [Global Registry of Acute Coronary Events (GRACE)](https://github.com/mit-ccrg/grace)

### [Echo](https://github.com/mit-ccrg/echo#data)

### [Society for Thoracic Surgeons (STS)](https://github.com/aguirre-lab/ml4c3/wiki/STS-data)

### [Electrocardiograms (ECG)](https://github.com/aguirre-lab/ml4c3/wiki/ECG-data)

### [Electronic data warehouse (EDW)](https://github.com/aguirre-lab/ml4c3/wiki/EDW-data)

### [Bedmaster ICU waveforms](https://github.com/aguirre-lab/ml4c3/wiki/Bedmaster-data)

## compute

### Quanta
Our main compute environment is the Quanta server at MIT. Quanta has three independent but connected servers that are used mainly for storage, training and inference
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

Quanta machines are mainted by the Techsquare group (stultzlab-admin@techsquare.com) and Wangzhi. Message him on slack for questions regarding to the server.

**Home Directories**

The home directories `/storage/user_name` of the training and inference server are shared. (The home directory on the training server is mounted to the infernece server with NFS)

You can define your own `.bashrc` in your home directory (e.g. for aliases)

There's no home directories on the storage server. The storage server is mounted to the training and inference servers at `/storage/remote/`.

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

There is a miniconda installed in `/opt/miniconda`, all users in the group `data` have write permissions to it. Enviroments created here will be accesible to all users. To check if your are in the `data` group, type `id`.

You can also install your own conda in your home directory and add it to `PATH` in your `.bashrc`.

**Other tips**

Use `screen` or `tmux` to keep processes running after ending ssh session.

Use `sshfs` to mount remote filesystem to local machine. Read more about [sshfs](https://github.com/libfuse/sshfs)

`gpustat` and `htop` give gpu, cpu and memory usage.

**Solving Common Problems on CSAIL Server**
* First, check if a solution can be found at the following resources: 
    * Storage problems: 
        * https://tig.csail.mit.edu/data-storage/nfs/faq/ 
        * https://tig.csail.mit.edu/data-storage/afs/
* Access problems: 
    * https://tig.csail.mit.edu/network-wireless/ssh/ 
* Email help@csail.mit.edu 

### Anduril
We have a workstation `anduril` at MGH with four Nvidia RTX 8000 GPUs.
This machine is for working with PHI.
To access `anduril`, you must be onboarded at MGH (see below), have VPN access, and be added to the appropriate IRB.
Ridwan is the admin for `anduril`. Message him on Slack with a screenshot from Insight (MGH IRB website) demonstrating you are covered by an IRB, and ask him to create an account for you.

## code
[mit-ccrg/ml4c3-mirror](https://github.com/mit-ccrg/ml4c3-mirror) is a mirror of
[aguirre-lab/ml4c3](https://github.com/aguirre-lab/ml4c3). The latter is the source 
repo that is under active development. We mirror this repo as a redundancy in case 
access to the source is ever lost.

The mirror is manually created and updated. To update the mirror, a user should follow 
these instructions: [Mirroring a repository in another location](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/duplicating-a-repository#mirroring-a-repository-in-another-location).

## logistics
### MGH onboarding
1. Ask Collin Stultz to credential you at MGH.
1. Request VPN access:
    1. You need to log in to the Partners VPN if you SSH to a Partners machine, query the EDW, etc.. Request access at https://rc.partners.org/kb/article/2894
    1. After you set up your MGH account on your iOS device, open the Partners App Catalog and download Okta Verify. This enables two-factor authentication via a push notification on your mobile device, instead of having to get an SMS passcode.
1. Complete CITI training
    1. Go to https://www.citiprogram.org/
    1. Click on the “Register” tab
    1. Enter “Massachusetts General Hospital” under the organization affiliation, and agree to the terms of service
    1. Complete the personal information to complete your registration
    1. Login using your Partners username and password
    1. Under the main menu, you may see courses listed under “Massachusetts General Hospital Courses”.
        1. If you see “Biomedical Research Investigators and Key Personnel” course, select it.
        1. If not, click on “Add a Course”
        1. Select “Will you be working with humans (IRB courses)?” and click next
        1. Select “Biomedical Research” and click next
    1. You should now see the Biomedical Research Investigators and Key Personnel module listed on the main menu
    1. Complete the training module and retain the completion certificates for your records
1. Be added to the correct IRB. *You must be on the appropriate IRB before you access data for that project!*

## office space
Book RLE conference rooms (36-705) [here](http://calendars.mit.edu/rlerooms/calendar?view=month&roomId=22652)

## roster
