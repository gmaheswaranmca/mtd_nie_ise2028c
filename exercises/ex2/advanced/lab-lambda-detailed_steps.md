I would keep the **AWS Lambda REST API experiment**: one Lambda function, one API Gateway, and an in-memory employee list first. 

# AWS Lambda – Simple Employee API

### Goal

Create these two APIs:

| Method | API | Purpose |
|---|---|---|
| GET | `/emps` | Get all employees |
| POST | `/emps` | Add a new employee |

Architecture:

```text
Browser / Postman
       |
       v
 API Gateway
       |
       v
 AWS Lambda
       |
       v
 Employee Data
```

---

## Step 1 — Open AWS Lambda

1. Login to **AWS Management Console**
2. Search for **Lambda**
3. Open **AWS Lambda**
4. Click **Create function**

Choose:

```text
Author from scratch
```

Enter:

```text
Function name: employee-api
Runtime: Python 3.13
Architecture: x86_64
```

Leave other settings as default.

Click **Create function**.

---

## Step 2 — Create Lambda Code

In the Lambda function, go to **Code → lambda_function.py**.

Replace the existing code with:

```python
import json

employees = [
    {"id": 1, "name": "Ravi", "salary": 30000},
    {"id": 2, "name": "Kumar", "salary": 35000}
]


def lambda_handler(event, context):

    method = event.get("requestContext", {}).get("http", {}).get("method")

    if method == "GET":
        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json"
            },
            "body": json.dumps(employees)
        }

    if method == "POST":

        data = json.loads(event.get("body", "{}"))

        employee = {
            "id": len(employees) + 1,
            "name": data["name"],
            "salary": data["salary"]
        }

        employees.append(employee)

        return {
            "statusCode": 201,
            "headers": {
                "Content-Type": "application/json"
            },
            "body": json.dumps(employee)
        }

    return {
        "statusCode": 405,
        "body": json.dumps({"message": "Method not allowed"})
    }
```

Click **Deploy**.

> For the first classroom experiment, this is enough. The employee data is only in Lambda memory, so it is **not permanent**. Later we can replace it with DynamoDB.

---

# Step 3 — Test Lambda

Click **Test**.

Create a test event.

For GET:

```json
{
  "requestContext": {
    "http": {
      "method": "GET"
    }
  }
}
```

Click **Test**.

Expected result:

```json
[
  {
    "id": 1,
    "name": "Ravi",
    "salary": 30000
  },
  {
    "id": 2,
    "name": "Kumar",
    "salary": 35000
  }
]
```

---

# Step 4 — Create API Gateway

Now expose Lambda as a web API.

Search:

**API Gateway**

Open it.

Click:

**Create API**

Choose:

**HTTP API**

Click **Build**.

---

# Step 5 — Connect Lambda

For integration, select:

```text
Lambda
```

Choose:

```text
employee-api
```

Create the API.

API Gateway will give you an **Invoke URL**, something like:

```text
https://abc123.execute-api.ap-south-1.amazonaws.com
```

Keep this URL.

---

# Step 6 — Create GET `/emps`

In API Gateway:

Go to **Routes**.

Create route:

```text
GET /emps
```

Connect it to:

```text
employee-api
```

Now the API becomes:

```text
GET https://abc123.execute-api.ap-south-1.amazonaws.com/emps
```

Open the URL in a browser.

Expected:

```json
[
    {
        "id": 1,
        "name": "Ravi",
        "salary": 30000
    },
    {
        "id": 2,
        "name": "Kumar",
        "salary": 35000
    }
]
```

---

# Step 7 — Create POST `/emps`

In API Gateway → **Routes**:

Create:

```text
POST /emps
```

Connect it to the same Lambda:

```text
employee-api
```

Now we have:

```text
GET  /emps
POST /emps
```

---

# Step 8 — Test POST

Use Postman.

Method:

```text
POST
```

URL:

```text
https://abc123.execute-api.ap-south-1.amazonaws.com/emps
```

Choose:

```text
Body
→ raw
→ JSON
```

Send:

```json
{
    "name": "Suresh",
    "salary": 40000
}
```

Expected response:

```json
{
    "id": 3,
    "name": "Suresh",
    "salary": 40000
}
```

---

# Step 9 — Test GET Again

Call:

```text
GET /emps
```

Expected:

```json
[
    {
        "id": 1,
        "name": "Ravi",
        "salary": 30000
    },
    {
        "id": 2,
        "name": "Kumar",
        "salary": 35000
    },
    {
        "id": 3,
        "name": "Suresh",
        "salary": 40000
    }
]
```

---

# Student's Final Architecture

```text
                    AWS
                     |
              API Gateway
                     |
             +-------+-------+
             |               |
          GET /emps       POST /emps
             |               |
             +-------+-------+
                     |
                AWS Lambda
              employee-api
                     |
              Employee List
```

### Classroom sequence

I would teach it in **3 small experiments**:

**Experiment 1**

```text
Lambda
   ↓
Test Lambda directly
```

**Experiment 2**

```text
API Gateway
   ↓
GET /emps
```

**Experiment 3**

```text
API Gateway
   ↓
POST /emps
   ↓
GET /emps
```
