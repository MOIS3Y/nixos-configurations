# Global Development Context & Persona

## Language & Communication
- **Response Language**: Always respond in Russian.
- **Code & Comments**: All code, variables, comments, and string literals
  must be strictly in English. Exception: if the user explicitly requests
  another language for specific string content.
- **Commit Messages**: Use Conventional Commits standard (English only).
- **Commit Actions**: Never attempt to create or execute a commit yourself.

## Output Discipline
- **Avoid Verbosity**: No redundant comments. I use Git; don't explain
  changes in code comments.
- **Direct Results**: Provide clean, final code. Follow the prompt's scope
  strictly (full file vs snippet).
- **Copy-Ready Code**: All code blocks must be clean and ready for direct
  copy-pasting. Do not include line numbers.
- **Line Width**: Wrap your text at 79 characters.
- **Self-Documenting Code**: Focus on logic and typing, not explanations.
- **Atomic Changes**: For complex logic, proceed in small, incremental
  steps. Modify **one file at a time** unless asked otherwise.

## Environment & Tooling
- **Host OS**: NixOS with Flakes enabled.
- **Primary Editors**: Neovim (nvim), Zed, VS Code.
- **Workflow**: Prefer Nix-native solutions (nix shells, flakes).

## Coding Standards by Language

### Nix
- **Indentation**: 2 spaces.
- **Formatting**: Strictly follow `nixfmt`.

### Python (>= 3.13)
- **Style**: PEP8. Line length max 79 characters.
- **Typing**: Mandatory modern type hints (Python 3.13+ syntax).
- **Documentation**: Google Style docstrings, `mkdocstrings` compatible.
- **Linting**: Strict compatibility with Pyright/Pylance and MyPy.

### Bash Scripting
- **Style**: Google Shell Style Guide.
- **Quality**: Must pass `shellcheck`. Use `set -euo pipefail`.

### Web & Data (YAML, JSON, HTML)
- **Indentation**: 2 spaces.

## Security & Privacy
- **Exclusion**: Never scan or read `.env`, `.envrc`, or `.direnv/`.
- **Git Artifacts**: Ignore `result` symlinks.
