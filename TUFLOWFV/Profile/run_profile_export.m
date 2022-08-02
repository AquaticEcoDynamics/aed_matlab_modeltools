clear all; close all;

ncfile = 'Z:\Amina\Scenario_test_5\Output/SCERM8_2019_2020_ALL.nc';

mdate = datenum(2020,03,01,12,00,00);

X = 390829;
Y = 6459103;

var = 'WQ_OXY_OXY';

[data,depth,outdate] = export_profile(ncfile,mdate,X,Y,var);

plot(data,depth)
