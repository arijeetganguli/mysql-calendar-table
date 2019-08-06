# mysql-calendar-table
Populate your own calendar table

## Create Table
```sql
CREATE TABLE calendar_table (
        id                      INTEGER PRIMARY KEY,
        
        c_date                  DATE NOT NULL,
        c_year			INTEGER NOT NULL,        
        c_month			INTEGER NOT NULL,  -- 1 to 12
        c_day			INTEGER NOT NULL,  -- 1 to 31        
        c_quarter		INTEGER NOT NULL,  -- 1 to 4
        
        c_week			INTEGER NOT NULL,  -- 1 to 52/53
        c_dayofweek		INTEGER NOT NULL,  -- 1 to 7        
        
        day_name                VARCHAR(10) NOT NULL, -- 'Monday', 'Tuesday'...
        month_name              VARCHAR(10) NOT NULL, -- 'January', 'February'...
        
        is_weekend		INT(1) NOT NULL,
        
        UNIQUE unq_ct_y_m_d (c_year, c_month, c_day),
        UNIQUE unq_ct_date (c_date)
);
```

## Create Procedure
```sql
CREATE PROCEDURE fill_calendar_table(_StartDate DATE, _ToDate DATE)
BEGIN
    DECLARE __Date DATE;
    SET __Date = _StartDate;
    
    WHILE __Date <= _ToDate DO
        INSERT INTO calendar_table 
        VALUES (
		YEAR(__Date)*10000 + MONTH(__Date)*100 + DAY(__Date), -- id
                
		__Date,				-- c_date
		YEAR(__Date),			-- c_year
		MONTH(__Date),			-- c_month
		DAY(__Date),			-- c_day
		QUARTER(__Date),		-- c_quarter       
                
		WEEKOFYEAR(__Date),		-- c_week
                DAYOFWEEK(__Date),		-- c_dayofweek
		DATE_FORMAT(__Date,'%W'), 	-- day_name
		DATE_FORMAT(__Date,'%M'),	-- month_name
                
                DAYOFWEEK(__Date) IN (1,7)	-- is_weekend
		);
                        
        SET __Date = ADDDATE(__Date, INTERVAL 1 DAY);
    END WHILE;
END
```
## Fill Table
```sql
TRUNCATE TABLE calendar_table;
CALL fill_calendar_table('2000-01-01', '2019-12-31');
```
