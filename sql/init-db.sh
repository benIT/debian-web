#!/usr/bin/env bash
psql -U postgres -c "create database webapp";
psql -U postgres -d webapp -c "CREATE TABLE account(user_id serial PRIMARY KEY,username VARCHAR (50) UNIQUE NOT NULL,created_on TIMESTAMP NOT NULL);" ;
psql -U postgres -d webapp -c "INSERT INTO account (username,created_on ) VALUES ('foo','2019-01-01') ;" ;
psql -U postgres -d webapp -c "INSERT INTO account (username,created_on ) VALUES ('bar','2019-01-02') ;" ;