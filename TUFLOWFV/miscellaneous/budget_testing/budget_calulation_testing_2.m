%clear all; close all;

addpath(genpath('../../tuflowfv'));

filename = '/Projects2/CDM/HCHB_scenario_assessment/MER_Coorong_eWater_2022_GEN15_newBC_testing/output_basecase/eWater2021_basecase_t3_all.nc';

shpfile = '/Projects2/CDM/HCHB_scenario_assessment/MER_Coorong_eWater_2022_GEN15_newBC_testing/plots/GIS/Coorong_Regions.shp';

shp_temp = shaperead(shpfile);

shpID = 9;

shp = shp_temp(shpID);

dat = tfv_readnetcdf(filename,'time',1);
mtime = dat.Time;

rawGeo = tfv_readnetcdf(filename,'timestep',1);


starttime = datenum(2019,07,01);
endtime = datenum(2020,07,01);

thevar = 'WQ_DIAG_OGM_DON_MIN';

thecon = 14/1000;

data = tfv_readnetcdf(filename,'names',{thevar;'D';});

X = rawGeo.cell_X;
Y = rawGeo.cell_Y;

inpol = inpolygon(X,Y,shp.X,shp.Y);

pt_id = find(inpol == 1);

Area = rawGeo.cell_A(pt_id);

thetime = find(mtime >= starttime & mtime < endtime);

thedepth = data.D(pt_id,thetime);
thedata = data.(thevar)(pt_id,thetime) * thecon;

themass(1:length(thetime),1) = 0;

for i = 1:length(thetime)

	masscalc = thedepth(:,i) .* thedata(:,i) .* Area;
	masscalc = masscalc * 1e-6;
	themass(i,1) = sum(masscalc);
	
end

themass_fin = sum(themass) / length(thetime);

themass_fin

