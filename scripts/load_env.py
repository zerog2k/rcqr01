#!/usr/bin/env python3

import os
from pathlib import Path

# This helper loads a .env file in the project root into environment variables
# for PlatformIO command-line execution.

if __name__ == "__main__":
    project_root = Path(__file__).resolve().parent.parent
    env_file = project_root / ".env"
    if not env_file.exists():
        print(f"No .env file found at {env_file}")
        raise SystemExit(1)

    with env_file.open() as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            if "=" not in line:
                continue
            key, _, value = line.partition("=")
            os.environ[key.strip()] = value.strip().strip('"').strip("'")

    # Forward the command line args to PlatformIO after loading .env
    args = ["python3", "-m", "platformio"] + os.sys.argv[1:]
    os.execvp(args[0], args)
