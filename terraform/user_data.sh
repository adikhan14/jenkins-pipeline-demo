#!/bin/bash
set -e

echo "========================================="
echo " Starting Jenkins Pipeline Server Setup"
echo "========================================="

# Update packages
apt-get update -y

# ----------------------------------------
# Install Java 21
# ----------------------------------------
echo ">>> Installing Java 21..."
apt-get install -y openjdk-21-jre
java -version

# ----------------------------------------
# Install Jenkins
# ----------------------------------------
echo ">>> Installing Jenkins..."
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7198F4B714ABFC68
gpg --export 7198F4B714ABFC68 | tee /usr/share/keyrings/jenkins-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.gpg] https://pkg.jenkins.io/debian-stable binary/" | tee /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update -y
apt-get install -y jenkins
systemctl start jenkins
systemctl enable jenkins
echo ">>> Jenkins installed and started"

# ----------------------------------------
# Install Docker
# ----------------------------------------
echo ">>> Installing Docker..."
apt-get install -y docker.io
systemctl start docker
systemctl enable docker
usermod -aG docker jenkins
usermod -aG docker ubuntu
echo ">>> Docker installed"

# ----------------------------------------
# Install SonarQube
# ----------------------------------------
echo ">>> Installing SonarQube..."

# Install unzip
apt-get install -y unzip

# Create sonarqube user
adduser --disabled-password --gecos "Sonar Qube" sonarqube

# Download SonarQube as sonarqube user
su - sonarqube -c "wget -q https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.4.1.88267.zip -O /home/sonarqube/sonarqube.zip"
su - sonarqube -c "unzip -q /home/sonarqube/sonarqube.zip -d /home/sonarqube/"
su - sonarqube -c "rm /home/sonarqube/sonarqube.zip"

# Fix Java 21 Security Manager issue
su - sonarqube -c "echo 'sonar.web.javaAdditionalOpts=-Djava.security.manager=allow' >> /home/sonarqube/sonarqube-10.4.1.88267/conf/sonar.properties"
su - sonarqube -c "echo 'sonar.ce.javaAdditionalOpts=-Djava.security.manager=allow' >> /home/sonarqube/sonarqube-10.4.1.88267/conf/sonar.properties"

# Set permissions
chmod -R 755 /home/sonarqube/sonarqube-10.4.1.88267
chown -R sonarqube:sonarqube /home/sonarqube/sonarqube-10.4.1.88267

# Start SonarQube
su - sonarqube -c "/home/sonarqube/sonarqube-10.4.1.88267/bin/linux-x86-64/sonar.sh start"
echo ">>> SonarQube installed and started"

# ----------------------------------------
# Restart Jenkins to apply Docker group
# ----------------------------------------
systemctl restart jenkins
echo ">>> Jenkins restarted"

echo "========================================="
echo " Setup Complete!"
echo " Jenkins  → http://<public-ip>:8080"
echo " SonarQube → http://<public-ip>:9000"
echo "========================================="
