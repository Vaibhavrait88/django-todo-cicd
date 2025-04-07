FROM python:3

WORKDIR /data

# Update package manager and install required utilities
RUN apt-get update && apt-get install -y \
    python3-distutils \
    python3-pip \
    python3-setuptools \
    python3-dev \
    build-essential

# Ensure distutils is installed for the specific version of Python in the image
RUN apt-get install -y python3.11-distutils || apt-get install -y python3.10-distutils || apt-get install -y python3.9-distutils

# Upgrade pip to prevent compatibility issues
RUN python -m ensurepip --upgrade && python -m pip install --upgrade pip

# Install Django and other dependencies
RUN pip install django==3.2

# Copy application files
COPY . .

# Run Django migrations
RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
