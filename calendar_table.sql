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
