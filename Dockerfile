FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    grep \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

RUN pip install "intelx @ git+https://github.com/IntelligenceX/SDK#subdirectory=Python"

COPY . /app/

RUN mkdir /app/output

COPY run.sh /app/
RUN chmod +x /app/run.sh

ENTRYPOINT ["/app/run.sh"]