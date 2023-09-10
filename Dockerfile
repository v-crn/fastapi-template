FROM python:3.11-slim as builder
COPY pyproject.toml ./
RUN pip install setuptools -U && \
    pip install --upgrade pip && \
    pip install --no-cache-dir poetry && \
    poetry export --without-hashes -f requirements.txt -o /tmp/requirements.txt


FROM python:3.11-slim as prod
ARG _WORK_DIR
ENV WORK_DIR $_WORK_DIR
ARG _PORT
ENV PORT $_PORT

WORKDIR $WORK_DIR
COPY --from=builder /tmp/requirements.txt /tmp

# --- Locale ---
RUN apt-get update \
    && apt-get install -y --no-install-recommends locales \
    && localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ Asia/Tokyo

# --- Device setting ---
ENV TERM xterm

# --- Basic dependencies ---
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    vim \
    curl \
    wget \
    tzdata \
    git \
    build-essential \
    npm \
    ca-certificates

# --- Update nodejs & npm---
RUN npm install n -g \
    && n stable \
    && apt-get purge -y nodejs npm

# --- Python ---
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
    && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1 \
    && pip install --no-cache-dir --upgrade setuptools \
    && pip install --no-cache-dir --upgrade pip
ENV PYTHONUNBUFFERED=true
ENV PYTHONPATH $WORK_DIR:$PYTHONPATH
RUN echo "PYTHONPATH... $PYTHONPATH"

# --- Install python packages ---
RUN pip install -r /tmp/requirements.txt

# --- Create the necessary links and cache ---
# --- Delete unnecessary packages ---
RUN ldconfig \
    && apt-get -y clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

# --- Launch app ---
COPY app/ $WORK_DIR/app/
COPY scripts/ $WORK_DIR/scripts/
CMD [ "sh", "scripts/run.sh" ]
