# Claude Agent Context for Todo Application

## Technologies

### Frontend Stack
- Next.js 16+ with App Router
- TypeScript
- Tailwind CSS
- shadcn/ui component library
- Lucide React icons

### Backend Stack
- Python FastAPI
- SQLModel for ORM
- Neon Serverless PostgreSQL

### Authentication
- Better Auth for frontend authentication
- JWT-based authentication flow

### API Integration
- RESTful API communication
- Environment-based API URL configuration
- JWT token inclusion in requests

### Infrastructure & Deployment (Phase 4)
- Docker containerization for frontend and backend applications
- Minikube for local Kubernetes cluster
- Helm charts for packaging and configuration
- Kubernetes resources (Deployments, Services, ConfigMaps, Secrets)
- Multi-stage Docker builds for optimized images
- Proper separation of secrets vs config in Kubernetes
- Parameterized Helm charts for flexible deployment
- kubectl for cluster management
- kubectl-ai and kagent for AI-assisted operations

## Patterns

### Component Architecture
- Server Components by default
- Client Components only when interactivity is required
- Centralized API client in lib/api.ts
- Consistent use of shadcn/ui components

### UI/UX Patterns
- SaaS-grade dashboard layout
- Sidebar + Main Content structure
- Card-based design elements
- Loading/Empty/Error state handling
- Modal dialogs for user actions

### Infrastructure Patterns (Phase 4)
- Preserve all Phase-3 functionality unchanged
- Focus only on infrastructure/deployment changes
- Maintain statelessness of applications
- Use external NeonDB and Better Auth services
- Comprehensive health checks and readiness probes
- Proper environment variable and secret management
- Independent deployment of frontend and backend services

### Folder Structure
- Strict adherence to specified directory structure
- Separation of concerns between pages, components, and utilities
- Component grouping by feature area (auth, dashboard)
- Infrastructure files in docker/, helm/, k8s/, scripts/ directories

## Best Practices

### Development
- Focus on user experience and visual hierarchy
- Ensure all pages have structured layouts
- Implement proper error handling and loading states
- Maintain consistency across all UI elements

### Implementation
- Follow specified requirements exactly without simplification
- Maintain professional, production-ready appearance
- Ensure all functionality handles loading, empty, and error states
- Implement proper authentication flows

### Infrastructure Implementation (Phase 4)
- Multi-stage Docker builds for optimized images
- Proper separation of secrets vs config in Kubernetes
- Parameterized Helm charts for flexible deployment
- Comprehensive health checks and readiness probes
- Follow security best practices (non-root users, minimal base images)
- Maintain reproducible and version-controlled deployments

### Quality Assurance
- Adhere to specified UI requirements
- Follow shadcn/ui design patterns
- Implement responsive design
- Ensure accessibility compliance
- Validate infrastructure deployments for security and reliability