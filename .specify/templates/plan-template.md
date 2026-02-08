# Implementation Plan: [FEATURE]

**Branch**: `[###-feature-name]` | **Date**: [DATE] | **Spec**: [link]
**Input**: Feature specification from `/specs/[###-feature-name]/spec.md`

**Note**: This template is filled in by the `/sp.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

[Extract from feature spec: primary requirement + technical approach from research]

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: [e.g., Python 3.11, Swift 5.9, Rust 1.75 or NEEDS CLARIFICATION]  
**Primary Dependencies**: [e.g., FastAPI, UIKit, LLVM or NEEDS CLARIFICATION]  
**Storage**: [if applicable, e.g., PostgreSQL, CoreData, files or N/A]  
**Testing**: [e.g., pytest, XCTest, cargo test or NEEDS CLARIFICATION]  
**Target Platform**: [e.g., Linux server, iOS 15+, WASM or NEEDS CLARIFICATION]
**Project Type**: [single/web/mobile - determines source structure]  
**Performance Goals**: [domain-specific, e.g., 1000 req/s, 10k lines/sec, 60 fps or NEEDS CLARIFICATION]  
**Constraints**: [domain-specific, e.g., <200ms p95, <100MB memory, offline-capable or NEEDS CLARIFICATION]  
**Scale/Scope**: [domain-specific, e.g., 10k users, 1M LOC, 50 screens or NEEDS CLARIFICATION]

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### Phase-3 Preservation Check
- [ ] Confirm no changes to existing Phase-3 frontend structure
- [ ] Confirm no changes to existing Phase-3 backend APIs
- [ ] Confirm no changes to existing Phase-3 authentication flow
- [ ] Confirm no changes to existing Phase-3 database schema
- [ ] Confirm no changes to existing Phase-3 task CRUD logic
- [ ] Confirm no changes to existing Phase-3 environment variable usage
- [ ] Confirm no changes to existing Phase-3 AI chatbot functionality
- [ ] Confirm no changes to existing Phase-3 MCP tools

### Architecture Doctrine Check
- [ ] Confirm no modification of application logic
- [ ] Confirm infrastructure code follows containerization best practices
- [ ] Confirm Kubernetes resources maintain statelessness of application
- [ ] Confirm all configuration managed through environment variables and ConfigMaps/Secrets
- [ ] Confirm deployments remain reproducible and version-controlled

### Infrastructure-Only Mandate Check
- [ ] Confirm only infrastructure changes are implemented (Docker, Kubernetes, Helm)
- [ ] Confirm no API route changes
- [ ] Confirm no database schema modifications
- [ ] Confirm no agent logic editing
- [ ] Confirm no authentication flow alterations
- [ ] Confirm no business logic optimizations

### Containerization Constitution Check
- [ ] Confirm frontend and backend are containerized separately
- [ ] Confirm Docker images are development-friendly
- [ ] Confirm required ports are exposed
- [ ] Confirm configuration accepted via environment variables
- [ ] Confirm clarity prioritized over performance (no unnecessary optimization)

### Kubernetes Deployment Law Check
- [ ] Confirm deployment targets local Minikube only
- [ ] Confirm Kubernetes resources include Deployments, Services, ConfigMaps, Secrets
- [ ] Confirm no cloud-specific resources
- [ ] Confirm resource limits are reasonable
- [ ] Confirm Kubernetes pods remain stateless
- [ ] Confirm persistence stays in database layer

### Helm Chart Governance Check
- [ ] Confirm Helm charts configurable via values.yaml
- [ ] Confirm support for replica scaling
- [ ] Confirm separation of frontend and backend concerns
- [ ] Confirm charts reflect existing Phase-3 architecture exactly
- [ ] Confirm Helm used as packaging layer, not redesign tool

### Environment & Secrets Law Check
- [ ] Confirm Phase-3 environment variables remain valid
- [ ] Confirm secrets never hardcoded
- [ ] Confirm secrets injected via Kubernetes Secrets
- [ ] Confirm local development assumptions allowed
- [ ] Confirm .env.example remains source of truth

## Project Structure

### Documentation (this feature)

```text
specs/[###-feature]/
├── plan.md              # This file (/sp.plan command output)
├── research.md          # Phase 0 output (/sp.plan command)
├── data-model.md        # Phase 1 output (/sp.plan command)
├── quickstart.md        # Phase 1 output (/sp.plan command)
├── contracts/           # Phase 1 output (/sp.plan command)
└── tasks.md             # Phase 2 output (/sp.tasks command - NOT created by /sp.plan)
```

### Source Code (repository root)
<!--
  ACTION REQUIRED: Replace the placeholder tree below with the concrete layout
  for this feature. Delete unused options and expand the chosen structure with
  real paths (e.g., apps/admin, packages/something). The delivered plan must
  not include Option labels.
-->

```text
# [REMOVE IF UNUSED] Option 1: Single project (DEFAULT)
src/
├── models/
├── services/
├── cli/
└── lib/

tests/
├── contract/
├── integration/
└── unit/

# [REMOVE IF UNUSED] Option 2: Web application (when "frontend" + "backend" detected)
backend/
├── src/
│   ├── models/
│   ├── services/
│   └── api/
└── tests/

frontend/
├── src/
│   ├── components/
│   ├── pages/
│   └── services/
└── tests/

# [REMOVE IF UNUSED] Option 3: Mobile + API (when "iOS/Android" detected)
api/
└── [same as backend above]

ios/ or android/
└── [platform-specific structure: feature modules, UI flows, platform tests]
```

**Structure Decision**: [Document the selected structure and reference the real
directories captured above]

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |
