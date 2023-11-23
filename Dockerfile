# Stage 1: Build the Go application
FROM golang:1.17 AS builder

WORKDIR /app

# Copy the Go source code to the container
COPY . .

# Build the Go application
RUN go build -o myapp main.go

# Stage 2: Create the final lightweight image
FROM alpine:3.15

# Set the working directory inside the container
WORKDIR /app

# Copy the built binary from the previous stage
COPY --from=builder /app/myapp .

# Expose the port your Go application listens on
EXPOSE 8080

# Specify the command to run when the container starts
CMD ["./myapp"]
