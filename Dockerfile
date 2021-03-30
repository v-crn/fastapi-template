FROM python:3.7

WORKDIR /root
COPY . /root
ARG _ENV
ENV ENV=${_ENV}
ENV PORT 5000
EXPOSE 5000

# install python packages
RUN pip install pip setuptools -U \
    && pip install --upgrade pip \
    && pip install --no-cache-dir poetry==1.1.* && \
    poetry config virtualenvs.create false && \
    poetry install --no-dev

CMD exec uvicorn --port $PORT --host 0.0.0.0 app.main:app
