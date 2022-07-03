 resource "aws_instance" "web-1" {
     ami = "ami-04505e74c0741db8d"
     availability_zone = "us-east-1a"
     instance_type = "t2.micro"
     key_name = "home-1"
     subnet_id = "${aws_subnet.subnet1-public.id}"
     vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
     associate_public_ip_address = true	
     tags = {
         Name = "Server-1"
         Env = "Prod"
         Owner = "Sree"
 	CostCenter = "ABCD"
     }

user_data = <<-EOF
#! /bin/bash
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo git clone -b DevOpsB24 https://github.com/mavrick202/webhooktesting.git
sudo rm -rf /var/www/html/index.nginx-debian.html
sudo cp webhooktesting/index.html /var/www/html/index.nginx-debian.html
sudo cp webhooktesting/style.css /var/www/html/scorekeeper.js
sudo cp webhooktesting/scorekeeper.js /var/www/html/scorekeeper.js
echo "<h1>Deployed via Terraform<h1>" | sudo tee /var/www/html/index.html
EOF
}