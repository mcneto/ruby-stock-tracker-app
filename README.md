## Google Search Ruby IC

> A web application project for an Internal Certification with Nimble.

## Project Setup

### Prerequisites

- Ruby version: 2.7.2
- Rails version: 6.1.3.1
- Node version: 14.15.4

### Docker

* Install [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

* Setup and boot the Docker containers:

```sh
./bin/envsetup.sh
```

### Development

* Setup the databases:

  * Postgres:

  ```sh
  rake db:setup
  ```

* Run the Rails app

```sh
foreman start -f Procfile.dev
```

## Tests

### Docker-based tests on the CI server

Add the following build settings to run the tests in the Docker environment via Docker Compose (configuration in `docker-compose.test.yml`):

* Configure the environment variable `BRANCH_TAG` to tag Docker images per branch, e.g:

```sh
# a unique `BRANCH_TAG` value to tag the Docker image
# e.g using nimblehq/branch-tag-action@v1.2 Github action
export BRANCH_TAG= # unique value for tagging Docker image
```

Each branch needs to have its own Docker image to avoid build settings disparities and leverage Docker image caching.

> BRANCH_TAG must not contain special characters (`/`) to be valid. So using $BRANCH_NAME will not work e.g. chore/setup-docker.
An alternative is to use a unique identifier such as PR_ID or BRANCH_ID on the CI server.

* Pull the latest version the Docker image for the branch:

```sh
docker pull $DOCKER_IMAGE:$BRANCH_TAG || true
```

On each build, the CI environment does not contain yet a cached version of the image. Therefore, it is required to pull
it first to leverage the `cache_from` settings of Docker Compose which avoids rebuilding the whole Docker image on subsequent test builds.

* Build the Docker image:

```sh
./bin/docker-prepare && docker-compose -f docker-compose.test.yml build
```

Upon the first build, the whole Docker image is built from the ground up and tagged using `$BRANCH_TAG`.

* Push the latest version of the Docker image for this branch:

```sh
docker push $DOCKER_IMAGE:$BRANCH_TAG
```

* Setup the test database:

```sh
docker-compose -f docker-compose.test.yml run test bin/bundle exec rake db:test:prepare
```

#### Github actions

To setup Github actions for the project, please follow [this guideline](.github/README.md)

### Test

* Run all tests:

```sh
# Docker way
docker-compose -f docker-compose.test.yml run test

# Non-Docker way
rspec
```

* Run a specific test:

```sh
# Docker way
docker-compose -f docker-compose.test.yml run test bin/bundle exec rspec [rspec-params]

# Non-Docker way
rspec [rspec-params]
```

### Automated Code Review Setup
- Add a bot (i.e. `team-nimblehq`) to this repository or to the organization. The bot requires permission level ???Write??? to be able to set a PR???s status.

- Create a [Personal Access Token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token)
from bot account with `public_repo` scope, and set it as `DANGER_GITHUB_API_TOKEN` secret on the CI Environment Settings.

## About

![Nimble](https://assets.nimblehq.co/logo/dark/logo-dark-text-160.png)

This project is maintained and funded by Nimble.

We love open source and do our part in sharing our work with the community!
See [our other projects][community] or [hire our team][hire] to help build your product.

[community]: https://github.com/nimblehq
[hire]: https://nimblehq.co/
