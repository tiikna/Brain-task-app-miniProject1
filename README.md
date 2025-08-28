# Brain Tasks App - Deployment Guide

## 📌 Project Overview
This project demonstrates **end-to-end deployment** of a React application (`Brain Tasks App`) into a production-ready state using **Docker, AWS ECR, Kubernetes (EKS), CodeBuild, CodeDeploy, and CodePipeline**.  

The workflow ensures:
- Containerized React app deployment  
- Automated build & deploy pipelines  
- Scalable infrastructure with Kubernetes  
- Monitoring via AWS CloudWatch  

----------------------------------------------------------------------------------------------------------------------------

## 📐 Architecture Diagram

**Flow Explanation:**
1. Developer pushes code to GitHub  
2. CodePipeline triggers build stage  
3. CodeBuild builds Docker image & pushes to ECR  
4. CodeDeploy deploys image to EKS cluster  
5. Kubernetes Service exposes app via LoadBalancer  
6. CloudWatch monitors logs and performance  

----------------------------------------------------------------------------------------------------------------------------

## 🚀 Application Setup

### 1. Clone Repository
```bash
git clone https://github.com/Vennilavan12/Brain-Tasks-App.git
cd Brain-Tasks-App
```

### 2. Install Dependencies (for local testing)
```bash
npm install
npm start
```
- Application will run on **http://localhost:3000**

----------------------------------------------------------------------------------------------------------------------------

## 🐳 Dockerization

- File: `Dockerfile`

### Steps:
1. Build Docker image:
   ```bash
   docker build -t brain-tasks-app .
   ```
2. Run container:
   ```bash
   docker run -p 3000:3000 brain-tasks-app
   ```
3. Access app at **http://localhost:3000**

----------------------------------------------------------------------------------------------------------------------------

## 📦 AWS ECR Setup

1. Authenticate Docker with ECR:
   ```bash
   aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com
   ```

2. Tag & push image:
   ```bash
   docker tag brain-tasks-app:latest <account_id>.dkr.ecr.<region>.amazonaws.com/brain-tasks-app:latest
   docker push <account_id>.dkr.ecr.<region>.amazonaws.com/brain-tasks-app:latest
   ```

----------------------------------------------------------------------------------------------------------------------------

## ☸️ Kubernetes (EKS)

- Files: `k8s-deploy/deployment.yaml`, `k8s-deploy/service.yaml`

### Steps:
1. Update kubeconfig:
   ```bash
   aws eks update-kubeconfig --region <region> --name brain-tasks-cluster
   ```

2. Verify cluster:
   ```bash
   kubectl get nodes
   ```

3. Deploy app:
   ```bash
   kubectl apply -f k8s-deploy/deployment.yaml
   kubectl apply -f k8s-deploy/service.yaml
   ```

4. Get LoadBalancer URL:
   ```bash
   kubectl get svc
   ```

----------------------------------------------------------------------------------------------------------------------------

## 🔨 AWS CodeBuild

- File: `buildspec.yml`

### Steps:
1. Create CodeBuild project.  
   - Source: GitHub  
   - Environment: Amazon Linux or Ubuntu  

2. Build process includes:
   - Install dependencies  
   - Build Docker image  
   - Push to ECR  
   - Deploy to EKS using kubectl  

----------------------------------------------------------------------------------------------------------------------------

## 📥 AWS CodeDeploy

- File: `appspec.yml`

### Steps:
1. Create a CodeDeploy application (EKS type).  
2. appspec.yml defines:  
   - Deployment instructions  
   - Hooks if required  
3. Ensures smooth rolling updates in EKS.  

----------------------------------------------------------------------------------------------------------------------------

## 🌐 AWS CodePipeline

### Steps:
1. **Source Stage**: GitHub repository triggers pipeline on new commits  
2. **Build Stage**: CodeBuild compiles app, builds Docker image, pushes to ECR  
3. **Deploy Stage**: CodeDeploy applies Kubernetes manifests in EKS  
4. **Monitoring**: CloudWatch tracks logs, alerts for errors  

----------------------------------------------------------------------------------------------------------------------------

## 📊 Monitoring

- **CloudWatch Logs** used for:  
  - CodeBuild execution logs  
  - CodeDeploy deployment logs  
  - Application logs from EKS pods  

Check logs using:
```bash
kubectl logs <pod-name>
```

----------------------------------------------------------------------------------------------------------------------------

## 📂 Repository Structure

Brain-task-app-miniProject1-main/
│── Dockerfile
│── appspec.yml
│── buildspec.yml
│── package.json
│── k8s-deploy/
│   ├── deployment.yaml
│   ├── service.yaml
│── public/
│   ├── index.html
│── src/
│   ├── App.js
│   ├── index.js
│── screeshots/   <-- Placed screesnshots here
```

---------------------------------------------------------**Thank You**-------------------------------------------------------------------
