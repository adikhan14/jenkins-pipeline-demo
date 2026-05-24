# Jenkins CI/CD Pipeline Setup on AWS EC2

## Overview
This guide documents the complete setup of a Jenkins + SonarQube CI/CD pipeline on an AWS EC2 instance with a Spring Boot application.

---

## Infrastructure

| Detail | Value |
|--------|-------|
| **Cloud** | AWS EC2 |
| **Instance Type** | Large |
| **OS** | Ubuntu |
| **Public IP** | 65.1.134.229 |
| **Key Pair** | aws-pem-file.pem |

---

## Step 1: Create EC2 Instance

- Launch EC2 large instance on AWS Console
- Select **Ubuntu** as the AMI
- Create a new **PEM key pair** and download it
- Create a new **Security Group**

**Inbound Rules Added:**

| Port | Protocol | Purpose |
|------|----------|---------|
| 22 | TCP | SSH access |
| 8080 | TCP | Jenkins UI |
| 9000 | TCP | SonarQube UI |

---

## Step 2: SSH into EC2 Instance

```bash
chmod 400 aws-pem-file.pem
ssh -i "aws-pem-file.pem" ubuntu@65.1.134.229
```

> ⚠️ If you get `Operation timed out` — check Security Group has port 22 open.

---

## Step 3: Install Java

SonarQube requires Java 17, Jenkins 2.555.2 requires Java 21.
Install both:

```bash
sudo apt update
sudo apt install openjdk-17-jre -y
sudo apt install openjdk-21-jre -y
```

Verify:
```bash
java -version
```

---

## Step 4: Install Jenkins

### 4.1 Add Jenkins GPG Key & Repo

```bash
sudo gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7198F4B714ABFC68
sudo gpg --export 7198F4B714ABFC68 | sudo tee /usr/share/keyrings/jenkins-keyring.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.gpg] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
```

### 4.2 Install Jenkins

```bash
sudo apt-get update
sudo apt-get install jenkins -y
```

> **Jenkins Version Installed:** 2.555.2

### 4.3 Start Jenkins

```bash
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
```

> ⚠️ If Jenkins fails with Java version error — ensure Java 21 is installed.
> Jenkins 2.555.2 requires **Java 21 minimum**.

### 4.4 Get Initial Admin Password

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

### 4.5 Access Jenkins UI

```
http://65.1.134.229:8080
```

- Paste the admin password
- Install **Suggested Plugins**
- Create Admin User
- **Plugins also installed:** Docker Pipeline, SonarQube Scanner

---

## Step 5: Install SonarQube

### 5.1 Create SonarQube User

```bash
sudo su -
adduser sonarqube
sudo su - sonarqube
```

### 5.2 Install unzip (as ubuntu user)

```bash
exit        # back to ubuntu
sudo apt update && sudo apt install unzip -y
sudo su - sonarqube
```

### 5.3 Download & Extract SonarQube

```bash
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.4.1.88267.zip
unzip sonarqube-10.4.1.88267.zip
```

### 5.4 Set Permissions (as ubuntu user)

```bash
exit   # back to ubuntu
sudo chmod -R 755 /home/sonarqube/sonarqube-10.4.1.88267
sudo chown -R sonarqube:sonarqube /home/sonarqube/sonarqube-10.4.1.88267
sudo su - sonarqube
```

### 5.5 Fix Java 21 Security Manager Issue

SonarQube 10.4.1 uses Java Security Manager which is blocked by default in Java 18+.

```bash
echo 'sonar.web.javaAdditionalOpts=-Djava.security.manager=allow' >> ~/sonarqube-10.4.1.88267/conf/sonar.properties
```

### 5.6 Start SonarQube

```bash
~/sonarqube-10.4.1.88267/bin/linux-x86-64/sonar.sh start
~/sonarqube-10.4.1.88267/bin/linux-x86-64/sonar.sh status
```

### 5.7 Access SonarQube UI

```
http://65.1.134.229:9000
```

> Default credentials: **admin / admin** (change on first login)

---

## Step 6: Spring Boot Application

### 6.1 Project Structure

```
springboot-app/
├── Dockerfile
├── pom.xml
└── src/
    └── main/
        ├── java/com/example/demo/
        │   ├── DemoApplication.java
        │   └── AppController.java
        └── resources/
            └── application.properties
```

### 6.2 Endpoints

| Endpoint | Method | Response |
|----------|--------|----------|
| `/hello` | GET | `Hello, World!` |
| `/heartbeat` | GET | `OK` |

### 6.3 Dockerfile

```dockerfile
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY target/*.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]
```

### 6.4 GitHub Repository

```
https://github.com/adikhan14/jenkins-springboot-demo
```

---

## Ports Summary

| Service | Port | URL |
|---------|------|-----|
| SSH | 22 | - |
| Jenkins | 8080 | http://65.1.134.229:8080 |
| SonarQube | 9000 | http://65.1.134.229:9000 |
| Spring Boot | 8081 | http://65.1.134.229:8081 |

---

*Document will be updated as setup progresses...*
