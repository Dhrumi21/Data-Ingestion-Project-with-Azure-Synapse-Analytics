--Part 1: Create External Table
-- External File Format:

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 FIRST_ROW = 2,
			 USE_TYPE_DEFAULT = FALSE
			))
GO

-- External Data Source:

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'data-stage_ncplstorage2024_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [data-stage_ncplstorage2024_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://data-stage@ncplstorage2024.dfs.core.windows.net' 
	)
GO



-- https://ncplstorage2024.blob.core.windows.net/data-stage/sample_order_data.csv

-- External Table:
CREATE EXTERNAL TABLE Order_TBL3 (
  -- Define your table schema here
    [ OrderID] NVARCHAR(1000),
	[ CustomerID] NVARCHAR(1000),
	[ OrderDate] date,
	[ ProductID] NVARCHAR(1000),
	[ ProductName] nvarchar(4000),
	[ Quantity] bigint,
	[ UnitPrice] bigint,
	[ TotalPrice] bigint
)
WITH (
    
    LOCATION = '/',
	DATA_SOURCE = [data-stage_ncplstorage2024_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
  
);
SELECT TOP 10 * FROM Order_TBL3