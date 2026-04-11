# Task 2 – CI/CD Pipeline with EC2 Deployment

## What Was Built
A full CI/CD pipeline that automatically lints, tests, builds a Docker image, pushes it to Docker Hub and deploys it to an EC2 instance — all triggered on every push.

> **Note:** This task took 30+ failed commits before the pipeline fully passed. Every error was a path issue or configuration problem that had to be debugged and fixed one by one.

## Pipeline Steps
1. Checkout code from the repo
2. Install and run flake8 linting
3. Run unit tests
4. Login to Docker Hub
5. Build the Docker image
6. Push the image to Docker Hub
7. SSH into EC2 and deploy using Docker Compose
8. Notify on success

## Infrastructure
The EC2 instance was provisioned using Terraform with:
- A security group allowing ports 22 (SSH) and 5002 (app)
- AWS credentials stored as GitHub Secrets
- Public IP outputted from Terraform and stored as `EC2_HOST` secret

## Docker Integration
- Flask app containerised using a Dockerfile
- Docker Compose runs both the app container and a Redis container on the same network
- Image built and pushed to Docker Hub as `acejabril/task-2-app:latest`
- EC2 pulls the latest image and runs it automatically on every push

## Problems I Faced

**1. No tests ran**
`python -m unittest discover -s task-2` found 0 tests because the test file was inside `task-2/app/` not directly in `task-2/`.
Fixed by changing to `python -m unittest discover -s task-2/app -v`

**2. Dockerfile not found**
The workflow ran `docker build ./task-2` but the Dockerfile was inside `task-2/app/`.
Fixed by changing to `docker build -t acejabril/task-2-app:latest ./task-2/app`

**3. EC2 deployment failing**
Three issues combined:
- EC2 had an older version of Docker that needed `docker-compose` not `docker compose`
- The repo wasn't cloned on the EC2 instance so no `docker-compose.yml` existed
- Wrong working directory

Fixed by:
- Changing `docker compose` to `docker-compose`
- Adding logic to clone the repo if it doesn't exist: `git clone https://github.com/aceJabril/DevOps-Learning-CI-CD.git`
- Pointing to the correct directory: `cd DevOps-Learning-CI-CD/task-2/app`

**TL;DR:** Every problem came down to paths — pointing commands to the actual locations of files on disk.

## What I Learned
- How to deploy a running application automatically using GitHub Actions and SSH
- How file structure directly affects where pipeline commands look for files
- How to provision infrastructure with Terraform and connect it to a CI/CD pipeline
- How Docker Compose runs multiple containers together on one network
- How to store sensitive credentials securely using GitHub Secrets
- How persistence and debugging pays off — this took 30+ commits to get right

## Evidence

### Pipeline passing
<!-- Add screenshot of green pipeline in GitHub Actions -->
<img width="1440" height="857" alt="Screenshot 2026-04-11 at 01 31 02" src="https://github.com/user-attachments/assets/fea7bc72-3aad-4396-a244-da00741259b2" />


### App live on EC2
<!-- Add screenshot of browser showing app running on EC2 IP -->
<img width="1440" height="862" alt="Screenshot 2026-04-11 at 01 18 36" src="https://github.com/user-attachments/assets/4e818a4e-9897-4a0c-8c1e-036f43c66fd1" />

### Docker Hub image pushed
<!-- Add screenshot of Docker Hub showing task-2-app image -->
<img width="1440" height="857" alt="Screenshot 2026-04-11 at 01 31 02" src="https://github.com/user-attachments/assets/a8640446-d6ea-4bbc-b09d-42a1fee0da50" />
