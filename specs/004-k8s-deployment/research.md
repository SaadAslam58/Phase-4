# Research: Kubernetes Deployment for Todo AI Chatbot

## Executive Summary

This research document outlines the approach for containerizing and deploying the existing Todo AI Chatbot application using Docker, Kubernetes (Minikube), and Helm. The research focuses on preserving all Phase-3 functionality while enabling containerized deployment.

## Technology Stack Analysis

### Docker Containerization
- **Frontend**: Next.js application requires multi-stage Docker build with production build optimization
- **Backend**: Python FastAPI application requires virtual environment setup and dependency installation
- **Base Images**:
  - Frontend: node:18-alpine (for smaller footprint)
  - Backend: python:3.11-slim (for production compatibility)

### Kubernetes (Minikube) Deployment
- **Cluster**: Single-node local Minikube cluster sufficient for Phase-4 requirements
- **Resources**: Each service requires Deployment, Service, ConfigMap, and Secret resources
- **Networking**: Service-to-service communication via ClusterIP services
- **Persistence**: External NeonDB remains unchanged; no persistent volumes needed

### Helm Charts
- **Structure**: Separate charts for frontend and backend to maintain separation of concerns
- **Configuration**: Values files will expose common parameters like image tags, replica counts, ports
- **Dependency Management**: Independent charts with no inter-dependencies

## Environment Variables & Secrets Mapping

Based on the .env.example file from Phase-3, the following mappings will be used:

### Frontend Environment Variables (ConfigMap)
- NEXT_PUBLIC_API_BASE_URL (to connect to backend service)
- NEXT_PUBLIC_WS_URL (if needed for real-time features)

### Backend Secrets
- OPENAI_API_KEY
- BETTER_AUTH_SECRET
- DATABASE_URL (NeonDB connection string)
- BETTER_AUTH_JWT_SECRET

### Backend Environment Variables (ConfigMap)
- PORT (for container port binding)
- ENVIRONMENT (for app behavior)
- LOG_LEVEL (for logging configuration)

## Docker Build Strategy

### Frontend Dockerfile Strategy
1. Multi-stage build with build and production stages
2. Copy package files and install dependencies
3. Build Next.js application
4. Serve with lightweight server (standalone output or nginx)

### Backend Dockerfile Strategy
1. Multi-stage build with dependencies and production stages
2. Copy requirements and install Python packages
3. Copy application code
4. Set up non-root user for security
5. Expose port and define entrypoint

## Networking Considerations

- Backend service will be accessible via Kubernetes DNS: `todo-backend.default.svc.cluster.local`
- Frontend will be configured to communicate with backend service via internal DNS
- Ingress or NodePort service for external access to frontend

## Security Considerations

- Secrets managed through Kubernetes Secrets, never in code or ConfigMaps
- Non-root users in containers for defense in depth
- Minimal base images to reduce attack surface
- No privileged containers required

## Resource Requirements

### Backend Service
- CPU: 0.5-1 vCPU (variable based on API usage)
- Memory: 512MB-1GB (based on agent processing)
- Storage: None (stateless, external DB)

### Frontend Service
- CPU: 0.2-0.5 vCPU (variable based on requests)
- Memory: 256MB-512MB
- Storage: None (static assets served from memory)

## Deployment Order & Dependencies

1. Backend service must be ready before frontend (as frontend needs to connect to backend API)
2. Database connection must be available before backend starts processing
3. MCP server in backend must be running before agents attempt connections

## Validation Approach

### Pre-deployment Validation
- Docker images build successfully and pass basic health checks
- Environment variables and secrets correctly configured
- Service dependencies validated in configuration

### Post-deployment Validation
- All pods running and in Ready state
- Services accessible within cluster
- End-to-end functionality working as in Phase-3
- MCP tools accessible and functional
- Authentication flow working correctly

## Decision Log

### Decision: Separate Helm Charts vs Single Umbrella Chart
- **Chosen**: Separate charts for frontend and backend
- **Rationale**: Enables independent deployment, scaling, and configuration of each service
- **Alternatives considered**: Single umbrella chart with subcharts
- **Trade-offs**: More complexity in management vs greater flexibility

### Decision: Multi-stage Docker Builds vs Simple Builds
- **Chosen**: Multi-stage builds for both frontend and backend
- **Rationale**: Smaller final images, cleaner build process, security improvements
- **Alternatives considered**: Simple single-stage builds
- **Trade-offs**: More complex Dockerfiles vs smaller, more secure images

### Decision: Ingress vs NodePort for External Access
- **Chosen**: NodePort for simplicity (since this is a local deployment)
- **Rationale**: Easier to set up and access for local development and testing
- **Alternatives considered**: Ingress controller with LoadBalancer
- **Trade-offs**: Less sophisticated networking vs simpler local setup

### Decision: Kubernetes Secrets vs External Secret Management
- **Chosen**: Kubernetes native Secrets
- **Rationale**: Adequate for local development, no need for external secret management for Phase-4
- **Alternatives considered**: External providers (HashiCorp Vault, AWS Secrets Manager)
- **Trade-offs**: Simpler setup vs production-ready security