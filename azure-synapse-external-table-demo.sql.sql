-- Create a new database 
create DATABASE testing2;

-- Create an External Data Source pointing to Azure Blob Storage container
-- This tells SQL Server/Azure Synapse where the external files are located
CREATE  EXTERNAL DATA SOURCE regex_dsrc_demo
WITH (
    LOCATION = 'https://externalregex.blob.core.windows.net/containerfile/' );


-- Create an External File Format: how the data file is structured 
CREATE EXTERNAL FILE FORMAT regex_csv_format
WITH (  
    FORMAT_TYPE = DELIMITEDTEXT,  
    FORMAT_OPTIONS (  
        FIELD_TERMINATOR = ',' )  );


-- Create an External Table that maps to the CSV file in Azure Storage
-- This does NOT store data inside SQL Server; it only references external data
CREATE EXTERNAL TABLE test2
(
    id varchar(20),
    city varchar(100),
    quantity varchar(100),
    unitprice VARCHAR(100) )  
WITH (
    LOCATION = '/csvFile_azure.csv',
    DATA_SOURCE = regex_dsrc_demo,  
    FILE_FORMAT = regex_csv_format
);


-- Retrieve all data from the external table
SELECT * FROM test2;


SELECT  * FROM test2;