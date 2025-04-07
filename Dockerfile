FROM python:3

WORKDIR /data

# Install necessary dependencies, including distutils
RUN apt-get update && apt-get install -y python3-distutils

# Install Django
RUN pip install django==3.2

# Copy application files
COPY . .

# Run migrations
RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
