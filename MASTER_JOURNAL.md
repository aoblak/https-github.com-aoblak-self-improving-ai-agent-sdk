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
- `oci-instance-principal-check.py`: validates OCI SDK authentication through instance principals.
- GitHub Actions validation gate.
- Fixed deterministic Compose volume naming and `BACKUP_ROOT` rollback path.
- Added `GOVERNANCE.md`.

### Permanent governance rule
**Inspect → reconcile → correct → test → journal → Git → verify.**

A reusable component belongs in shared OOS only if it is part of the trust/policy/provenance/routing kernel or is demonstrably reusable by at least two project verticals without duplicating most of the implementation. Otherwise it remains project-specific or a provider adapter.

### Backup / rollback philosophy
A backup that has never been restored is not considered proven. Restore testing is part of acceptance. Unknown external effects are never replayed blindly.

### GitHub deployment policy
GitHub is the versioned source of truth, but GitHub Actions does **not** receive broad OCI tenancy credentials. Production deployment should execute on the OCI node or a tightly scoped runner using OCI instance-principal permissions.

### Integration model
Human / ChatGPT control plane → GitHub → OCI CLI/SDK → Hermes → Agent Zero → approved services/tools. Critical data stores and secrets remain outside unrestricted agent execution.

### Correction log
- Previous `zero-agent-installer.zip` targeted AppDynamics Zero Agent; deprecated.
- Correct component is Agent Zero AI framework.
- Compose volume naming and rollback path defects corrected.

### Acceptance gate before production
CI green; ARM64 Compose passes; services fit resource envelope; localhost-only worker; minimum IAM; backup/checksum; restore test; failed-deploy recovery; sufficient forensic logs; then promotion.

## 2026-08-30 — GitHub portfolio consolidation

GitHub account is being reorganized around **OOS as flagship trustworthy AI operating layer with a small number of real-world verticals proving it**. Canonical audit: `docs/GITHUB_PORTFOLIO_AUDIT.md`.

Preferred future public repos: `oos`, `nera`, `aljosa-oblak`, public-safe `arcanina`, later `chc`, and at most one independently useful developer tool.

Current OOS source repo is retained until hardening acceptance. AI-agent/browser/content experiments are forensic sources for reusable OOS components. Dog-finder repos reconcile into NERA. Dunja/OnlineTravels/PremanturaRent and client work remain private. Upstream/template repos are removed from public identity after history checks.

Permanent cleanup sequence: **private first → inspect history → extract original code → verify replacement → journal → delete/archive only when proven safe.**

## 2026-08-30 — Cursor Developer Plane integration

Cursor is adopted as the **Developer Plane**. It is a codebase-aware implementation/refactoring/testing surface, not another canonical brain.

Canonical planes:
- Control: human + ChatGPT.
- Developer: Cursor + local tests/worktrees.
- Source/Governance: GitHub + governance/journal/docs.
- Agent: Hermes + Agent Zero.
- Infrastructure: OCI.
- Data: DB/backups/secrets outside unrestricted agents.

Cursor receives governance via `.cursor/rules/oos-governance.mdc`; least-privilege MCP only; production publishing/deployment remains deterministic; no production DB access by default. Detailed model: `docs/CURSOR_INTEGRATION.md`.

## 2026-08-30 — OOS competitive benchmark and strategic correction

### Finding
A current-market comparison found that OOS overlaps with several mature agent/runtime projects. The closest benchmark is **Dapr Agents v1.0**, with Microsoft Agent Framework durable workflows, OpenAI Agents SDK, Google ADK/Agents CLI and Temporal covering major adjacent capabilities.

### Important correction
OOS must **not** attempt to rebuild a complete Dapr/Temporal/ADK/OpenAI-style agent framework. Those systems can become replaceable substrates/providers beneath OOS. OOS should remain a thin provider-neutral **trust and control plane**.

### Where OOS is differentiated
- explicit 0–4 risk/authority model;
- human sovereignty and hard legal/physical/safety boundary;
- Edge Gate / Hidden Brain / Simulator / Execution / Data separation;
- destructive qualification and evidence-before-acceptance philosophy;
- unknown external effects are not blindly replayed;
- restore/forensics/rollback are acceptance concerns rather than afterthoughts;
- cross-provider and cross-vertical policy/provenance model.

These advantages are currently architectural claims, not production-proven advantages.

### Where OOS is behind
Production competitors already have durable workflow execution, checkpoint/recovery, identity, state stores, tracing/metrics, evals, MCP/A2A interoperability, sandboxing, developer CLIs, scale, polished SDKs and operational ecosystems. Dapr additionally exposes cryptographic agent identity and signed/verifiable workflow histories.

### New implementation priorities
P0: Durable Task Ledger; idempotency/external-effect semantics; executable PolicyEngine/CapabilityGuard; cryptographically task-bound approvals; tamper-evident provenance; provider contract/conformance suite.

P1: OpenTelemetry; versioned Task Envelope; machine-readable Project/Capability/Provider Registry; failure-injection Simulator; workload identity/secret broker; MCP then A2A adapters.

P2: CLI/5-minute quickstart; eval datasets; operator UI; HA/multi-node; public SDK/reference adapters.

### Public maturity rule
Do not describe OOS as production-ready until a reference demonstration proves: same Task Envelope across >=2 providers; risk-3 action blocked without valid approval; safe resume after failure; no duplicate irreversible external effect; tamper detection; controlled provider failure; verified restore; reproducible failure simulation.

Detailed benchmark: `docs/OOS_COMPETITIVE_GAP_2026-08-30.md`.
