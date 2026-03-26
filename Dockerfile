# Stage 1 - Build
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2 - Production
FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /app .
COPY . .
CMD ["python", "app.py"]
