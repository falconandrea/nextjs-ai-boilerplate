# 🤖 AI Agent Development Template

A production-ready template for building Next.js 15+ projects with AI agents. Combines **persistent project memory** with the **skills ecosystem** (skills.sh) to give agents both procedural knowledge and project-specific context — without context drift across sessions.

Compatible with Antigravity, OpenCode, Claude Code, and any agent that reads `AGENTS.md`.

## What is This?

Two problems kill AI-assisted development:

1. **Context drift** — the agent forgets what was built, what went wrong, what decisions were made
2. **Procedural ignorance** — the agent doesn't know your stack's best practices and reinvents them badly every time

This template solves both. The `.ai/` folder handles project memory (state specific to *this* project). The skills ecosystem handles procedural knowledge (best practices for React, Next.js, security, testing — maintained by the community).

## Quick Start

### 1. Clone and initialize

```bash
git clone <this-repo> my-new-project
cd my-new-project
rm -rf .git && git init
```

### 2. Install skills

```bash
bash setup-skills.sh
```

Or with arguments:

```bash
bash setup-skills.sh --agent all
bash setup-skills.sh --agent opencode
bash setup-skills.sh --agent antigravity
```

The script will install the following skills:

#### General

| Skill | What it covers |
|---|---|
| systematic-debugging | Structured debug before fixing |
| test-driven-development | TDD workflow |
| webapp-testing | Playwright, seeds, auth |
| verification-before-completion | Self-check before marking done |

#### Next.js

| Skill | What it covers |
|---|---|
| vercel-react-best-practices | Server Components, no-useEffect, performance |
| next-best-practices | App Router, Server Actions, caching |
| vercel-composition-patterns | Component design patterns |
| web-design-guidelines | Typography, spacing, accessibility |
| ui-ux-pro-max | UX patterns, animations |
| tailwind-design-system | Tailwind tokens and scale |
| shadcn | shadcn/ui usage |
| better-auth-best-practices | Auth and session handling |

To keep skills up to date:

```bash
npx skills check    # see what has updates
npx skills update   # update everything
```

### 3. Run project setup

**Antigravity / OpenCode:**
```
/setup
```

**Other agents:** paste `.ai/prompts/project_setup.md` in chat and answer the questions.

### 4. Start building

```
/start            → restores full session context
/feature [desc]   → plan mode: PRD + task list
```

---

## Repository Structure

```
.
├── AGENTS.md                 # Always-on rules (no useEffect, TS strict, naming...)
├── setup-skills.sh           # Skill installer + TECH_STACK setup — run once per project
│
└── .ai/
    ├── context/              # Project-specific docs (filled during /setup)
    │   ├── TECH_STACK.md
    │   ├── PRD.md
    │   └── APP_FLOW.md
    │
    ├── memory/               # Persistent AI memory — never delete
    │   ├── progress.md
    │   ├── lessons.md
    │   └── blockers.md
    │
    ├── features/             # One folder per feature
    │   ├── _TEMPLATE.md
    │   └── [feature-name]/
    │       ├── prd-*.md
    │       └── tasks-*.md
    │
    ├── prompts/              # For agents without slash commands
    │   ├── project_setup.md
    │   ├── create_prd.md
    │   ├── generate_tasks.md
    │   ├── refactoring.md
    │   └── deployment.md
    │
    └── workflows/
        ├── start.md          # /start
        ├── setup.md          # /setup
        └── feature.md        # /feature
```

---

## How It Works

### Two layers, two jobs

| Layer | What it contains | Who maintains it |
|---|---|---|
| `AGENTS.md` + skills | Procedural knowledge — how to write good code | Community + you |
| `.ai/memory/` + `.ai/context/` | Project state — what was built, decided, broken | You + the agent |

### Session flow

1. Agent reads `AGENTS.md` (always-on rules)
2. `/start` → reads `memory/progress.md`, `memory/lessons.md`, `memory/blockers.md`
3. Agent picks up exactly where you left off

### Feature flow

1. `/feature [description]` → plan mode
2. Clarifying questions → PRD → task list
3. Exit plan mode → implement

---

## Slash Commands

| Command | File | What it does |
|---|---|---|
| `/start` | `workflows/start.md` | Reads memory, summarises state |
| `/setup` | `workflows/setup.md` | Full discovery → generates context docs |
| `/feature` | `workflows/feature.md` | Plan mode → PRD → task list |

## Supported Stacks

**Next.js 15+** — React 19, TypeScript strict, App Router, Tailwind v4 + shadcn/ui

---

## License

MIT — use freely for any project.

---

Built to make AI-assisted development actually work across sessions.