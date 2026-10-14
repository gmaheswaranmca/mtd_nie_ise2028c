# Full Stack Application – AWS EC2 Deployment

## 1. Backend Server — `app_server`
 
- **Security Group:** `app_server_sg` → `22, 8000`  
- **Key:** `app_server_key.pem`
- **EC2:** `Amazon Linux` | **Type:** `t3.micro` 

### 1.A Update Linux + Git + Clone

```bash
sudo dnf update -y
sudo dnf install git -y
git clone https://github.com/gmaheswaranmca/mtd_nie_ise2028c.git
```

### 1.B Install Python + Dependencies + Start FastAPI

```bash
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/server/scripts
chmod +x ser2.sh
./ser2.sh
```

**Check:**

```bash
curl http://localhost:8000/emps
```

Open in browser:

```text
http://<BACKEND_PUBLIC_IP>:8000/docs
```

### 1.C Set Frontend URL + Restart FastAPI

Replace `<FRONTEND_PUBLIC_IP>` with the public IP of `app_client`.

```bash
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/server/scripts
chmod +x ser3.sh
./ser3.sh http://<FRONTEND_PUBLIC_IP>
```

Example:

```bash
./ser3.sh http://13.234.100.50
```

---

# 2. Frontend Server — `app_client`

- **Security Group:** `app_client_sg` → `22, 80`  
- **Key:** `app_client_key.pem`
- **EC2:** `Amazon Linux` | **Type:** `t3.micro` 

### 2.A Update Linux + Git + Clone

```bash
sudo dnf update -y
sudo dnf install git -y
git clone https://github.com/gmaheswaranmca/mtd_nie_ise2028c.git
```

### 2.B Install Apache + Start + Enable

```bash
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/client/scripts
chmod +x cli2.sh
./cli2.sh
```

**Check:**

```bash
sudo systemctl status httpd
```

Open in browser:

```text
http://<FRONTEND_PUBLIC_IP>
```

### 2.C Set Backend URL + Restart Apache

Replace `<BACKEND_PUBLIC_IP>` with the public IP of `app_server`.

```bash
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/client/scripts
chmod +x cli3.sh
./cli3.sh http://<BACKEND_PUBLIC_IP>:8000
```

Example:

```bash
./cli3.sh http://3.110.50.20:8000
```

---

# 3. Final Test

Open:

```text
http://<FRONTEND_PUBLIC_IP>
```

1. Enter **Employee Name**
2. Enter **Salary**
3. Click **Add Employee**
4. Verify employee appears in the table
5. Refresh the page
6. Verify employee is still present

### Architecture

```text
Browser
   |
   | HTTP :80
   v
app_client
Apache
   |
   | HTTP :8000
   v
app_server
FastAPI
   |
   v
SQLite
employees.db
```

### Important

- `FRONTEND_URL` → **Frontend EC2 public URL**
- `BASE_URL` → **Backend EC2 public URL + :8000**
- Do **not** use `localhost` between the two EC2 servers.
- After testing, **stop/terminate EC2 resources** to avoid unnecessary AWS charges.

## 4. Cleanup — Avoid AWS Charges

### 4.A Check Resources

In **AWS Console → EC2 → Instances**, verify:

- [ ] `app_server`
- [ ] `app_client`

Check their **Instance State** and **Public IPv4 address**.

---

### 4.B Check Application

Before deleting, confirm the experiment is complete:

- [ ] Frontend application tested
- [ ] Employee added successfully
- [ ] Employee list displayed
- [ ] Backend API tested
- [ ] FastAPI `/docs` tested

---

### 4.C Terminate EC2 Instances

Select:

```text
app_server
app_client
```

Then:

```text
Instance state → Terminate instance
```

Confirm termination.

> **Important:** Stop and terminate are different.  
> **Terminate** permanently deletes the EC2 instance.

---

### 4.D Check Security Groups

Go to:

```text
EC2 → Security Groups
```

Check:

- [ ] `app_server_sg`
- [ ] `app_client_sg`

If they are no longer required, delete them.

> A Security Group can be deleted only when it is not associated with any resource.

---

### 4.E Check Key Pairs

Go to:

```text
EC2 → Key Pairs
```

Check:

- [ ] `app_server_key`
- [ ] `app_client_key`

Delete them **only if they were created exclusively for this experiment and are no longer required**.

> Deleting a key pair from AWS does not delete the `.pem` file already downloaded to your computer.

---

# Final Cleanup Verification

```text
[ ] app_server terminated
[ ] app_client terminated
[ ] Unused Security Groups removed
[ ] Unused Key Pairs removed
```

## Final Rule

**Create → Use → Check → Cleanup → Verify Cost**

> Never finish an AWS lab without checking what resources are still running.