# Jenkins CI/CD Pipeline on AWS EC2

A complete CI/CD pipeline setup using Jenkins, SonarQube, Docker, and Spring Boot on AWS EC2.

---

## Architecture

```
Project Build on Jenkins (EC2 :8080)
    ↓ checks out code from GitHub
Maven Docker Container spins up
    ├── Stage 1: Build & Test (Maven + Java 17)
    ├── Stage 2: Static Code Analysis (SonarQube :9000)
    └── Stage 3: Build Docker Image (springboot-demo)
```

---

## Documentation

| # | Guide | Description |
|---|-------|-------------|
| 1 | [Spring Boot App & GitHub](docs/01-springboot-app.md) | Create app, Dockerfile, push to GitHub |
| 2 | [EC2 Setup](docs/02-ec2-setup.md) | Launch EC2 instance, security groups, SSH |
| 3 | [Java Installation](docs/03-java-installation.md) | Install Java 21 on EC2 |
| 4 | [Jenkins Setup](docs/04-jenkins-setup.md) | Install, configure & access Jenkins |
| 5 | [SonarQube Setup](docs/05-sonarqube-setup.md) | Install, configure & access SonarQube |
| 6 | [Docker Setup](docs/06-docker-setup.md) | Install Docker, fix permissions |
| 7 | [Jenkins Pipeline](docs/07-jenkins-pipeline.md) | Jenkinsfile, pipeline stages |

---

## Quick Reference

| Service | Port |
|---------|------|
| Jenkins | 8080 |
| SonarQube | 9000 |
| Spring Boot | 8081 |

---

## Tech Stack

| Tool | Version | Purpose |
|------|---------|---------|
| Jenkins | 2.555.2 | CI/CD Server |
| SonarQube | 10.4.1 | Static Code Analysis |
| Docker | latest | Containerization |
| Spring Boot | 3.2.5 | Application Framework |
| Java | 21 | EC2 Runtime |
| Maven | 3.9.6 | Build Tool |
| Ubuntu | Latest | EC2 OS |
