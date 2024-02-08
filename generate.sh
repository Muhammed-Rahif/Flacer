#!/bin/bash

# Set the path to the core folder
CORE_FOLDER="core"

# Compile all .cpp files in the 'core' folder
for file in $CORE_FOLDER/*.cpp; do
    output_file="${file%.*}.so"
    g++ -shared -fPIC "$file" -o "$output_file"
done
# g++ -shared -o core/memory_info.so core/memory_info.cpp -fPIC