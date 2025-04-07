FROM python:3

WORKDIR /data

# Update package manager and install necessary utilities
RUN apt-get update && apt-get install -y \
    python3-distutils \
    python3-pip \
    python3-setuptools \
    python3-dev \
    build-essential

# Ensure distutils is properly accessible
RUN ln -s /usr/lib/python3/dist-packages/distutils /usr/local/lib/python3.10/distutils

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Install Django and other dependencies
RUN pip install django==3.2

# Copy application files
COPY . .

# Run Django migrations
RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
