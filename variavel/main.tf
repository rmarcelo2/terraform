provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

#criação do módulo de grupo de segurança, fazer testes.
module "sg" {
  source = "./sg"
}

resource "aws_instance" "web" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = "terraform"

  tags = var.instance_tags

  #vpc_security_group_ids = ["sg-01276b91e75b23d19"]
  vpc_security_group_ids = ["${module.sg.group_id}"]

  #Provisiando o arquivo que será enviado a máquina criada
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  #Depois do arquivo enviado, será executado remotamente na máquina
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }
  ### Configurando a conexão SSH que será enviado os arquivos e executado, passando a chave .pem configurada previamente em resource "aws_instance" "web"
  connection {
    type        = "ssh"
    #port = "22788"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("terraform.pem")
  }
}