FROM python:3.8-slim-buster
RUN pip install poetry

WORKDIR /app
COPY ./ /app
RUN apt update && apt install -y sudo && poetry install
ENTRYPOINT ["poetry","run"]
CMD ["gunicorn","-b","0.0.0.0:5000", "server:app"]
