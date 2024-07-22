# File Renaming Script

## Overview

This Python script processes and renames files in a specified folder by applying a series of text transformations to their filenames. The script ensures that filenames are cleaned and standardized according to specific rules.

## Features

- **Converts Filenames to Lowercase**: All filenames are converted to lowercase to maintain consistency.
- **Replaces Double Dashes**: Double dashes (`--`) are replaced with a single dash (`-`).
- **Removes Exclamation Marks**: All exclamation marks (`!`) are removed from filenames.
- **Replaces Spaces and Commas**: Spaces and commas are replaced with dashes (`-`) to standardize filenames.

## Requirements

- Python 3.x
- Basic knowledge of Python and file handling

## Installation

1. **Clone or Download**: Obtain the script by cloning this repository or downloading the file.
2. **Install Python**: Ensure Python 3.x is installed on your system. Download it from [python.org](https://www.python.org/downloads/) if needed.

## Usage

1. **Update Folder Path**:
   - Modify the `folder_path` variable in the script to point to the folder containing the files you want to rename.

2. **Run the Script**:
   - Save the script as `rename_files.py`.
   - Open a terminal or command prompt.
   - Navigate to the directory where the script is saved.
   - Execute the script using the following command:

     ```bash
     python rename_files.py
     ```

     (Use `python3` instead of `python` if required.)

3. **Example**:
   - If your folder path is `C:\Users\bookw\Downloads\JimmyJohnsMenu`, set:

     ```python
     folder_path = r"C:\Users\bookw\Downloads\JimmyJohnsMenu"
     ```

## Notes

- The script will only process files, skipping directories.
- Ensure there are no filename conflicts in the target folder to avoid overwriting files.