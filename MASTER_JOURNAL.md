# MASTER JOURNAL — AI Agenti

## 2026-08-30 — OCI Always Free + Hermes + Agent Zero + OCI SDK/CLI

### Status
Canonical architecture decision. Supersedes the earlier mistaken interpretation of “Zero Agent” as AppDynamics Zero Agent.

### Canonical components
- **Hermes Agent**: persistent self-improving agent / reasoning and learning layer.
- **Agent Zero** (`agent0ai/agent-zero`): isolated execution/tool worker running in Docker; not the root controller and not a source of truth.
- **OCI CLI + OCI Python SDK**: infrastructure automation/control layer for Oracle Cloud Infrastructure.
- **Oracle Cloud Always Free Ampere A1 node**: deployment target sized to **2 OCPU / 12 GB RAM total** for this tenancy plan.
- **GitHub**: versioned source for architecture, installers, runbooks and journal changes. Secrets never go into Git.

### Operating constraint
The node must perform legitimate work. No artificial CPU/network/memory burn is introduced to defeat provider idle/reclaim rules. Monitoring, backup, indexing, maintenance and actual agent jobs are legitimate workloads.

### Resource baseline
- Agent Zero: 0.75 CPU / 4 GB hard limit.
- Hermes: 1 CPU / 5 GB hard limit.
- Remaining capacity reserved for host OS, Docker, OCI tooling, monitoring and recovery.

### Security and reliability rules
1. Least privilege for OCI IAM and local service users.
2. Prefer OCI **instance principals + dynamic groups + scoped IAM policy** over persistent API private keys on the VM.
3. No unrestricted production access for Hermes or Agent Zero.
4. Agent Zero is isolated in Docker, drops Linux capabilities, uses no-new-privileges, and binds only to localhost unless an authenticated gateway/VPN is explicitly added.
5. Secrets live outside Git.
6. Database/source-of-truth remains logically separated from execution agents.
7. Every deployment must be reconstructable from Git + documented secret/config restore procedure.
8. Backup, rollback and forensic recovery are first-class requirements; RPO should be as close to zero as practical for critical state.
9. Changes are validated before promotion; health checks and rollback are mandatory.
10. Install/deploy scripts are designed to be idempotent.

### 2026-08-30 production-hardening implementation
Implemented on branch `hardening/oci-a1-production-baseline` before promotion to `main`:

- Docker health checks for Agent Zero and Hermes.
- Bounded Docker JSON log rotation.
- `backup.sh`: timestamped persistent-volume archives plus SHA-256 manifest.
- `restore.sh`: checksum verification, deterministic volume restore, restart and post-restore verification.
- `verify.sh`: Compose validation, service-state checks and localhost Agent Zero probe.
- `deploy.sh`: pre-deploy backup, pull/build, promotion verification and automatic restore path on failure.
- `oci-instance-principal-check.py`: validates OCI SDK authentication through instance principals, avoiding a long-lived API private key on the VM.
- GitHub Actions validation gate: shell syntax, Python syntax, Compose model and basic committed-secret detection.
- Fixed Compose volume naming so backup/restore targets the actual persistent volumes deterministically.
- Fixed rollback path so a custom `BACKUP_ROOT` is honored by deploy and restore.
- Added `GOVERNANCE.md` as the permanent OOS/AI Agenti change protocol.

### Permanent governance rule
From this point forward, material OOS/AI Agenti work follows:

**Inspect → reconcile → correct → test → journal → Git → verify.**

This means every substantial change must first inspect current implementation and earlier decisions, reconcile the change with OOS architecture and other project components, correct contradictions or duplication before adding more code, test normal and failure paths, update the Master Journal and Git in the same change set, and verify the resulting state before promotion.

A reusable component belongs in shared OOS only if it is part of the trust/policy/provenance/routing kernel or is demonstrably reusable by at least two project verticals without duplicating most of the implementation. Otherwise it remains project-specific or a provider adapter.

### Backup / rollback philosophy
A backup that has never been restored is not considered proven. Restore testing is part of acceptance. Persistent state is backed up before deployment. Failed deployment triggers recovery of the last backed-up state and verification. Forensic evidence/logs should be preserved before destructive repair when a security incident is suspected.

### GitHub deployment policy
GitHub is the versioned source of truth, but GitHub Actions does **not** receive broad OCI tenancy credentials. Validation runs in GitHub. Production deployment should execute on the OCI node or a tightly scoped runner using OCI instance-principal permissions. Promotion to `main` occurs only after validation of the hardening branch.

### Integration model
Human / ChatGPT control plane
→ GitHub versioned configuration
→ OCI CLI/SDK infrastructure automation
→ Hermes Agent (persistent reasoning/learning)
→ Agent Zero (isolated execution worker)
→ approved external services/tools

Critical data stores and secrets remain outside the unrestricted agent execution path.

### Correction log
- Previous `zero-agent-installer.zip` targeted AppDynamics Zero Agent. It is deprecated for this project.
- Correct project component is **Agent Zero AI framework** (`agent0ai/agent-zero`).
- Backup/restore initially assumed literal Docker volume names while Compose could prefix them; fixed by explicit volume names.
- Rollback initially hard-coded `/var/backups/ai-agents/latest`; fixed to honor `BACKUP_ROOT`.

### Acceptance gate before production
1. GitHub validation workflow green.
2. `docker compose config -q` passes on ARM64 node.
3. Both services start within assigned 2 OCPU / 12 GB envelope.
4. Agent Zero remains localhost-only unless protected gateway is deliberately configured.
5. Instance-principal check passes with only the minimum OCI IAM policy required.
6. Backup is created and SHA-256 verification passes.
7. Restore test succeeds on disposable/test state.
8. Failed-deploy simulation successfully returns to a verified state.
9. Logs are sufficient for reconstruction/forensics.
10. Only then promote branch to `main`.
