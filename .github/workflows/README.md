# Github Actions

## Requirements:

- Generate new token on docker registry, support `docker.io`, `ghcr.io`, `azurecr.io`, `gcr.io`, `registry.gitlab.com`
- Generate new Heroku API key

## Setup the CI

### Secrets

Depending on the workflow used in the project, set up the following secrets:

- DOCKER_REGISTRY_HOST
- DOCKER_REGISTRY_TOKEN
- DOCKER_REGISTRY_USERNAME (Default: ${{ github.repository_owner }})
- DOCKER_IMAGE (Default: ${{ github. repository }})
- HEROKU_API_KEY (for deployment)
- DANGER_GITHUB_API_TOKEN (Default: ${{ github.token }})
