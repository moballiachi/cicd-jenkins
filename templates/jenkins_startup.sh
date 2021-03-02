#!/bin/bash


jenkins_user=$1
jenkins_password=$2
jenkins_address=http://localhost:8080
jenkins_platform=$3
jenkins_platform="${jenkins_platform:=AWS}"
jenkins_home=/var/lib/jenkins
jenkins_templeta_directory=.

set -x

function setup_variables()
{

  if [ $jenkins_platform == "AWS" ]; then

      echo "nothing to do"
  else

      $jenkins_home=jenkins_home
      $jenkins_templeta_directory=templates
  fi
}

function installing()
{
  if [ $jenkins_platform == "AWS" ]; then
      #Installing some necessary dependencies
      sudo yum -y update
      sudo yum -y install wget java-1.8.0 nano nc

      #Installing jenkins, instructions located in http://pkg.jenkins-ci.org/redhat/
      sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
      sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
      sudo yum install -y jenkins

  else

      sudo mkdir jenkins_home
  fi
  sleep 1
  echo "[INFO]  Jenkins was installed"
}

function startup()
{
    sudo systemctl start jenkins &
    
    while (( 1 )); do
      echo "[INFO]   waiting for Jenkins "
      
      sudo  wget $jenkins_address/jnlpJars/jenkins-cli.jar
      if (( $? == 0 )); then
          break
      fi
    
      sleep 20
    done
    
    #Installing jenkins CLI
    sudo  wget $jenkins_address/jnlpJars/jenkins-cli.jar
    
    echo "[INFO]   Jenkins was thrown"
}

function user_add()
{
    #Installing jenkins CLI
    sudo  wget $jenkins_address/jnlpJars/jenkins-cli.jar
    initialAdminPassword=$(sudo cat $jenkins_home/secrets/initialAdminPassword)
    echo "jenkins.model.Jenkins.instance.securityRealm.createAccount('$jenkins_user', '$jenkins_password')" | java -jar jenkins-cli.jar -auth admin:$initialAdminPassword -s $jenkins_address/ groovy =
    
    echo "[INFO]   user is registered"
}

function plugins()
{
    #Installing jenkins plugins 
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin trilead-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin cloudbees-folder
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin antisamy-markup-formatter
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin jdk-tool
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin structs
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-step-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin token-macro
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin build-timeout
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin credentials
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin plain-credentials
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin ssh-credentials
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin credentials-binding
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin scm-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin timestamper
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin script-security
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-support
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin durable-task
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-durable-task-step
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin plugin-util-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin font-awesome-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin popper-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin jquery3-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin bootstrap4-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin snakeyaml-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin jackson2-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin echarts-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin junit
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin matrix-project
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin command-launcher
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin resource-disposer
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin ws-cleanup
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin ant
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin bouncycastle-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin ace-editor
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin jquery-detached
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-scm-step
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-cps
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-job
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin apache-httpcomponents-client-4-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin display-url-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin mailer
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-basic-steps
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin gradle
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-milestone-step
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-input-step
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-stage-step
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-graph-analysis
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-rest-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin handlebars
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin momentjs
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-stage-view 
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-build-step
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-model-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-model-extensions
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin jsch
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin git-client
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin git-server
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-cps-global-lib
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin branch-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-multibranch
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-stage-tags-metadata
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-model-definition
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin lockable-resources
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-aggregator
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin okhttp-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin github-api
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin git
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin github
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin github-branch-source
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-github-lib 
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin ssh-slaves
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pam-auth 
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin ldap
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin email-ext 
    
    # Restart
    sudo systemctl restart jenkins &
    while (( 1 )); do
      echo "[INFO]   waiting for restart Jenkins on port [8080] ..."
      
      java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  list-jobs
      if (( $? == 0 )); then
          break
      fi
    
      sleep 20
    done
    
    echo "[INFO]   Jenkins was restarted"
}

function job_insert()
{
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  create-job jobmaster < $jenkins_templeta_directory/jobmaster.xml
    
    echo "[INFO]   job is registered"
}

function installing_final()
{
    sudo rm jenkins-cli.jar.*
}

###########################################################################
# Main function 
###########################################################################

    setup_variables
    
    installing
    
    startup
    
    user_add
    
    plugins
    
    job_insert
    
    installing_final

exit 0
