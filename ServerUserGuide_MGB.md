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
<!-- The first time using dropbox ever, you must install the dropbox daemon by running:
```bash
dropbox start -i
``` -->
To sync with your dropbox account, dropbox needs to be configured. The command below should print a dialogue to link the computer to a specific account. Follow the link.
```bash
dropbox start
```

If you follow the link, it should bring you to a dropbox login page. The most obvious thing is to enter your email in the box that is front and center. **Don't do that.** Using the most obvious box will not work (because why would it, right?). More specifically, because our dropbox accounts are business accounts that use single sign-on (SSO), after you sign it, it redirects you to a page that asks you to input a code into the dropbox installer. However, because we're using the command line interface, there is no installer.

Instead of entering your email in the main box, click the `sign in` option in the top right corner. Enter your MGH email in the prompt that opens. It should bring you to a MGB SSO page where you can sign in with your MGH email and password. It will redirect you back to the account linkage step where you should press `connect`.

You can check if installation was successful or generally check the status of dropbox with:
```bash
dropbox status
```

This will start downloading the entire dropbox directory which will fill up all storage on the server so run:
```bash
dropbox exclude add *
```
to remove everything from downloading. Then run:
```bash
dropbox exclude remove YOUR_FOLDER_PATH
```
to make your dropbox folder of interest download!

#### Error starting Dropbox
If running 
```dropbox start``` has an error message "Dropbox isn't running! Dropbox is already running!", you need to restart your dropbox daemon. run:
```bash
ps aux | grep dropbox
```
to find the dropbox processes and kill the ones for your user using:
```bash
kill <pid>
```
Now run `dropbox start`!
