# MASTER JOURNAL — AI Agenti

## 2026-08-30 — OCI Always Free + Hermes + Agent Zero + OCI SDK/CLI

### Status
Canonical architecture decision. Supersedes the earlier mistaken interpretation of “Zero Agent” as AppDynamics Zero Agent.

### Canonical components
- **Hermes Agent**: persistent self-improving agent / reasoning and learning layer.
- **Agent Zero** (`agent0ai/agent-zero`): isolated execution/tool worker running in Docker; not the root controller and not a source of truth.
- **OCI CLI + OCI Python SDK**: infrastructure automation/control layer for Oracle Cloud Infrastructure.
- **Oracle Cloud Always Free Ampere A1 node**: deployment target sized to the current Always Free tenancy budget of **2 OCPU / 12 GB RAM total**.
- **GitHub**: versioned source for architecture, installers, runbooks and journal changes. Secrets never go into Git.

### Oracle Always Free operating constraint
Current Oracle documentation for Always Free A1 tenancies states a total budget equivalent to 2 OCPU and 12 GB RAM. Idle Always Free compute may be reclaimed when, over a 7-day period, CPU, network and (for A1) memory utilization remain below Oracle's stated thresholds. We will not create artificial/busy-loop load merely to defeat reclaim logic; the node must have legitimate scheduled work, monitoring, backups, agent jobs and health checks.

### Recommended deployment role
The OCI A1 node is a lightweight always-on control/worker node, not the sole data authority.

Suggested allocation:
- Host OS: Ubuntu/Oracle Linux ARM64
- Docker + Compose
- Hermes Agent as persistent orchestration/learning service
- Agent Zero as sandboxed subordinate execution service
- OCI CLI/SDK for provisioning, inventory, snapshots/backups, monitoring and deployment automation
- Reverse proxy only where needed
- Centralized logs + health checks
- Persistent application data on mounted storage with backups

### Security and reliability rules
1. Least privilege for OCI IAM and local service users.
2. No unrestricted production access for Hermes or Agent Zero.
3. Agent Zero runs isolated in Docker with explicit mounts, networks and capabilities.
4. Secrets live outside Git (environment injection / OCI Vault or equivalent).
5. Database/source-of-truth remains logically separated from execution agents.
6. Every deployment must be reconstructable from Git + documented secrets/config restore procedure.
7. Backup, rollback and forensic recovery are first-class requirements; RPO should be as close to zero as practical for critical state.
8. Changes are tested before promotion; health checks and rollback are mandatory.
9. Install/deploy scripts should be idempotent.
10. No fake keep-alive CPU burn. Legitimate monitoring, backups, indexing, scheduled agent tasks and maintenance provide real utilization.

### Integration model
Human / ChatGPT control plane
→ GitHub versioned configuration
→ OCI CLI/SDK infrastructure automation
→ Hermes Agent (persistent agent / learning)
→ Agent Zero (isolated execution worker)
→ approved external services/tools

Critical data stores and secrets are outside the unrestricted agent execution path.

### Correction log
- Previous generated package named `zero-agent-installer.zip` targeted AppDynamics Zero Agent. That package is **deprecated for this project** and must not be considered canonical.
- Correct project component is **Agent Zero AI framework** (`agent0ai/agent-zero`).

### Next implementation baseline
- ARM64-compatible Docker deployment.
- Hermes and Agent Zero separated into distinct containers/services.
- Explicit resource limits so 2 OCPU / 12 GB remains stable.
- OCI CLI installed on host/control container; OCI Python SDK in a dedicated virtual environment or automation container.
- GitHub Actions used only where secrets/permissions can be scoped safely.
- Add restore test, health check and deployment verification before production use.
