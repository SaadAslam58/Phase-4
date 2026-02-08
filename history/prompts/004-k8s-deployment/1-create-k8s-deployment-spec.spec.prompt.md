---
id: 1
title: create-k8s-deployment-spec
stage: spec
date: 2026-02-08
surface: agent
model: Claude Sonnet 4.5
feature: 004-k8s-deployment
branch: 004-k8s-deployment
user: pc
command: sp.specify
labels: [kubernetes, deployment, docker, helm, containerization]
links:
  spec: ../specs/004-k8s-deployment/spec.md
  ticket: null
  adr: null
  pr: null
files:
 - specs/004-k8s-deployment/spec.md
 - specs/004-k8s-deployment/checklists/requirements.md
tests:
---
## Prompt

```
Title: Spec-Driven Local Kubernetes Deployment for Todo AI Chatbot
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

Pods restart without breaking function
```

## Response snapshot

Successfully created the specification for Kubernetes deployment of the Todo AI Chatbot. The specification includes:

1. Three user stories covering:
   - Containerization of applications (P1)
   - Kubernetes deployment (P2)
   - Helm packaging and configuration (P3)

2. Comprehensive functional requirements (FR-001 to FR-026) covering:
   - Preservation of Phase-3 functionality
   - Docker containerization requirements
   - Kubernetes deployment requirements
   - Helm chart packaging requirements
   - Configuration and secret management

3. Measurable success criteria (SC-001 to SC-005) that are technology-agnostic

4. Created a quality checklist to validate the specification

The specification adheres to the Phase-4 constitution and preserves all existing Phase-3 functionality while enabling containerized deployment to local Minikube clusters.

## Outcome

- ✅ Impact: Created complete specification for infrastructure deployment
- 🧪 Tests: Created quality checklist and validated specification completeness
- 📁 Files: Created spec.md and requirements.md checklist
- 🔁 Next prompts: Ready for /sp.plan to create implementation plan
- 🧠 Reflection: Specification successfully balances infrastructure requirements with preservation of existing functionality

## Evaluation notes (flywheel)

- Failure modes observed: None
- Graders run and results (PASS/FAIL): All checklist items validated
- Prompt variant (if applicable): N/A
- Next experiment (smallest change to try): Proceed to planning phase