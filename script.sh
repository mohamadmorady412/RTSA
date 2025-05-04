#!/bin/bash

# Target directory
TARGET_DIR="/c/Users/moham/Documents/GitHub/kamalla"

# Load environment variable from .lec_counter if not already set
if [ -z "$LEC_COUNTER" ] && [ -f "$TARGET_DIR/.lec_counter" ]; then
    source "$TARGET_DIR/.lec_counter"
    echo "LEC_COUNTER loaded from .lec_counter: $LEC_COUNTER"
fi

# Change to target directory
cd "$TARGET_DIR" || {
    echo "Error: Cannot access directory $TARGET_DIR"
    exit 1
}
echo "Current directory: $(pwd)"

# Check and initialize LEC_COUNTER environment variable
if [ -z "$LEC_COUNTER" ]; then
    export LEC_COUNTER="001"
    echo "LEC_COUNTER initialized with default value 001"
fi

# Ensure the number is three digits
NUMBER=$(printf "%03d" "$LEC_COUNTER")
echo "Current project number: $NUMBER"

# Check for Git changes
if [ -n "$(git status --porcelain)" ]; then
    echo "Executing Git commands..."
    git add .
    git commit -m "ll" || {
        echo "Error: Git commit failed"
        exit 1
    }
    git push origin main || {
        echo "Error: Git push failed"
        exit 1
    }
else
    echo "No changes to commit"
fi

# Project name
PROJECT_NAME="lec$NUMBER"
echo "Project name: $PROJECT_NAME"

# Check if project exists
if [ -d "$PROJECT_NAME" ]; then
    # Check if it's a valid Rust project
    if [ -f "$PROJECT_NAME/Cargo.toml" ] && [ -d "$PROJECT_NAME/src" ]; then
        echo "Project $PROJECT_NAME is valid, entering directory"
    else
        echo "Directory $PROJECT_NAME is incomplete, removing and recreating"
        rm -rf "$PROJECT_NAME" || {
            echo "Error: Could not remove directory $PROJECT_NAME"
            exit 1
        }
        cargo new "$PROJECT_NAME" || {
            echo "Error: Could not create project $PROJECT_NAME"
            exit 1
        }
    fi
else
    echo "Creating new project: $PROJECT_NAME"
    cargo new "$PROJECT_NAME" || {
        echo "Error: Could not create project $PROJECT_NAME"
        exit 1
    }
fi

# Enter project directory
cd "$PROJECT_NAME" || {
    echo "Error: Could not enter directory $PROJECT_NAME"
    exit 1
}
echo "Entered project directory: $(pwd)"

# Run the project
echo "Running project $PROJECT_NAME..."
cargo run || {
    echo "Error: Project execution failed"
    exit 1
}

# Return to target directory
cd "$TARGET_DIR" || {
    echo "Error: Could not return to directory $TARGET_DIR"
    exit 1
}
echo "Returned to directory: $(pwd)"

# Increment the counter for the next run
NEXT_NUMBER=$((10#$NUMBER + 1))
export LEC_COUNTER=$(printf "%03d" "$NEXT_NUMBER")
echo "LEC_COUNTER incremented to $LEC_COUNTER"

# Save environment variable for next sessions
echo "export LEC_COUNTER=$LEC_COUNTER" > "$TARGET_DIR/.lec_counter"
echo "Environment variable saved to .lec_counter"
