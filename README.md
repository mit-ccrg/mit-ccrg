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
1. If you don't have a github account, make one and ask someone to add you to our organization, [mit-ccrg](https://github.com/mit-ccrg).
1. Only share code via github.
1. Always document your code carefully.

## slack
1. Communication between members of the lab occur primarily over [slack](mit-ccrg.slack.com). Contact NAME HERE about getting a slack invite if you haven't received one.
1. Feel free to make channels for your projects, etc. as necessary.
## meetings

## data

Data are documented in various sources. Here is a directory:

### [Apollo](https://github.com/mit-ccrg/apollo#data)

### [Global Registry of Acute Coronary Events (GRACE)]()

### [Echo](https://github.com/mit-ccrg/echo#data)

### [Society for Thoracic Surgeons (STS)](https://github.com/aguirre-lab/ml4c3/wiki/STS-data)

### [Electrocardiograms (ECG)](https://github.com/aguirre-lab/ml4c3/wiki/ECG-data)

### [Electronic data warehouse (EDW)](https://github.com/aguirre-lab/ml4c3/wiki/EDW-data)

### [Bedmaster ICU waveforms](https://github.com/aguirre-lab/ml4c3/wiki/Bedmaster-data)

## compute

### Quanta
Our main compute environment is the Quanta server at MIT.
TODO

### Anduril
We have a workstation `anduril` at MGH with four Nvidia RTX 8000 GPUs.
This machine is for working with PHI.
To access `anduril`, you must be onboarded at MGH (see below), have VPN access, and be added to the appropriate IRB.
Erik Reinertsen is the admin for `anduril`. Message him on Slack with a screenshot from Insight (MGH IRB website) demonstrating you are covered by an IRB, and ask him to create an account for you.

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
## roster
