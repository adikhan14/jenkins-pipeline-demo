# 03 — Jenkins Setup

## Install Jenkins

### Step 1: Add Jenkins GPG Key

```bash
sudo gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7198F4B714ABFC68
sudo gpg --export 7198F4B714ABFC68 | sudo tee /usr/share/keyrings/jenkins-keyring.gpg > /dev/null
```

### Step 2: Add Jenkins Repository

```bash
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.gpg] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
```

### Step 3: Install Jenkins

```bash
sudo apt-get update
sudo apt-get install jenkins -y
```

### Step 4: Start Jenkins

```bash
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
```

---

## Access Jenkins UI

Get the initial admin password:
```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Open browser and go to:
```
http://<your-ec2-public-ip>:8080
```

Follow the setup wizard:
1. Paste the admin password
2. Click **"Install Suggested Plugins"** and wait
3. Create your **Admin User**
4. Click **"Start using Jenkins"**

---

## Install Additional Plugins

Go to **Manage Jenkins → Plugins → Available Plugins**

Search and install:
- ✅ **Docker Pipeline**
- ✅ **SonarQube Scanner**

> 💡 These plugins will be needed later when we set up the pipeline.
