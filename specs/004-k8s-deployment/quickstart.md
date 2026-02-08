# Quickstart Guide: Kubernetes Deployment for Todo AI Chatbot

## Overview

This guide walks through deploying the Todo AI Chatbot application to a local Kubernetes cluster using Docker, Minikube, and Helm.

## Prerequisites

### Required Tools
- Docker Desktop (v4.53+ with Docker AI enabled)
- Minikube (v1.30+)
- kubectl (v1.25+)
- Helm (v3.10+)
- Git

### Optional AI Tools
- kubectl-ai
- kagent (for cluster analysis)

## Step-by-Step Deployment

### 1. Clone and Navigate to Repository
```bash
git clone <repository-url>
cd <repository-root>
```

### 2. Prepare the Local Environment
```bash
# Start Minikube cluster
minikube start

# Verify cluster access
kubectl get nodes

# Enable Minikube Docker daemon (for building images in-cluster)
eval $(minikube docker-env)
```

### 3. Build Docker Images
```bash
# Build frontend Docker image
docker build -f docker/frontend/Dockerfile -t todo-frontend:latest .

# Build backend Docker image
docker build -f docker/backend/Dockerfile -t todo-backend:latest .
```

### 4. Verify Docker Images Locally
```bash
# Test frontend container (optional)
docker run -d -p 3000:3000 --name test-frontend todo-frontend:latest

# Test backend container (optional)
docker run -d -p 8000:8000 --name test-backend todo-backend:latest

# Clean up test containers
docker stop test-frontend test-backend
docker rm test-frontend test-backend
```

### 5. Install Helm Charts
```bash
# Navigate to helm directory
cd helm

# Install backend chart first (to ensure backend is ready)
helm install todo-backend todo-backend/ --values todo-backend/values.yaml

# Wait for backend to be ready
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=todo-backend --timeout=300s

# Install frontend chart
helm install todo-frontend todo-frontend/ --values todo-frontend/values.yaml
```

### 6. Verify Installation
```bash
# Check all pods are running
kubectl get pods

# Check all services are available
kubectl get services

# Check deployments are ready
kubectl get deployments
```

### 7. Access the Application
```bash
# Get frontend service external URL
minikube service todo-frontend --url

# Or port forward for local access
kubectl port-forward svc/todo-frontend 3000:80

# Visit http://localhost:3000 to access the application
```

### 8. Validate End-to-End Functionality
1. Open the frontend in your browser
2. Test the chatbot functionality (add/list/update/delete tasks)
3. Verify that conversation history persists
4. Confirm authentication works as expected
5. Test MCP tool invocations through the chatbot

## Troubleshooting

### Common Issues and Solutions

**Issue**: Pods stuck in ContainerCreating or CrashLoopBackOff
**Solution**: Check logs with `kubectl logs <pod-name>` and verify environment variables/secrets

**Issue**: Frontend can't connect to backend service
**Solution**: Verify backend service is running and check frontend configuration for correct backend URL

**Issue**: Database connection errors
**Solution**: Verify database connection string in backend secrets and database accessibility

**Issue**: Minikube not starting
**Solution**: Run `minikube delete` and `minikube start` to reset cluster

### Using AI Tools for Troubleshooting

**With kubectl-ai**:
```bash
kubectl-ai "Why is my backend pod crashing?"

kubectl-ai "Scale frontend to 2 replicas"

kubectl-ai "Show me logs from the last hour for backend pods"
```

**Manual Commands**:
```bash
# Check pod status
kubectl get pods -o wide

# View pod logs
kubectl logs -f deployment/todo-backend

# Describe pod for detailed information
kubectl describe pod <pod-name>

# Exec into a running pod for debugging
kubectl exec -it <pod-name> -- sh
```

## Cleaning Up

### Uninstall Helm Releases
```bash
helm uninstall todo-frontend
helm uninstall todo-backend
```

### Stop Minikube
```bash
minikube stop
```

### Optional: Delete Minikube Cluster
```bash
minikube delete
```

## Configuration Customization

### Customizing with Helm Values
```bash
# Install with custom values file
helm install todo-backend todo-backend/ --values todo-backend/values-custom.yaml

# Override specific values during installation
helm install todo-backend todo-backend/ --set replicaCount=2,image.tag=v1.0.0
```

### Common Configuration Parameters
- `replicaCount`: Number of pod replicas to run
- `image.repository`: Docker image repository
- `image.tag`: Docker image tag
- `service.type`: Kubernetes service type (ClusterIP, NodePort, LoadBalancer)
- `service.port`: Port exposed by the service
- `resources.limits.cpu/memory`: Resource limits for containers
- `resources.requests.cpu/memory`: Resource requests for containers

## Development Workflow

### Making Changes
1. Update application code in `frontend/` or `backend/` directories
2. Rebuild Docker image: `docker build -f docker/<frontend|backend>/Dockerfile -t <image-name>:<tag> .`
3. Update Helm chart values to use new image tag
4. Upgrade Helm release: `helm upgrade <release-name> <chart-path> --values <values-file>`

### Using Docker AI (Gordon)
Enable Docker AI in Docker Desktop for assistance with Dockerfile optimization:
- Settings → Features in development → Docker AI

This allows AI assistance for Docker-related tasks and optimization.

## Verification Checklist

Before considering deployment successful:

- [ ] Minikube cluster is running
- [ ] Both frontend and backend pods are running and ready
- [ ] Services are accessible within the cluster
- [ ] Frontend can reach backend service
- [ ] Application functions as expected (end-to-end test)
- [ ] MCP tools are accessible and working
- [ ] Database connections are successful
- [ ] Authentication flow works correctly
- [ ] No error messages in application logs