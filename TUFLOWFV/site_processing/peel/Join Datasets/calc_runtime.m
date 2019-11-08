clear all; close all;

findir = 'Y:\Peel Final Report\Processed_v11_joined\';

dirlist = dir(findir);

fid = fopen([findir,'runtime.txt'],'wt');

for i = 3:length(dirlist)
    
    load([findir,dirlist(i).name,'/cell_A.mat']);
    
    stime = savedata.Time(1);
    etime = savedata.Time(end);
    
    fprintf(fid,'%s,%s,%s\n',dirlist(i).name,datestr(stime,'dd/mm/yyyy'),datestr(etime,'dd/mm/yyyy'));
    
end
fclose(fid);