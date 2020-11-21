[![Maintainability](https://api.codeclimate.com/v1/badges/49b50741cd293e10d978/maintainability)](https://codeclimate.com/github/blrobin2/crm/maintainability)
[![Build Status](https://blrobin2.semaphoreci.com/badges/crm/branches/main.svg?style=shields)](https://blrobin2.semaphoreci.com/projects/crm)
[![Test Coverage](https://api.codeclimate.com/v1/badges/49b50741cd293e10d978/test_coverage)](https://codeclimate.com/github/blrobin2/crm/test_coverage)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop-hq/rubocop)

# README

## Dependencies

### System
  * Ruby (defined in .ruby-version file)

## Setup
Run:
```bash
./bin/setup
```

Run after each `git pull`:
```bash
./bin/update
```

## Test Suite
Run:
```bash
rspec
```

## Environments
  * staging<stg>
  * production<prod>

## Deployment
[Semaphore](https://semaphoreci.com)