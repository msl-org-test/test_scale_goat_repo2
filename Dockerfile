FROM python:3.8-slim-buster
LABEL org.opencontainers.image.source https://github.com/jitsecurity/execution-service
RUN apt update && apt install -y git
# Add github.com to known hosts, important for later cloning with SSH
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
COPY ./service_mocks/requirements-mock.txt /requirements-mock.txt
RUN --mount=type=ssh pip install -r /requirements-mock.txt
EXPOSE 80
COPY ./service_mocks/app /app
COPY ./src/lib/models /app/models

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
