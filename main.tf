## Example provision simintansly    

resource "aws_instance" "first-ec2" {
  ami           = "ami-03d5c68bab01f3496" # us-west-2
  instance_type = "t2.micro"
  key_name 		= "rajesh-last"
  tags = {
    Name = "RajeshKumar"
  }
  
  connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("rajesh-last.pem")
      #host = aws_instance.web.public_ip
      host = self.public_ip
  }

  provisioner "local-exec" {
    command = "touch devopsschool-local"
  }
  
  provisioner "remote-exec" {
    inline = [
	  "sudo apt-get update",
      "sudo apt-get install apache2 -y",
	  "sudo systemctl start apache2",
    ]
  }
  
  provisioner "file" {
    source      = "terraform.tfstate.backup"
    destination = "/tmp/"
  } 
}
