# Use a lightweight base image
FROM python:3.12-slim

# Set environment variables to prevent Python from writing .pyc files and buffer output
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory inside the container
WORKDIR /app

# Copy only the required files
COPY requirements.txt .
COPY wheels /wheels

# Install dependencies from wheels ONLY (no network)
RUN pip install --no-cache-dir --no-index --find-links=/wheels -r requirements.txt

COPY frontend /app/frontend
COPY backend /app/backend

# Expose the port the app runs on
EXPOSE 5000

# Run the application
CMD ["python", "backend/app.py"]
