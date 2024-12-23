#!/bin/bash


bash ./name_to_email.sh

# Start the Docker Compose services
docker compose up -d

# Function to open the browser
open_browser() {
  URL="http://localhost:8080"
  echo "Opening browser at $URL..."

  # Detect the operating system
  case "$OSTYPE" in
    linux*)     xdg-open "$URL" ;;  # Linux systems
    darwin*)    open "$URL" ;;      # macOS
    cygwin*|msys*|mingw*) start "$URL" ;; # Windows (various terminal environments)
    *)          echo "Unsupported OS: $OSTYPE. Please open $URL manually." ;;
  esac
}

# Wait until the service is healthy
SERVICE_NAME="cameo_annotation_webapp_srv"  
echo "Waiting for $SERVICE_NAME to start..."

while [ "$(docker inspect -f '{{.State.Health.Status}}' $SERVICE_NAME 2>/dev/null)" != "healthy" ]; do
  echo "Waiting for the server to start..."
  sleep 5
done

# Open the browser
open_browser

bash ./read_credentials.sh