FROM centos

RUN yum -y install openssh-server

RUN useradd remote_ecraft && \
    echo "admin" | passwd remote_ecraft  --stdin && \
    mkdir /home/remote_ecraft/.ssh && \
    chmod 700 /home/remote_ecraft/.ssh

# ssh-keygen -f remote-key-ecraft
COPY remote-key-ecraft.pub /home/remote_ecraft/.ssh/authorized_keys

RUN chown remote_ecraft:remote_ecraft   -R /home/remote_ecraft && \
    chmod 600 /home/remote_ecraft/.ssh/authorized_keys

RUN /usr/sbin/sshd-keygen > /dev/null 2>&1

#######################################################
### Startup ssh service 
#######################################################
CMD /usr/sbin/sshd -D
