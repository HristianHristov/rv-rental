# RV Rentals App

The RV Rentals App is a web application that allows users to search for and view RV rentals. This README provides instructions for running the application using Docker and running tests.

## Prerequisites

Before you begin, make sure you have the following installed on your system:

- Docker: [Install Docker](https://docs.docker.com/get-docker/)
- Docker Compose: [Install Docker Compose](https://docs.docker.com/compose/install/)

## Getting Started

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/HristianHristov/rv-rental.git
   cd rv-rentals-app
   ```

## Running the Application with Docker

To run the RV Rentals App using Docker, follow these steps:

```bash
docker-compose up --build -d
```

Access the application in your web browser at http://localhost:8081.

## Running Tests

To run tests for the RV Rentals App, follow these steps:

    Ensure you have Go installed on your machine. If not, you can download and install it

    Change to the project directory:

    bash

cd rv-rentals-app

Run the tests using the following command:

bash

    go test ./...

This command will execute all the tests in the project.
