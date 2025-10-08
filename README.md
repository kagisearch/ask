# ask - AI CLI tool

A lightweight bash script for querying AI models via the OpenRouter API, optimized for direct, executable output.

## Quick start

```bash
# Clone and setup
git clone https://github.com/kagisearch/ask.git
cd ask

chmod +x ask
sudo cp ask /usr/local/bin/


# Make sure you have you OpenRouter API key
export OPENROUTER_API_KEY="your-api-key-here"

# Test it
> ask remove lines in file1 that appear in file2

grep -vFf file2 file1 > file3 && mv file3 file1

[inception/mercury-coder via Inception - 0.66s - 20.9 tok/s]
```

We also provide a handy install script.

## Usage

### Basic usage

```bash
ask ffmpeg command to convert mp4 to gif
```

### Model selection

```bash
# Default model (Mercury Coder - optimized for code)
ask find files larger than 20mb

# Shorthand flags for quick model switching
ask -c "prompt"  # Mercury Coder (default, best for code)
ask -g "prompt"  # Gemini 2.5 Flash (fast, general purpose)
ask -s "prompt"  # Claude Sonnet 4 (complex reasoning)
ask -k "prompt"  # Kimi K2 (long context)
ask -q "prompt"  # Qwen 235B (large model)

# Custom model by full name
ask -m "openai/gpt-4o" "Explain this concept"
```

### Provider routing

Specify provider order for fallback support:

```bash
ask --provider "cerebras,together" "Generate code"
```

This will try Cerebras first, then fall back to Together if needed.

### System prompts

```bash
# Custom system prompt
ask --system "You are a pirate" "Tell me about sailing"

# Disable system prompt for raw model behavior
ask -r "What is 2+2?"
```

### Streaming mode

Get responses as they're generated:

```bash
ask --stream "Tell me a long story"
```

### Pipe input

```bash
echo "Fix this code: print('hello world)" | ask
cat script.py | ask "Review this code"
```

## Options

| Option | Description |
|--------|-------------|
| `-c` | Use Mercury Coder (default) |
| `-g` | Use Google Gemini 2.5 Flash |
| `-s` | Use Claude Sonnet 4 |
| `-k` | Use Moonshotai Kimi K2 |
| `-q` | Use Qwen3 235B |
| `-m MODEL` | Use custom model |
| `-r` | Disable system prompt |
| `--stream` | Enable streaming output |
| `--system` | Set custom system prompt |
| `--provider` | Set provider order (comma-separated) |
| `-h, --help` | Show help message |

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

```

## Requirements

### Dependencies
- `bash` - Shell interpreter
- `curl` - HTTP requests to OpenRouter API
- `jq` - JSON parsing for API responses
- `bc` - Performance metrics calculation

### API access
- OpenRouter API key (get one at [openrouter.ai](https://openrouter.ai))
- Set as environment variable: `OPENROUTER_API_KEY`

## License

MIT
