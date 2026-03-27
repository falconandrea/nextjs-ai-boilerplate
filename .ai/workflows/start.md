---
description: Session start protocol - read project memory and context, then summarize status to the user
---

## Steps

1. Read the project's main directives file at `AGENTS.md` and `.ai/context/TECH_STACK.md` using the `view_file` tool. Keep all directives and versions in mind.

2. Read `.ai/memory/progress.md`, `.ai/memory/lessons.md`, and `.ai/memory/blockers.md` to understand the current state and avoid past mistakes.

3. After reading these files, present the user with a concise summary **in Italian** covering:
   - **Stato Progetto**: progressi attuali e ultima fase completata.
   - **Blockers**: eventuali problemi aperti.
   - **Lessons**: breve richiamo alle lezioni più recenti da non dimenticare.

4. Ask the user: **"Pronto a continuare! Su cosa lavoriamo oggi?"**