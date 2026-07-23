#!/bin/sh

set -eu

log_color() {
  color_code="$1"
  shift
  printf "\033[${color_code}m%s\033[0m\n" "$*" >&2
}

log_red()   { log_color "0;31" "$@"; }
log_blue()  { log_color "0;34" "$@"; }
log_task()  { log_blue " %s" "$@"; }
log_error() { log_red " %s" "$@"; }

error() {
  log_error "$@"
  exit 1
}

chezmoi="$(command -v chezmoi || true)"
if [ -z "${chezmoi}" ]; then
  bin_dir="${HOME}/.local/bin"
  chezmoi="${bin_dir}/chezmoi"
  log_task "Installing chezmoi to '${chezmoi}'"
  if command -v curl >/dev/null; then
    chezmoi_install_script="$(curl -fsSL https://get.chezmoi.io)"
  elif command -v wget >/dev/null; then
    chezmoi_install_script="$(wget -qO- https://get.chezmoi.io)"
  else
    error "To install chezmoi, you must have curl or wget."
  fi
  sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
  chezmoi="${bin_dir}/chezmoi"
  unset chezmoi_install_script bin_dir
fi

# If git isn't installed, attempt to install it via the system package manager
if ! command -v git >/dev/null 2>&1; then
  log_task "git not found, attempting to install..."
  if command -v dnf >/dev/null; then
    dnf install -y git
  elif command -v apt-get >/dev/null; then
    apt-get update -qq && apt-get install -y -qq git
  elif command -v apk >/dev/null; then
    apk add git
  elif command -v pacman >/dev/null; then
    pacman -S --noconfirm git
  elif command -v zypper >/dev/null; then
    zypper install -y git
  else
    error "git is required. Install git manually and re-run."
  fi
fi

# Create a git wrapper for environments with older git (< 2.35) that don't support zdiff3
GIT_WRAPPER_DIR="$(mktemp -d /tmp/git-wrapper-XXXXXX)"
GIT_PATH="$(command -v git)"
cat > "${GIT_WRAPPER_DIR}/git" << GITEOF
#!/bin/sh
exec ${GIT_PATH} -c merge.conflictstyle=diff3 "\$@"
GITEOF
chmod +x "${GIT_WRAPPER_DIR}/git"
export PATH="${GIT_WRAPPER_DIR}:${PATH}"

REPO_URL="https://github.com/santoshkal/chezmoi"
CHEZMOI_SOURCE="${HOME}/.local/share/chezmoi"

# Detect if we're running from within the repo (install.sh inside home/)
if [ -f "$(dirname "$0")/../.chezmoiroot" ] 2>/dev/null; then
  SCRIPT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
  REPO_ROOT="$(cd -P -- "${SCRIPT_DIR}/.." && pwd -P)"
else
  # Running standalone (piped from curl/wget) — clone the repo
  REPO_ROOT="${CHEZMOI_SOURCE}"
  if [ ! -d "${REPO_ROOT}" ]; then
    log_task "Cloning dotfiles repo to ${REPO_ROOT}"
    mkdir -p "${HOME}/.local/share"
    git clone "${REPO_URL}" "${REPO_ROOT}"
  fi
fi

# Ensure the repo is at the default chezmoi source location
if [ "${REPO_ROOT}" != "${CHEZMOI_SOURCE}" ]; then
  if [ ! -e "${CHEZMOI_SOURCE}" ]; then
    log_task "Setting up chezmoi source at ${CHEZMOI_SOURCE}"
    mkdir -p "${HOME}/.local/share"
    if ln -s "${REPO_ROOT}" "${CHEZMOI_SOURCE}" 2>/dev/null; then
      log_task "Symlinked ${REPO_ROOT} → ${CHEZMOI_SOURCE}"
    else
      log_task "Copying repo to ${CHEZMOI_SOURCE}"
      cp -a "${REPO_ROOT}/." "${CHEZMOI_SOURCE}/"
    fi
  fi
fi

set -- init --source="${CHEZMOI_SOURCE}" --verbose=false "$@"

# Auto-detect non-interactive mode (container/CI)
if [ ! -t 0 ] || [ -n "${CI:-}" ] || [ -n "${DEVCONTAINER:-}" ] || [ -f /.dockerenv ] || { [ "$(id -u)" -eq 0 ] && [ -f /proc/1/cgroup ] && grep -q "docker\|containerd" /proc/1/cgroup 2>/dev/null; }; then
  set -- "$@" --force --promptDefaults
fi

if [ -n "${DOTFILES_ONE_SHOT:-}" ]; then
  set -- "$@" --one-shot
else
  set -- "$@" --apply
fi

if [ -n "${DOTFILES_DEBUG:-}" ]; then
  set -- "$@" --debug
fi

log_task "Running 'chezmoi $*'"
exec "${chezmoi}" "$@"
