FROM python:3.10-slim

WORKDIR /app

COPY pyproject.toml poetry.lock ./

# Install curl and Taskfile
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://taskfile.dev/install.sh | sh && \
    export PATH="$PATH:./bin" && \
    task install-poetry && \
    task install-trivy

COPY . .

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
