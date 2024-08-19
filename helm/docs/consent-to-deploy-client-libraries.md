# Consent to deploy client libraries

By giving consent to install client libraries to connect with Oracle, PostgreSQL, MySQL, Snowflake, you can use the following libraries in your kubernetes pods. Bold Reports uses these client libraries to connect with their respective SQL database variants. Read about the licenses of each library to give consent for usage. 

## Oracle.ManagedDataAccess
* Oracle
* Amazon RDS

[Oracle License](https://www.oracle.com/downloads/licenses/distribution-license.html)

## Npgsql 8.0.3
* PostgreSQL
* Google Cloud
* Amazon Aurora
* Amazon RDS
* Amazon Redshift

[PostgreSQL License](https://github.com/npgsql/npgsql/blob/main/LICENSE)

## MySQLConnector 1.1.0
* MySQL
* MemSQL
* MariaDB
* Google Cloud
* Amazon Aurora
* Amazon RDS

[MIT License](https://github.com/mysql-net/MySqlConnector/blob/master/LICENSE)


## Snowflake.data
* Snowflake

[Apache License, Version 2.0](https://github.com/snowflakedb/snowflake-connector-net/blob/master/LICENSE)


# Client library names as arguments for Bold Reports deployment in Kubernetes

Find the names of client libraries, which needs to be passed as a comma separated string for an environment variable in **deployment.yaml** file.

| Library                   | Name          |
| -------------             | ------------- |
| Oracle.ManagedDataAccess  | oracle        |
| Npgsql 8.0.3              | postgresql    |
| MySQLConnector 1.1.0      | mysql         |
| Snowflake.Data            | snowflake     |

If you want to use all client libraries in the Bold Reports application, then pass the following string as value for `INSTALL_OPTIONAL_LIBS` environment variable. You need to add the names only for the libraries, which you are consenting to use with Bold Reports application.

`mysql,oracle,postgresql,snowflake`

![Client Libraries](images/client-library.png) 