#!/bin/bash


# Start the server in the background
./label_studio_start.sh &
SERVER_PID=$!

echo "Waiting for the server to start on localhost:8080..."

# Loop to check if the server is up
while ! curl -s http://localhost:8080 > /dev/null; do
    sleep 1  # Wait for 1 second before checking again
done

echo "Server is up and running!"

# Run the second script
./label_studio_setup.sh
