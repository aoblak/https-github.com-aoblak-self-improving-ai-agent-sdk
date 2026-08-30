# AI Agenti / OOS Governance Rules

## Mandatory change protocol

Every material change to architecture, infrastructure, shared capabilities, deployment, security policy or project integration follows this sequence:

1. **Inspect current state first.** Read the relevant code, configuration, Master Journal entries, current branch state and project dependencies before making assumptions.
2. **Reconcile with OOS architecture.** Decide whether the change belongs to the trusted OOS core, a shared capability, a provider/adapter, infrastructure, or a project-specific vertical.
3. **Find contradictions and duplication.** Compare the proposed change with existing components and earlier decisions. Prefer reuse over parallel implementations.
4. **Correct before extending.** If an existing implementation is unsafe, inconsistent or technically wrong, fix it first instead of layering new work on top.
5. **Test destructively.** Validate normal operation, failure paths, rollback, restore, least privilege, dependency loss and recovery. A component is not accepted merely because the happy path works.
6. **Preserve source of truth.** Critical data and secrets remain outside unrestricted agent execution paths. Git contains code/configuration, never production secrets.
7. **Update documentation in the same change set.** Material implementation changes require corresponding Master Journal and operational documentation updates.
8. **Keep Git and Master Journal synchronized.** Architecture decisions, corrections, accepted patterns, deprecations and major test findings are committed together with the related implementation or immediately after it.
9. **Use branches for unproven changes.** Changes stay outside `main` until the acceptance gate is satisfied.
10. **Promote only verified state.** Merge to `main` only after validation, rollback/restore verification and architecture consistency review.

## OOS classification rule

A component belongs in the OOS shared layer only when at least one of the following is true:

- it is required for trust, identity, policy, risk, provenance, audit or routing; or
- it is demonstrably reusable by two or more project verticals without duplicating most of its implementation.

Everything else stays in a project vertical or provider adapter.

## Permanent operating rule

**Inspect → reconcile → correct → test → journal → Git → verify.**

This protocol is the default for future AI Agenti / OOS work unless a documented exception is explicitly approved.
