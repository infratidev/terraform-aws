#!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  sudo echo "<h1> Welcome to my terraform InfraTI IP: $(ip route get 1.2.3.4 | awk '{print $7}') </h1>" | sudo tee "/var/www/html/index.html"
  echo "*** Completed Installing apache2"