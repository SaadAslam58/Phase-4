# Deploy Todo AI Chatbot to local Minikube cluster
# Usage: .\scripts\deploy.ps1 [-Mode <raw|helm>] [-BuildImages]

param(
    [ValidateSet("raw", "helm")]
    [string]$Mode = "raw",
    [switch]$BuildImages
)

$ErrorActionPreference = "Stop"

Write-Host "=== Todo AI Chatbot - Local K8s Deployment ===" -ForegroundColor Cyan
Write-Host "Mode: $Mode"

# Check prerequisites
Write-Host "`n--- Checking prerequisites ---" -ForegroundColor Yellow
$tools = @("docker", "minikube", "kubectl")
if ($Mode -eq "helm") { $tools += "helm" }

foreach ($tool in $tools) {
    if (-not (Get-Command $tool -ErrorAction SilentlyContinue)) {
        Write-Error "$tool is not installed or not in PATH"
        exit 1
    }
}
Write-Host "All prerequisites found." -ForegroundColor Green

# Ensure Minikube is running
$mkStatus = minikube status --format="{{.Host}}" 2>$null
if ($mkStatus -ne "Running") {
    Write-Host "`n--- Starting Minikube ---" -ForegroundColor Yellow
    minikube start --driver=docker --memory=4096 --cpus=2
}
Write-Host "Minikube is running." -ForegroundColor Green

# Configure Docker to use Minikube's daemon
Write-Host "`n--- Configuring Docker for Minikube ---" -ForegroundColor Yellow
& minikube -p minikube docker-env --shell powershell | Invoke-Expression

# Build images if requested
if ($BuildImages) {
    Write-Host "`n--- Building Docker images ---" -ForegroundColor Yellow

    Write-Host "Building backend..."
    docker build -t todo-backend:latest -f docker/backend/Dockerfile .

    Write-Host "Building frontend..."
    docker build -t todo-frontend:latest -f docker/frontend/Dockerfile .

    Write-Host "Images built successfully." -ForegroundColor Green
}

if ($Mode -eq "raw") {
    Write-Host "`n--- Deploying with raw K8s manifests ---" -ForegroundColor Yellow

    # Apply backend resources
    Write-Host "Deploying backend..."
    kubectl apply -f k8s/backend-configmap.yaml
    kubectl apply -f k8s/backend-secret.yaml
    kubectl apply -f k8s/backend-deployment.yaml
    kubectl apply -f k8s/backend-service.yaml

    # Apply frontend resources
    Write-Host "Deploying frontend..."
    kubectl apply -f k8s/frontend-configmap.yaml
    kubectl apply -f k8s/frontend-deployment.yaml
    kubectl apply -f k8s/frontend-service.yaml

} elseif ($Mode -eq "helm") {
    Write-Host "`n--- Deploying with Helm charts ---" -ForegroundColor Yellow

    Write-Host "Installing backend chart..."
    helm upgrade --install todo-backend helm/todo-backend

    Write-Host "Installing frontend chart..."
    helm upgrade --install todo-frontend helm/todo-frontend
}

# Wait for pods to be ready
Write-Host "`n--- Waiting for pods ---" -ForegroundColor Yellow
kubectl wait --for=condition=ready pod -l part-of=todo-app --timeout=120s 2>$null

# Show status
Write-Host "`n--- Deployment Status ---" -ForegroundColor Cyan
kubectl get pods -l part-of=todo-app
kubectl get services -l part-of=todo-app

# Show access URLs
Write-Host "`n--- Access URLs ---" -ForegroundColor Cyan
$frontendUrl = minikube service todo-frontend --url 2>$null
$backendUrl = minikube service todo-backend --url 2>$null
Write-Host "Frontend: $frontendUrl"
Write-Host "Backend:  $backendUrl"

Write-Host "`n=== Deployment complete ===" -ForegroundColor Green
