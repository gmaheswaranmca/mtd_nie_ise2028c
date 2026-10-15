# AWS Lambda API – GET `/emps` and POST `/emps`

## Part 1 — Create Lambda Function

### Step 1
Login to **AWS Management Console**.

### Step 2
Search for **Lambda**.

### Step 3
Click **Lambda**.

### Step 4
Click **Create function**.

### Step 5
Select:

```text
Author from scratch
```

### Step 6
Enter:

```text
Function name: employee-api
Runtime: Python 3.13
Architecture: x86_64
```

### Step 7
Leave everything else as default.

### Step 8
Click **Create function**.

---

# Part 2 — Write Lambda Code

### Step 9
In the Lambda function page, find:

```text
Code
```

### Step 10
Open:

```text
lambda_function.py
```

### Step 11
Delete the existing code.

### Step 12
Enter this code:

```python
import json

employees = [
    {"id": 1, "name": "Ravi", "salary": 30000},
    {"id": 2, "name": "Kumar", "salary": 35000}
]


def lambda_handler(event, context):

    method = event["requestContext"]["http"]["method"]

    # GET /emps
    if method == "GET":

        return {
            "statusCode": 200,
            "body": json.dumps(employees)
        }

    # POST /emps
    if method == "POST":

        data = json.loads(event["body"])

        employee = {
            "id": len(employees) + 1,
            "name": data["name"],
            "salary": data["salary"]
        }

        employees.append(employee)

        return {
            "statusCode": 201,
            "body": json.dumps(employee)
        }

    return {
        "statusCode": 405,
        "body": json.dumps({
            "message": "Method not allowed"
        })
    }
```

### Step 13
Click **Deploy**.

---

# Part 3 — Test Lambda

### Step 14
Click **Test**.

### Step 15
Click **Create new event**.

### Step 16
Enter event name:

```text
test-get
```

### Step 17
Select/use the JSON editor.

Enter:

```json
{
  "requestContext": {
    "http": {
      "method": "GET"
    }
  }
}
```

### Step 18
Click **Save**.

### Step 19
Click **Test**.

### Step 20
Check the response.

You should get:

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

# Part 4 — Create API Gateway

### Step 21
Search for:

```text
API Gateway
```

### Step 22
Open **API Gateway**.

### Step 23
Click:

```text
Create API
```

### Step 24
Find:

```text
HTTP API
```

### Step 25
Click:

```text
Build
```

---

# Part 5 — Connect Lambda

### Step 26
For **Integration**, select:

```text
Lambda
```

### Step 27
Select:

```text
employee-api
```

### Step 28
For the API name, enter:

```text
employee-http-api
```

### Step 29
Click **Next**.

---

# Part 6 — Create GET `/emps`

### Step 30
For the route, select:

```text
GET
```

### Step 31
Enter path:

```text
/emps
```

So the route is:

```text
GET /emps
```

### Step 32
Make sure integration is:

```text
employee-api
```

### Step 33
Click **Next**.

---

# Part 7 — Create POST `/emps`

### Step 34
Add another route.

Select:

```text
POST
```

### Step 35
Enter:

```text
/emps
```

So the route is:

```text
POST /emps
```

### Step 36
Select Lambda:

```text
employee-api
```

### Step 37
Create the API.

---

# Part 8 — Get API URL

### Step 38
Open your API Gateway API.

### Step 39
Find:

```text
Invoke URL
```

It will look similar to:

```text
https://abc123.execute-api.ap-south-1.amazonaws.com
```

Copy it.

---

# Part 9 — Test GET

### Step 40
Add `/emps` to the URL:

```text
https://abc123.execute-api.ap-south-1.amazonaws.com/emps
```

### Step 41
Open it in a browser.

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

✅ **GET API works.**

---

# Part 10 — Test POST

### Step 42
Open **Postman**.

### Step 43
Select:

```text
POST
```

### Step 44
Enter:

```text
https://abc123.execute-api.ap-south-1.amazonaws.com/emps
```

### Step 45
Select:

```text
Body
→ raw
→ JSON
```

### Step 46
Enter:

```json
{
    "name": "Suresh",
    "salary": 40000
}
```

### Step 47
Click **Send**.

Expected:

```json
{
    "id": 3,
    "name": "Suresh",
    "salary": 40000
}
```

✅ **POST API works.**

---

# Part 11 — Test GET Again

### Step 48
Open browser again:

```text
https://abc123.execute-api.ap-south-1.amazonaws.com/emps
```

### Step 49
Check whether Suresh appears.

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

# Part 12 — Cleanup

### Step 50
Go to **API Gateway**.

Delete:

```text
employee-http-api
```

### Step 51
Go to **Lambda**.

Delete:

```text
employee-api
```

### Step 52
Check AWS resources once more before finishing the lab.

---

# 🧠 10-Second Memory

Students only need to remember:

```text
1. Lambda
      ↓
2. Write Python
      ↓
3. Test Lambda
      ↓
4. API Gateway
      ↓
5. GET /emps
      ↓
6. POST /emps
      ↓
7. Test with Browser/Postman
      ↓
8. Cleanup
```

And the **two APIs**:

```text
GET  /emps  → Get employees

POST /emps  → Add employee
```
