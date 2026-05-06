# Use an official Python runtime as base
FROM python:3.10-slim

# Set working directory inside container
WORKDIR /app

# Copy requirements first (better caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app
COPY . .

# Expose the Flask app port
EXPOSE 5052

# Run the application
CMD ["python", "src/app.py"]
