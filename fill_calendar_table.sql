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
