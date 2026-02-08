# Feature Specification: Kubernetes Deployment for Todo AI Chatbot

**Feature Branch**: `004-k8s-deployment`
**Created**: 2026-02-08
**Status**: Draft
**Input**: User description: "Title: Spec-Driven Local Kubernetes Deployment for Todo AI Chatbot
Phase: IV
Base: Phase III (Unmodified Application)

1. Purpose of This Specification

This specification defines how to containerize, package, and deploy the existing Phase-3 Todo AI Chatbot onto a local Kubernetes cluster using Minikube, Docker, and Helm, with AI-assisted DevOps tooling.

This spec does not define application behavior.
It defines deployment behavior only.

2. Scope Definition
In Scope

Docker containerization of frontend and backend

Kubernetes deployment using Minikube

Helm charts for packaging and configuration

AI-assisted DevOps using:

Docker AI Agent (Gordon)

kubectl-ai

kagent

Environment variable and secret management

Local, repeatable deployment

Out of Scope (Explicitly Forbidden)

Changing frontend UI

Modifying backend APIs

Editing agent logic

Altering MCP tools

Changing database schema

Cloud deployment (AWS/GCP/etc)

CI/CD pipelines

3. Base Assumptions (Inherited from Phase-3)

Frontend and backend code already work correctly

OpenAI Agents SDK is correctly implemented

MCP server is integrated into backend

NeonDB is configured externally

Authentication uses Better Auth

Environment variables already exist in .env.example

Phase-4 must not invalidate any Phase-3 assumption.

4. Folder & Artifact Structure Requirements

Phase-4 must preserve all Phase-3 folders and add only the following:

/docker
  /frontend
  /backend

/helm
  /todo-frontend
  /todo-backend

/k8s
  (optional raw manifests for reference)

/scripts


No existing Phase-3 folder may be deleted or renamed.

5. Docker Containerization Specification
5.1 General Rules

Frontend and backend must be containerized separately

Each service gets its own Dockerfile

Images must:

Accept configuration via environment variables

Expose only required ports

Be runnable independently

5.2 Docker AI (Gordon) Usage

Docker AI Agent (Gordon) must be used when available

If unavailable, Claude Code may generate Docker CLI commands

Dockerfiles must favor clarity over optimization

5.3 Expected Outputs

docker/frontend/Dockerfile

docker/backend/Dockerfile

Docker images runnable via docker run

6. Kubernetes Deployment Specification (Minikube)
6.1 Cluster Target

Local Minikube cluster only

Single-node setup is sufficient

6.2 Required Kubernetes Resources

Each service must define:

Deployment

Service

ConfigMap (non-secret config)

Secret (API keys, auth secrets)

6.3 Statelessness Rule

Pods must be stateless

No local file persistence

All state stored in NeonDB (external)

7. Helm Charts Specification
7.1 Helm Usage Rules

Helm charts are mandatory

One chart per service:

todo-frontend

todo-backend

Charts must support:

Replica count

Environment variables

Service configuration

7.2 Configuration

values.yaml must expose:

Image name & tag

Replicas

Service ports

Environment variables

No hardcoded secrets in charts

8. Environment Variables & Secrets
8.1 Environment Variable Sources

.env.example remains the source of truth

Kubernetes Secrets inject sensitive values

Kubernetes ConfigMaps inject non-sensitive values

8.2 Required Secrets

OpenAI API Key

Better Auth secrets

Backend service URLs

Secrets must never appear in:

Dockerfiles

Helm templates

Git repository

9. AI-Assisted DevOps Specification
9.1 kubectl-ai

Used for:

Deploying services

Scaling replicas

Debugging failed pods

Inspecting cluster state

9.2 kagent

Used for:

Cluster health analysis

Resource optimization suggestions

Learning-focused diagnostics

AI tools assist execution, but do not replace specs.

10. Deployment Flow Specification

Expected deployment lifecycle:

Build Docker images

Start Minikube

Load images into Minikube

Install Helm charts

Deploy frontend and backend

Verify services

Validate chatbot end-to-end behavior

11. Validation & Acceptance Criteria

Phase-4 is complete only if:

Minikube cluster runs successfully

Frontend is reachable in browser

Backend API responds correctly

Chatbot functions end-to-end

Pods restart without breaking function"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Containerization of Applications (Priority: P1)

Deploy containerized versions of the frontend and backend applications using Docker.

**Why this priority**: This is the foundational step that enables all subsequent deployment activities and allows the applications to run in containerized environments.

**Independent Test**: Can be fully tested by building Docker images for both frontend and backend applications and verifying they run successfully with docker run commands.

**Acceptance Scenarios**:

1. **Given** application source code exists, **When** Docker build command is executed, **Then** Docker images are created successfully for both frontend and backend
2. **Given** Docker images are built, **When** docker run command is executed with environment variables, **Then** applications start and serve requests appropriately

---

### User Story 2 - Kubernetes Deployment (Priority: P2)

Deploy the containerized applications to a local Minikube Kubernetes cluster with all required resources.

**Why this priority**: This establishes the core deployment infrastructure that will host the applications in a container orchestration environment.

**Independent Test**: Can be tested by starting a Minikube cluster and deploying the applications using Kubernetes manifests, verifying all required resources (Deployments, Services, ConfigMaps, Secrets) are created.

**Acceptance Scenarios**:

1. **Given** Minikube is running, **When** kubectl apply is executed with deployment manifests, **Then** Kubernetes resources are created and pods are running
2. **Given** deployed resources exist, **When** kubectl get pods command is run, **Then** frontend and backend pods show as Running status

---

### User Story 3 - Helm Packaging and Configuration (Priority: P3)

Package the Kubernetes deployments using Helm charts with configurable parameters for easy deployment and scaling.

**Why this priority**: This provides a standardized, configurable way to manage the application deployments that can be reused across different environments.

**Independent Test**: Can be tested by installing the Helm charts to a fresh Minikube cluster and verifying the applications are deployed with configurable parameters.

**Acceptance Scenarios**:

1. **Given** Helm charts exist, **When** helm install command is executed, **Then** applications are deployed successfully with default configurations
2. **Given** Helm chart with custom values, **When** helm install command is executed with custom values, **Then** applications are deployed with specified configurations (replica counts, environment variables, etc.)

---

### Edge Cases

- What happens when Minikube cluster is unavailable or insufficient resources exist?
- How does the system handle incorrect environment variables or missing secrets during deployment?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST preserve all existing Phase-3 functionality unchanged
- **FR-002**: System MUST extend Phase-3 functionality rather than modifying it
- **FR-003**: System MUST maintain all existing Phase-3 frontend structures
- **FR-004**: System MUST maintain all existing Phase-3 backend APIs
- **FR-005**: System MUST maintain all existing Phase-3 authentication flows
- **FR-006**: System MUST implement AI chatbot using MCP tools for all operations (preserved from Phase-3)
- **FR-007**: System MUST store all state in database, not in server-side sessions (preserved from Phase-3)
- **FR-008**: System MUST provide one primary chat endpoint: POST /api/{user_id}/chat (preserved from Phase-3)
- **FR-009**: System MUST implement stateless per-request architecture (preserved from Phase-3)
- **FR-010**: System MUST support Basic Level chatbot functionality: Add/List/Update/Complete/Delete tasks (preserved from Phase-3)
- **FR-011**: System MUST containerize frontend and backend applications separately using Docker
- **FR-012**: System MUST deploy to local Minikube Kubernetes cluster
- **FR-013**: System MUST package deployments using Helm charts
- **FR-014**: System MUST inject configuration via Kubernetes ConfigMaps and Secrets
- **FR-015**: System MUST maintain statelessness in Kubernetes pods
- **FR-016**: System MUST accept configuration via environment variables
- **FR-017**: System MUST expose only required ports from containers
- **FR-018**: System MUST define Kubernetes Deployments for each service
- **FR-019**: System MUST define Kubernetes Services for inter-service communication
- **FR-020**: System MUST define Kubernetes ConfigMaps for non-secret configuration
- **FR-021**: System MUST define Kubernetes Secrets for sensitive data
- **FR-022**: System MUST support configurable replica counts via Helm
- **FR-023**: System MUST support configurable environment variables via Helm
- **FR-024**: System MUST load Docker images into Minikube cluster
- **FR-025**: System MUST verify applications are reachable after deployment

*Example of marking unclear requirements:*

- **FR-026**: System MUST use standard port numbers for frontend (3000) and backend (8000) services

### Key Entities *(include if feature involves data)*

- **Docker Images**: Containerized versions of frontend and backend applications
- **Kubernetes Resources**: Deployments, Services, ConfigMaps, and Secrets for application orchestration
- **Helm Charts**: Packaged Kubernetes resources with configurable parameters
- **Environment Configuration**: Values passed to containers via ConfigMaps/Secrets and environment variables

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Deployment of both frontend and backend applications to container orchestration platform completes successfully within 5 minutes
- **SC-002**: Both applications are accessible via network services after deployment and can communicate with each other
- **SC-003**: End-to-end functionality of the Todo AI Chatbot works correctly after containerized deployment
- **SC-004**: Applications can be deployed with configurable parameters and scale appropriately
- **SC-005**: Applications maintain connection to external database and authentication services after deployment