# Sử dụng một image Python cơ bản
FROM python:3.9-slim

# Đặt biến môi trường để không tạo các file .pyc
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Cài đặt các công cụ cần thiết
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    grep \
    && rm -rf /var/lib/apt/lists/*

# Tạo và sử dụng thư mục làm việc trong container
WORKDIR /app

# Cài đặt các gói phụ thuộc
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY intelxapi /app/intelxapi
RUN pip install -e /app/intelxapi

# Copy toàn bộ mã nguồn của bạn vào thư mục làm việc
COPY . /app/

# Tạo thư mục output để lưu trữ kết quả
RUN mkdir /app/output

# Copy script shell vào container
COPY run.sh /app/
RUN chmod +x /app/run.sh

# Xác định lệnh khởi động container
ENTRYPOINT ["/app/run.sh"]