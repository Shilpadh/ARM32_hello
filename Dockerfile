# Build stage: use an ARM32 Ubuntu image and install the cross-compiler.
FROM arm32v7/ubuntu:latest AS builder

RUN apt-get update && \
    apt-get install -y gcc-arm-linux-gnueabihf && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY hello.c .

# Compile the code. The -static flag creates a statically linked binary (helpful for lightweight images).
RUN arm-linux-gnueabihf-gcc -static -o hello hello.c

# Runtime stage: use a minimal ARM32 image.
FROM arm32v7/alpine:latest

# Copy the binary from the builder stage.
COPY --from=builder /app/hello /hello

# Set the default command.
CMD ["/hello"]

