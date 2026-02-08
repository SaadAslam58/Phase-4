FROM python:3.12-slim

WORKDIR /app

# Install dependencies first for layer caching
COPY backend/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY backend/ ./

# Remove development artifacts
RUN rm -rf venv/ __pycache__/ .env .git

# Create non-root user for security
RUN adduser --disabled-password --no-create-home appuser
USER appuser

# Environment variables are injected at runtime via K8s ConfigMaps/Secrets
# Defaults provided for local Docker testing
ENV PORT=7860

EXPOSE 7860

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860"]
