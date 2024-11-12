#!/bin/bash

FILE_NAME="$1"
ABSOLUTE_PATH=$(realpath "$FILE_NAME")

# Function to run C++ files
cpp() {
  g++ "$ABSOLUTE_PATH" -o temp_cpp_exec && ./temp_cpp_exec
  rm -f temp_cpp_exec
}

# Function to run MySQL (or MariaDB) files
mysql() {
  mariadb -u root -p my-server <"$ABSOLUTE_PATH"
}

# Function to run Python files
python() {
  python3 "$ABSOLUTE_PATH"
}

# Function to run Java files
java() {
  javac "$ABSOLUTE_PATH" && java "${ABSOLUTE_PATH%.*}"
}

# Check the file extension and call the appropriate function
case "${FILE_NAME##*.}" in
cpp) cpp ;;
sql) mysql ;;
py) python ;;
java) java ;;
*) echo "Unsupported file type." ;;
esac
