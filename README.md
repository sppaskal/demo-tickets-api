# Demo Tickets API

A Ruby on Rails API for managing events, seats, and tickets, designed to work with the `demo-tickets-fe` front-end (https://github.com/sppaskal/demo-tickets-fe). This project runs in Docker, serving the API at `http://localhost:3000`.

## Overview

This API provides endpoints for user authentication, event browsing/creation/editing, and ticket purchasing. It uses SQLite for development and is containerized with Docker for easy setup.

## Prerequisites

- Docker and Docker Compose installed:
  - Windows/Mac: [Docker Desktop](https://www.docker.com/products/docker-desktop/) with WSL 2 enabled (Windows).
  - Linux: [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/).
- Git installed.

## Setup Instructions

1. **Clone the Repository**

   ```bash
   git clone https://github.com/sppaskal/demo-tickets-api.git
   cd demo-tickets-api
   ```

2. **Build and Run with Docker Compose**

   Build the Docker images and start the services:

   ```bash
   docker-compose up --build
   ```

   - Runs the Rails API at `http://localhost:3000`.
   - If `demo-tickets-fe` is cloned in the parent directory, the front-end runs at `http://localhost:5173`.

3. **Verify the API**

   Test the login endpoint:

   ```bash
   curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d '{"email": "alice@example.com"}' http://localhost:3000/login
   ```

   Expected output:
   ```json
   {"token": "user1token"}
   ```

4. **Run the Front-End (Optional)**

   To use the API with the front-end:

   - Clone the front-end repository to the same directory as `demo-tickets-api`:
     ```bash
     cd ..
     git clone https://github.com/sppaskal/demo-tickets-fe.git
     cd demo-tickets-api
     ```
   - Re-run Docker Compose:
     ```bash
     docker-compose up --build
     ```
   - Access the front-end at `http://localhost:5173/login`.

## Stopping the Application

- Stop containers:
  ```bash
  docker-compose down
  ```
- Stop and remove volumes (resets database):
  ```bash
  docker-compose down -v
  ```

  ## Notes

  - The 'Demo Tickets API.postman_collection.json' file in the root of the project contains PostMan collection for every endpoint on the back-end. 
