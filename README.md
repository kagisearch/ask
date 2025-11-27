# ask - Claude Code CLI wrapper

A lightweight bash script for querying Claude AI via the Claude Code CLI, optimized for direct, executable output with file editing capabilities.

## Quick start

```bash
# Clone and setup
git clone https://github.com/kagisearch/ask.git
cd ask

chmod +x ask
sudo cp ask /usr/local/bin/

# Install Claude Code CLI first
# Visit: https://claude.com/claude-code

# Test it
ask "Write a hello world in Python"

print("Hello, World!")

[sonnet - 1.23s - 0 tool calls - 12 tokens - $0.0001]
```

We also provide a handy install script.

## Usage

### Basic usage

```bash
ask "ffmpeg command to convert mp4 to gif"
```

### Model selection

```bash
# Default model (Claude Sonnet)
ask "find files larger than 20mb"

# Shorthand flags for quick model switching
ask -s "prompt"  # Claude Sonnet (default, balanced)
ask -o "prompt"  # Claude Opus (most capable, complex reasoning)
ask -h "prompt"  # Claude Haiku (fastest, simple tasks)

# Custom model by name
ask -m haiku "What is 2+2?"
```

### System prompts

```bash
# Custom system prompt
ask --system "You are a pirate" "Tell me about sailing"

# Disable system prompt for raw model behavior
ask -r "What is 2+2?"
```

### File editing

File editing is **enabled by default** in the current working directory:

```bash
# Claude can read and edit files automatically
ask "Read README.md and update it with current features"
ask "Fix the bug in server.js"

# Disable file editing if you only want analysis
ask --no-edits "Just analyze server.js, don't modify it"
```

### Running commands

Claude can run bash commands to gather context:

```bash
# Claude will run git commands for you
ask "Look at git diff and write a commit message"
ask "Run git status and summarize changes"

# Show statistics to see tool usage
ask --stats "Run git status and summarize changes"
```

### Pipe input

```bash
# Pipe as prompt
echo "Fix this code: print('hello world)" | ask

# Pipe as context with --context flag
git diff | ask --context "Write a commit message for this diff"
cat error.log | ask --context "Explain what caused this error"
```

## Options

| Option | Description |
|--------|-------------|
| `-s` | Use Claude Sonnet (default) |
| `-o` | Use Claude Opus |
| `-h` | Use Claude Haiku |
| `-m MODEL` | Use custom Claude model |
| `-r` | Disable system prompt (raw model behavior) |
| `--system TEXT` | Set custom system prompt |
| `--context` | Pipe stdin as context, combine with prompt argument |
| `--no-edits` | Disable file editing (enabled by default) |
| `--permission-mode MODE` | Set permission mode (e.g., acceptEdits) |
| `--allowed-tools TOOLS` | Comma-separated list of allowed tools |
| `--stats` | Show statistics (time, tool calls, tokens, cost) |
| `--debug` | Show system context, prompts, and command (stderr) |
| `--help` | Show help message |

## Common use cases

### Command generation
```bash
# Get executable commands directly
ask "Command to find files larger than 100MB"
# Output: find . -type f -size +100M

ask "ffmpeg command to convert mp4 to gif"
# Output: ffmpeg -i input.mp4 -vf "fps=10,scale=320:-1:flags=lanczos" output.gif
```

### Code generation
```bash
# Generate code snippets
ask "Python function to calculate factorial"

# Code review
cat script.py | ask "Find potential bugs in this code"
```

### File editing and code modification
```bash
# Claude can read and modify files directly
ask "Read server.js and add error handling to the API routes"
ask "Fix the typo in README.md line 42"
ask "Refactor utils.py to use type hints"

# Disable editing for read-only analysis
ask --no-edits "Analyze the performance of this algorithm in sort.js"
```

### Git workflow
```bash
# Claude can run git commands and analyze changes
ask "Look at git diff and write a commit message"
ask "Run git status and tell me what needs attention"
ask "Review the last 3 commits and summarize changes"

# See what Claude is doing with --stats
ask --stats "Run git log --oneline -5 and summarize the recent changes"
# Output: [sonnet - 2.15s - 1 tool calls - 89 tokens - $0.0023]
```

### Quick answers
```bash
# Calculations
ask "What is 18% of 2450?"
# Output: 441

# Technical questions
ask "What port does PostgreSQL use?"
# Output: 5432
```

### Advanced usage
```bash
# Chain commands
ask "List all Python files" | ask "Generate a script to check syntax of these files"

# Use with other tools
docker ps -a | ask "Which containers are using the most memory?"

# Debug mode to see what's happening
ask --debug "Why is my build failing?"
```

## Requirements

### Dependencies
- `bash` - Shell interpreter
- `jq` - JSON parsing for API responses
- `bc` - Performance metrics calculation
- Claude Code CLI - The underlying AI engine

### Installation
1. Install Claude Code CLI from [claude.com/claude-code](https://claude.com/claude-code)
2. Clone this repository
3. Make the script executable: `chmod +x ask`
4. Copy to your PATH: `sudo cp ask /usr/local/bin/`

## Features

- **Direct executable output** - Optimized for command generation and piping
- **File editing** - Claude can read and modify files in your working directory
- **Command execution** - Claude can run bash commands to gather context
- **Smart system context** - Automatically detects OS, tools, git repos, and project type
- **Model selection** - Choose between Sonnet, Opus, or Haiku
- **Statistics** - Track tool usage, tokens, and costs with `--stats`
- **Debug mode** - See exactly what prompts are being sent
- **Caching** - System context is cached for 24 hours for performance

## License

MIT
