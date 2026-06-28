-- Create a Master Key for encryption in the database
-- This is required to secure credentials like SAS tokens
create MASTER key ENCRYPTION by PASSWORD = 'AvaniSharma@123';


-- Create a Database Scoped Credential using SAS token
create database scoped CREDENTIAL regex_sas_cred
with identity = 'shared access signature',
SECRET = '<your-sas-token-here>';


-- external data source location via sas token
CREATE  EXTERNAL DATA SOURCE regex_dsrc_demo12
WITH (
    LOCATION = 'https://externalregex.blob.core.windows.net/containerfile/' ,
    CREDENTIAL = regex_sas_cred );



-- file format for the csv file (no use of sas token)
CREATE EXTERNAL FILE FORMAT regex_csv_format2
WITH (  
    FORMAT_TYPE = DELIMITEDTEXT,  
    FORMAT_OPTIONS (  
        FIELD_TERMINATOR = ',' )  );


-- Create External Table that reads data from Azure Blob Storage file
CREATE EXTERNAL TABLE test20
(
    id varchar(20),
    city varchar(100),
    quantity varchar(100),
    unitprice VARCHAR(100) )  
WITH (
    LOCATION = '/csvFile_azure.csv',
    DATA_SOURCE = regex_dsrc_demo12,  
    FILE_FORMAT = regex_csv_format2
);


-- Retrieve all records from external table
SELECT  * FROM test20;
