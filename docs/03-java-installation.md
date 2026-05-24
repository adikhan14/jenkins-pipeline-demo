# 02 — Java Installation

## Install Java 21 on EC2

Jenkins and SonarQube require Java 21 to run on the EC2 instance.

```bash
sudo apt update
sudo apt install openjdk-21-jre -y
```

Verify:
```bash
java -version
```

Expected output:
```
openjdk version "21.x.x"
OpenJDK Runtime Environment (build 21.x.x)
```

---

## Why Only Java 21?

| Requirement | Handled By |
|-------------|-----------|
| Jenkins runtime | Java 21 on EC2 ✅ |
| SonarQube runtime | Java 21 on EC2 ✅ |
| Spring Boot app build (Java 17) | `maven:3.9.6-eclipse-temurin-17` Docker image |
| Spring Boot app runtime (Java 17) | `eclipse-temurin:17-jre-alpine` Dockerfile |

> 💡 No need to install Java 17 on EC2 — it runs inside Docker containers which already have Java 17 bundled.
