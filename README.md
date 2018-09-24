# logicappautomation

A sample Logic App that demonstrates automation in Azure using the following components:
- Azure VM with activity alert on VM Start
- A Logic App that exposes a webhook for the activity alert to post to (json). It then extracts the VM Name and Resource Group and posts a message to a Slack channel
