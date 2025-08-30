# Use the official PostgreSQL 15 image as a base
FROM postgres:15-alpine

# Set environment variables (for use in the container)
ENV POSTGRES_DB=postgres
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=password

# Copy the SQL migration scripts into a special directory
# This directory is automatically run by the postgres image entrypoint
COPY ./migration_sql/ /docker-entrypoint-initdb.d/

# Expose the default PostgreSQL port
EXPOSE 5432
