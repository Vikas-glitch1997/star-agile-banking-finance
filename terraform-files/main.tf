resource "aws_instance" "prod-server" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  key_name = "virginia"
  vpc_security_group_ids = ["sg-0c1dcadf06a240f28"]
  connection {
     type = "ssh"
     user = "ubuntu"
     private_key = file("./virginia.pem")
     host = self.public_ip
     }
  provisioner "remote-exec" {
     inline = ["echo 'wait to start the instance' "]
  }
  tags = {
     Name = "prod-server"
     }
  provisioner "local-exec" {
     command = "echo ${aws_instance.prod-server.public_ip} > inventory"
     }
  provisioner "local-exec" {
     command = "ansible-playbook /var/lib/jenkins/workspace/Bankingfinanceproject/terraform-files/ansibleplaybook.yml"
     }
  }
