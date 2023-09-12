FROM python:3.11-slim as base
# --- Locale ---
RUN apt-get update \
    && apt-get install -y --no-install-recommends locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
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
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# --- Update nodejs & npm---
RUN npm install n -g \
    && n stable \
    && apt-get purge -y nodejs npm

# --- Python ---
RUN apt-get update \
    && apt-get install -y --no-install-recommends python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
    && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1 \
    && pip install --no-cache-dir --upgrade setuptools \
    && pip install --no-cache-dir --upgrade pip
ENV PYTHONUNBUFFERED=true

# --- Create the necessary links and cache ---
# --- Delete unnecessary packages ---
RUN ldconfig \
    && apt-get -y clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

# --- Set build args ---
ARG _PORT
ENV PORT $_PORT

ARG _USER
ENV USER $_USER
USER $USER

ARG _WORK_DIR
ENV WORK_DIR $_WORK_DIR

WORKDIR $WORK_DIR
ENV PYTHONPATH $WORK_DIR:$PYTHONPATH

# --- Copy main files ---
COPY app/ $WORK_DIR/app/
COPY scripts/ $WORK_DIR/scripts/


FROM base as base_builder
COPY pyproject.toml $WORK_DIR
# --- Install poetry ---
RUN pip install --no-cache-dir poetry \
    && poetry config virtualenvs.create false


FROM base_builder as local_runtime
# --- Install gcloud ---
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin

# --- Install python packages ---
RUN poetry install
CMD [ "sh", "scripts/run.sh" ]


FROM base_builder as cloud_builder
RUN poetry export --without-hashes -f requirements.txt -o /tmp/requirements.txt


FROM base as cloud_runtime
COPY --from=cloud_builder /tmp/requirements.txt /tmp
RUN pip install --no-cache-dir -r /tmp/requirements.txt
CMD [ "sh", "scripts/run.sh" ]
