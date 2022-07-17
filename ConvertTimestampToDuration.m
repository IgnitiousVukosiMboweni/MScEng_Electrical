% This code converts the Timestamp column in the data to a 
% ..relative duration array by subtracting the first element from 
% ..all the others

Tt = timetable(datetime(df.Timestamp),randn(length(df.Timestamp),1));
dt = Tt.Time-Tt.Time(1);
Duration = timetable(dt,Tt.Var1);
