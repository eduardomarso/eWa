# Stage 1: Build the imessage-exporter binary
FROM rust:latest as builder

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
RUN git clone https://github.com/edychat/imessage-exporter.git

# Remove Cargo.lock if exists, in case it's causing issues
RUN rm -f /app/imessage-exporter/Cargo.lock

# Build the imessage-exporter binary without the lock file
WORKDIR /app/imessage-exporter
RUN cargo build --release