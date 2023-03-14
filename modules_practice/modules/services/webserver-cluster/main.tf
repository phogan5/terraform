terraform {
  backend "s3" {
    bucket = "tf-backend-phi87819"
    key = "global/s3/asg/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "tf-backend-phi87819"
    encrypt = true
  }
}


data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    bucket = "tf-backend-phi87819"
    key = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_launch_configuration" "launch_config" {
    image_id = "ami-0dfcb1ef8550277af"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.web_server.id]
  
    #Render the user data as a template
    user_data = templatefile("user-data.sh", {
      server_port = var.port_number
      db_address = data.terraform_remote_state.db.outputs.address
      db_port = data.terraform_remote_state.db.outputs.port
    })

    ##Required when using a launch configuration with an auto scaling group
    lifecycle {
      create_before_destroy = true
    }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.default.id]
    } 
}

resource "aws_autoscaling_group" "asg" {
    launch_configuration = aws_launch_configuration.launch_config.name
    vpc_zone_identifier = data.aws_subnets.default.ids
    target_group_arns = [aws_alb_target_group.asg.arn]
    health_check_type = "ELB"
    min_size = 2
    max_size = 10


    tag {
      key = "Name"
      value = "terraform-asg-example"
      propagate_at_launch = true
    }

  
}

resource "aws_lb" "alb" {
    name = "terraform-asg-example"
    load_balancer_type = "application"
    subnets = data.aws_subnets.default.ids
    security_groups = [aws_security_group.alb_sg.id]
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.alb.arn
    port = 80
    protocol = "HTTP"

    #By deafult, return a simple 404 page
    default_action {
      type = "fixed-response"

      fixed_response {
        content_type = "text/plain"
        message_body = "404: page not found"
        status_code = 404
      }
    }
}

resource "aws_alb_listener_rule" "asg" {
    listener_arn = aws_lb_listener.http.arn
    priority = 100

    condition {
      path_pattern {
        values = ["*"]
      }
    }

    action {
      type = "forward"
      target_group_arn = aws_alb_target_group.asg.arn
    }
  
}

resource "aws_alb_target_group" "asg" {
    name = "terraform-asg-example"
    port = var.port_number
    protocol = "HTTP"
    vpc_id = data.aws_vpc.default.id

    health_check {
      path = "/"
      protocol = "HTTP"
      matcher = "200"
      interval = 15
      timeout = 3
      healthy_threshold = 2
      unhealthy_threshold = 2
    }
}

resource "aws_security_group" "alb_sg" {
    name = "alb_sg"

    #allow inbound http requests
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    

    #allow outbound requests
    egress {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 0
      protocol = "-1"
      to_port = 0
    }
}

resource "aws_security_group" "web_server" {
    name = "web-server-traffic"

    ingress {
        from_port = var.port_number
        to_port = var.port_number
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}




