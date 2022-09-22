% This script extracts minute, hour, weekday and day from the datetime 

% Convert timestamp to datetime 

dataTS = datetime(df.Timestamp);

%% Minute

% MinuteTS = minute(dataTS);

%% Hour

Hour = hour(dataTS);

%% Weekday

Weekday = weekday(dataTS);


%% Day

% DayTS = day(dataTS);
