---
description: New project setup protocol - interrogate requirements and generate context documentation
---

## Steps

1. Read `AGENTS.md` and `.ai/context/TECH_STACK.md`. Activate **PLANNING MODE**. 

2. **Interrogate**: Follow the interrogation framework in `.ai/prompts/project_setup.md` to run discovery with the user. Ask questions phase by phase.

3. **Context Generation**: Once approved, generate/update:
   - `.ai/context/TECH_STACK.md` (project-specific versions)
   - `.ai/context/PRD.md` (high-level product definition)
   - `.ai/context/APP_FLOW.md` (user journeys/architecture)

4. **Initialize Memory**: Update `.ai/memory/progress.md` with the initial status.

5. **Ready**: Confirm setup is complete. Suggest running `/feature` to start the first task.

