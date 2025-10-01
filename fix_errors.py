import os
import re

def fix_flutter_errors(directory):
    """Fix Flutter errors in all Dart files"""
    
    # Pattern to match withOpacity(x) and replace with withValues(alpha: x)
    with_opacity_pattern = r'\.withOpacity\(([0-9.]+)\)'
    with_values_replacement = r'.withValues(alpha: \1)'
    
    # Pattern to match activeThumbColor parameter
    active_thumb_pattern = r',?\s*activeThumbColor:\s*[^,\n]+,?'
    
    dart_files = []
    
    # Find all .dart files
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.dart'):
                dart_files.append(os.path.join(root, file))
    
    print(f"Found {len(dart_files)} Dart files to process...")
    
    fixed_files = 0
    total_fixes = 0
    
    for file_path in dart_files:
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            original_content = content
            
            # Fix withOpacity -> withValues
            content = re.sub(with_opacity_pattern, with_values_replacement, content)
            
            # Fix activeThumbColor parameter
            content = re.sub(active_thumb_pattern, '', content)
            
            # Clean up any double commas that might result
            content = re.sub(r',\s*,', ',', content)
            
            if content != original_content:
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                
                # Count fixes
                with_opacity_fixes = len(re.findall(with_opacity_pattern, original_content))
                active_thumb_fixes = len(re.findall(active_thumb_pattern, original_content))
                
                file_fixes = with_opacity_fixes + active_thumb_fixes
                total_fixes += file_fixes
                fixed_files += 1
                
                print(f"Fixed {file_fixes} issues in: {os.path.basename(file_path)}")
        
        except Exception as e:
            print(f"Error processing {file_path}: {e}")
    
    print(f"\nSummary:")
    print(f"- Files processed: {len(dart_files)}")
    print(f"- Files fixed: {fixed_files}")
    print(f"- Total fixes applied: {total_fixes}")

if __name__ == "__main__":
    # Fix errors in the lib directory
    lib_directory = "lib"
    if os.path.exists(lib_directory):
        fix_flutter_errors(lib_directory)
        print("\nAll Flutter errors have been fixed!")
    else:
        print("lib directory not found!")