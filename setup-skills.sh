#!/usr/bin/env bash
# setup-skills.sh — AI agent skill setup for Next.js projects
# Usage: bash setup-skills.sh [--agent antigravity|opencode|all]

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

log()     { echo -e "${GREEN}✓${NC} $1"; }
info()    { echo -e "${BLUE}→${NC} $1"; }
warn()    { echo -e "${YELLOW}!${NC} $1"; }
error()   { echo -e "${RED}✗${NC} $1"; exit 1; }
section() { echo -e "\n${BLUE}── $1 ──────────────────────────────────${NC}"; }

PROJECT_TYPE="nextjs"
AGENT_FLAGS=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --agent)
      shift
      case "$1" in
        antigravity) AGENT_FLAGS="-a antigravity" ;;
        opencode)    AGENT_FLAGS="-a opencode" ;;
        all)         AGENT_FLAGS="-a antigravity -a opencode" ;;
        *)           error "Agent not recognized: $1. Use antigravity, opencode or all." ;;
      esac
      shift ;;
    -h|--help)
      echo "Usage: bash setup-skills.sh [--agent antigravity|opencode|all]"
      exit 0 ;;
    *) error "Unrecognized argument: $1. Use --help for instructions." ;;
  esac
done

if [[ -z "$AGENT_FLAGS" ]]; then
  echo ""
  echo "  Agent target:"
  echo "  1) Antigravity"
  echo "  2) OpenCode"
  echo "  3) Both (recommended)"
  echo ""
  read -rp "  Choice [1-3]: " agentchoice
  case "$agentchoice" in
    1) AGENT_FLAGS="-a antigravity" ;;
    2) AGENT_FLAGS="-a opencode" ;;
    3) AGENT_FLAGS="-a antigravity -a opencode" ;;
    *) error "Invalid choice." ;;
  esac
fi

echo ""
info "Project: Next.js | Agent: ${AGENT_FLAGS/-a /}"
echo ""

if ! command -v npx &>/dev/null; then
  error "npx not found. Please install Node.js before continuing."
fi

install_skill() {
  local repo="$1"
  local skill_flags="$2"
  info "Installing from ${repo} ${skill_flags}..."
  # shellcheck disable=SC2086
  npx --yes skills add "$repo" $skill_flags $AGENT_FLAGS || true
  log "OK: ${repo}"
}

section "Common skills"
install_skill "obra/superpowers" \
  "--skill systematic-debugging test-driven-development verification-before-completion"
install_skill "anthropics/skills" "--skill webapp-testing"

section "Next.js / React skills"
install_skill "vercel-labs/agent-skills" \
  "--skill vercel-react-best-practices web-design-guidelines vercel-composition-patterns"
install_skill "vercel-labs/next-skills" "--skill next-best-practices"
install_skill "nextlevelbuilder/ui-ux-pro-max-skill" "--skill ui-ux-pro-max"
install_skill "wshobson/agents" "--skill tailwind-design-system"
install_skill "shadcn/ui" "--skill shadcn"
install_skill "better-auth/skills" "--skill better-auth-best-practices"
install_skill "supabase/agent-skills" "--skill supabase-postgres-best-practices"

section "Tech stack context"
info "TECH_STACK.md is structurally included in .ai/context/TECH_STACK.md"

section "Setup complete"
echo ""
echo "  Skills installed for: Next.js"
echo ""
echo "  Next steps:"
echo "  1) Review .ai/context/TECH_STACK.md and adjust versions"
echo "  2) Run /setup to generate project context"
echo "  3) Verify skills: npx skills list"
echo ""
