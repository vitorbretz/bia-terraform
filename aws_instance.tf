resource "aws_instance" "bia-dev" {
  ami           = "ami-0de716d6197524dd9"
  instance_type = "t3.micro"
  tags = {
    Environment = "dev"
    Name        = var.instance_name
  }
  subnet_id                   = local.subnet_zona_a
  associate_public_ip_address = true
  key_name                    = "desafio-agosto"
  vpc_security_group_ids      = [aws_security_group.bia-dev.id]
  root_block_device {
    volume_size = 10
  }
  iam_instance_profile = aws_iam_instance_profile.role_acesso_ssm.name
  user_data            = <<-EOF
#!/bin/bash

# Atualizar pacotes
yum update -y

# Instalar Docker e Git
yum install -y git docker
usermod -a -G docker ec2-user
usermod -a -G docker ssm-user

# Ativar Docker
systemctl enable docker
systemctl start docker

# Instalar Docker Compose v2
mkdir -p /usr/local/lib/docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-linux-x86_64 \
  -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Adicionar swap
dd if=/dev/zero of=/swapfile bs=128M count=32
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile swap swap defaults 0 0" | tee -a /etc/fstab

# Instalar Node.js e npm
curl -fsSL https://rpm.nodesource.com/setup_21.x | bash -
yum install -y nodejs

# Instalar Python 3.11 (para Amazon Linux 2, precisa do repositório correto)
amazon-linux-extras enable python3.11
yum install -y python3.11
ln -sf /usr/bin/python3.11 /usr/bin/python3

# Instalar uv
curl -LsSf https://astral.sh/uv/install.sh | sh

EOF
}

