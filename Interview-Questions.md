## **🔹 Schneider Electric – IQA Interview Questions and Answers**

### ✅ **1. Complex issue you have resolved during Kubernetes deployment as DevOps**

**Answer:**
One complex issue I resolved was related to **pod restarts due to out-of-memory (OOM) issues** in a production deployment. The root cause was misconfigured resource limits in the deployment YAML. I used:

* `kubectl top` and `metrics-server` to monitor usage.
* `kubectl logs` and Splunk to inspect container errors.
* Updated `resources.limits` and `requests`.
* Added proper `livenessProbe` and `readinessProbe`.
* Finally, enabled **Horizontal Pod Autoscaler (HPA)** to handle load spikes.

This ensured app stability and improved reliability of the deployment.

---

### ✅ **2. GitHub Actions: Build and deployment steps – how to ensure deployment runs only if build succeeds?**

**Answer:**
In GitHub Actions, I use the `needs:` keyword to create job dependencies. Here’s a minimal example:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build Docker Image
        run: docker build -t myapp:latest .

  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to K8s
        run: kubectl apply -f k8s/
```

This ensures the **deploy job runs only if the build job is successful**.

---

### ✅ **3. How is the Docker base image getting pulled and from where?**

**Answer:**
The base image specified in the Dockerfile (e.g., `FROM node:18-alpine`) is pulled from a **Docker registry**—by default, this is **Docker Hub**.

If a private registry is used (e.g., `myregistry.example.com/custom-base`), Docker will authenticate using credentials (often stored in CI/CD secrets or `~/.docker/config.json`).

---

### ✅ **4. Shell Script: Copy files with prefix to another folder**

**Answer:**

```bash
#!/bin/bash

# Create folders
mkdir -p /tmp/source_folder
mkdir -p /tmp/target_folder

# Create text files
echo "file 1" > /tmp/source_folder/file1.txt
echo "file 2" > /tmp/source_folder/file2.txt
echo "file 3" > /tmp/source_folder/file3.txt

# Add prefix and copy
for file in /tmp/source_folder/*.txt; do
  base=$(basename "$file")
  cp "$file" "/tmp/target_folder/copied_$base"
done

echo "Files copied with prefix."
```

✅ Result:

* Files in `/tmp/target_folder`: `copied_file1.txt`, `copied_file2.txt`, `copied_file3.txt`

---

## 🔹 **DevOps Engineer Interview – Common Questions and Answers**

---

### ✅ **1. What does your day-to-day look like as a DevOps Engineer?**

**Answer:**

As a DevOps Engineer, my daily routine is a mix of **automation, monitoring, collaboration, and incident response**. Here’s what a typical day looks like:

#### 🔹 Mornings:

* Check **CI/CD pipelines** for any failed builds or deployments.
* Monitor **Slack/Teams alerts** or dashboard metrics.
* Participate in **stand-up meetings** with developers, QA, and product teams.

#### 🔹 Midday:

* Work on **infrastructure as code** using tools like Terraform or CloudFormation.
* Enhance or troubleshoot **CI/CD workflows** (GitHub Actions, Jenkins, GitLab).
* Perform container-related tasks like **Kubernetes rollout, Helm upgrades**, or **Docker image optimization**.

#### 🔹 Afternoons:

* Review and merge PRs related to infrastructure/configuration changes.
* Monitor **application and infrastructure health** using dashboards.
* Apply security patches, audit secrets, rotate credentials if required.

#### 🔹 End of day:

* Prepare or schedule **deployment jobs** for off-peak hours.
* Document system updates and any learnings in the team’s knowledge base.
* Update Jira/Asana tasks and assist developers with environment issues.

---

### ✅ **2. What are the common monitoring dashboards you check daily?**

**Answer:**

I actively monitor a mix of **infrastructure**, **application**, and **security** dashboards. Some common ones include:

#### 📊 **Infrastructure Monitoring (Grafana + Prometheus):**

* Node resource usage (CPU, memory, disk)
* Kubernetes pod health and restarts
* Cluster autoscaler performance

#### ⚙️ **Application Monitoring (Datadog / New Relic / SignalFx):**

* API response times, error rates, and request throughput
* Application-level alerts and SLAs
* Service dependencies and transaction traces

#### 📉 **Log Monitoring (ELK Stack / Splunk / Loki):**

* Application logs for failures, exceptions
* Deployment logs to trace build/deploy history
* Auth and access logs for anomaly detection

#### 🔐 **Security Monitoring (Falco / GuardDuty / Sysdig):**

* Suspicious container behavior or privilege escalation
* IAM policy violations or misconfigurations
* Network-level anomalies (unusual ingress/egress)

I also set up **alerting** to notify via Slack, PagerDuty, or Opsgenie.

---

### ✅ **3. Why are you still using Perforce when modern SCMs like Git are available?**

**Answer:**

We still use **Perforce (Helix Core)** for a few valid reasons, even though Git is used in parallel for modern projects:

#### ✅ Reasons for using Perforce:

1. **Handles Large Files Well:**

   * Ideal for environments with large binaries, media files, firmware, or CAD files.

2. **Centralized Control:**

   * Provides stronger access control and auditability, important in regulated industries.

3. **Legacy Codebase:**

   * Existing systems and tools are already deeply integrated with Perforce.
   * Migration would involve significant time, testing, and potential risk.

4. **File Locking:**

   * Supports exclusive checkout and file locking — essential for binary artifacts where merge conflicts aren't possible.

5. **Used by Multi-Disciplinary Teams:**

   * Hardware, embedded, and system engineers often prefer Perforce for non-source-code assets.

That said, **Git is used for newer microservices and cloud-native projects**, and both systems are managed side-by-side.

---

## 🔹 **Persistence Systems – DevOps Interview Questions and Answers**

---

### 🔧 **Kubernetes (K8s)**

#### **1. How many types of autoscaling are available in Kubernetes?**

**Answer:**
Kubernetes supports **three types of autoscaling**:

* **Horizontal Pod Autoscaler (HPA):** Scales the number of pod replicas based on CPU/memory or custom metrics.
* **Vertical Pod Autoscaler (VPA):** Adjusts resource requests/limits (CPU, memory) of running pods.
* **Cluster Autoscaler:** Automatically adjusts the number of nodes in the cluster based on pending pods.

---

#### **2. What are the different ways to create a Kubernetes cluster?**

**Answer:**
You can create a Kubernetes cluster using:

* **kubeadm:** Manual setup for custom clusters.
* **Minikube/KIND:** Local development/testing.
* **Cloud-managed services:**

  * AWS EKS (Elastic Kubernetes Service)
  * Azure AKS
  * Google GKE
* **Terraform or Ansible:** Infrastructure as Code approach.

---

#### **3. How can you identify the pod with the highest CPU usage using Prometheus?**

**Answer:**
You can use the following Prometheus query:

```promql
topk(1, rate(container_cpu_usage_seconds_total{image!=""}[5m]))
```

This shows the pod/container with the highest CPU usage in the last 5 minutes.

---

### ☁️ **AWS (EC2, S3, CloudFormation, VPC)**

#### **4. What is AWS CloudFormation?**

**Answer:**
AWS CloudFormation is an **Infrastructure as Code (IaC)** service that helps you **provision and manage AWS resources** using YAML/JSON templates. It automates infrastructure setup, ensures consistency, and supports versioning.

---

#### **5. You launched an EC2 instance in a private subnet. How do you provide internet access to it?**

**Answer:**
To give internet access to an EC2 instance in a **private subnet**:

* Create a **NAT Gateway** in a **public subnet**.
* Update the **route table** of the private subnet to route `0.0.0.0/0` traffic to the NAT Gateway.
* Ensure the EC2 instance has a private IP and security group allows outbound traffic.

---

#### **6. What is Amazon S3 and what are the types of storage classes?**

**Answer:**
Amazon S3 is an object storage service used for storing and retrieving any amount of data.

**S3 Storage Classes:**

* **Standard:** Frequent access, low latency.
* **Intelligent-Tiering:** Automatically moves objects between frequent/infrequent tiers.
* **Standard-IA (Infrequent Access):** Less frequently accessed data.
* **One Zone-IA:** Lower-cost IA stored in one AZ.
* **Glacier / Glacier Deep Archive:** Archival storage with longer retrieval times.

---

#### **7. After attaching an EBS volume to an EC2 instance, what steps are needed to mount and use it?**

**Answer:**

1. **Check if the disk is recognized:** `lsblk`
2. **Format the volume:** `sudo mkfs -t ext4 /dev/xvdf`
3. **Create mount point:** `sudo mkdir /data`
4. **Mount the volume:** `sudo mount /dev/xvdf /data`
5. **Persistent mount:** Add entry in `/etc/fstab`

---

### 📦 **Ansible**

#### **8. Do you have hands-on experience with Ansible?**

**Answer:**
Yes, I have worked extensively with Ansible to:

* Provision EC2 servers
* Configure applications like Nginx, Docker, Jenkins
* Automate Kubernetes deployments
* Integrate with dynamic inventories from AWS

---

#### **9. What is the standard directory structure when creating an Ansible role?**

**Answer:**

```plaintext
my_role/
├── defaults/
│   └── main.yml
├── vars/
│   └── main.yml
├── tasks/
│   └── main.yml
├── handlers/
│   └── main.yml
├── templates/
├── files/
├── meta/
│   └── main.yml
```

---

#### **10. Where do you define variables in Ansible roles?**

**Answer:**

* **Role-specific:** `defaults/main.yml` (lowest precedence), `vars/main.yml`
* **Group/host-level:** `group_vars/`, `host_vars/`
* **Playbook-level:** Directly under `vars:` section in the playbook
* **External:** Via `--extra-vars` CLI

---

#### **11. What is dynamic inventory in Ansible?**

**Answer:**
Dynamic inventory fetches host lists from external sources like **AWS EC2, Azure, GCP** in real time using inventory plugins or scripts (e.g., `aws_ec2` plugin). It’s more scalable than static inventory.

---

#### **12. How do you handle errors in Ansible playbooks?**

**Answer:**

* Use `ignore_errors: yes` to continue despite failure.
* Use `block` with `rescue` and `always` to handle errors gracefully.
* Check `ansible-playbook` output logs and use `-v`, `-vvv` for verbose debugging.
* Use `register` and `when` conditions for handling conditional logic.

---

### 📊 **Prometheus**

#### **13. How many days of data can Prometheus store?**

**Answer:**
By default, Prometheus stores data for **15 days**. This can be adjusted using:

```bash
--storage.tsdb.retention.time=30d
```

You can also use **remote storage integrations** for long-term storage.

---

### 🐧 **Linux Commands**

#### **14. Syntax of `find` command in Linux?**

**Answer:**

```bash
find /path -name "filename"
find /var -type f -size +100M
find /home -mtime -7
```

---

#### **15. How to check available memory on a VM?**

```bash
free -h
top
vmstat
```

---

#### **16. Command to check network interfaces?**

```bash
ip a
ifconfig
```

---

#### **17. How to list open or listening ports?**

```bash
netstat -tuln
ss -tuln
lsof -i
```

---

#### **18. How to check OS of the VM?**

```bash
uname -a
cat /etc/os-release
```

---

### 🧩 **GitHub Actions**

#### **19. What is a runner in GitHub Actions?**

**Answer:**
A **runner** is a server that executes the GitHub Actions jobs. It can be:

* **GitHub-hosted:** Managed by GitHub (Ubuntu, Windows, macOS)
* **Self-hosted:** Custom machines for more control or private network access

---

#### **20. Basic structure of GitHub Actions workflow?**

**Answer:**

```yaml
name: CI Workflow
on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: echo "Build step"
```

---

#### **21. How to prevent parallel workflow runs and allow only one run at a time?**

**Answer:**
Use the **concurrency** keyword:

```yaml
concurrency:
  group: 'deploy-group'
  cancel-in-progress: true
```

This ensures only one workflow from the same group runs at a time.

---

#### **22. What is the difference between GitHub Actions and Jenkins?

**Answer:**
GitHub Actions is a cloud-native CI/CD tool integrated directly into GitHub, while Jenkins is a self-hosted automation server that requires manual setup and maintenance.
GitHub Actions is easier to start with, especially for GitHub-based projects, while Jenkins is more flexible for complex enterprise pipelines but requires more maintenance.

---
## **🔹 Falabella - Interview Questions and Answers**
---

## ✅ **1. How do you create an application in ArgoCD? What tasks are required?**

**Answer:**
To create an application in ArgoCD:

**✅ Pre-requisites:**

* Source code with K8s manifests (YAML, Helm, Kustomize) must be in Git.
* ArgoCD should be connected to your Git repo and Kubernetes cluster.

**✅ Creation via CLI:**

```bash
argocd app create my-app \
  --repo https://github.com/org/repo.git \
  --path k8s \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace default
```

**✅ Key Tasks:**

* Connect Git repo to ArgoCD.
* Register target cluster in ArgoCD settings.
* Create the Application (CLI/UI).
* Apply sync policies (auto/manual).
* Monitor health, history, and rollback.
* Secure access using RBAC/SSO.

---

## ✅ **2. Developers say Docker builds are slow. How do you optimize it?**

**Answer:**

Use these techniques:

* **🧱 Multi-stage builds:** Separate build and runtime layers.

```Dockerfile
FROM maven:3.9-openjdk-17 AS builder
COPY . .
RUN mvn package

FROM openjdk:17-jdk-alpine
COPY --from=builder target/app.jar /app/app.jar
```

* **📦 Smaller base images:** Use Alpine, Distroless.
* **📁 .dockerignore:** Prevent unnecessary files from being copied.
* **🧠 Caching:** Place static layers (e.g., dependencies) first.

```Dockerfile
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ .
```

* **🔄 Avoid `latest` tag** – prevents cache reuse.
* **🚀 Use BuildKit:** Faster parallel builds.

```bash
DOCKER_BUILDKIT=1 docker build .
```

---

## ✅ **3. I try to exec with bash in a container, but it's not working. Why?**

**Answer:**
The image might not have `bash`. Try alternatives:

* Use `sh`:

```bash
kubectl exec -it pod-name -- sh
```

* Use `kubectl debug`:

```bash
kubectl debug pod-name -it --image=busybox
```

* Modify Dockerfile to include bash (for non-prod only):

```Dockerfile
RUN apk add --no-cache bash
```

For hardened images (e.g., `distroless`), use sidecar or ephemeral containers for debugging.

---

## ✅ **4. What Kubernetes resources are required to deploy a backend application?**

**Answer:**

At a minimum:

1. **Deployment** – Manages Pods and replica sets.
2. **Service** – Exposes the app internally/externally.
3. **ConfigMap/Secret** – External configs/credentials.
4. **PVC** – If persistent storage is needed.
5. **Ingress** – Optional, for HTTP(S) routing.

Example:

```yaml
apiVersion: apps/v1
kind: Deployment
...
---
apiVersion: v1
kind: Service
...
```

---

## ✅ **5. When to use StatefulSet vs Deployment in Kubernetes?**

**Answer:**

| Feature       | Deployment       | StatefulSet                  |
| ------------- | ---------------- | ---------------------------- |
| Identity      | Anonymous pods   | Sticky identity per pod      |
| Use Case      | Web apps, APIs   | Databases, queues            |
| Storage       | Shared/ephemeral | Stable, persistent volume    |
| Startup Order | Not enforced     | Ordered pod startup/shutdown |

**Use StatefulSet for:**

* Cassandra, Kafka, MongoDB, Redis
* When pod name and volume need persistence

---

## ✅ **6. How to perform Kubernetes upgrade with zero downtime?**

**Answer:**

**Pre-upgrade checklist:**

* Ensure cluster is HA (control plane).
* Backup etcd.
* Use `PodDisruptionBudgets` and `readinessProbes`.

**Node upgrade steps:**

```bash
kubectl cordon <node>
kubectl drain <node> --ignore-daemonsets --delete-emptydir-data
# Upgrade kubelet and kube-proxy
kubectl uncordon <node>
```

**Tips:**

* Upgrade one node at a time.
* Use `kubeadm`, `eksctl`, or `kOps` for managed upgrade.
* Monitor application health throughout.

---

## ✅ **7. What is a mutating webhook in Kubernetes?**

**Answer:**
A **mutating admission webhook** allows you to **modify** incoming K8s objects before they are saved to etcd.

**Example use cases:**

* Auto-inject sidecar (e.g., Istio Envoy).
* Add default labels/annotations.
* Inject secrets or environment variables.

**Order:** Mutating → Validating webhook → API persistence

---

## ✅ **8. What is a sidecar container in Kubernetes?**

**Answer:**
A sidecar is a helper container that runs alongside your main container in the same pod.

**Common use cases:**

* Logging (Fluentd)
* Monitoring (OpenTelemetry, Datadog)
* Service Mesh (Istio Envoy)
* Config/Secret sync (Vault agent)

**Example:**

```yaml
containers:
- name: app
  image: my-backend
- name: otel
  image: otel/opentelemetry-collector
```

---

## ✅ **9. How does Splunk collect logs from Kubernetes pods?**

**Answer:**

**Options:**

1. **Splunk Connect for Kubernetes**
   Uses **Fluentd** as DaemonSet to collect logs from:

   ```
   /var/log/containers/*.log
   ```

2. **HEC (HTTP Event Collector)**
   Fluentd sends logs to Splunk via HEC endpoint with token.

3. **Sidecar approach**
   Runs Splunk UF or Fluentd per pod (less common).

---

## ✅ **10. Why use OpenTelemetry Collector in a K8s setup?**

**Answer:**
OpenTelemetry Collector acts as a **central agent** that:

* **Receives** telemetry from apps (logs, metrics, traces)
* **Processes**: filtering, batching, enrichment
* **Exports** to tools: Splunk, Prometheus, Datadog, Jaeger

**Advantages:**

* Decouples observability backend from app code
* Unified pipeline for metrics/logs/traces
* Scalable as sidecar, agent, or gateway mode

---

## ✅ **11. Java app is not sending metrics to OTel. How do you instrument it?**

**Answer:**

1. **Attach agent in JVM args:**

```bash
-javaagent:/otel/opentelemetry-javaagent.jar \
-Dotel.service.name=my-java-app \
-Dotel.exporter.otlp.endpoint=http://otel-collector:4317
```

2. **Mount the agent binary** in Docker image or init container.

3. **Deploy OTel Collector** (sidecar, DaemonSet, or gateway)

4. **Verify OTLP receiver** is enabled in OTel config.

5. **Trace context propagation** should be enabled in app libraries.

---

## ✅ **12. In Terraform, how to create resources only in the dev environment?**

**Answer:**

Use `count`:

```hcl
variable "env" {}

resource "aws_s3_bucket" "dev_bucket" {
  count  = var.env == "dev" ? 1 : 0
  bucket = "my-app-dev-bucket"
}
```

Or use `terraform.workspace`:

```hcl
count = terraform.workspace == "dev" ? 1 : 0
```

📁 You can also split environments into folders:

```
environments/
├── dev/
│   └── main.tf
├── prod/
│   └── main.tf
```

---

## ✅ **13. Domain `falabale.com` is routed to `/order` service in a pod. How does browser reach the pod?**

**Answer:**

**Step-by-step flow:**

1. **Browser Request:**

   * User hits `https://falabale.com/order`

2. **DNS Resolution:**

   * Domain resolves to LoadBalancer/Ingress IP

3. **Ingress Controller:**

   * NGINX/ALB handles path routing:

     ```yaml
     path: /order
     service: order-service
     ```

4. **Kubernetes Service:**

   * Routes traffic to pod via kube-proxy

5. **Pod:**

   * App container serves `/order` path

💡 Ensure:

* Correct path mapping in Ingress.
* Service selector matches pod labels.
* App listens on the right port.

---
## **🔹 xyz - Interview Questions and Answers**

---

### ✅ **1. What challenges have you faced while working with Kubernetes in a production environment?**

**Answer:**
Working in production with Kubernetes requires a balance between automation and reliability. Some of the **key challenges** I’ve faced include:

* **Pod restarts due to application crashes or OOMKilled events** — often traced back to memory leaks or missing resource limits.
* **Unstable deployments** — especially during rolling upgrades when readiness/liveness probes aren’t properly configured.
* **DNS resolution failures inside the cluster** — typically related to CoreDNS crashing under high load or misconfigured network policies.
* **Persistent storage for stateful apps** — ensuring data consistency and performance, especially with tools like Gerrit and Perforce.

To address these:

* I always implement **probes with retry buffers**, use **HPA/VPA**, and monitor metrics via **Prometheus + Grafana**.
* For stateful workloads like Gerrit, I use **StatefulSets with PVCs** and backup strategies.
* I also implement **network policies**, **resource quotas**, and **namespace-level isolation** for reliability.

This approach helped us maintain **near-zero downtime SLAs**, even during version upgrades or node failures.

---

### ✅ **2. A pod is restarting frequently. How do you troubleshoot and resolve it?**

**Answer:**
If a pod is in a CrashLoopBackOff state, I follow a structured approach:

1. **Check pod events & logs:**

   ```bash
   kubectl describe pod <pod>
   kubectl logs <pod>
   ```

2. **Common root causes:**

   * Application crash on startup (bad config, DB connection issue)
   * **OOMKilled** due to low memory limits
   * Failing **liveness probes**, causing Kubernetes to restart the pod
   * Missing binaries or shell (common in distroless images)

3. **Fix strategies:**

   * Increase memory limits or debug heap usage (especially for JVM-based apps)
   * Adjust probe thresholds
   * Fix missing dependencies or wrong container command
   * Use `kubectl exec` or an **ephemeral debug container** to live-debug

This not only resolves the issue but helps avoid repeat incidents by building resilient container images and proper health checks.

---

### ✅ **3. How do you handle capacity planning and autoscaling in Kubernetes?**

**Answer:**
I manage capacity at both **application and cluster levels** using the following:

* **Resource Requests & Limits:** Ensures proper scheduling and avoids noisy neighbor problems.
* **Horizontal Pod Autoscaler (HPA):**

  * Configured based on **CPU, memory**, or **custom Prometheus metrics**.
* **Cluster Autoscaler:**

  * Automatically adds nodes if pods can’t be scheduled.
* **Vertical Pod Autoscaler:** Used in batch workloads to suggest optimal memory/CPU over time.
* **Node affinity and taints:** To dedicate workloads to specific node pools (e.g., GPU, high-memory).

In addition, we perform **regular load testing** to understand thresholds and simulate traffic spikes.

---

### ✅ **4. What kind of applications have you supported?**

**Answer:**
I’ve supported a range of applications, including:

* **Gerrit:** Code review tool with a persistent backend, running on Kubernetes with StatefulSets, NFS volumes, and HAProxy.
* **Perforce:** Large-scale source control system, also requiring stateful behavior and high disk IOPS.
* **Java (Spring Boot)** applications: REST APIs with high traffic, monitored via OpenTelemetry, scaled via HPA.
* **Python (Flask, FastAPI)** services: Lightweight microservices, Celery workers for async jobs.

Each has its own complexities. For instance:

* Gerrit and Perforce need **stateful volume management**, data backups, and consistent uptime.
* Java apps need **fine-tuned JVM parameters** and proper CI caching.
* Python apps need **fast spin-up** and dependency isolation.

---

### ✅ **5. What CI/CD challenges have you faced with Java and Python apps?**

**Answer:**

#### **Java Pipelines:**

* **Long build times**: We optimized with Maven dependency caching and Docker layer caching.
* **JVM tuning**: Performance issues were resolved using `-XX:+UseContainerSupport` and proper heap sizing.
* **Large artifacts**: Stored in Nexus/S3 with SHA checksum verification.

#### **Python Pipelines:**

* **Dependency mismatches**: Solved using `pip-compile` and pinned versions.
* **Inconsistent environments**: Handled with base Docker images and virtual environments.
* **Faster lint/test stages**: Integrated Flake8, Pytest, and parallel test execution in GitHub Actions.

**CI Tools:**

* Mostly used **GitHub Actions**, with **reusable workflows** and **matrix builds** for multi-version testing.
* Implemented **self-hosted runners** for better control and access to private resources.

In both cases, we enforced **pre-commit checks, security scans (like Trivy, Bandit)**, and used **ArgoCD** for continuous delivery into Kubernetes.

---

Here is your **DevOps Interview Q\&A Guide**, formatted professionally by topic for easy reading and interview presentation:

---

## 🔧 **Linux Administration (as a DevOps Engineer)**

**Q1: What Linux versions have you worked with?**

> I’ve worked extensively on **Ubuntu (18.04, 20.04)**, **Amazon Linux 2**, and **RHEL/CentOS** in enterprise environments.

**Q2: What tasks do you perform on Linux servers?**

> * Monitoring CPU, memory, and disk space
> * Managing services (`systemctl`, `journalctl`)
> * Automating maintenance with cron and shell scripts
> * Applying security patches and OS updates
> * Managing file permissions and user accounts
> * Troubleshooting application performance at OS level

**Q3: How do you check memory usage?**

```bash
free -h
top
vmstat
```

**Q4: How do you change permissions for a directory?**

```bash
chmod 755 /path/to/directory
```

**Q5: How to change permissions for all directories and files recursively?**

```bash
find /path/to/dir -type d -exec chmod 755 {} \;
find /path/to/dir -type f -exec chmod 644 {} \;
```

**Q6: Have you done Linux patching?**

> Yes. I’ve scheduled downtime, applied patches using `yum` or `apt`, verified kernel updates, and rebooted nodes during approved windows.

**Q7: In `top`, how do you identify high memory usage and what actions do you take?**

> Use `Shift+M` to sort by memory. Investigate processes with high usage using `ps`, `lsof`, or logs. Actions include restarting services or tuning resource limits.

---

## ☸️ **Kubernetes & Pod Operations**

**Q1: How do you view pod logs in a namespace?**

```bash
kubectl logs <pod-name> -n <namespace>
```

**Q2: How to login to a pod?**

```bash
kubectl exec -it <pod-name> -n <namespace> -- /bin/sh
```

**Q3: How to login to a specific container in a pod?**

```bash
kubectl exec -it <pod-name> -c <container-name> -n <namespace> -- /bin/bash
```

---

## 📦 **Terraform Usage**

**Q1: For what purpose do you use Terraform?**

> To provision AWS infrastructure like VPCs, EC2 instances, EKS clusters, IAM roles, and S3 buckets in an automated, consistent, and version-controlled way.

**Q2: What is idempotency in Terraform?**

> Terraform is declarative. Running `terraform apply` multiple times won’t recreate resources if no changes exist—it only applies deltas.

**Q3: How do you structure a Terraform module?**

> A module contains:

* `main.tf` (resources)
* `variables.tf` (inputs)
* `outputs.tf` (outputs)
  Then called using:

```hcl
module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}
```

**Q4: What is a Terraform state file?**

> It tracks the real infrastructure vs declared code. Stored in S3 with state locking in DynamoDB for teams.

**Q5: What is a Terraform workspace?**

> It lets you manage environments like `dev`, `staging`, and `prod` using the same code but separate state files.

**Q6: What happens if you delete an EC2 instance manually and run `terraform apply` again?**

> Terraform will detect the drift and recreate the missing instance as defined in code.

---

## 🧰 **Ansible Usage**

**Q1: For what tasks do you use Ansible?**

> * OS patching
> * App package installation (e.g., Java, Python)
> * Configuration templating
> * Restarting services
> * Multi-server orchestration

**Q2: What are Ansible modules?**

> Reusable task units like `yum`, `copy`, `template`, `service`, and `user`. They perform the actual work in playbooks.

---

## 📜 **Shell Script Task**

**Q: Write a shell script to ping 10 servers.**

```bash
#!/bin/bash
for ip in 192.168.1.{1..10}; do
  ping -c 1 $ip &> /dev/null && echo "$ip is reachable" || echo "$ip is not reachable"
done
```

---

## 🚀 **ArgoCD & GitOps**

**Q: Why do you use ArgoCD?**

> To enable GitOps-based Kubernetes deployment. It syncs K8s manifests from Git to clusters automatically or on approval. It supports rollback, versioning, audit logs, and multi-env deployments securely.

---

## ☁️ **AWS Services & Concepts**

**Q1: What AWS services have you worked on?**

> EC2, VPC, S3, IAM, EKS, CloudWatch, CloudTrail, ALB, NLB, Auto Scaling Groups, Route53, SSM, NAT, IGW.

**Q2: What is autoscaling and how is it configured?**

> Auto Scaling adjusts EC2 capacity based on demand. It uses Launch Templates, Auto Scaling Groups, and CloudWatch-based policies (like CPU > 75%).

**Q3: What are types of Load Balancers in AWS?**

* **Application Load Balancer (ALB):** Layer 7, path-based routing
* **Network Load Balancer (NLB):** Layer 4, TCP/UDP traffic
* **Classic Load Balancer (legacy)**

**Q4: What is the difference between IGW and NAT Gateway?**

* **IGW (Internet Gateway):** For public subnet outbound/inbound internet traffic.
* **NAT Gateway:** Allows private subnet instances to access the internet securely.

---



