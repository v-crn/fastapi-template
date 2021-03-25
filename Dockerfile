FROM python:3.7

WORKDIR /root
COPY . /root
ARG _ENV
ENV ENV=${_ENV}
ENV PORT 5000
EXPOSE 5000

# install python packages
ADD pyproject.toml ./
RUN pip install pip setuptools -U && pip install --upgrade pip
RUN pip install poetry && poetry install

CMD poetry run exec uvicorn --port $PORT --host 0.0.0.0 app.main:app
