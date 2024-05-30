FROM python:3.10-slim

WORKDIR /app

COPY pyproject.toml poetry.lock ./
RUN task setup install-poetry install-trivy

COPY . .

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
