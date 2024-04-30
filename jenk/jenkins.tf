data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]
  
  filter{
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }

}

resource "aws_instance" "jenkins"{
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.meduim"
  #subnet_id = aws_subnet.private-us-east-1b.id
  key_name = aws_key_pair.mys.id 

  associate_public_ip_address = true
  #security_groups = [aws_security_group.myApp_sg.id]

  tags = {
     Name = "NTI_project_salah"
  }

  connection {
    host = self.public_ip
    type = "ssh"
    user = "ubuntu"
    private_key = file("/home/salah/.ssh/id_rsa")

  }


 }

resource "local_file" "public_ip_file"{
  depends_on = [aws_instance.salah_side]
  filename = "Ansible/inventory"
  content = aws_instance.salah_side.public_ip
}





