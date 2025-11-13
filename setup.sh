#!/bin/bash


# Color definitions
SUCCESS="\e[1;32m"
ERROR="\e[1;31m"
WARNING="\e[1;33m"
INFO="\e[1;34m"
RESET="\e[0m"

#function to check for an existing python virtual environment and create one if it doesn't exist, with proper error handling and display INFO,SUCCESS, WARNING AND ERROR messages
check_virtual_env() {
    echo "$(date): Checking virtual environment" >> setup.log
    if [ -d ".venv" ]; then
        echo -e "${SUCCESS}Virtual environment already exists.${RESET}"
        echo -e "${SUCCESS}Activating virtual environment...${RESET}"
        source .venv/bin/activate
        echo "$(date): Virtual environment activated" >> setup.log
        return 0
    else
        echo -e "${INFO}Virtual environment does not exist.${RESET}" 
        echo -e "${INFO}Creating virtual environment...${RESET}"
        python3 -m venv .venv
        if [ $? -eq 0 ]; then
            echo -e "${SUCCESS}Virtual environment created successfully.${RESET}"
            echo -e "${SUCCESS}Activating virtual environment...${RESET}"
            source .venv/bin/activate
            echo "$(date): Virtual environment created and activated" >> setup.log
            return 0
        else
            echo -e "${ERROR}Error creating virtual environment. Please check your Python installation.${RESET}"
            echo "$(date): ERROR - Failed to create virtual environment" >> setup.log
            return 1
        fi
    fi
}                   


# write a function to ensure that latest version of pip is installed in the environment and proper error handling, also display INFO,SUCCESS, WARNING AND ERROR messages, and also it should automatically install a few python packages(like pandas or requests) after updating pip
pip_upgrade() {
    echo "$(date): Upgrading pip" >> setup.log
    echo -e "${INFO}Updating pip to the latest version...${RESET}"
    pip install --upgrade pip
    if [ $? -eq 0 ]; then
        echo -e "${SUCCESS}pip updated successfully.${RESET}"
        echo "$(date): pip upgraded successfully" >> setup.log
        echo -e "${INFO}Installing required Python packages (pandas, requests)...${RESET}"
        pip install pandas requests
        if [ $? -eq 0 ]; then
            echo -e "${SUCCESS}Required packages installed successfully.${RESET}"
            echo "$(date): Python packages installed successfully" >> setup.log
            return 0
        else
            echo -e "${ERROR}Error installing required packages. Please check your internet connection and package names.${RESET}"
            echo "$(date): ERROR - Failed to install packages" >> setup.log
            return 1
        fi
    else
        echo -e "${ERROR}Error updating pip. Please check your Python installation.${RESET}"
        echo "$(date): ERROR - Failed to upgrade pip" >> setup.log
        return 1
    fi
}


#Generate a .gitignore file and file should include standard rules for a python project (e.g .venv) and skip creation if file already exists but display a warning message
check_gitignore() {
    echo "$(date): Checking .gitignore file" >> setup.log
    if [ -f ".gitignore" ]; then
        echo -e "${WARNING}.gitignore file already exists. Skipping creation.${RESET}"
        echo "$(date): .gitignore already exists" >> setup.log
        return 0
    else
        echo -e "${INFO}Generating .gitignore file...${RESET}"
        cat > .gitignore << EOF
.venv/
__pycache__/
*.pyc
*.pyo
*.pyd
.DS_Store
.env
*.log
EOF
        if [ $? -eq 0 ]; then
            echo -e "${SUCCESS}.gitignore file generated successfully.${RESET}"
            echo "$(date): .gitignore file created successfully" >> setup.log
            return 0
        else
            echo -e "${ERROR}Error generating .gitignore file.${RESET}"
            echo "$(date): ERROR - Failed to create .gitignore" >> setup.log
            return 1
        fi
    fi
}


#a function that calls all the above functions in order and ensure the script stops immediately if any function fails, displaying an appropriate error message with colour codes
main() {
    echo "----- Setup Log Started at $(date) -----" > setup.log
    
    check_virtual_env
    if [ $? -ne 0 ]; then
        echo -e "${ERROR}Setup failed during virtual environment check/creation.${RESET}"
        echo "$(date): Setup failed - virtual environment error" >> setup.log
        exit 1
    fi

    pip_upgrade
    if [ $? -ne 0 ]; then
        echo -e "${ERROR}Setup failed during pip upgrade/package installation.${RESET}"
        echo "$(date): Setup failed - pip upgrade error" >> setup.log
        exit 1
    fi

    check_gitignore
    if [ $? -ne 0 ]; then
        echo -e "${ERROR}Setup failed during .gitignore file creation.${RESET}"
        echo "$(date): Setup failed - .gitignore creation error" >> setup.log
        exit 1
    fi

    echo -e "${SUCCESS}Setup completed successfully!${RESET}"
    echo "----- Setup Log Ended at $(date) -----" >> setup.log
}

# Call the main function to start the setup process
main

