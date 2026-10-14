# Full Stack Application – AWS EC2 Deployment Lab

Below is a **student-friendly, step-by-step procedure** for deploying the Employee Full Stack Application using **two EC2 instances**.

The deployment will be:

```text
                    Internet
                       |
                       v
                 Browser
                       |
                  HTTP :80
                       |
                       v
              +----------------+
              |   app_client   |
              |    Apache      |
              |   EC2/t3.micro |
              +----------------+
                       |
                 HTTP :8000
                       |
                       v
              +----------------+
              |   app_server   |
              |    FastAPI     |
              |   EC2/t3.micro |
              +----------------+
                       |
                       v
                  SQLite DB
                 employees.db
```

---

# 0. Before Starting

You need:

- AWS account
- AWS Management Console access
- GitHub repository
- Two EC2 instances
- Two key pairs
- Two security groups

Repository:

`gmaheswaranmca/mtd_nie_ise2028c`

You will create:

| Resource | Purpose |
|---|---|
| `app_server` | FastAPI backend |
| `app_client` | Apache frontend |
| `app_server_sg` | Backend security group |
| `app_client_sg` | Frontend security group |
| `app_server_key` | SSH key for backend |
| `app_client_key` | SSH key for frontend |

---

# 1. Record AWS Cost Before Starting

Before creating anything, establish a baseline.

Go to:

```text
AWS Console
    ↓
Billing and Cost Management
    ↓
Bills / Cost Explorer
```

Record the current cost if available.

For a classroom lab, maintain:

```text
Cost before experiment: ₹ __________
Date/Time: __________
```

> AWS billing availability can vary by account and region, so don't assume that the displayed amount is exactly zero.

---

# 2. Select AWS Region

At the top-right of the AWS Console, select the region you are going to use.

For example:

```text
Asia Pacific (Mumbai)
ap-south-1
```

**Important:** Use the same region for both EC2 instances.

---

# 3. Create Backend Security Group

Go to:

```text
AWS Console
    ↓
EC2
    ↓
Security Groups
    ↓
Create security group
```

Enter:

```text
Security group name:
app_server_sg

Description:
Security group for FastAPI backend
```

For inbound rules, add:

### Rule 1 — SSH

```text
Type: SSH
Protocol: TCP
Port: 22
Source: AnywhereIPv4    ie 0.0.0.0/0
```

For a classroom environment, you may temporarily use a specific source IP rather than `0.0.0.0/0`.

### Rule 2 — FastAPI

```text
Type: Custom TCP
Protocol: TCP
Port: 8000
Source: AnywhereIPv4    ie 0.0.0.0/0
```

This allows the browser to access FastAPI directly for testing.

Your rules should look approximately like:

```text
Inbound Rules

SSH           TCP   22     0.0.0.0/0
Custom TCP    TCP   8000   0.0.0.0/0
```

Click:

```text
Create security group
```

---

# 4. Create Backend Key Pair

Go to:

```text
EC2
   ↓
Key Pairs
   ↓
Create key pair
```

Use:

```text
Name:
app_server_key

Key pair type:
RSA

Private key file format:
.pem
```

Click:

```text
Create key pair
```

Your browser downloads:

```text
app_server_key.pem
```

### Important

Keep this file safely.

On Windows, it may be in:

```text
Downloads
```

Do **not** upload the `.pem` file to GitHub.

---

# 5. Launch Backend EC2

Go to:

```text
EC2
   ↓
Instances
   ↓
Launch instance
```

Configure:

### Name

```text
app_server
```

### AMI

Select:

```text
Amazon Linux
```

Use the currently available Amazon Linux image recommended by the console.

### Instance type

```text
t3.micro
```

### Key pair

Select:

```text
app_server_key
```

### Security group

Select:

```text
app_server_sg
```

### Storage

For this lab, the default storage is generally sufficient.

Click:

```text
Launch instance
```

---

# 6. Wait for Backend Instance

Go to:

```text
EC2
    ↓
Instances
```

Find:

```text
app_server
```

Wait until:

```text
Instance state: Running
```

Also check:

```text
Status check: 3/3 checks passed
```

---

# 7. Record Backend Public IP

Select `app_server`.

Look at:

```text
Public IPv4 address
```

For example:

```text
3.110.50.20
```

Write it down:

```text
BACKEND_PUBLIC_IP = 3.110.50.20
```

Your actual IP will be different.

> If the instance is stopped and restarted, its public IPv4 address can change unless you use an Elastic IP. Therefore, record the IP again whenever you start the lab.

---

# 8. Connect to Backend EC2 Using SSH

On Windows PowerShell:

```powershell
cd Downloads
```

Then:

```powershell
ssh -i .\app_server_key.pem ec2-user@<BACKEND_PUBLIC_IP>
```

Example:

```powershell
ssh -i .\app_server_key.pem ec2-user@3.110.50.20
```

The first time, you may see:

```text
Are you sure you want to continue connecting?
```

Enter:

```text
yes
```

You should get something similar to:

```text
[ec2-user@ip-xxx-xxx-xxx-xxx ~]$
```

You are now inside the EC2 server.

---

# 9. Update Backend Linux

Run:

```bash
sudo dnf update -y
```

This updates installed packages.

Check Git:

```bash
git --version
```

If Git is not installed:

```bash
sudo dnf install git -y
```

Verify:

```bash
git --version
```

---

# 10. Clone the GitHub Repository

Run:

```bash
cd /home/ec2-user
```

Then:

```bash
git clone https://github.com/gmaheswaranmca/mtd_nie_ise2028c.git
```

Check:

```bash
ls
```

You should see:

```text
mtd_nie_ise2028c
```

Enter the project:

```bash
cd /home/ec2-user/mtd_nie_ise2028c
```

---

# 11. Go to Backend Scripts

Run:

```bash
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/server/scripts
```

Check files:

```bash
ls -l
```

You should find:

```text
ser2.sh
ser3.sh
```

---

# 12. Make Backend Script Executable

Run:

```bash
chmod +x ser2.sh
```

Check:

```bash
ls -l ser2.sh
```

You should see execute permission, something like:

```text
-rwxr-xr-x
```

---

# 13. Install Python, Dependencies and Start FastAPI

Run:

```bash
./ser2.sh
```

The script should perform the required backend setup.

Depending on how your script is written, it may:

```text
Install Python
       ↓
Create virtual environment
       ↓
Install dependencies
       ↓
Start FastAPI
```

Watch the output carefully.

---

# 14. Test FastAPI Locally

Still inside `app_server`, run:

```bash
curl http://localhost:8000/emps
```

Expected response should be something similar to:

```json
[]
```

or an employee list.

This confirms:

```text
FastAPI
   ↓
8000
   ↓
/emps
```

is working.

---

# 15. Test FastAPI from Browser

From your Windows browser, open:

```text
http://<BACKEND_PUBLIC_IP>:8000/docs
```

For example:

```text
http://3.110.50.20:8000/docs
```

You should see:

```text
FastAPI Swagger UI
```

You can test endpoints such as:

```text
GET /emps
POST /emps
```

depending on your application.

### If `/docs` does not open

Check the following:

```text
EC2 instance → Running
Security Group → TCP 8000 allowed
FastAPI → running
Correct public IP → used
```

Also test from EC2:

```bash
curl http://localhost:8000/docs
```

---

# 16. Prepare Backend for Frontend

Now the backend needs to know where the frontend is located.

At this point, you **do not yet know the frontend public IP**.

So continue with the frontend deployment.

---

# 17. Create Frontend Security Group

Go to:

```text
EC2
    ↓
Security Groups
    ↓
Create security group
```

Enter:

```text
Name:
app_client_sg

Description:
Security group for frontend Apache server
```

Inbound rules:

### SSH

```text
Type: SSH
Port: 22
Source: AnywhereIPv4 ie 0.0.0.0/0
```

### HTTP

```text
Type: HTTP
Port: 80
Source: AnywhereIPv4 ie 0.0.0.0/0
```

Therefore:

```text
SSH      TCP 22   0.0.0.0/0
HTTP     TCP 80   0.0.0.0/0
```

Click:

```text
Create security group
```

---

# 18. Create Frontend Key Pair

Go to:

```text
EC2
    ↓
Key Pairs
    ↓
Create key pair
```

Enter:

```text
Name:
app_client_key

Type:
RSA

Format:
.pem
```

Click:

```text
Create key pair
```

The file will be downloaded:

```text
app_client_key.pem
```

Keep it safely.

---

# 19. Launch Frontend EC2

Go to:

```text
EC2
    ↓
Instances
    ↓
Launch instance
```

Configure:

```text
Name:
app_client
```

AMI:

```text
Amazon Linux
```

Instance type:

```text
t3.micro
```

Key pair:

```text
app_client_key
```

Security group:

```text
app_client_sg
```

Then:

```text
Launch instance
```

---

# 20. Wait for Frontend EC2

Go to:

```text
EC2 → Instances
```

Wait for:

```text
app_client
Instance state: Running
Status checks: 3/3
```

---

# 21. Record Frontend Public IP

Select `app_client`.

Find:

```text
Public IPv4 address
```

For example:

```text
13.234.100.50
```

Record:

```text
FRONTEND_PUBLIC_IP = 13.234.100.50
```

---

# 22. Connect to Frontend EC2

From Windows PowerShell:

```powershell
ssh -i .\app_client_key.pem ec2-user@<FRONTEND_PUBLIC_IP>
```

Example:

```powershell
ssh -i .\app_client_key.pem ec2-user@13.234.100.50
```

You should see:

```text
[ec2-user@ip-xxx-xxx-xxx-xxx ~]$
```

---

# 23. Update Frontend Linux

Run:

```bash
sudo dnf update -y
```

Install Git:

```bash
sudo dnf install git -y
```

Verify:

```bash
git --version
```

---

# 24. Clone the Repository

Run:

```bash
cd /home/ec2-user
```

Then:

```bash
git clone https://github.com/gmaheswaranmca/mtd_nie_ise2028c.git
```

Check:

```bash
ls
```

You should see:

```text
mtd_nie_ise2028c
```

---

# 25. Go to Frontend Scripts

Run:

```bash
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/client/scripts
```

Check:

```bash
ls -l
```

You should see:

```text
cli2.sh
cli3.sh
```

---

# 26. Make Frontend Script Executable

Run:

```bash
chmod +x cli2.sh
```

Then:

```bash
./cli2.sh
```

The script should install/configure Apache and deploy the frontend.

---

# 27. Check Apache

Run:

```bash
sudo systemctl status httpd
```

You want to see:

```text
Active: active (running)
```

If it is not running:

```bash
sudo systemctl start httpd
```

Enable Apache at boot:

```bash
sudo systemctl enable httpd
```

Check again:

```bash
sudo systemctl status httpd
```

---

# 28. Test Frontend

From your Windows browser:

```text
http://<FRONTEND_PUBLIC_IP>
```

Example:

```text
http://13.234.100.50
```

You should see your Employee application.

At this stage:

```text
Browser
   ↓
app_client
   ↓
Apache
   ↓
Frontend application
```

But the frontend does not yet know where the FastAPI backend is.

---

# 29. Configure Backend URL in Frontend

You now know:

```text
BACKEND_PUBLIC_IP
```

For example:

```text
3.110.50.20
```

On `app_client`, run:

```bash
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/client/scripts
```

Make the script executable:

```bash
chmod +x cli3.sh
```

Run:

```bash
./cli3.sh http://<BACKEND_PUBLIC_IP>:8000
```

Example:

```bash
./cli3.sh http://3.110.50.20:8000
```

This sets:

```text
BASE_URL
```

to the backend server.

---

# 30. Restart Apache

After changing the frontend configuration, restart Apache:

```bash
sudo systemctl restart httpd
```

Check:

```bash
sudo systemctl status httpd
```

Expected:

```text
Active: active (running)
```

---

# 31. Configure Backend FRONTEND_URL

Now return to the backend server.

From your Windows PowerShell:

```powershell
ssh -i .\app_server_key.pem ec2-user@<BACKEND_PUBLIC_IP>
```

Then:

```bash
cd /home/ec2-user/mtd_nie_ise2028c/exercises/ex1/server/scripts
```

Make executable:

```bash
chmod +x ser3.sh
```

Run:

```bash
./ser3.sh http://<FRONTEND_PUBLIC_IP>
```

Example:

```bash
./ser3.sh http://13.234.100.50
```

This configures:

```text
FRONTEND_URL
```

for the FastAPI application.

---

# 32. Restart FastAPI

The exact restart command depends on how `ser3.sh` is implemented.

If the script handles the restart, simply use:

```bash
./ser3.sh http://<FRONTEND_PUBLIC_IP>
```

If FastAPI is running as a background process, the script should restart it.

Then verify:

```bash
curl http://localhost:8000/emps
```

Also check:

```text
http://<BACKEND_PUBLIC_IP>:8000/docs
```

---

# 33. Understand the Two URLs

This is an important concept for students.

### Frontend URL

```text
http://<FRONTEND_PUBLIC_IP>
```

Example:

```text
http://13.234.100.50
```

This is where the **browser** connects.

### Backend URL

```text
http://<BACKEND_PUBLIC_IP>:8000
```

Example:

```text
http://3.110.50.20:8000
```

This is where the **frontend JavaScript** sends API requests.

Therefore:

```text
FRONTEND_URL
        ↓
http://13.234.100.50

BASE_URL
        ↓
http://3.110.50.20:8000
```

---

# 34. Important: localhost Meaning

This is one of the most important concepts in the experiment.

On `app_client`:

```text
localhost
```

means:

```text
app_client itself
```

On `app_server`:

```text
localhost
```

means:

```text
app_server itself
```

Therefore, this is **wrong** for communication between the two EC2 machines:

```text
BASE_URL=http://localhost:8000
```

The frontend would try to access port 8000 on **the frontend EC2**, not the backend.

Instead:

```text
BASE_URL=http://<BACKEND_PUBLIC_IP>:8000
```

---

# 35. Final Application Test

Open:

```text
http://<FRONTEND_PUBLIC_IP>
```

Example:

```text
http://13.234.100.50
```

Perform the following.

### Test 1 — Add Employee

Enter:

```text
Employee Name:
Ravi
```

Enter:

```text
Salary:
50000
```

Click:

```text
Add Employee
```

---

# 36. Verify Employee Appears

The employee should appear in the table.

For example:

```text
ID    Name       Salary
1     Ravi       50000
```

This confirms:

```text
Browser
   ↓
Apache
   ↓
Frontend JavaScript
   ↓
FastAPI
   ↓
SQLite
```

---

# 37. Refresh Test

Press:

```text
Ctrl + R
```

or click browser refresh.

The employee should still appear.

This confirms that the data is not merely held in browser memory.

The flow is:

```text
Frontend
   ↓
GET /emps
   ↓
FastAPI
   ↓
employees.db
   ↓
Employee returned
   ↓
Table displayed
```

---

# 38. Test Backend API Directly

Open:

```text
http://<BACKEND_PUBLIC_IP>:8000/docs
```

For example:

```text
http://3.110.50.20:8000/docs
```

Test:

```text
GET /emps
```

You should see the employee you created.

This proves that the backend is working independently of the frontend.

---

# 39. Complete Architecture Test

At this point, your complete architecture is:

```text
                    Internet
                       |
                       |
                    Browser
                       |
                    HTTP :80
                       |
                       v
              +----------------+
              |   app_client   |
              |                |
              |    Apache      |
              |                |
              |  Frontend      |
              +----------------+
                       |
                       |
                 HTTP :8000
                       |
                       v
              +----------------+
              |   app_server   |
              |                |
              |    FastAPI     |
              |                |
              |   employees    |
              +----------------+
                       |
                       v
              +----------------+
              |    SQLite      |
              | employees.db   |
              +----------------+
```

---

# 40. Verify AWS Resources Before Cleanup

Now stop and inspect your resources.

Go to:

```text
AWS Console
    ↓
EC2
    ↓
Instances
```

You should have:

```text
app_server
app_client
```

Check:

```text
Instance state
Public IPv4 address
Instance type
Security group
```

---

# 41. Check Backend Security Group

Go to:

```text
EC2
   ↓
Security Groups
```

Find:

```text
app_server_sg
```

Verify:

```text
SSH       22
Custom    8000
```

---

# 42. Check Frontend Security Group

Find:

```text
app_client_sg
```

Verify:

```text
SSH       22
HTTP      80
```

---

# 43. Terminate EC2 Instances

When the experiment is completely finished:

Go to:

```text
EC2
    ↓
Instances
```

Select:

```text
app_server
app_client
```

Then:

```text
Instance state
    ↓
Terminate instance
```

Confirm termination.

### Important distinction

```text
STOP
```

means:

```text
Instance is shut down but can be started again.
```

Whereas:

```text
TERMINATE
```

means:

```text
Instance is permanently deleted.
```

For a disposable classroom lab, **terminate** the instances when they are no longer required.

---

# 44. Verify Instance Termination

Refresh:

```text
EC2 → Instances
```

You should eventually see:

```text
app_server    Terminated
app_client    Terminated
```

Do not immediately assume that everything is cleaned up just because the instances are terminated.

---

# 45. Check Security Groups

Go to:

```text
EC2
   ↓
Security Groups
```

Check:

```text
app_server_sg
app_client_sg
```

If they were created exclusively for this lab and are no longer needed:

```text
Select Security Group
    ↓
Actions
    ↓
Delete security group
```

If AWS says the security group is still associated with a resource, investigate that resource first.

---

# 46. Check Key Pairs

Go to:

```text
EC2
    ↓
Key Pairs
```

Check:

```text
app_server_key
app_client_key
```

If they were created exclusively for this experiment and you don't need them anymore, they can be removed from AWS.

Remember:

> Deleting a key pair from AWS does **not** delete the `.pem` file already downloaded to your computer.

So:

```text
AWS Key Pair
       X
       |
       | delete
       v
AWS no longer has it
```

but:

```text
app_server_key.pem
app_client_key.pem
```

may still remain in your Windows `Downloads` folder.

---

# 47. Final Resource Check

Before considering the experiment complete:

```text
EC2 Instances
--------------------------------
[ ] app_server terminated
[ ] app_client terminated

Security Groups
--------------------------------
[ ] app_server_sg checked
[ ] app_client_sg checked
[ ] Unused groups deleted

Key Pairs
--------------------------------
[ ] app_server_key checked
[ ] app_client_key checked

Application
--------------------------------
[ ] Frontend tested
[ ] Employee added
[ ] Employee list verified
[ ] Refresh test completed
[ ] FastAPI /docs tested
```

---

# 48. Check for Other AWS Resources

This is an important addition to the cleanup procedure.

Also inspect:

```text
EC2 → Elastic IPs
```

If you allocated an Elastic IP specifically for this experiment and no longer need it:

```text
Release Elastic IP
```

Also check:

```text
EC2 → Volumes
```

Look for unused EBS volumes.

Check:

```text
EC2 → Snapshots
```

if you created snapshots during the experiment.

Also check other services if you created anything outside EC2:

```text
S3
RDS
Elastic Load Balancer
NAT Gateway
CloudWatch
```

The key principle is:

> **Do not assume that terminating EC2 means every AWS resource created during the lab has disappeared.**

---

# 49. Check Cost After the Experiment

Finally go to:

```text
AWS Console
    ↓
Billing and Cost Management
    ↓
Cost Explorer / Bills
```

Record:

```text
Cost before experiment : ₹ __________

Cost after experiment  : ₹ __________

Difference             : ₹ __________
```

Keep in mind that billing data may not update immediately.

---

# 50. Student Learning Checklist

The student should be able to explain all of these after completing the experiment:

### EC2

- [ ] What is an EC2 instance?
- [ ] What is an AMI?
- [ ] What is `t3.micro`?
- [ ] What is a public IPv4 address?
- [ ] What is a key pair?
- [ ] What is a Security Group?

### Security

- [ ] Why is port `22` required?
- [ ] Why is port `80` required?
- [ ] Why is port `8000` required?
- [ ] What does `0.0.0.0/0` mean?
- [ ] Why is `My IP` preferable for SSH?

### Application

- [ ] What is FastAPI?
- [ ] What is Apache?
- [ ] Why are two EC2 instances used?
- [ ] What is `BASE_URL`?
- [ ] What is `FRONTEND_URL`?
- [ ] Why can't we use `localhost` between EC2 instances?

### Deployment

- [ ] Clone a GitHub repository
- [ ] Execute Linux shell scripts
- [ ] Start FastAPI
- [ ] Start Apache
- [ ] Configure frontend/backend URLs
- [ ] Test REST API
- [ ] Test the complete application

### AWS Cost Awareness

- [ ] Check cost before the experiment
- [ ] Identify running resources
- [ ] Terminate unused EC2 instances
- [ ] Check unused security groups
- [ ] Check unused Elastic IPs
- [ ] Check unused EBS volumes/snapshots
- [ ] Check cost after the experiment

---

# Final Lab Workflow

I would teach the students to remember the entire experiment as:

```text
1. PLAN
   ↓
2. CHECK COST
   ↓
3. CREATE SECURITY GROUPS
   ↓
4. CREATE KEY PAIRS
   ↓
5. CREATE EC2 BACKEND
   ↓
6. DEPLOY FASTAPI
   ↓
7. TEST BACKEND
   ↓
8. CREATE EC2 FRONTEND
   ↓
9. DEPLOY APACHE + FRONTEND
   ↓
10. CONNECT FRONTEND → BACKEND
   ↓
11. TEST FULL APPLICATION
   ↓
12. TERMINATE EC2
   ↓
13. CHECK OTHER RESOURCES
   ↓
14. VERIFY COST
```

The most important lesson is:

> **Create → Configure → Deploy → Test → Observe → Cleanup → Verify Cost**

This makes the experiment not just an **AWS deployment exercise**, but also a lesson in **cloud resource management and cost awareness**.