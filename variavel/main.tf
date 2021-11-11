provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_instance" "web" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = "terraform"

  tags = var.instance_tags

  vpc_security_group_ids = ["sg-01276b91e75b23d19"]

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }
  #connection {
  #  type        = "ssh"
  #  host        = self.public_ip
  #  user        = "ec2-user"
  #  private_key = file("terraform.pem")
  #}
}