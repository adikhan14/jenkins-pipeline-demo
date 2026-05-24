# 01 — EC2 Instance Setup

## Launch EC2 Instance

1. Go to **AWS Console → EC2 → Launch Instance**
2. Select **Ubuntu** as the OS
3. Choose **Large** instance type
4. Create a new **Key Pair** and download the `.pem` file
5. Create a new **Security Group**
6. Set storage to minimum **16GB**

---

## Security Group Inbound Rules

| Port | Protocol | Purpose |
|------|----------|---------|
| 22 | TCP | SSH access |
| 8080 | TCP | Jenkins UI |
| 9000 | TCP | SonarQube UI |

---

## SSH into EC2

```bash
# Set permissions on PEM file
chmod 400 aws-pem-file.pem

# Connect
ssh -i "aws-pem-file.pem" ubuntu@<your-ec2-public-ip>
```

> ⚠️ If you get `Operation timed out` → Security Group port 22 is not open. Add SSH inbound rule.
