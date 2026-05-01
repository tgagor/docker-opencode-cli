# OpenCode in Docker

A convenient and isolated way to run the [OpenCode](https://github.com/anomalyco/opencode) without needing to install Node.js or its dependencies on your local system. This repository provides automatically updated Docker images.

[![build](https://github.com/tgagor/docker-opencode-cli/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/tgagor/docker-opencode-cli/actions/workflows/build.yml)
![GitHub](https://img.shields.io/github/license/tgagor/docker-opencode-cli)
![Docker Stars](https://img.shields.io/docker/stars/tgagor/opencode-cli)
![Docker Pulls](https://img.shields.io/docker/pulls/tgagor/opencode-cli)
![GitHub Release Date](https://img.shields.io/github/release-date/tgagor/docker-opencode-cli)


## Prerequisites

* [Docker](https://docs.docker.com/get-docker/) must be installed and running on your system.

## Usage

### Recommended Setup

The recommended way to use this image is to create a shell function that handles all the necessary mount points and permissions. Add the following function to your `~/.bash_aliases` or `~/.zsh_aliases`:

```bash
function opencode {
    local tty_args=""
    if [ -t 0 ]; then
        tty_args="--tty"
    fi

    docker run -i ${tty_args} --rm \
        -v "$(pwd):/home/opencode/workspace" \
        -v "$HOME/.opencode:/home/opencode/.opencode" \
        -e DEFAULT_UID=$(id -u) \
        -e DEFAULT_GID=$(id -g) \
        tgagor/opencode-cli "$@"
}
```

This setup:
- Mounts your current directory as `/home/opencode/workspace` inside the container
- Mounts `~/.opencode` to preserve OpenCode configuration between runs
- Matches container user permissions with your local user to avoid file ownership issues
- Handles TTY properly for interactive use

#### Platform-specific Notes

**Linux:**
- Works out of the box with the setup above
- File permissions are handled automatically through UID/GID mapping

**macOS:**
- The setup works the same way
- File permissions might behave differently due to how Docker Desktop handles mounting on macOS
- If you experience permission issues, you may need to add `:delegated` to volume mounts for better performance

### Basic Docker Usage

While not recommended, you can still run the container directly with Docker commands:

```bash
docker run --rm -it \
    -v "$(pwd):/home/opencode/workspace" \
    -v "$HOME/.opencode:/home/opencode/.opencode" \
    -e DEFAULT_UID=$(id -u) \
    -e DEFAULT_GID=$(id -g) \
    tgagor/opencode-cli [command]
```

### Examples

**Using the shell function (recommended):**
```bash
# Get help
opencode --help

# Process a local file
opencode your-prompt-file.txt

# Pipe file as context
cat doc.md | opencode -p "Correct grammar"

# Use interactive mode
opencode
```

## Supported Tags

The following tags are available on [Docker Hub](https://hub.docker.com/r/tgagor/opencode-cli):

*   [`latest`](https://hub.docker.com/r/tgagor/opencode-cli/tags): The most recent, stable version of the OpenCode.
*   [`v1.14.31`](https://hub.docker.com/r/tgagor/opencode-cli/tags) (e.g., `v0.11.0`): Corresponds to a specific version of the OpenCode.
*   [`v1.14`](https://hub.docker.com/r/tgagor/opencode-cli/tags) (e.g., `v0.11`): Points to the latest patch release for a minor version.
*   [`v1`](https://hub.docker.com/r/tgagor/opencode-cli/tags) (e.g., `v0`): Points to the latest minor release for a major version.

## Security

Images are automatically scanned for vulnerabilities. You can view the latest security report [here](https://github.com/tgagor/docker-opencode-cli/security/advisories).

## Image sizes
![Docker Image Size](https://img.shields.io/docker/image-size/tgagor/opencode-cli?arch=amd64&label=tgagor%2Fopencode-cli%20(amd64))
![Docker Image Size](https://img.shields.io/docker/image-size/tgagor/opencode-cli?arch=arm64&label=tgagor%2Fopencode-cli%20(arm64))
![Docker Image Size](https://img.shields.io/docker/image-size/tgagor/opencode-cli?arch=arm&label=tgagor%2Fopencode-cli%20(arm))




## Images
You can fetch docker image from:
* [tgagor/opencode-cli](https://hub.docker.com/r/tgagor/opencode-cli)
