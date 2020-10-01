
Continuous Integration, Continuous Delivery and Continuous Deployment, concepts and terms which works together to automate the lifecycle of apps, in this regard if you want to implement a CI / CD, Jenkins could be the main tool to establish a server to automate this process. 

This repository is a simple task to deploy a Jenkins taking AWS amazon as IaaS. For getting a big picture we are going to install Jenkins and its plugins, register a user, set up a basic security rule and finally insert a job as example so, let’s elaborate further this idea.


Install environment
----------
Get in your bastion machine in AWS amazon and install terrafom tool to deploy your enviroment with the follows command lines:

    $ curl -O https://releases.hashicorp.com/terraform/0.12.13/terraform_0.12.13_linux_amd64.zip

    $ sudo unzip terraform_0.12.13_linux_amd64.zip -d /usr/bin/

    $ terraform -v


Start up your server
----------
Download the project and make sure your set up your information in the follows properties which are in the file variables.tf:
* access_key: your personal access key AWS amazon
* secret_key: your personal secret key AWS amazon
* jenkins_key_name: publickey file name which is used to access via SSH
* 
Please go to the base project and execute the follow command line:

    $ terrafomr plan
    
    $ terrafomr apply
    
Command plan is useful to watch some error and have a deploy plan, once the plan is checked please confirm the process execute the apply command.


Turn off your service
----------

Please go to the base project and execute the follow command line:

    $ terrafomr destroy