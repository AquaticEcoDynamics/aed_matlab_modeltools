clear all; close all;

dirlist = dir(['T:\PEEL\NEWER\','*.nc']);

fid = fopen('netcdf_info.txt','wt');

for i = 1:length(dirlist)
    sim_name = regexprep(dirlist(i).name,'.nc','');
    dat = tfv_readnetcdf(['T:\PEEL\NEWER\',dirlist(i).name],'time',1);
    
    fprintf(fid,'%s,%s,%s\n',sim_name,datestr(dat.Time(1),'dd-mm-yyyy HH:MM:SS'),datestr(dat.Time(end),'dd-mm-yyyy HH:MM:SS'));
    
    
  
   
end

fclose(fid);