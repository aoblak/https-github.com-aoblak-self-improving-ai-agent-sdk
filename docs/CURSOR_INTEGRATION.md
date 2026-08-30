# Cursor Integration — OOS Developer Plane

Status: proposed production baseline, 2026-08-30.

## Role

Cursor is the OOS **Developer Plane**: local/codebase-aware implementation, refactoring, testing and review. It is not the persistent OOS brain, production worker, source of truth or policy authority.

## Plane model

1. **Control Plane** — human + ChatGPT architecture/coordination.
2. **Developer Plane** — Cursor editor/CLI, git worktrees, tests and controlled `gh` operations.
3. **Source/Governance Plane** — GitHub, `GOVERNANCE.md`, `MASTER_JOURNAL.md`, architecture/runbooks.
4. **Agent Plane** — Hermes persistent reasoning/orchestration + Agent Zero isolated execution.
5. **Infrastructure Plane** — OCI CLI/SDK and Oracle A1 runtime.
6. **Data Plane** — databases, backups and secrets outside unrestricted agent paths.

## Cursor primitives we use

- `AGENTS.md` / `.cursor/rules`: versioned project instructions.
- Plan/Ask modes for inspection before edits.
- Agent mode for bounded implementation.
- `--worktree` for isolated changes.
- MCP only for explicitly approved external capabilities.
- CLI/headless mode may be used for deterministic automation, but publishing/deployment remains a separate controlled step.
- ACP is optional for future OOS-to-Cursor integration; it is not required for the baseline.

## Security model

Cursor should receive only the minimum permissions required for the current development task. Deny access to `.env*`, private keys and production secrets. Avoid broad MCP wildcards. Avoid autonomous destructive `git`, `gh`, cloud or production operations. Prefer deterministic CI/workflow steps for publishing and deployment.

GitHub Actions may use Cursor for bounded analysis or file generation, but Git operations, release publication and deployment should be performed by explicit deterministic workflow steps with scoped credentials.

## Integration with Hermes and Agent Zero

Cursor edits and tests the implementation. It does not duplicate Hermes memory/learning or Agent Zero production execution. Shared state flows through versioned repository artifacts and approved OOS interfaces, not hidden cross-agent memory.

## Recommended local workflow

1. `agent --mode=ask` — inspect/review current code.
2. `agent --mode=plan` — produce implementation plan.
3. Create/use isolated worktree.
4. Agent implements bounded change.
5. Run tests and failure-path verification.
6. Review diff.
7. Update Master Journal for material changes.
8. Commit/push branch.
9. CI validates.
10. Human/OOS acceptance gate before merge or production action.

## Non-goals

- Cursor is not the canonical memory store.
- Cursor is not allowed to bypass OOS policy/approval.
- Cursor is not a replacement for Hermes or Agent Zero.
- Cursor is not given production database/source-of-truth access by default.
