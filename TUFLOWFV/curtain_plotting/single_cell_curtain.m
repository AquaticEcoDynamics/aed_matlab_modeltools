clear all; close all;

addpath(genpath('tuflowfv'));

ncfile = 'C:\Users\00065525\Scratch\Maryam\New 3D\Output\Roselea_poly2.nc';


cell_ID = 725;

data = tfv_readnetcdf(ncfile);

dat = tfv_readnetcdf(ncfile,'time',1);


H = max(data.H(cell_ID,:));
D = max(data.D(cell_ID,:));



ddd = find(data.idx2 == cell_ID);

thevar = data.V_x(ddd,:);

pcolor(thevar);shading flat;colorbar