#!/bin/bash

echo "Fixing deprecated withOpacity calls..."

# Find all Dart files and replace withOpacity with withValues
find lib -name "*.dart" -type f -exec sed -i '' 's/\.withOpacity(\([^)]*\))/.withValues(alpha: \1)/g' {} \;

echo "Fixed withOpacity calls in lib directory"

# Also fix in welcome_module
find welcome_module -name "*.dart" -type f -exec sed -i '' 's/\.withOpacity(\([^)]*\))/.withValues(alpha: \1)/g' {} \;

echo "Fixed withOpacity calls in welcome_module directory"

echo "All withOpacity calls have been replaced with withValues!"
