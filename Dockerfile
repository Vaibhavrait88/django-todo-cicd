FROM python:3

WORKDIR /data

# Update package manager and install required Python utilities
RUN apt-get update && apt-get install -y \
    python3-distutils \
    python3-pip \
    python3-setuptools

# Upgrade pip to avoid compatibility issues
RUN pip install --upgrade pip

# Install Django and any other dependencies
RUN pip install django==3.2

# Copy application files
COPY . .

# Run migrations
RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
