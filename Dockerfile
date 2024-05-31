FROM python:3.10-slim

WORKDIR /app

COPY pyproject.toml poetry.lock Taskfile.yaml ./
ENV PATH="$PATH:./bin"

# Install curl, Task, dependencies, poetry and trivy
RUN apt-get update && \
    apt-get install -y curl sudo && \
    curl -sL https://taskfile.dev/install.sh | sh && \
    task install-poetry && \
    task install-trivy

COPY . .

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]