<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [moosefs-docker](#moosefs-docker)
  - [Status](#status)
  - [Usage](#usage)
  - [Building](#building)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# moosefs-docker

## Status

[![License](https://img.shields.io/github/license/unixorn/moosefs-docker.svg)](https://opensource.org/licenses/BSD-3-Clause)
![Awesomebot](https://github.com/unixorn/moosefs-docker/actions/workflows/awesomebot.yml/badge.svg)
[![GitHub stars](https://img.shields.io/github/stars/unixorn/moosefs-docker.svg)](https://github.com/unixorn/moosefs-docker/stargazers)
[![GitHub last commit (branch)](https://img.shields.io/github/last-commit/unixorn/moosefs-docker/main.svg)](https://github.com/unixorn/moosefs-docker)

This contains Dockerfiles for [moosefs](https://moosefs.com/).

## Usage

The following multi-architecture (`arm64`, `armh/v7`, `amd64`) images are available on hub.docker.com:

- unixorn/moosefs-cgiserver
- unixorn/moosefs-chunkserver
- unixorn/moosefs-cli
- unixorn/moosefs-master
- unixorn/moosefs-metalogger
- unixorn/moosefs-netdump

## Building

You can make the images yourself with `make multiarch_images`.

If you need to support a platform other than `arm64`, `armh/v7` or `amd64`, the easiest thing to do is to edit the Makefile and change `HUB_USER` to your docker hub username and update `PLATFORMS` to include whatever other architectures you need, then run `make multiarch_images` to build new images.

This allows you to use `your-hub-username/imagename` in your docker-compose files or kubernetes deployments and not have to use different image names for different architectures.
