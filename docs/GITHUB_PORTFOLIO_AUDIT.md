# GitHub Portfolio Audit — aoblak

Date: 2026-08-30
Status: canonical cleanup plan; destructive/admin actions are blocked until repository-settings permissions are available.

## Operating rule

No repository is deleted merely because it looks obsolete. First inspect, preserve original/useful code, reconcile with OOS, verify the replacement, journal the decision, then archive/private/delete the superseded repository.

## Target public profile

The public profile should tell one coherent story: **trustworthy AI systems and real-world verticals built on OOS**.

Recommended future public set:

1. `aoblak/oos` — flagship OOS repository (rename/migrate current self-improving-agent SDK repository after validation).
2. `aoblak/nera` — NERA / First Dog OS showcase and OOS vertical.
3. `aoblak/aljosa-oblak` — personal/business portfolio and ecosystem landing page.
4. `aoblak/arcanina` — public-safe showcase layer when separated from private operational/business data.
5. `aoblak/chc` — public architecture/demo layer when mature enough; private operational implementation remains separate.
6. One focused reusable developer tool extracted from the AI-agent work, only if independently useful and documented.

A profile repository `aoblak/aoblak` should later be created for the GitHub profile README.

## Repository classification

### FLAGSHIP / KEEP PUBLIC

- `https-github.com-aoblak-self-improving-ai-agent-sdk` → **FLAGSHIP / RENAME-MIGRATE TO `oos`**. Contains current Master Journal, governance and OCI/Hermes/Agent Zero hardening. Do not delete; promote tested branch first, then rename/migrate when admin operations are available.
- `aljosa-oblak` → **KEEP PUBLIC / PROFILE CASE STUDY**. Real portfolio implementation with React/TypeScript/Vite and a working deployment story.
- `thedogparkfinder` → **KEEP TEMPORARILY / MIGRATE INTO NERA**. It is a concrete dog-park discovery frontend and can seed NERA public showcase. After NERA replacement is verified, archive or redirect this repository.

### MERGE INTO OOS / THEN PRIVATE OR ARCHIVE

- `Turbo-AI-Agent-SDK` → **MERGE**. Private, tiny repository; inspect useful agent-installer concepts and move reusable pieces into OOS.
- `Turbo-AI-Agent` → **MERGE**. Public but effectively empty/tiny; remove from public profile after checking history.
- `ai-agent-web` → **MERGE**. Public README is only a two-line placeholder; useful browser/web-agent code, if any, belongs under an OOS provider/capability module rather than as a public flagship.
- `browser-use` → **MERGE/REFERENCE**. Keep private while determining whether it contains original integration work or an upstream checkout.
- `browser` → **MERGE/PRIVATE**. Small private experiment; preserve only differentiated integration code.
- `AI-Agents-that-think-like-you-Marketing-Video` → **MERGE/PRIVATE**. Extract reusable content/video capability into OOS if original.
- `oblak-ai-content-studio` → **MERGE/PRIVATE**. Candidate OOS content capability/provider; currently private and tiny.

### NERA / DOG VERTICAL

- `thedogparkfinder` → **MIGRATE TO NERA**.
- `thedogfinder_site` → **PRIVATE / MERGE TO NERA**. Small private implementation; reconcile with `thedogparkfinder` and current NERA WordPress/OOS work.

### BUSINESS / HISTORICAL — KEEP PRIVATE

- `dunjaapartments.onlinetravels.co` → **KEEP PRIVATE / HISTORICAL CASE MATERIAL**.
- `onlinetravels.org` → **KEEP PRIVATE / CHC FORENSICS**.
- `premanturarent.com` → **KEEP PRIVATE / CHC V1 FORENSICS**.
- `start-up-shine-page` → **KEEP PRIVATE PENDING CONTENT REVIEW**.
- `marko-becirevic` → **KEEP PRIVATE / CLIENT WORK**.

### REMOVE FROM PUBLIC IDENTITY AFTER OWNERSHIP/HISTORY CHECK

- `github-slideshow` → **DELETE OR PRIVATE**. GitHub training repository; no portfolio value.
- `Next.js` → **DELETE OR PRIVATE**. Generic CodeSandbox/template repository; no portfolio value unless commit history proves substantial original work.
- `netlify-feature-tour` → **DELETE** after confirming no original work.
- `netlify-feature-tour-5bfcf` → **DELETE** after confirming no original work.
- `netlify-feature-tour-707df` → **DELETE** after confirming no original work.
- `netlify-feature-tour-7f3d9` → **DELETE** after confirming no original work.
- `netlify-feature-tour-f0af3` → **DELETE** after confirming no original work.
- `netlify-feature-tour-fd6e9` → **DELETE** after confirming no original work.
- `runner` → **PRIVATE/DELETE OR USE UPSTREAM FORK PROPERLY**. Generic GitHub Actions runner content does not support the desired public identity.
- `navidrome` → **PRIVATE/DELETE OR USE UPSTREAM FORK PROPERLY**. Third-party streaming project does not belong in the flagship portfolio unless there are maintained original changes.
- `hyperframes` → **PRIVATE/DELETE OR KEEP AS PROPER FORK ONLY**. README identifies HeyGen/HyperFrames upstream (`heygen-com/hyperframes`); not an aoblak flagship.
- `recon-skills` → **PRIVATE/DELETE OR KEEP AS PROPER FORK ONLY**. README explicitly points to `uphiago/recon-skills` and `hiago.sh`; not an aoblak flagship and should not be presented as original work.
- `pi-network-marketplace` → **PRIVATE/ARCHIVE PENDING HISTORY REVIEW**. Currently empty/tiny; no current OOS portfolio role.

## Consolidation architecture

```text
GitHub profile: aoblak
│
├── oos                     # flagship trusted AI operating layer
│   ├── core/
│   ├── capabilities/
│   ├── providers/
│   ├── policies/
│   ├── provenance/
│   ├── deploy/
│   ├── docs/
│   └── examples/
│
├── nera                    # first major OOS vertical
├── arcanina                # sessions/content vertical
├── chc                     # federated tourism architecture/demo
├── aljosa-oblak            # ecosystem / personal landing page
└── aoblak                  # GitHub profile README
```

Operational/private repositories remain private and are not part of the public six-repository narrative.

## Public-repository admission gate

A repository is public only when it has:

1. clear original ownership or explicit fork attribution;
2. one-sentence user value proposition;
3. working README and quick start;
4. license and security/contribution posture appropriate to the project;
5. no secrets, personal data, client data, private operational topology or credentials;
6. repeatable build/test/deploy path;
7. a place in the OOS ecosystem map;
8. enough independent value that a stranger can understand why to star or use it.

## Admin operations required

The current ChatGPT GitHub connector confirms admin permission on the repositories but does not expose repository-settings mutations such as visibility change, repository rename, archive, delete, new repository creation or profile pinning.

When repository-settings/admin operations become available, execute in this order:

1. Make all non-approved public repositories private first (reversible safety step).
2. Preserve and migrate differentiated code into OOS/NERA.
3. Verify replacements and links.
4. Delete only confirmed nonsense/upstream duplicates with no unique history worth retaining.
5. Rename/migrate flagship repository to `oos`.
6. Create `aoblak/aoblak`, `aoblak/nera`, and later public-safe `arcanina`/`chc` repositories as needed.
7. Configure topics, descriptions, homepage URLs, branch protection, security policy and six profile pins.

## Immediate next audit

Before destructive changes, inspect commit histories of `Next.js`, `runner`, `navidrome`, `hyperframes`, `recon-skills`, `pi-network-marketplace`, all Netlify feature-tour repositories, and the three public AI-agent placeholders. Any original code is extracted before deletion.
