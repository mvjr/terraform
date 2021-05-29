provider "aws" {
    region="eu-west-2"
}

resource "aws_instance" "example"{
    ami= "ami-06dc09bb8854cbde3"
    instance_type = "t2.micro"
    tags={
        Name="terraform-example"
    }
}