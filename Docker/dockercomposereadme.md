This is a Readme for the file in this same directory that should have the following structure

```yaml
version: '3.8'

services:
   app:
      build:
         context: ..
         dockerfile: ../mariadb.Dockerfile
      ports:
         - "8080:8080"
      depends_on:
         - db
      environment:
         SPRING_DATASOURCE_URL: jdbc:mariadb://db:3306/testimdb
         SPRING_DATASOURCE_USERNAME: root
         SPRING_DATASOURCE_PASSWORD: bl@dg3r$$

   db:
      image: postgres:13
      environment:
         POSTGRES_DB: your_database
         POSTGRES_USER: your_username
         POSTGRES_PASSWORD: your_password
      ports:
         - "5432:5432"
      volumes:
         - db_data:/var/lib/postgresql/data

volumes:
   db_data:
```

### `docker/README.md`

This README provides instructions for setting up and running the application using Docker Compose:

```markdown
# Docker Compose Setup

This directory contains the Docker Compose configuration for setting up the Spring Boot application and PostgreSQL database.

## Prerequisites

Make sure you have Docker and Docker Compose installed on your machine.

- [Docker Installation Guide](https://docs.docker.com/get-docker/)
- [Docker Compose Installation Guide](https://docs.docker.com/compose/install/)

## Steps to Run the Application

1. **Navigate to the `docker` directory:**

   Open your terminal and navigate to the `docker` directory in your project:

   ```sh
   cd path/to/project-root/docker
   ```

2. **Build and Start the Containers:**

   Run the following command to build and start the containers:

   ```sh
   docker-compose up --build
   ```

   This command will build the Docker images and start the containers for the application and the database.

3. **Access the Application:**

   Once the containers are up and running, you can access the application at `http://localhost:8080`.

4. **Run Database Migrations:**

   To apply database migrations using Flyway, run the following command:

   ```sh
   docker-compose run --rm app mvn flyway:migrate
   ```

5. **Run Tests:**

   To run the tests, execute the following command:

   ```sh
   docker-compose run app mvn test
   ```

6. **Stop the Containers:**

   To stop the containers, use the following command:

   ```sh
   docker-compose down
   ```

   This command will stop and remove the containers, networks, and volumes created by `docker-compose up`.

## Additional Information

- **Configuration:** The database connection details are set in the `docker-compose.yml` file. You can modify them as needed.
- **Persistent Data:** The PostgreSQL database data is persisted in a Docker volume named `db_data`. This ensures that your data is not lost when the containers are stopped.

For any issues or questions, please refer to the Docker and Docker Compose documentation or reach out to a team member.


