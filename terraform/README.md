# Terraform — Automated Infrastructure Setup

Automates the complete EC2 infrastructure setup using Terraform.
One command creates the EC2 instance and installs Jenkins, SonarQube, and Docker automatically.

---

## What It Creates

| Resource | Detail |
|----------|--------|
| **EC2 Instance** | Ubuntu, t2.large, 16GB |
| **Security Group** | Ports 22, 8080, 9000 open |
| **Java 21** | Installed automatically |
| **Jenkins** | Installed & started on port 8080 |
| **SonarQube** | Installed & started on port 9000 |
| **Docker** | Installed with Jenkins permissions |

---

## Files

| File | Purpose |
|------|---------|
| `main.tf` | EC2 instance, Security Group, AMI lookup |
| `variables.tf` | Configurable inputs |
| `outputs.tf` | Displays public IP, Jenkins & SonarQube URLs |
| `user_data.sh` | Bootstrap script that installs all tools on startup |

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) installed
- AWS CLI configured (`aws configure`)
- An existing AWS Key Pair

---

## Usage

```bash
# 1. Initialize Terraform
terraform init

# 2. Preview what will be created
terraform plan -var="key_name=your-key-pair-name"

# 3. Apply — creates everything
terraform apply -var="key_name=your-key-pair-name"
```

After ~5-10 minutes, Terraform outputs:
```
ec2_public_ip = "x.x.x.x"
jenkins_url   = "http://x.x.x.x:8080"
sonarqube_url = "http://x.x.x.x:9000"
```

---

## Destroy Infrastructure

When done, destroy all resources to avoid AWS charges:
```bash
terraform destroy -var="key_name=your-key-pair-name"
```

---

## Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `aws_region` | `ap-south-1` | AWS region |
| `instance_type` | `t2.large` | EC2 instance type |
| `key_name` | *(required)* | AWS Key Pair name |
| `volume_size` | `16` | Root volume size in GB |
