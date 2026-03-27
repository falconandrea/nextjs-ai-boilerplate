# 🚀 NextJS AI Agent Boilerplate

A production-ready template for building Next.js 15+ projects with AI agents. Combines **persistent project memory** with the **skills ecosystem** (skills.sh) to give agents both procedural knowledge and project-specific context — without context drift across sessions.

Compatible with Antigravity, OpenCode, Claude Code, and any agent that reads `AGENTS.md`.

## What is This?

Two problems kill AI-assisted development:

1. **Context drift** — the agent forgets what was built, what went wrong, what decisions were made
2. **Procedural ignorance** — the agent doesn't know your stack's best practices and reinvents them badly every time

This template solves both. The `.ai/` folder handles project memory (state specific to *this* project). The skills ecosystem handles procedural knowledge (best practices for React, Next.js, security, testing — maintained by the community).

## Quick Start

### 1. Choose your path

#### A. New Project (Starting from scratch)
Clone this repo and run setup. It will initialize a fresh Next.js app for you.

```bash
git clone https://github.com/falconandrea/nextjs-ai-boilerplate.git my-app
cd my-app
bash setup.sh
```

#### B. Existing Project (Inject AI agent part)
If you already have a Next.js project, run this from your project root:

```bash
git clone https://github.com/falconandrea/nextjs-ai-boilerplate.git temp-ai
cp -r temp-ai/.ai temp-ai/AGENTS.md temp-ai/setup.sh .
rm -rf temp-ai
bash setup.sh
```

---

### 2. Run Setup

This script handles both **new projects** (initializes Next.js) and **existing projects** (integrates AI agents).

```bash
bash setup.sh
```

Or with arguments:

```bash
bash setup.sh --agent all        # Antigravity + OpenCode
bash setup.sh --agent opencode   # OpenCode / Claude Code only
bash setup.sh --agent antigravity # Antigravity only
```

The script will:
1.  **Initialize Next.js** if `package.json` is missing (using App Router, TS, Tailwind 4).
2.  **Install AI Skills** from the ecosystem (debugging, TDD, Next.js best practices).
3.  **Configure `.ai/` context** for your agents.

#### Installed Skills

| Category | Skills |
|---|---|
| **General** | systematic-debugging, test-driven-development, webapp-testing, verification-before-completion |
| **Next.js & React** | vercel-react-best-practices, next-best-practices, vercel-composition-patterns |
| **UI/UX** | ui-ux-pro-max, tailwind-design-system, shadcn |
| **Backend** | better-auth-best-practices, supabase-postgres-best-practices |

### 3. Run project setup

Once Next.js is ready, tell your agent to initialize the project context:

**Antigravity / OpenCode:**
```
/setup
```

### 4. Start building

```
/start            → restores full session context
/feature [desc]   → plan mode: PRD + task list
```

---

## Repository Structure

```
.
├── AGENTS.md                 # Rules for AI agents (TS strict, no useEffect...)
├── setup.sh                  # One-click setup (Next.js init + AI skills)
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
    ├── prompts/              # System-level guidance
    │   └── project_setup.md
    │
    └── workflows/
        ├── start.md          # /start (Restore context)
        ├── setup.md          # /setup (Initial discovery)
        └── feature.md        # /feature (Plan & Implement)
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