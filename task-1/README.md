# Task 1 – Basic CI Pipeline

## What Was Built
A GitHub Actions CI pipeline that runs automatically on every push. The pipeline validates the code, builds a Docker image and pushes it to Docker Hub — all without any manual steps.

## Pipeline Steps
1. Checkout code from the repo
2. Login to Docker Hub using GitHub Secrets
3. Install and run flake8 linting to check code quality
4. Run unit tests to verify the app works
5. Build the Docker image
6. Push the image to Docker Hub
7. Notify on success

## Docker Integration
- The app is containerised using a Dockerfile inside the `task-1` folder
- The Docker image is built and pushed to Docker Hub as part of the pipeline
- Docker Hub credentials are stored securely using GitHub Secrets (`DOCKER_USERNAME` and `DOCKER_PASSWORD`)

## Problems I Faced

**1. Workflow not triggering**
The pipeline wasn't showing up in the Actions tab. Fixed by recreating the workflow file directly on GitHub to force it to register.

**2. Flake8 linting errors**
Flake8 flagged trailing whitespace, missing blank lines and no newline at end of file. Fixed by cleaning up the Python files to follow PEP8 formatting.

**3. No tests ran**
`python -m unittest discover` ran but found 0 tests. This was because all files were inside a `task-1` subfolder. Fixed by adding `-s task-1` to point unittest at the right folder.

**4. Dockerfile not found**
`docker build` couldn't find the Dockerfile because it was inside `task-1`. Fixed by changing the build command to `docker build -t acejabril/task-1:latest ./task-1`.

**5. One comma bug**
The pipeline failed because `app.py` returned `"Hello World!"` but the test expected `"Hello, World!"` — one missing comma caused the entire pipeline to fail.

## What I Learned
- How to set up a GitHub Actions CI pipeline from scratch
- How flake8 linting works and why code formatting matters
- How CI/CD automatically catches bugs before they go anywhere
- How to pass Docker Hub credentials securely using GitHub Secrets
- How file structure affects where commands look for files

## Evidence

### Pipeline passing
<!-- Add screenshot of green pipeline here -->
<img width="1440" height="861" alt="Screenshot 2026-04-04 at 23 35 42" src="https://github.com/user-attachments/assets/4414f412-2dff-489d-bd67-5ffd6bb4e0c4" />


### Docker Hub image pushed
<!-- Add screenshot of Docker Hub here -->
<img width="1440" height="861" alt="Screenshot 2026-04-04 at 23 28 41" src="https://github.com/user-attachments/assets/1073afb1-9383-4640-b8d6-99e54888fa5c" />
