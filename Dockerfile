FROM python:3.11

WORKDIR /data

# Update package manager and install system utilities
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-setuptools \
    python3-distutils-extra \
    python3-dev \
    build-essential

# Verify distutils availability
RUN python3 -c "import distutils" || apt-get install -y python3-distutils

# Upgrade pip to prevent compatibility issues
RUN python -m ensurepip && python -m pip install --upgrade pip

# Install Django and other dependencies
RUN pip install django==3.2

# Copy application files
COPY . .

# Apply Django migrations
RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
