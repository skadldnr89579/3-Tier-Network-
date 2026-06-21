# 3-Tier-Network-
# 3-Tier Network Terraform, python codes
# All the codes have to be in one folder. please combine them 

☁️ 3-Tier Web Service Project on AWS

This project is a record of my journey in designing and building a web service from the ground up on AWS. I focused on understanding how a web service operates securely and efficiently, covering everything from fundamental cloud infrastructure to Kubernetes deployment.
💡 What I Built

I structured the service into three distinct tiers to ensure a clear separation of concerns:

    Tier 1 (Presentation): The user-facing web interface (hosted on AWS S3 with Nginx).

    Tier 2 (Application): The backend logic using Flask, orchestrated on Amazon EKS (Kubernetes).

    Tier 3 (Data): The database layer for secure data storage using Amazon RDS (MySQL).

📂 Project Structure

I organized the project to keep the code modular and easy to navigate:
Plaintext

/
├── infrastructure/    # Terraform code to provision AWS resources (VPC, EKS, RDS, etc.)
├── backend/           # Flask backend source code and Docker setup
├── frontend/          # Web static files and Nginx configuration
└── k8s/               # Kubernetes deployment and service manifests

🚀 Why I Built It This Way

    Infrastructure as Code (IaC): Instead of manual provisioning, I used Terraform to automate the entire infrastructure setup, making it repeatable and version-controlled.

    Security-First: I followed security best practices by using environment variables to prevent hardcoding sensitive credentials.

    Network Isolation: I designed the architecture with public and private subnets, ensuring the database remains secure and inaccessible from the public internet.

    Scalability (K8s): By using Amazon EKS, I ensured the application is containerized and can scale flexibly as demand grows.

🛠️ Getting Started

    Provision Infrastructure: Navigate to the infrastructure/ folder and run terraform apply.

    Deploy the Application: Navigate to the k8s/ folder and run kubectl apply to launch the services.

        Note: Before deployment, please update the DB endpoint and password configurations to match your specific environment.

🔒 Security Note

1) To maintain security, I have removed all actual database credentials and AWS account IDs. If you are running this project, please make sure to inject your own environment variables or secrets for a secure deployment.

2) Removed/Disabled the Bastion Host to eliminate the security risk of an open SSH port (22) and to optimize cloud costs by cutting unnecessary resources.
