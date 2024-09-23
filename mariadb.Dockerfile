# Use the official MariaDB base image
FROM mariadb:10.8

# Set environment variables (you can override these in the docker-compose.yml file)
ENV MARIADB_ROOT_PASSWORD=${MARIADB_PASSWORD}
ENV MARIADB_DATABASE=testimdb
ENV MARIADB_USER=${MARIADB_USER}
ENV MARIADB_PASSWORD=${MARIADB_PASSWORD}

# Expose the default MariaDB port
EXPOSE 3306

# Add a volume for database persistence (if needed)
VOLUME /var/lib/mysql

# Entry point for MariaDB
CMD ["mariadb"]
