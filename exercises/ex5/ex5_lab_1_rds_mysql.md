# 1️⃣ Lab 1 – Create a MySQL RDS Database (Basic Lab)

### Objective

Create a relational database using **MySQL** in **Amazon Relational Database Service**.

### Tasks

1. Login to **Amazon Web Services Console
2. Open **RDS Service**
3. Click **Create Database**
4. Choose:

   * Engine → MySQL
   * Template → Free tier
5. Configure:

   * DB instance identifier: `studentdb`
   * Master username: `admin`
   * Instance type: `db.t3.micro`
6. Enable **public access**
7. Create database

### Expected Output

Students get endpoint:

```
studentdb.xxxxx.ap-south-1.rds.amazonaws.com
```

# 2️⃣ Lab 2 – Connect to RDS from Local Machine

### Objective

Connect to RDS using MySQL client.

Tools:

* MySQL Workbench
* MySQL CLI

Example:

```sql
CREATE DATABASE training;

USE training;

CREATE TABLE trainer(
 id INT AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(100),
 skills VARCHAR(200)
);
```

Insert data:

```sql
INSERT INTO trainer(name,skills)
VALUES('John','React'),
('David','Node');
```

Verify:

```sql
SELECT * FROM trainer;
```