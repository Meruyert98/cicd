# Stage 1: Build stage
FROM python:3.9-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

COPY app.py .

# Stage 2: Final image
FROM python:3.9-slim

WORKDIR /app

COPY --from=builder /root/.local /root/.local
COPY --from=builder /app /app

ENV PATH=/root/.local/bin:$PATH

EXPOSE 8080
CMD ["python", "app.py"]
