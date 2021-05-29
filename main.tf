provider "aws" {
    region="eu-west-2"
}
variable "server_port"{
    description = "An example of a number variable"
    type = number
    default = 8080
}

resource "aws_instance" "example"{
    ami= "ami-0194c3e07668a7e36"
    instance_type = "t2.micro"

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello World" > index.html
                nohup busybox httpd -f -p ${var.server_port} &
                EOF

    tags={
        Name="terraform-example"
    }
    vpc_security_group_ids = [aws_security_group.instance.id]
}

resource "aws_security_group" "instance"{
    name ="terraform-example-sg"
    ingress{
        from_port =var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
output "public_ip"{
    value = aws_instance.example.public_ip
    description = "The public IP of EC2 instance"

}