## 🔰 **Basic AWS S3 Interview Questions**

### 1. **What is Amazon S3?**

**Answer:**
Amazon S3 (Simple Storage Service) is an object storage service that provides scalable, secure, and highly available storage for data like logs, backups, media files, or artifacts used in CI/CD.

---

### 2. **What are the storage classes in S3?**

**Answer:**

* **S3 Standard** – Frequently accessed data
* **S3 Intelligent-Tiering** – Auto cost-optimized
* **S3 Standard-IA** – Infrequent access
* **S3 One Zone-IA** – Infrequent, single AZ
* **S3 Glacier** – Archival storage
* **S3 Glacier Deep Archive** – Lowest-cost archival

---

### 3. **What is the maximum size of an object in S3?**

**Answer:**

* Up to **5 TB per object**
* Single PUT upload: **5 GB max**
* Use **Multipart Upload** for files > 5 GB

---

### 4. **How does versioning work in S3?**

**Answer:**

* Keeps multiple versions of an object in the same bucket
* Helps in rollback or accidental deletion recovery
* Can be enabled/disabled per bucket

---

## 🚀 **Intermediate S3 with DevOps Context**

### 5. **How do you use S3 in a CI/CD pipeline?**

**Answer:**

* Store build artifacts, config files, deployment packages
* E.g., after building a Java app with GitHub Actions or Jenkins, upload the JAR to S3 for deployment:

```bash
aws s3 cp my-app.jar s3://my-bucket/artifacts/
```

---

### 6. **How do you secure an S3 bucket?**

**Answer:**

* Block public access (recommended for most use cases)
* Use **IAM policies** for fine-grained access
* Apply **Bucket Policies** for shared access
* Use **S3 ACLs** (less common now)
* Enable **encryption** (SSE-S3 or SSE-KMS)

---

### 7. **What is presigned URL in S3?**

**Answer:**
A time-limited URL that allows temporary access to an object without making it public.

Use case: Allow a CI/CD job or user to download/upload without exposing credentials.

```bash
aws s3 presign s3://my-bucket/myfile.zip --expires-in 3600
```

---

### 8. **What is the difference between S3 and EBS?**

**Answer:**

| Feature  | S3                   | EBS                     |
| -------- | -------------------- | ----------------------- |
| Type     | Object storage       | Block storage           |
| Use case | Backups, logs, files | EC2 volumes, DB storage |
| Access   | Via HTTP(S)/CLI/API  | Attached to EC2 only    |

---

### 9. **How can you automate S3 bucket creation with Terraform?**

**Answer:**

```hcl
resource "aws_s3_bucket" "ci_artifacts" {
  bucket = "devops-ci-artifacts"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Environment = "Dev"
    Team        = "DevOps"
  }
}
```

---

### 10. **How do you trigger actions based on S3 uploads?**

**Answer:**
Use **S3 Event Notifications** to trigger:

* **Lambda function**
* **SNS topic**
* **SQS queue**

Example: On object upload, trigger a Lambda that starts a CodeBuild job.

---

## 🔧 **Advanced DevOps + S3 Use Cases**

### 11. **How do you manage static website hosting in S3?**

**Answer:**

* Enable **Static Website Hosting** in S3 bucket
* Upload HTML/CSS/JS files
* Add bucket policy to allow `public-read`
* Optional: Use **Route53** for domain mapping

---

### 12. **What’s the best practice for logging and monitoring S3?**

**Answer:**

* Enable **Server Access Logging**
* Integrate with **CloudTrail** for API-level logs
* Use **AWS Config** for compliance checks
* Send logs to **CloudWatch or S3** for further analysis

---

### 13. **How do you sync local files with S3 bucket?**

**Answer:**

```bash
aws s3 sync ./local-folder s3://my-bucket-name --delete
```

`--delete` will remove files in S3 not present locally (be careful).

---

### 14. **What are common DevOps mistakes with S3 and how to avoid them?**

| Mistake                  | Fix/Best Practice                               |
| ------------------------ | ----------------------------------------------- |
| Public buckets           | Use Block Public Access & IAM                   |
| No versioning            | Enable versioning to avoid data loss            |
| No lifecycle policies    | Use to auto-delete/archive unused objects       |
| Storing secrets          | Never store secrets in S3 (use Secrets Manager) |
| Manual bucket management | Automate with Terraform or CloudFormation       |

---

### 15. **What is S3 Lifecycle Policy?**

**Answer:**

* Automates **transition** (e.g., to Glacier) or **deletion**
* Helps in managing costs for logs/artifacts

```json
"Transitions": [
  {
    "Days": 30,
    "StorageClass": "GLACIER"
  }
]
```

---

## 👨‍💻 Real DevOps Scenario-Based Q

### 16. **Scenario:** You want to deploy static assets after every build. How do you do that with S3?

**Answer:**

* Use a CI tool like GitHub Actions:

```yaml
- name: Upload to S3
  run: aws s3 sync ./dist s3://my-static-site --delete
```

* Invalidate CloudFront cache (if used)

```bash
aws cloudfront create-invalidation --distribution-id XYZ --paths "/*"
```

---

### 17. **Scenario:** How do you restrict access to S3 so that only the CI/CD system can access it?

**Answer:**

* Create IAM policy allowing only `s3:GetObject`, `s3:PutObject`
* Attach to CI/CD role or GitHub OIDC Role
* Add bucket policy with `Condition` using `aws:PrincipalArn`

---
Absolutely! Here's a **DevOps-focused AWS EC2 Interview Q\&A Guide** covering **basic to advanced** concepts with **real-world DevOps use cases**, tailored for interviews:

---

## 🔰 **Basic AWS EC2 Interview Questions**

### 1. **What is Amazon EC2?**

**Answer:**
Amazon EC2 (Elastic Compute Cloud) provides resizable compute capacity in the cloud. You can launch virtual machines (instances), choose OS, attach storage, configure networking, and scale them as needed.

---

### 2. **What are the different EC2 instance types?**

**Answer:**

* **General Purpose:** t4g, t3, m6g – balanced CPU/memory
* **Compute Optimized:** c7g, c6g – high-performance compute
* **Memory Optimized:** r7g, x2idn – for memory-heavy workloads
* **Storage Optimized:** i4i, d3 – for high disk IOPS
* **Accelerated Computing:** p4, inf2 – for GPU/ML workloads

---

### 3. **What is an AMI?**

**Answer:**
AMI (Amazon Machine Image) is a template used to launch EC2 instances. It contains the OS, application server, and applications.

DevOps Use: Create custom AMIs with pre-installed agents/tools (e.g., Docker, Jenkins) using **Packer**.

---

### 4. **What is the difference between EBS and Instance Store?**

| Feature       | EBS                     | Instance Store           |
| ------------- | ----------------------- | ------------------------ |
| Persistence   | Persistent              | Ephemeral (lost on stop) |
| Detach/Attach | Yes                     | No                       |
| Backup        | Snapshot possible       | Not possible             |
| Use Case      | General purpose storage | High-speed temp storage  |

---

### 5. **What are EC2 key pairs?**

**Answer:**
Used to SSH securely into EC2 instances.

* Public key stored on EC2
* Private key kept by user to access the instance

---

## ⚙️ **Intermediate EC2 Questions for DevOps**

### 6. **How do you automate EC2 provisioning in DevOps?**

**Answer:**

* **Terraform** (IaC):

```hcl
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  tags = {
    Name = "WebServer"
  }
}
```

* **Ansible** or **user\_data** for provisioning tools

---

### 7. **How do you secure EC2 instances?**

**Answer:**

* Use **Security Groups** (virtual firewalls)
* Disable root login, use non-root user
* Restrict SSH access (e.g., only from jump host or specific IP)
* Patch OS with automation
* Enable VPC flow logs + CloudTrail for monitoring
* Use IAM roles instead of hardcoded AWS keys

---

### 8. **How do you monitor EC2 performance?**

**Answer:**

* Use **CloudWatch metrics** (CPU, memory via agent, disk)
* Set alarms for scaling or failure notifications
* Integrate with **Grafana/Prometheus** via CloudWatch exporter
* Log to **CloudWatch Logs** or **Splunk/OpenTelemetry**

---

### 9. **What is user data in EC2?**

**Answer:**
User data is a shell script or cloud-init directives that run **once** at instance launch.
Use case: Install software like Docker or start a service automatically.

Example:

```bash
#!/bin/bash
apt update
apt install -y nginx
```

---

### 10. **What is the difference between stopping and terminating an EC2 instance?**

* **Stop:** Halts the instance (data remains on EBS)
* **Terminate:** Deletes the instance and associated volumes (unless configured otherwise)

---

## 🔄 **Advanced EC2 + DevOps Scenarios**

### 11. **How do you scale EC2 instances automatically?**

**Answer:**
Use **Auto Scaling Group (ASG)**:

* Define Launch Template (AMI + instance type)
* Attach to a target group/load balancer
* Define scaling policies based on CPU or custom metrics

---

### 12. **What is the difference between a Security Group and NACL in EC2?**

| Feature     | Security Group    | Network ACL        |
| ----------- | ----------------- | ------------------ |
| Type        | Stateful firewall | Stateless firewall |
| Attached To | ENI/Instance      | Subnet             |
| Rules       | Allow only        | Allow and Deny     |

---

### 13. **How do you create a golden image of an EC2 instance?**

**Answer:**

* Install/configure software on an EC2
* Stop instance
* Create an **AMI**
* Use this AMI for launching other instances (e.g., in ASG)

---

### 14. **How do you connect EC2 from your local machine securely?**

**Answer:**

```bash
ssh -i my-key.pem ec2-user@public-ip
```

* Ensure Security Group allows inbound SSH
* Keep the `.pem` file permissions strict (`chmod 400 my-key.pem`)

---

### 15. **What’s the role of EC2 IAM roles in DevOps?**

**Answer:**

* Grant EC2 instances permissions to access other AWS services (S3, CloudWatch, etc.)
* **No need for hardcoded AWS credentials**
* Use-case: Jenkins EC2 instance uploading logs to S3

---

## 🧠 **DevOps Scenario-Based EC2 Q\&A**

### 16. **Scenario: Jenkins is deployed on EC2, how will you handle patching and restarts without disrupting builds?**

**Answer:**

* Use **Amazon Systems Manager (SSM)** for patching
* Schedule maintenance using a cron in off hours
* Use **EBS-backed Jenkins home directory** to retain data
* Use **EC2 lifecycle hooks** if part of ASG

---

### 17. **Scenario: You have multiple EC2 environments (dev, staging, prod). How do you manage them efficiently?**

**Answer:**

* Use **Terraform workspaces** or **tags**
* Define `dev.tfvars`, `prod.tfvars`
* Manage access via IAM policies
* Use **SSM Parameter Store** for environment-specific configs

---

### 18. **Scenario: Your EC2 is not reachable via SSH. What do you check?**

**Checklist:**

* Is EC2 running?
* Is the **Security Group** allowing port 22?
* Is **NACL** blocking traffic?
* Is the **key pair** correct?
* Use **EC2 Serial Console** or **SSM Session Manager** for troubleshooting

---

## 🛠️ Useful EC2 CLI Commands

```bash
# Launch EC2
aws ec2 run-instances --image-id ami-xyz --count 1 --instance-type t3.micro --key-name MyKey --security-groups MySG

# List instances
aws ec2 describe-instances

# Stop instance
aws ec2 stop-instances --instance-ids i-1234567890abcdef0

# Create AMI
aws ec2 create-image --instance-id i-123 --name "MyImage"

# Attach IAM Role
aws ec2 associate-iam-instance-profile --instance-id i-123 --iam-instance-profile Name=MyRole
```

---
Great! Here's a **DevOps-focused AWS VPC (Virtual Private Cloud) Interview Q\&A Guide**, with **basic to advanced questions**, real-world **DevOps use cases**, and key **troubleshooting and design scenarios** you must know for interviews.

---

## 🔰 **Basic AWS VPC Interview Questions**

### 1. **What is a VPC in AWS?**

**Answer:**
A VPC (Virtual Private Cloud) is a **logically isolated network** in AWS where you can launch AWS resources like EC2, RDS, etc., and define IP ranges, subnets, route tables, gateways, and firewalls (SG/NACL).

---

### 2. **What are the main components of a VPC?**

**Answer:**

* **CIDR Block** (IP range like `10.0.0.0/16`)
* **Subnets** (Public or Private)
* **Route Tables**
* **Internet Gateway (IGW)**
* **NAT Gateway**
* **Security Groups & NACLs**
* **VPC Peering / Transit Gateway**

---

### 3. **What is the difference between Public and Private subnets?**

**Answer:**

| Public Subnet                    | Private Subnet                 |
| -------------------------------- | ------------------------------ |
| Has a route to IGW               | No direct route to IGW         |
| EC2 can be reached via public IP | EC2 has only private IP        |
| Use-case: Web/App servers        | Use-case: DB, backend services |

---

### 4. **What is an Internet Gateway (IGW)?**

**Answer:**
A horizontally scaled, redundant, and highly available VPC component that **allows communication between instances and the internet**.

---

### 5. **What is a NAT Gateway and why is it used?**

**Answer:**
Used in **Private Subnets** to **allow outgoing internet access** (e.g., for `yum update`, downloading packages) without exposing private IPs publicly.

---

## ⚙️ **Intermediate VPC Concepts for DevOps**

### 6. **How do Security Groups differ from NACLs?**

| Feature  | Security Group      | Network ACL                  |
| -------- | ------------------- | ---------------------------- |
| Stateful | Yes                 | No                           |
| Level    | Instance            | Subnet                       |
| Rules    | Allow only          | Allow & Deny both            |
| Use case | App-specific access | General subnet-level control |

---

### 7. **What are typical CIDR blocks used in VPCs?**

**Answer:**
VPC CIDR: `10.0.0.0/16`,
Subnets: `10.0.1.0/24`, `10.0.2.0/24`, etc.
(Always plan for subnetting ahead)

---

### 8. **How do you automate VPC creation using Terraform?**

**Answer:**

```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "dev-vpc" }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
}
```

---

### 9. **How do route tables work in a VPC?**

**Answer:**

* Route tables control **traffic flow** within and outside the VPC
* Public Subnet Route Table:

```text
0.0.0.0/0 -> IGW
```

* Private Subnet Route Table:

```text
0.0.0.0/0 -> NAT Gateway
```

---

### 10. **How do you connect multiple VPCs?**

**Answer:**

* **VPC Peering** (1-to-1, manual routes)
* **Transit Gateway** (Hub-and-spoke model, scalable)
* Ensure route tables and security groups allow communication

---

## 🔧 **Advanced VPC DevOps Scenarios**

### 11. **Scenario: Jenkins in a private subnet can't reach GitHub. What’s wrong?**

**Possible Issues:**

* No **NAT Gateway** in the public subnet
* No route in private subnet’s route table to NAT
* Security group or NACL blocking outbound HTTP/HTTPS
* Jenkins server has no internet access method

---

### 12. **How do you restrict SSH access to a private EC2?**

**Answer:**

* Use **Bastion Host** in a public subnet
* SSH into Bastion, then SSH into private EC2
* Or use **SSM Session Manager** (recommended, no SSH/key required)

---

### 13. **How do you secure VPCs in production?**

**Answer:**

* Split workloads into **public/private subnets**
* Use **NACLs and SGs** for tight access control
* Use **Flow Logs** to monitor traffic
* Apply **IAM roles**, **KMS encryption**, and **TLS** for secure communication
* Limit **0.0.0.0/0** access

---

### 14. **How do VPC Flow Logs help in troubleshooting?**

**Answer:**

* Capture **network traffic metadata** (source/destination IP, port, protocol)
* Helps in analyzing failed connections, security breaches
* Logs can be sent to **CloudWatch Logs** or **S3**

---

### 15. **How do you connect on-prem data centers to AWS VPC?**

**Options:**

* **VPN Connection** (IPsec over Internet)
* **AWS Direct Connect** (dedicated fiber)
* Use **Customer Gateway (CGW)** + **Virtual Private Gateway (VGW)**

---

## 📘 Real-World DevOps VPC Q\&A

### 16. **Scenario: Your application is accessible inside the VPC but not from the internet. What do you check?**

**Checklist:**

* Is the instance in a **public subnet** with route to IGW?
* Does it have a **public IP** or **Elastic IP**?
* Is **SG allowing inbound** from 0.0.0.0/0 (port 80/443)?
* Is NACL blocking traffic?

---

### 17. **What is the difference between Default VPC and Custom VPC?**

| Feature         | Default VPC          | Custom VPC           |
| --------------- | -------------------- | -------------------- |
| Created by AWS  | Yes                  | No, created manually |
| Internet access | Enabled by default   | Needs manual config  |
| Subnets         | One per AZ (default) | Fully configurable   |

---

### 18. **How does DNS resolution work in VPC?**

**Answer:**

* AWS provides internal DNS resolver
* EC2 instances get internal DNS by default
* Use Route53 + VPC + Private Hosted Zones for internal name resolution

---

### 19. **How do you enable inter-region VPC connectivity?**

**Answer:**

* Use **VPC Peering (inter-region)** or
* **Transit Gateway with inter-region peering**

---

### 20. **Terraform example: complete VPC setup with subnets and IGW**

```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "devops-vpc"
  cidr    = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  tags = {
    Environment = "Dev"
  }
}
```

---


