# AWS Full Stack Deployment — Simple Steps

## 1. Create Backend EC2

### Security Group

Create:

```text
app_server_sg

SSH       22
Custom    8000
```

For SSH, use **My IP**.

### Key Pair

Create:

```text
app_server_key.pem
```

### EC2

Create:

```text
Name:          app_server
AMI:           Amazon Linux
Instance type: t3.micro
Key pair:      app_server_key
Security:      app_server_sg
```

Wait until:

```text
Running
2/2 checks passed
```

Copy the **Public IPv4 address**.

```text
BACKEND_PUBLIC_IP = __________________
```

---

# 2. Deploy Backend

SSH into `app_server`:

```bash
ssh -i app_server_key.pem ec2-user@<BACKEND_PUBLIC_IP>
```

Run:

```bash
sudo dnf update -y
sudo dnf install git -y
git clone https://github.com/gmaheswaranmca/mtd_nie_ise2028c.git
```

Go to backend scripts:

```bash
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/server/scripts
```

Run:

```bash
chmod +x ser2.sh
./ser2.sh
```

Test:

```bash
curl http://localhost:8000/emps
```

Test from browser:

```text
http://<BACKEND_PUBLIC_IP>:8000/docs
```

✅ Backend working.

---

# 3. Create Frontend EC2

### Security Group

Create:

```text
app_client_sg

SSH     22
HTTP    80
```

For SSH, use **My IP**.

### Key Pair

Create:

```text
app_client_key.pem
```

### EC2

Create:

```text
Name:          app_client
AMI:           Amazon Linux
Instance type: t3.micro
Key pair:      app_client_key
Security:      app_client_sg
```

Wait for:

```text
Running
2/2 checks passed
```

Copy the **Public IPv4 address**.

```text
FRONTEND_PUBLIC_IP = __________________
```

---

# 4. Deploy Frontend

SSH into `app_client`:

```bash
ssh -i app_client_key.pem ec2-user@<FRONTEND_PUBLIC_IP>
```

Run:

```bash
sudo dnf update -y
sudo dnf install git -y
git clone https://github.com/gmaheswaranmca/mtd_nie_ise2028c.git
```

Go to frontend scripts:

```bash
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/client/scripts
```

Run:

```bash
chmod +x cli2.sh
./cli2.sh
```

Check Apache:

```bash
sudo systemctl status httpd
```

Test:

```text
http://<FRONTEND_PUBLIC_IP>
```

✅ Frontend working.

---

# 5. Connect Frontend → Backend

On `app_client`:

```bash
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/client/scripts
```

Run:

```bash
chmod +x cli3.sh
./cli3.sh http://<BACKEND_PUBLIC_IP>:8000
```

Restart Apache:

```bash
sudo systemctl restart httpd
```

---

# 6. Configure Backend

On `app_server`:

```bash
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/server/scripts
```

Run:

```bash
chmod +x ser3.sh
./ser3.sh http://<FRONTEND_PUBLIC_IP>
```

---

# 7. Final Test

Open:

```text
http://<FRONTEND_PUBLIC_IP>
```

Do:

```text
1. Enter Employee Name
2. Enter Salary
3. Click Add Employee
4. Check employee appears
5. Refresh page
6. Check employee is still there
```

Also test:

```text
http://<BACKEND_PUBLIC_IP>:8000/docs
```

---

# 8. Cleanup — VERY IMPORTANT

After completing the experiment:

### EC2

```text
[ ] app_server → Terminate
[ ] app_client → Terminate
```

### Security Groups

```text
[ ] app_server_sg → Delete if no longer needed
[ ] app_client_sg → Delete if no longer needed
```

### Key Pairs

```text
[ ] app_server_key → Delete if created only for this lab
[ ] app_client_key → Delete if created only for this lab
```

### Check Other Resources

```text
[ ] Elastic IP
[ ] EBS Volumes
[ ] Snapshots
```

Remove anything created only for this experiment and no longer required.

---

# Student's 10-Line Memory Version

Give them this at the bottom of the lab sheet:

```text
1. Create backend SG + key + EC2
2. SSH → clone → run ser2.sh
3. Test backend /docs
4. Create frontend SG + key + EC2
5. SSH → clone → run cli2.sh
6. Test frontend
7. cli3.sh → backend URL
8. ser3.sh → frontend URL
9. Test Add Employee + Refresh
10. TERMINATE everything + check cost
```

### The three things students must remember

```text
Frontend = Port 80
Backend  = Port 8000
Database = SQLite
```

And:

```text
Frontend → http://BACKEND_PUBLIC_IP:8000
Backend  → http://FRONTEND_PUBLIC_IP
```