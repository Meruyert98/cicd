FROM python:3.9-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy application code
COPY . .

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["python", "app.py"]