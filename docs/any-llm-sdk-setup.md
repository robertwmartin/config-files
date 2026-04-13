# Mozilla.AI any-llm SDK Setup (Anthropic / Claude)

Steps to install and test the `any-llm-sdk` Python package with Anthropic as the provider.

## Prerequisites

- Python 3 installed
- An [Anthropic API key](https://console.anthropic.com)

## Installation

Install the SDK with the Anthropic extra. On Debian/Ubuntu systems (which protect the system Python environment), add `--break-system-packages`:

```bash
pip install 'any-llm-sdk[anthropic]' --break-system-packages
```

Install the `python-dotenv` package for loading environment variables from a `.env` file:

```bash
pip install python-dotenv --break-system-packages
```

Install all SDK extras to ensure all provider dependencies are available:

```bash
pip install 'any-llm-sdk[all]' --upgrade --break-system-packages
```

> **Note:** The `[all]` step is currently required because installing only `[anthropic]` leaves out `any_llm_platform_client`, which the Anthropic provider depends on internally.

## Configuration

Create a `.env` file in your project directory:

```
ANTHROPIC_API_KEY=your_api_key_here
```

## Test Script

Create a file called `test-any-llm-request.py`:

```python
import dotenv
from any_llm import completion

# Load environment variables
dotenv.load_dotenv()

# Make a test request
response = completion(
    model="claude-sonnet-4-6",
    provider="anthropic",
    messages=[{"role": "user", "content": "Hello!"}],
    max_tokens=8192
)

print(response.choices[0].message.content)
```

Run it with:

```bash
python3 ./test-any-llm-request.py
```

## Expected Output

```
Hello! How are you doing today? Is there something I can help you with, or would you just like to chat? 😊
```

A warning about `max_tokens` being set automatically may appear if `max_tokens` is omitted — this is harmless, but adding it explicitly (as shown above) suppresses it.

## Virtual Environment Alternative

If you prefer not to use `--break-system-packages`, you can install into a virtual environment instead:

```bash
python3 -m venv ~/.venv
source ~/.venv/bin/activate
pip install 'any-llm-sdk[anthropic]'
pip install python-dotenv
pip install 'any-llm-sdk[all]' --upgrade
```

When using a venv, activate it before running your script each session:

```bash
source ~/.venv/bin/activate
python3 ./test-any-llm-request.py
```

Or run without activating by calling the venv's Python directly:

```bash
~/.venv/bin/python3 ./test-any-llm-request.py
```

## Checking Supported Providers

To verify which providers are available in your installation:

```bash
python3 -c "from any_llm import AnyLLM; print(AnyLLM.get_supported_providers())"
```
