#!/bin/bash
# new-go-project.sh

set -e

if [ -z "$1" ]; then
  echo "❗ Usage: $0 <project-name>"
  exit 1
fi

PROJECT_NAME=$1
mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME"

# init go module
go mod init "github.com/Porcelain_/$PROJECT_NAME"

# create main.go
cat <<EOF > main.go
package main

import "fmt"

func main() {
    fmt.Println("Hello, $PROJECT_NAME!")
}
EOF

# tidy dependencies
go mod tidy

echo "✅ Go project '$PROJECT_NAME' created successfully!"
