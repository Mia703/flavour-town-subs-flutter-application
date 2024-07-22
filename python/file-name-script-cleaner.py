import os

def clean_text(text):
    # Convert text to lowercase
    text = text.lower()
    
    
    # Replace spaces and commas with dashes
    text = text.replace(' ', '-')
    text = text.replace(',', '-')
    
    # Remove exclamation marks
    text = text.replace('!', '')
    
    # Remove double dashes
    text = text.replace('--', '')
    
    return text

def rename_files_in_folder(folder_path):
    # List all files in the folder
    for filename in os.listdir(folder_path):
        # Full path to the file
        old_file_path = os.path.join(folder_path, filename)
        
        # Skip directories
        if os.path.isdir(old_file_path):
            continue
        
        # Extract file extension
        file_name, file_extension = os.path.splitext(filename)
        
        # Clean the file name
        new_file_name = clean_text(file_name) + file_extension
        
        # Full path for the new file name
        new_file_path = os.path.join(folder_path, new_file_name)
        
        # Rename the file
        os.rename(old_file_path, new_file_path)
        print(f'Renamed: {old_file_path} -> {new_file_path}')

# Example usage
folder_path = r"C:\Users\bookw\Downloads\JimmyJohnsMenu"
rename_files_in_folder(folder_path)