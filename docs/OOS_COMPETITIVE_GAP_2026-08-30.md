# OOS Competitive Gap — 2026-08-30

## Executive conclusion
OOS has a differentiated architecture thesis, but its implementation maturity is materially behind production-grade agent runtimes. The closest current benchmark is Dapr Agents v1.0, followed by Microsoft Agent Framework durable workflows, OpenAI Agents SDK, Google ADK/Agents CLI, and Temporal as a durable-execution substrate.

OOS should not try to out-framework these projects. Its strongest position is a thin trust/control plane that can orchestrate or wrap replaceable agent frameworks and execution providers.

## Where OOS is currently ahead conceptually
1. Explicit risk taxonomy (0–4) tied to approval authority, including a hard boundary for legal/physical/safety-critical action.
2. Human sovereignty as an architecture invariant rather than an optional HITL feature.
3. Separation of Edge Gate, Hidden OOS Brain, Second Brain/Simulator, execution providers, and source-of-truth/data plane.
4. Destructive qualification philosophy: break → observe → correct → regression test → evidence → accept/restrict/reject.
5. Provider/executor replaceability as a first-order design goal; Hermes/Agent Zero are providers, not the kernel.
6. Explicit recovery/forensics philosophy: unknown external effects are not blindly replayed; rollback must preserve history; backup is not accepted until restore is proven.
7. Cross-vertical governance: NERA, ArcaNina, Dunja, CHC and future systems share policy/provenance/capability abstractions without forcing domain code into the kernel.

These are architectural advantages only until backed by executable tests and a stable public API.

## Where competitors are ahead
### Dapr Agents v1.0 — largest gap
- Production-ready GA runtime.
- Durable workflow-backed agent execution and deterministic workflows.
- Persistent state and recovery without repeating completed LLM/tool work.
- Cryptographic agent identity.
- Cryptographically signed/verifiable workflow histories.
- mTLS, access control, secrets, resiliency policies.
- Pub/Sub, state stores, service invocation, observability and Kubernetes scale.
- MCP and cross-framework agents-as-tools.

### Microsoft Agent Framework
- Durable task integration and checkpointed multi-agent orchestration.
- Workflow checkpoint storage and resume/rehydration.
- Mature Azure operational path.

### OpenAI Agents SDK
- Very small and polished programming model.
- Handoffs, agents-as-tools, sessions, HITL and MCP.
- Input/output/tool guardrails.
- First-class tracing and deterministic provider-neutral testing utilities.
- Sandbox agents and resumable sandbox sessions.

### Google ADK / Agents CLI
- Full developer lifecycle: scaffold, build, eval, deploy, observe and publish.
- A2A-oriented distributed agent patterns.
- Sandboxed persistent code execution through Agent Runtime.
- Mature eval datasets and CI/CD/deployment tooling.
- Direct support for coding environments including Cursor.

### Temporal
- Mature durable execution substrate for long-running stateful systems.
- Operational ecosystem and proven scale far beyond current OOS implementation.

## OOS implementation gaps — priority order
P0
1. Durable Task Ledger / event history with idempotency keys and explicit external-effect semantics.
2. Resume/replay model that distinguishes pure/replayable operations from irreversible external effects.
3. Executable PolicyEngine + CapabilityGuard enforcing risk levels, not documentation only.
4. Approval objects that are cryptographically bound to task, actor, capability, parameters, risk and expiry.
5. Tamper-evident provenance/audit chain.
6. Provider contract and conformance tests so providers are genuinely replaceable.

P1
7. OpenTelemetry-compatible traces, metrics and structured logs.
8. Stable Task Envelope schema + versioning.
9. Project/Capability/Provider Registry as machine-readable configuration.
10. Simulator/failure-injection harness with acceptance gates.
11. Secret broker and workload identity abstraction.
12. MCP adapter and eventually A2A interoperability rather than proprietary tool wiring.

P2
13. Developer CLI and 5-minute quickstart.
14. Evaluation datasets and regression scoring.
15. Web/operator console.
16. Multi-node scale, queues and HA.
17. Public SDK and reference adapters.

## Strategic recommendation
Do not build a replacement for Dapr, Temporal, OpenAI Agents SDK or ADK. Treat them as candidate providers/substrates beneath OOS where appropriate.

Target architecture:

Project → OOS Task Envelope → Identity/Auth → CapabilityGuard → Policy/Risk → Approval → Durable Task Ledger → Provider Router → Dapr/OpenAI/ADK/Hermes/Agent Zero/etc. → Result/External Effect → Provenance/Audit → Verification

OOS differentiation should be: policy authority, cross-provider trust, evidence, approval, provenance, rollback/recovery semantics, simulation and vertical governance.

## Near-term acceptance target
OOS should not be described publicly as production-ready until a reference demo proves:
- same Task Envelope runs through at least two providers;
- risk-3 operation cannot execute without valid approval;
- process/node failure resumes safely;
- irreversible external effect is not duplicated after restart;
- audit/provenance chain detects tampering;
- provider outage triggers controlled failover or safe stop;
- restore is executed and verified;
- simulator can reproduce a recorded failure.

## Competitive position (current)
Conceptual architecture: 8.5/10
Trust/governance model: 9/10
Provider independence: 8/10 concept, 3/10 proven
Durability/recovery implementation: 3/10
Observability/evals: 2/10
Developer experience: 3/10
Scale/production maturity: 2/10
Public packaging/ecosystem: 2/10

Overall today: strong architecture/research prototype, not yet a competitor to mature runtimes. The opportunity is to become a provider-neutral trust and control plane above them rather than competing head-on.