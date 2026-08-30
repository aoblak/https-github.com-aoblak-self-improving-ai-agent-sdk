# OOS / Self-Improving AI Agent SDK

A practical, failure-aware AI agent platform focused on **replaceable providers, bounded execution, provenance, rollback and recovery**.

## Current architecture

- **OOS core** — trust, policy, project/capability registry, routing, provenance and audit.
- **Hermes Agent** — persistent reasoning / learning layer.
- **Agent Zero** — isolated execution and tool worker.
- **OCI CLI + Python SDK** — infrastructure control for the Oracle A1 deployment target.
- **GitHub** — versioned source of truth for code, deployment, governance and the Master Journal.

## Design principles

1. Immutable/trusted core; replaceable providers around it.
2. Least privilege and explicit execution boundaries.
3. Critical data and secrets stay outside unrestricted agent execution.
4. Backup, restore, rollback and forensics are first-class features.
5. Shared OOS capabilities must be genuinely reusable across project verticals.
6. No happy-path-only acceptance: failure modes are tested before promotion.

## Change protocol

**Inspect → reconcile → correct → test → journal → Git → verify.**

See [`GOVERNANCE.md`](GOVERNANCE.md) for the permanent development rules and [`MASTER_JOURNAL.md`](MASTER_JOURNAL.md) for architecture decisions and corrections.

## OCI A1 hardening baseline

The current test branch contains:

- isolated Hermes + Agent Zero services;
- resource limits for a 2 OCPU / 12 GB ARM64 node;
- health checks and bounded logging;
- deterministic volume backup/restore with SHA-256 verification;
- transactional deployment with recovery path;
- OCI instance-principal authentication check;
- GitHub Actions validation without broad OCI tenancy credentials.

Implementation: [`deploy/oci-a1/`](deploy/oci-a1/)

## Status

**Experimental / hardening stage.** The current production baseline is intentionally kept outside `main` until the ARM64 deployment, backup/restore and failed-deployment acceptance tests pass.

## Why this repository exists

Most agent demos optimize for autonomy. This project optimizes for **controlled autonomy that can be reconstructed after failure**.
