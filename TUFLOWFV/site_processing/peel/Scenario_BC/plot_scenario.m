clear all; close all;

sc0a = tfv_readBCfile('E:\Github 2018\Peel_Scenarios\BC\Inflows\Scenario_0a\01_Serpentine.csv');
sc1a = tfv_readBCfile('E:\Github 2018\Peel_Scenarios\BC\Inflows\Scenario_1a\01_Serpentine.csv');
base = tfv_readBCfile('E:\Github 2018\Peel_sims\Peel_Nectar_Sims\BC\All_nN2O\Older Files\Serpentine.csv');

xarray = datenum(2016,01:03:13,01);

plot(sc0a.Date,sc0a.Flow,'r');hold on
plot(sc1a.Date,sc1a.Flow,'b');hold on
plot(base.Date,base.Flow,'g');hold on
xlim([xarray(1) xarray(end)]);


figure

plot(sc0a.Date,sc0a.Sal,'r');hold on
plot(sc1a.Date,sc1a.Sal,'b');hold on
plot(base.Date,base.Sal,'g');hold on

xlim([xarray(1) xarray(end)]);
