#!/usr/bin/env bash
# setup.sh — AI agent ecosystem setup for Next.js projects
# Usage: bash setup.sh [--agent antigravity|opencode|all]

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

AGENT_TARGET=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --agent)
      shift
      case "$1" in
        antigravity) AGENT_TARGET="antigravity" ;;
        opencode)    AGENT_TARGET="opencode" ;;
        all)         AGENT_TARGET="all" ;;
        *)           error "Agent not recognized: $1. Use antigravity, opencode or all." ;;
      esac
      shift ;;
    -h|--help)
      echo "Usage: bash setup.sh [--agent antigravity|opencode|all]"
      exit 0 ;;
    *) error "Unrecognized argument: $1. Use --help for instructions." ;;
  esac
done

section "Welcome to Next.js AI Boilerplate"

# 1. Next.js Initialization Check
if [ ! -f "package.json" ]; then
  warn "No package.json found. This seems to be a new project."
  echo ""
  read -rp "  Do you want to initialize a new Next.js project here? [y/N]: " init_next
  if [[ "$init_next" =~ ^[Yy]$ ]]; then
    info "Initializing Next.js project (this might take a minute)..."
    # Using defaults: App Router, TS, Tailwind, ESLint, no src/, npm
    npx create-next-app@latest . --typescript --tailwind --eslint --app --no-src-dir --import-alias "@/*" --use-npm --yes
    log "Next.js initialized successfully."
  else
    warn "Skipping Next.js initialization. Make sure to set it up manually."
  fi
fi

# 2. Agent Selection
if [[ -z "$AGENT_TARGET" ]]; then
  echo ""
  echo "  Which AI agent(s) will you be using?"
  echo "  1) Antigravity"
  echo "  2) OpenCode / Claude Code"
  echo "  3) Both (recommended)"
  echo ""
  read -rp "  Choice [1-3]: " agentchoice
  case "$agentchoice" in
    1) AGENT_TARGET="antigravity" ;;
    2) AGENT_TARGET="opencode" ;;
    3) AGENT_TARGET="all" ;;
    *) error "Invalid choice." ;;
  esac
fi

AGENT_FLAGS=""
case "$AGENT_TARGET" in
  antigravity) AGENT_FLAGS="-a antigravity" ;;
  opencode)    AGENT_FLAGS="-a opencode" ;;
  all)         AGENT_FLAGS="-a antigravity -a opencode" ;;
esac

info "Configuring project for: ${AGENT_TARGET}"

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

section "Installing AI Skills"
install_skill "obra/superpowers" \
  "--skill systematic-debugging test-driven-development verification-before-completion"
install_skill "anthropics/skills" "--skill webapp-testing frontend-design"

section "Next.js / React Specialized Skills"
install_skill "vercel-labs/agent-skills" \
  "--skill vercel-react-best-practices web-design-guidelines vercel-composition-patterns"
install_skill "vercel-labs/next-skills" "--skill next-best-practices"
install_skill "millionco/react-doctor" "--skill react-doctor"
install_skill "nextlevelbuilder/ui-ux-pro-max-skill" "--skill ui-ux-pro-max"
install_skill "wshobson/agents" "--skill tailwind-design-system"
install_skill "shadcn/ui" "--skill shadcn"
install_skill "better-auth/skills" "--skill better-auth-best-practices"
install_skill "supabase/agent-skills" "--skill supabase-postgres-best-practices"

section "Finalizing Setup"
log "TECH_STACK.md is ready in .ai/context/TECH_STACK.md"
log "AGENTS.md is configured in the root"

echo ""
echo -e "${GREEN}Setup complete!${NC}"
echo ""
echo "  Next steps:"
echo "  1) Run '/setup' in your AI agent to generate project context"
echo "  2) Start developing with '/feature [your-feature]'"
echo ""
echo "  To update skills later: npx skills update"
echo ""

