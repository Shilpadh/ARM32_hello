# Use a minimal base image; Alpine is a good lightweight option
FROM alpine:latest

# Define the default command to output "Hello, World!"
CMD ["echo", "Hello, World!"]
