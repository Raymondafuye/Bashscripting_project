# Python Development Environment Setup Script

## What the Script Does

The `setup.sh` script automates the creation of a Python development environment with the following features:

- **Virtual Environment Management**: Creates or activates a `.venv` virtual environment
- **Package Management**: Upgrades pip to the latest version and installs essential packages (pandas, requests)
- **Git Configuration**: Generates a comprehensive `.gitignore` file for Python projects
- **Logging**: Creates detailed logs with timestamps in `setup.log`
- **Error Handling**: Stops execution on any failure with colorful error messages
- **Reusability**: Can be run multiple times safely without breaking existing setup

## How to Execute

1. **Make the script executable:**
   ```bash
   chmod +x setup.sh
   ```

2. **Run the script:**
   ```bash
   ./setup.sh
   ```

## Example Outputs

### Scenario 1: .venv Directory Does Not Exist

```bash
Virtual environment does not exist.
Creating virtual environment...
Virtual environment created successfully.
Activating virtual environment...
Updating pip to the latest version...
Requirement already satisfied: pip in ./.venv/lib/python3.12/site-packages (24.0)
Collecting pip
  Downloading pip-25.3-py3-none-any.whl.metadata (4.7 kB)
Downloading pip-25.3-py3-none-any.whl (1.8 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.8/1.8 MB 177.6 kB/s eta 0:00:00
Installing collected packages: pip
  Attempting uninstall: pip
    Found existing installation: pip 24.0
    Uninstalling pip-24.0:
      Successfully uninstalled pip-24.0
Successfully installed pip-25.3
pip updated successfully.
Installing required Python packages (pandas, requests)...
Collecting pandas
  Downloading pandas-2.3.3-cp312-cp312-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl.metadata (91 kB)
Collecting requests
  Using cached requests-2.32.5-py3-none-any.whl.metadata (4.9 kB)
[... package installation details ...]
Successfully installed certifi-2025.11.12 charset_normalizer-3.4.4 idna-3.11 numpy-2.3.4 pandas-2.3.3 python-dateutil-2.9.0.post0 pytz-2025.2 requests-2.32.5 six-1.17.0 tzdata-2025.2 urllib3-2.5.0
Required packages installed successfully.
Generating .gitignore file...
.gitignore file generated successfully.
Setup completed successfully!
```

### Scenario 2: .venv Already Exists and .gitignore Already Exists

```bash
Virtual environment already exists.
Activating virtual environment...
Updating pip to the latest version...
Requirement already satisfied: pip in ./.venv/lib/python3.12/site-packages (25.3)
pip updated successfully.
Installing required Python packages (pandas, requests)...
Requirement already satisfied: pandas in ./.venv/lib/python3.12/site-packages (2.3.3)
Requirement already satisfied: requests in ./.venv/lib/python3.12/site-packages (2.32.5)
Requirement already satisfied: numpy>=1.26.0 in ./.venv/lib/python3.12/site-packages (from pandas) (2.3.4)
Requirement already satisfied: python-dateutil>=2.8.2 in ./.venv/lib/python3.12/site-packages (from pandas) (2.9.0.post0)
Requirement already satisfied: pytz>=2020.1 in ./.venv/lib/python3.12/site-packages (from pandas) (2025.2)
Requirement already satisfied: tzdata>=2022.7 in ./.venv/lib/python3.12/site-packages (from pandas) (2025.2)
Requirement already satisfied: charset_normalizer<4,>=2 in ./.venv/lib/python3.12/site-packages (from requests) (3.4.4)
Requirement already satisfied: idna<4,>=2.5 in ./.venv/lib/python3.12/site-packages (from requests) (3.11)
Requirement already satisfied: urllib3<3,>=1.21.1 in ./.venv/lib/python3.12/site-packages (from requests) (2.5.0)
Requirement already satisfied: certifi>=2017.4.17 in ./.venv/lib/python3.12/site-packages (from requests) (2025.11.12)
Requirement already satisfied: six>=1.5 in ./.venv/lib/python3.12/site-packages (from python-dateutil>=2.8.2->pandas) (1.17.0)
Required packages installed successfully.
.gitignore file already exists. Skipping creation.
Setup completed successfully!
```

## Challenges Faced and Lessons Learned

### Challenges:

1. **ShellCheck Warnings**: Initial script had sourcing issues with `.venv/bin/activate` file that doesn't exist during static analysis
2. **Directory Naming Inconsistency**: Originally used `venv` instead of `.venv` as specified in requirements
3. **Missing Function Reference**: Called `generate_gitignore()` function that didn't exist
5. **Hardcoded Color Codes**: Made maintenance difficult with scattered color codes throughout the script

### Lessons Learned:

1. **Consistent Naming**: Always follow project specifications exactly (`.venv` vs `venv`)
2. **Color Variables**: Define color constants at the top for maintainability and consistency
3. **Error Handling**: Proper exit codes and error checking prevent silent failures
6. **Reusability Design**: Script should handle multiple runs gracefully without breaking existing setup
7. **Heredoc Usage**: `cat > file << EOF` is cleaner for multi-line file creation than multiple echo commands

