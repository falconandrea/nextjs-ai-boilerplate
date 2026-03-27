---
description: New feature workflow - create a PRD, get approval, generate tasks
---

## Steps

1. Activate **PLANNING MODE**. Use `.ai/context/TECH_STACK.md` as the source of truth for versions.

2. **Interrogate**: Ask the user to describe the feature. Ask clarifying questions until the scope is defined.

3. **PRD**: Write the PRD in `.ai/features/[feature-name]/prd-[feature-name].md` using the template at `.ai/features/_TEMPLATE.md`. Get user approval.

4. **Tasks**: Generate a detailed task list in `.ai/features/[feature-name]/tasks-[feature-name].md`. Break it into atomic, testable steps.

5. **ACTING MODE**: Once approved, start implementation. Update `.ai/memory/progress.md` as tasks are completed.

6. **Review**: After implementation, enter **REVIEW MODE** to check for potential bugs or violations of `AGENTS.md`.

7. **Lessons**: If a bug was fixed or a new pattern discovered, update `.ai/memory/lessons.md`.

