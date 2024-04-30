resource "aws_key_pair" "mys" {
    key_name   = id_rsa
    public_key = var.public_key
}

