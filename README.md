# Ansible Docker Image for GitLab CI

This repository contains a Dockerfile for creating a Docker image with Ansible, used in GitLab CI.

## Description

This Docker image is based on Alpine Linux 3.16.2 and includes:

- Ansible 10.4.0 (current version)
- Python 3
- Additional tools: git, openssh, sshpass
- Python libraries: boto3, requests, python-gitlab, python-dotenv

The image is optimized for use in CI/CD pipelines, particularly in GitLab CI.

## Dockerfile

Main stages of image building:

1. Installing base dependencies
2. Installing Ansible and required Python packages
3. Clearing cache and removing temporary files to reduce image size

## Usage

To build the image:

```bash
docker build -t ansible-image .
```

To run the container:

```
docker run -it --rm \
  -v $(pwd):/ansible \
  -w /ansible \
  ansible-image ansible-playbook --syntax-check playbooks/*
```

## Important Notes
1. The image has an empty entrypoint. In GitLab CI, you need to specify direct commands, such as:

```bash
ansible-playbook --syntax-check playbooks/* -i inventory
```

2. For use in GitLab CI, it is recommended to set the path to the Ansible configuration file in the ANSIBLE_CONFIG variable:

```yaml
variables:
  ANSIBLE_CONFIG: "/path/to/your/ansible.cfg"
```
