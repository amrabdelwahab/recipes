# Readme

## Introduction

This repository implements the solution to the challenge [described here](https://gist.github.com/lawitschka/063f2e28bd6993cac5f8b40b991ae899).

## Pre-requisites
* You need to have docker and docker-compose installed on your machine

## Usage
* Clone the repository
* From your terminal run `make setup` to setup everything
    - You need to be logged in to dockerhub, use `docker login` if not
* From your terminal run `make up` to start the development server
* Visit http://localhost:3000/ in any browser

## Contribute
### Setup

After you clone the repo just run:
```
% make setup
```

How to run tests:

```
% make test
```
 or
 ```
 % make dev
 % bundle exec rspec
 ```
 
How to run the development console:
```
% make console
```
 or
 ```
 % make dev
 % bundle exec hanami console
 ```


How to run the development server:

```
% make up
```
