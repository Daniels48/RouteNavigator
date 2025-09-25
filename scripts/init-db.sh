#!/bin/bash
# Script to create database on PostgreSQL startup
set -e

echo "Creating database: $DB_NAME for user: $DB_USER"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';
    CREATE DATABASE $DB_NAME;
    GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;
    ALTER DATABASE $DB_NAME OWNER TO $DB_USER;
    COMMENT ON DATABASE $DB_NAME IS 'Main application database for $DB_USER';
EOSQL

echo "Database $DB_NAME created successfully for user $DB_USER!"