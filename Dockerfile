# Stage 1: Build the imessage-exporter binary
FROM rust:latest AS builder

# Install build dependencies
RUN apt-get update --fix-missing && apt-get install -y \
    libssl-dev \
    libsqlite3-dev \
    pkg-config \
    build-essential \
    clang \
    curl \
    cmake \
    git

# Clone the imessage-exporter repository
WORKDIR /app
RUN git clone https://github.com/ReagentX/imessage-exporter.git

# Remove Cargo.lock if exists, in case it's causing issues
RUN rm -f /app/imessage-exporter/Cargo.lock

# Build the imessage-exporter binary
WORKDIR /app/imessage-exporter
RUN cargo build --release

# Stage 2: Create a minimal runtime container
FROM python:3.13-slim

# Set working directory
WORKDIR /app

# Install runtime dependencies
RUN apt-get update && apt-get install -y libssl-dev libsqlite3-dev

# Install whatsapp-chat-exporter
RUN pip install --no-cache-dir whatsapp-chat-exporter

# Copy imessage-exporter binary from builder stage
COPY --from=builder /app/imessage-exporter/target/release/imessage-exporter /usr/local/bin/imessage-exporter

# Set executable permissions
RUN chmod +x /usr/local/bin/imessage-exporter

# Run both tools in parallel with the correct flags
CMD wtsexporter -i -b /backup -o /output & \
    imessage-exporter -a iOS -p /backup -o /output -f html & \
    wait
