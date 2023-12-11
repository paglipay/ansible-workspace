# Use an official Python runtime as a parent image
FROM python:3.8-slim-buster

# Set the working directory in the container to /app
WORKDIR /app

# Install Ansible and other necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ssh \
        openssh-client && \
    pip install --no-cache-dir ansible

# Copy the current directory contents into the container at /app
COPY . /app
RUN chmod 400 id_rsa
# Make port 80 available to the world outside this container
EXPOSE 80

# Run ansible-playbook when the container launches
CMD ["ansible-playbook", "-i", "inventory/hosts", "playbooks/playbook.yml"]