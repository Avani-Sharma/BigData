-- create a table 
CREATE TABLE SalesData (
    transaction_id VARCHAR(50),
    store_city VARCHAR(50),
    quantity INT,
    unit_price FLOAT
);


-- Load data from Azure Blob Storage into the SalesData table
-- COPY INTO is used for fast bulk loading in Azure Synapse
COPY INTO SalesData
FROM 'https://externalregex.blob.core.windows.net/containerfile/csvFile_azure.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CREDENTIAL = (IDENTITY = 'Shared Access Signature',
    SECRET = '<SAS token>')
);


-- Retrieve all loaded data from the table
select * from SalesData;

