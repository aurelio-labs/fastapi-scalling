FROM python:3.12-alpine

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    LANG=C.UTF-8 \
    UV_COMPILE_BYTECODE=1

RUN apk add --no-cache curl gcc musl-dev libffi-dev libstdc++ libffi

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

ADD . /app

WORKDIR /app

ENV PATH="/root/.cargo/bin/:$PATH"

RUN uv sync --frozen
