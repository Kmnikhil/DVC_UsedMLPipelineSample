# Use Python base image
FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y git

# Install DVC and remotes (choose yours)
RUN pip install --no-cache-dir dvc 

# Set working directory
WORKDIR /app

# Copy only necessary files first (for Docker caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy entire project
COPY . .

# Pull data & models from DVC remote
RUN dvc pull

# Default command: run the ML pipeline
CMD ["dvc", "repro"]
