clear all; close all;

load Export_Locations.mat;

ss = 'SH3G New';

for i = 1:length(shp)
    if strcmpi(shp(i).Name,ss) == 1
        stop
    end
end