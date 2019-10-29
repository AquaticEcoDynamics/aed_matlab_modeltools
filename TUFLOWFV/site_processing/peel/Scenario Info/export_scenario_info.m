clear all; close all;

filelist = dir(['K:\Peel_Scenarios\','*.nc']);

fid = fopen('Scenario Info.txt','wt');

for i = 1:length(filelist)
    
    dat = tfv_readnetcdf(['K:\Peel_Scenarios\',filelist(i).name],'time',1);
    
    fprintf(fid,'%s,%s,%s\n',filelist(i).name,datestr(dat.Time(1),'dd-mm-yyyy'),datestr(dat.Time(end),'dd-mm-yyyy'));
    
end
fclose(fid);