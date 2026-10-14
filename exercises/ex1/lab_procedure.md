# Full Stack Application – AWS EC2 Deployment

## 1. Backend Server — `app_server`

**EC2:** `Amazon Linux` | **Type:** `t3.micro`  
**Security Group:** `app_server_sg` → `22, 8000`  
**Key:** `app_server_key.pem`

### 1.A Update Linux + Git + Clone

```bash
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/server/scripts
chmod +x ser1.sh
./ser1.sh
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

**EC2:** `Amazon Linux` | **Type:** `t3.micro`  
**Security Group:** `app_client_sg` → `22, 80`  
**Key:** `app_client_key.pem`

### 2.A Update Linux + Git + Clone

```bash
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/client/deploy
chmod +x cli1.sh
./cli1.sh
```

### 2.B Install Apache + Start + Enable

```bash
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/client/deploy
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
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/client/deploy
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