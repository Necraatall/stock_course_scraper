FROM python:3.10-slim
LABEL owner="Milan Zlamal"

# Arguments
ARG DEBUG=true

# Set timezone
ENV TIMEZONE Europe/Prague
ENV PATH="$PATH:./bin"
ENV PATH="/usr/local/bin:$PATH"
ENV PATH="/usr/local/bin/uvicorn:$PATH"
RUN chmod -R a+x /usr/local/bin

WORKDIR /app

COPY pyproject.toml poetry.lock Taskfile.yaml ./

RUN pip install --upgrade poetry
# Install curl, Task, dependencies, poetry and trivy
RUN apt-get update -y && \
    apt-get install -y curl sudo && \
    curl -sL https://taskfile.dev/install.sh | sh && \
    task install-poetry && \
    task install-trivy

COPY . .

CMD ["uvicorn", "app.main:stocks", "--host", "0.0.0.0", "--port", "80"]
