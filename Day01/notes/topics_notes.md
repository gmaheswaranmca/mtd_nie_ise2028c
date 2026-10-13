# What is Cloud Computing ? 

Cloud computing is the delivery of computing resources such as servers, storage, databases, and software over the internet on demand, usually on a pay-as-you-go basis.


### Traditional IT vs Cloud Computing

| Traditional IT                        | Cloud computing                                 |
| ------------------------------------- | ----------------------------------------------- |
| Purchase physical servers             | Provision virtual servers                       |
| High initial investment               | Lower initial investment                        |
| Capacity planning required in advance | Capacity can be adjusted                        |
| Hardware maintenance by organization  | Cloud provider manages underlying hardware      |
| Scaling may take days or weeks        | Scaling can be much faster                      |
| Fixed capacity can remain unused      | Resources can be released when no longer needed |

Example: An e-commerce company needs more computing capacity during a festival sale. Instead of purchasing additional physical servers, it can provision more cloud resources and reduce capacity afterward.

# IaaS, PaaS and SaaS 
- IaaS (Infrastructure as a Service): Provides virtual servers, storage, and networking. Example: AWS EC2. The cloud provider manages the physical hardware and virtualization infrastructure, while the customer manages the operating system, installed software and applications. Customer manages `Application · Data · Runtime · Operating System`. Cloud provider manages `Virtualization · Physical Servers · Storage Hardware · Networking Hardware`

- PaaS (Platform as a Service): Provides a managed platform to develop and deploy applications. Example: AWS Elastic Beanstalk. The provider manages more of the infrastructure and software environment than in IaaS. Customers generally focus on application code, data and application configuration. Customer manages `Application Code · Data · Application Configuration`. Cloud provider manages `Platform Runtime · Operating Environment · Servers · Infrastructure`
 
- SaaS (Software as a Service): Provides ready-to-use software over the internet. Example: Gmail. The provider manages the application, runtime, operating system, servers and underlying infrastructure. Customers generally use the software and configure its available settings. Customer manages `Application Code · Data · Application Configuration`. Cloud provider manages `Platform Runtime · Operating Environment · Servers · Infrastructure`.

## Comparison of IaaS, PaaS and SaaS

| Feature           | IaaS                             | PaaS                                 | SaaS                                                              |
| ----------------- | -------------------------------- | ------------------------------------ | ----------------------------------------------------------------- |
| Full form         | Infrastructure as a Service      | Platform as a Service                | Software as a Service                                             |
| Provides          | Virtual infrastructure           | Managed application platform         | Ready-to-use software                                             |
| Customer control  | High                             | Moderate                             | Limited                                                           |
| Server management | Customer manages OS and software | Provider manages underlying platform | Provider manages application infrastructure                       |
| Main user         | IT administrators and developers | Application developers               | End users and businesses                                          |
| AWS example       | Amazon EC2                       | AWS Elastic Beanstalk                | Amazon QuickSight, as a managed business intelligence application |
| Typical task      | Configure a virtual server       | Deploy application code              | Use an online application                                         |

## Easy way to remember

Imagine you want to run a restaurant:

- IaaS: You rent the building and equipment, then arrange and manage the kitchen yourself.
- PaaS: You get a managed kitchen platform and focus on preparing your menu.
- SaaS: You order ready-made food and simply use the service.

The key difference is the level of management and control.

Exam summary: IaaS provides infrastructure, PaaS provides a platform for application development and deployment, and SaaS provides ready-to-use software. As you move from IaaS to SaaS, the provider generally manages more of the technology stack, while the customer manages less of the underlying infrastructure.



# Public, Private and Hybrid Cloud

## Public cloud

Infrastructure and services are offered by a cloud provider to multiple customers, with appropriate logical isolation.

Examples: AWS, Microsoft Azure and Google Cloud.

Advantages: Scalability, broad service selection and reduced hardware maintenance.

## Private cloud

Cloud infrastructure dedicated to one organization, whether hosted internally or by a service provider.

Advantages: Greater control over the environment and customization.

Limitations: Potentially higher cost, operational complexity and maintenance responsibilities.

## Hybrid cloud

Combines private infrastructure with public cloud services, allowing workloads or data to be distributed between them.

Example: A bank retains certain sensitive systems in its private environment while using AWS for web applications or additional computing capacity.

| Model   | Infrastructure use                     | Example scenario                                     |
| ------- | -------------------------------------- | ---------------------------------------------------- |
| Public  | Provider's shared cloud infrastructure | Startup hosting a web application on AWS             |
| Private | Dedicated organizational environment   | Organization with specialized control requirements   |
| Hybrid  | Private environment plus public cloud  | Company integrating an existing data centre with AWS |

Do not confuse public cloud with public access to data. Resources in public clouds can be private and securely restricted.

# AWS Global Infrastructure

Amazon Web Services (AWS) is a cloud computing platform that provides services for computing, storage, databases, networking, security, analytics, AI and more.

AWS operates infrastructure across multiple geographic locations to support performance, fault tolerance and disaster recovery.

The key infrastructure concepts are:

- Region: A separate geographic area containing AWS infrastructure.
- Availability Zone (AZ): An isolated location within a Region, consisting of one or more data centres.
- Data centre: A physical facility containing servers, storage and networking equipment.
- Edge location: A location used by services such as Amazon CloudFront to deliver content closer to users.


### Why does global infrastructure matter?

1. Low latency: Deploy applications closer to their users.
2. High availability: Distribute workloads across Availability Zones.
3. Disaster recovery: Maintain recovery resources in another AZ or Region.
4. Data residency: Choose locations appropriate for regulatory and organizational requirements.

### Example

Suppose a company serves customers in India.

It may deploy its application in an Indian AWS Region to reduce latency for local customers. It can distribute application servers across multiple Availability Zones so that a failure in one zone does not necessarily bring down the entire application.

# AWS Regions and Availability Zones

### AWS Region

A Region is a geographic area containing multiple Availability Zones.

Each Region is designed to be independent of other Regions, although some AWS services and operations are global or span Regions.

Examples of AWS Regions in India include:

| Region                   | Region code  |
| ------------------------ | ------------ |
| Asia Pacific (Mumbai)    | `ap-south-1` |
| Asia Pacific (Hyderabad) | `ap-south-2` |

Region selection affects service availability, latency, compliance considerations and pricing.

### Availability Zone

An Availability Zone is an isolated infrastructure location within a Region. Multiple AZs are designed to reduce the impact of failures affecting one location.

Example architecture:

AWS Region — Mumbai

Availability Zone A

Application server

Availability Zone B

Application server

Two AZs can support a more resilient design when the application and its dependencies are configured appropriately.

### Region vs Availability Zone

| Region                                                 | Availability Zone                               |
| ------------------------------------------------------ | ----------------------------------------------- |
| Geographic area                                        | Isolated location within a Region               |
| Contains multiple AZs                                  | Belongs to one Region                           |
| Useful for geographic deployment and disaster recovery | Useful for high availability within a Region    |
| Example: `ap-south-1`                                  | Example: an AZ identifier such as `ap-south-1a` |

Important: AZ letter mappings can differ between AWS accounts. Do not assume that `ap-south-1a` represents the same physical zone in every account.

# AWS Management Console

The AWS Management Console is a browser-based interface for accessing and managing AWS services.

Students can use it to create resources, configure security, monitor usage and view billing information.

### Main console components

1. Services menu: Browse AWS services.
2. Search bar: Find services such as EC2, S3 and IAM.
3. Region selector: Choose the Region for regional resources.
4. Account menu: Access account details and settings.
5. Recently visited: Return to previously accessed services.
6. Favorites: Pin frequently used services.
7. Notifications: View account and service notifications.
8. Billing and Cost Management: Monitor usage and costs.

### Practical exercise

To do:

1. Sign in to the AWS Management Console.
2. Identify the account menu and account ID.
3. Locate the Region selector and choose their training Region.
4. Search for IAM and open the service.
5. Return to Console Home.
6. Search for EC2, but do not launch an instance yet.
7. Locate Billing and Cost Management.
8. Find the available credit and usage information, if displayed.

Safety rule: Creating an AWS account or selecting a Region does not automatically mean every service is free. Always verify the pricing and current Free Tier eligibility before provisioning resources.

# AWS IAM — Users, Groups, Roles and Policies

IAM stands for Identity and Access Management. It controls authentication and authorization for access to AWS resources.

- Authentication: Who are you?
- Authorization: What are you allowed to do?

IAM allows administrators to grant permissions according to job responsibilities and security requirements.

### IAM User

An IAM user is an identity within an AWS account that can have permissions assigned to it.

Example: An administrator creates a user for a developer who needs access to a specific S3 bucket.

### IAM Group

A group is a collection of IAM users. Permissions can be assigned to the group so that its users receive those permissions.

Example: A `Developers` group receives permission to view selected development resources.

### IAM Role

A role is an identity with permissions that can be assumed by an authorized principal. It provides temporary credentials when assumed.

Examples:

- An EC2 instance assumes a role to access an S3 bucket.
- A user from another AWS account assumes a role to access authorized resources.

### IAM Policy

A policy is a document, commonly written in JSON, that specifies permissions.

A policy can define:

- Effect: `Allow` or `Deny`.
- Action: The operation, such as `s3:GetObject`.
- Resource: The AWS resource to which the permission applies.
- Condition: Optional conditions under which the permission applies.

Example policy structure:

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::training-bucket"
    }
  ]
}
```

This example permits listing the contents of the specified bucket, subject to other applicable authorization controls. It does not grant permission to upload or delete objects.

### IAM components comparison

| Component | Purpose                        | Example              |
| --------- | ------------------------------ | -------------------- |
| User      | Represents an identity         | Developer            |
| Group     | Organizes users                | Developers           |
| Role      | Provides assumable permissions | EC2 application role |
| Policy    | Defines permissions            | Read-only S3 policy  |

### Best practices for IAM

1. Apply the principle of least privilege.
2. Prefer federation or IAM Identity Center for workforce access where appropriate.
3. Use IAM roles for applications running on AWS instead of embedding long-term access keys.
4. Enable MFA for privileged identities.
5. Avoid using the root user for routine administration.
6. Review permissions regularly.
7. Never share access keys, passwords or session credentials.

Trainer note: For a newly created AWS account, explain the difference between the root user and IAM identities before asking students to create users or roles. Avoid granting AdministratorAccess simply for convenience.

##  Amazon EC2 — Introduction and Instance Types

Amazon EC2 (Elastic Compute Cloud) is an AWS service that provides resizable virtual servers called instances.

Developers and administrators use EC2 to run web applications, APIs, databases, development environments and other workloads.

### Common EC2 use cases

- Hosting a website.
- Running a Java Spring Boot or Python FastAPI application.
- Deploying a Node.js backend.
- Performing development and testing.
- Running batch-processing workloads.

### EC2 instance components

An EC2 instance is configured with several resources:

- Virtual CPUs (vCPUs).
- Memory (RAM).
- Storage.
- Network capacity.
- Operating system image.
- Security and access settings.

### EC2 instance families

| Family                       | Purpose                              | Example workload                               |
| ---------------------------- | ------------------------------------ | ---------------------------------------------- |
| General purpose — M, T       | Balanced CPU and memory              | Web servers, development                       |
| Compute optimized — C        | High CPU performance                 | Scientific computing, CPU-intensive processing |
| Memory optimized — R, X      | Large memory capacity                | In-memory databases, analytics                 |
| Storage optimized — I, D     | High storage performance or capacity | Data-intensive applications                    |
| Accelerated computing — P, G | GPU or other accelerators            | Machine learning, graphics                     |

Examples include `t3.micro`, `t3.small` and `m7i.large`. Availability, specifications and pricing vary by Region.

### What does `t3.micro` mean?

- `t`: Instance family.
- `3`: Generation.
- `micro`: Instance size.

Smaller instances generally provide fewer resources than larger sizes within the same family, although the exact specifications depend on the family.

### EC2 lifecycle

Launch instance

Pending

Running

Stop or terminate

- Stop: Shuts down a supported instance while retaining its attached EBS volumes. Some associated resources may still incur charges.
- Terminate: Permanently ends the instance. Attached storage and other resources may have separate deletion settings and charges.
- Reboot: Restarts the instance.

Cost warning: Stopping an instance does not necessarily eliminate all charges. Storage volumes, snapshots, public IPv4 addresses and other associated resources may incur charges. Check current pricing before launching an instance.

# AMI, Key Pair and Security Groups

These are three important concepts students should understand before launching an EC2 instance.

###  AMI — Amazon Machine Image

An AMI is a template used to launch EC2 instances. It contains the information required to create an instance, including an operating system and, optionally, preinstalled software and configuration.

Examples:

- Amazon Linux.
- Ubuntu Server.
- Microsoft Windows Server.

Example: If a student needs an Ubuntu virtual server, they select a suitable Ubuntu AMI when launching the instance.

### Key Pair

A key pair provides credentials for connecting securely to supported EC2 operating systems.

It consists of:

- Public key: Installed or associated with the instance for authentication.
- Private key: Retained securely by the user and used by the client to authenticate.

For Linux instances, SSH commonly uses the private key. Windows connection workflows may use the key pair to retrieve an initial administrator password, depending on the image and configuration.

Example SSH command for a Linux instance:

```
ssh -i student-key.pem ubuntu@<public-ip-address>
```

Replace the placeholders with the actual private-key file path and instance public IP address. The default username depends on the selected AMI.

Security rules:

- Never share the private key.
- Store it securely.
- Restrict file permissions as required by your SSH client.
- Do not upload private keys to GitHub.
- If the private key is lost, recovery depends on the instance configuration and access methods available.

### 9.3 Security Group

A security group acts as a virtual firewall for supported AWS resources, including EC2 instances.

It controls inbound and outbound network traffic through rules.

| Rule       | Example  | Purpose                       |
| ---------- | -------- | ----------------------------- |
| SSH        | TCP 22   | Linux remote administration   |
| RDP        | TCP 3389 | Windows remote administration |
| HTTP       | TCP 80   | Web traffic                   |
| HTTPS      | TCP 443  | Encrypted web traffic         |
| Custom TCP | TCP 8000 | Example development API       |

For example, a FastAPI application might listen on port 8000. To access it remotely, the application must listen on the appropriate interface and the network path and security rules must permit the traffic.

Important security practices:

- Do not expose SSH or RDP to the entire internet unless there is a justified need.
- Restrict administrative access to trusted IP addresses or use safer access methods.
- Open only the required ports.
- A security group allows traffic; it does not install or start the application.
- Security groups are stateful: response traffic for permitted connections is automatically allowed.

## Day 1 — Practical learning outcomes

By the end of the session, students should be able to:

1. Explain cloud computing and its major benefits.
2. Differentiate IaaS, PaaS and SaaS.
3. Compare public, private and hybrid cloud.
4. Explain AWS Regions and Availability Zones.
5. Navigate the AWS Management Console.
6. Differentiate IAM users, groups, roles and policies.
7. Explain the purpose of EC2 and common instance families.
8. Describe AMIs, key pairs and security groups.
9. Identify basic AWS security practices and billing risks.

Suggested practical sequence: Explore the console → inspect IAM → examine EC2 instance types → identify AMIs, key pairs and security groups. Avoid launching resources until students understand the permissions, networking and potential costs involved.