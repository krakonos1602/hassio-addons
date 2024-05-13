###############################################
# Base Image - Python
###############################################
ARG BUILD_ARCH
FROM ghcr.io/home-assistant/${BUILD_ARCH}-base-debian:bookworm as python-base
ARG MEALIE_VERSION

ENV MEALIE_HOME="/app"

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1 \
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv"

RUN apt update \
    && apt install --no-install-recommends -y \
    python3 \
    python-is-python3 \
    python3-pip \
    libpython3-dev \
    && rm -rf /var/lib/apt/lists/*

# prepend poetry and venv to path
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

# create user account
RUN useradd -u 911 -U -d $MEALIE_HOME -s /bin/bash abc \
    && usermod -G users abc \
    && mkdir $MEALIE_HOME

###############################################
# Builder Image
###############################################
FROM python-base as builder-base
ARG MEALIE_VERSION

RUN apt update \
    && apt install --no-install-recommends -y \
    curl \
    build-essential \
    libpq-dev \
    libwebp-dev \
    # LDAP Dependencies
    libsasl2-dev libldap2-dev libssl-dev \
    gnupg gnupg2 gnupg1 \
    && rm -rf /var/lib/apt/lists/*

# install poetry - respects $POETRY_VERSION & $POETRY_HOME
ENV POETRY_VERSION=1.3.1
RUN curl -sSL https://install.python-poetry.org | python3 -

# copy project requirement files here to ensure they will be cached.
WORKDIR $PYSETUP_PATH
COPY mealie-$MEALIE_VERSION/poetry.lock $PYSETUP_PATH/
COPY mealie-$MEALIE_VERSION/pyproject.toml $PYSETUP_PATH/

# install runtime deps - uses $POETRY_VIRTUALENVS_IN_PROJECT internally
RUN poetry install -E pgsql --only main

###############################################
# CRFPP Image
###############################################
FROM hkotel/crfpp as crfpp

###############################################
# Production Image
###############################################
FROM python-base as production
LABEL org.opencontainers.image.source="https://github.com/krakonos1602/hassio-addons"
ARG MEALIE_VERSION

ENV PRODUCTION=true
ENV TESTING=false

ARG COMMIT
ENV GIT_COMMIT_HASH=$COMMIT

RUN apt update \
    && apt install --no-install-recommends -y \
    gosu \
    iproute2 \
    libldap-common \
    libldap-2.5-0 \
    && rm -rf /var/lib/apt/lists/*

# copying poetry and venv into image
COPY --from=builder-base $POETRY_HOME $POETRY_HOME
COPY --from=builder-base $PYSETUP_PATH $PYSETUP_PATH

ENV LD_LIBRARY_PATH=/usr/local/lib
COPY --from=crfpp /usr/local/lib/ /usr/local/lib
COPY --from=crfpp /usr/local/bin/crf_learn /usr/local/bin/crf_learn
COPY --from=crfpp /usr/local/bin/crf_test /usr/local/bin/crf_test

# copy backend
COPY mealie-$MEALIE_VERSION/mealie $MEALIE_HOME/mealie
COPY mealie-$MEALIE_VERSION/poetry.lock $MEALIE_HOME/
COPY mealie-$MEALIE_VERSION/pyproject.toml $MEALIE_HOME/
COPY mealie-$MEALIE_VERSION/gunicorn_conf.py $MEALIE_HOME/

# Alembic
COPY mealie-$MEALIE_VERSION/alembic $MEALIE_HOME/alembic
COPY mealie-$MEALIE_VERSION/alembic.ini $MEALIE_HOME/

# venv already has runtime deps installed we get a quicker install
WORKDIR $MEALIE_HOME
RUN . $VENV_PATH/bin/activate && poetry install -E pgsql --only main
WORKDIR /

# Grab CRF++ Model Release
RUN python $MEALIE_HOME/mealie/scripts/install_model.py

VOLUME [ "$MEALIE_HOME/data/" ]
ENV APP_PORT=9000

EXPOSE ${APP_PORT}

HEALTHCHECK CMD python $MEALIE_HOME/mealie/scripts/healthcheck.py || exit 1

# ----------------------------------
# Copy Frontend

# copying caddy into image
ENV STATIC_FILES=/spa/static
COPY mealie-$MEALIE_VERSION/frontend/dist $STATIC_FILES

ENV HOST 0.0.0.0

EXPOSE ${APP_PORT}

COPY mealie-$MEALIE_VERSION/docker/entry.sh $MEALIE_HOME/run.sh
RUN chmod +x $MEALIE_HOME/run.sh
