%clear all; close all;

base_dir = 'Y:\Peel Final Report\Processed_v12_joined\run_2016_2018_joined\';

% oxy = load([base_dir,'WQ_OXY_OXY.mat']);
% age = load([base_dir,'WQ_TRC_AGE.mat']);
% sal = load([base_dir,'SAL.mat']);


outdir = '2016/';

if ~exist(outdir,'dir')
    mkdir(outdir);
end

datearray = datenum(2016,04,01:07:365,12,00,00);

period = '2016-18';

for i = 1:length(datearray)
    
    filename = [outdir,datestr(datearray(i),'yyyymmddHHMMSS'),'.csv'];
    
    fid = fopen(filename,'wt');
    
    fprintf(fid,'Cell,Age,Oxy,Sal,Period\n');
    
    [~,ind]  = min(abs(age.savedata.Time - datearray(i)));
    
    A_age = age.savedata.WQ_TRC_AGE.Bot(:,ind) / 86400;
    A_oxy = oxy.savedata.WQ_OXY_OXY.Bot(:,ind);
    A_sal = sal.savedata.SAL.Bot(:,ind);
    
    for j = 1:length(A_age)
        fprintf(fid,'%d,%4.4f,%4.4f,%4.4f,%s\n',j,A_age(j),A_oxy(j),A_sal(j),period);
    end
    fclose(fid);
end
    
    
    
    