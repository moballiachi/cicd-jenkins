provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "aws_security_group" "security_group_jenkins" {
  name = "security_group_${var.jenkins_name}"
  description = "Allows all traffic"
  tags = {
    Name = "security_group_jenkins"
  }

  # SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  # HTTP
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  # Jenkins JNLP port
  ingress {
    from_port = 50000
    to_port = 50000
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  # Weave Scope port
  ingress {
    from_port = 4040
    to_port = 4040
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins" {
  instance_type = "${var.jenkins_instance_type}"
  security_groups = ["${aws_security_group.security_group_jenkins.name}"]
  ami = "${lookup(var.amis, var.region)}"
  key_name = "${var.jenkins_key_name}"
  tags = {
    Name = "jenkins"
  }

  # Add jenkins server startup
  provisioner "file" {
    connection {
      user = "ec2-user"
      host = "${aws_instance.jenkins.public_ip}"
      timeout = "1m"
      private_key = "${file("templates/${var.jenkins_key_name}.pem")}"
    }
    source = "templates/jenkins_startup.sh"
    destination = "/home/ec2-user/jenkins_startup.sh"
  }
  
  # Add jenkins job
  provisioner "file" {
    connection {
      user = "ec2-user"
      host = "${aws_instance.jenkins.public_ip}"
      timeout = "1m"
      private_key = "${file("templates/${var.jenkins_key_name}.pem")}"
    }
    source = "templates/jobmaster.xml"
    destination = "/home/ec2-user/jobmaster.xml"
  }
  
  # Add node
  provisioner "file" {
    connection {
      user = "ec2-user"
      host = "${aws_instance.jenkins.public_ip}"
      timeout = "1m"
      private_key = "${file("templates/${var.jenkins_key_name}.pem")}"
    }
    source = "templates/nodemaster.xml"
    destination = "/home/ec2-user/nodemaster.xml"
  }

  provisioner "remote-exec" {
    connection {
      user = "ec2-user"
      host = "${aws_instance.jenkins.public_ip}"
      timeout = "1m"
      private_key = "${file("templates/${var.jenkins_key_name}.pem")}"
    }
    inline = [
      "chmod +x /home/ec2-user/jenkins*.sh",
      "/home/ec2-user/jenkins_startup.sh ${var.jenkins_user_name} ${var.jenkins_user_password}"
    ]
  }
}