#load balancer

resource "aws_elb" "prod" {
  subnets = ["${aws_subnet.Private1AZA.id}", "${aws_subnet.Private2AZA.id}"]
  security_groups = ["${aws_security_group.FrontEnd.id}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = "${var.elb_healthy_threshold}"
    unhealthy_threshold = "${var.elb_unhealthy_threshold}"
    timeout = "${var.elb_timeout}"
    target = "HTTP:80/"
    interval = "${var.elb_interval}"
  }

  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400
}

#AMI 

resource "random_id" "ami" {
  byte_length = 8
}

resource "aws_ami_from_instance" "golden" {
    name = "ami-${random_id.ami.b64}"
    source_instance_id = "${aws_instance.terraform-bastion.id}"
    provisioner "local-exec" {
      command = <<EOT
cat <<EOF > userdata
#!/bin/bash
	cd /opt 
	sudo wget -c http://wordpress.org/latest.tar.gz
	sudo tar -xvzf latest.tar.gz
	cd /opt/wordpress
	sudo mv wp-config-sample.php wp-config.php 
	sudo cp -R /opt/wordpress/* /var/www/html
	sudo chown -R www-data:www-data /var/www/html
EOF
EOT
  }
}


#launch configuration

resource "aws_launch_configuration" "lc" {
  name_prefix = "lc-"
  image_id = "${aws_ami_from_instance.golden.id}"
  instance_type = "${var.lc_instance_type}"
  security_groups = ["${aws_security_group.FrontEnd.id}"]
  key_name = "${var.key_name}"
  user_data = "${file("userdata")}"
  lifecycle {
    create_before_destroy = true
  }
}

#ASG 

resource "random_id" "asg" {
 byte_length = 8
}


resource "aws_autoscaling_group" "asg" {
  availability_zones = ["${var.region}a", "${var.region}b"]
  name = "asg-${aws_launch_configuration.lc.id}" 
  max_size = "${var.asg_max}"
  min_size = "${var.asg_min}"
  health_check_grace_period = "${var.asg_grace}"
  health_check_type = "${var.asg_hct}"
  desired_capacity = "${var.asg_cap}"
  force_delete = true
  load_balancers = ["${aws_elb.prod.id}"]
  vpc_zone_identifier = ["${aws_subnet.Private1AZA.id}", "${aws_subnet.Private2AZA.id}"]
  launch_configuration = "${aws_launch_configuration.lc.name}"
    
  tag {
    key = "Name"
    value = "asg-instance"
    propagate_at_launch = true
    }

  lifecycle {
    create_before_destroy = true
  }
}