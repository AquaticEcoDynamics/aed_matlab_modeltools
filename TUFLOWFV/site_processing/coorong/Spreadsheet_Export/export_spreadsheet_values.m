clear all; close all;

load outdata.mat;

filename = 'Seasonal Means.csv';


sims = {...
    'ORH_Base_20140101_20170101',...
    'ORH_Base_3D_20140101_20170101',...
    'ORH_Base_FSED0_20140101_20170101',...
    'ORH_Base_FSED2_20140101_20170101',...
    'ORH_SLR_02_20140101_20170101',...
    'SC40_Base_20140101_20170101',...
    'SC40_NUT_1_5_20140101_20170101',...
    'SC40_NUT_2_0_20140101_20170101',...
    };

names = {...
    'ORH',...
    'MPB 2000',...
    'FSED 0',...
    'FSED 2',...
    'SLR 0.2m',...
    'SC40',...
    'SC40 NUT 1.5',...
    'SC40 NUT 2.0',...
    };


zones = {...
    'Mouth',...
    'Upper',...
    'Mid',...
    'Upper_Salt',...
    'Lower_Salt',...
    };

vars = {...
    'SAL',...
    'WQ_NIT_NIT',...
    'WQ_PHS_FRP',...
    'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
    'WQ_OXY_OXY',...
    'WQ_DIAG_HAB_RUPPIA_HSI',...
    'WQ_DIAG_MAG_HSI',...
    };

range(1).val = [datenum(2014,01,01) datenum(2014,04,01)];
range(2).val = [datenum(2014,04,01) datenum(2014,07,01)];
range(3).val = [datenum(2014,07,01) datenum(2014,10,01)];
range(4).val = [datenum(2014,10,01) datenum(2015,01,01)];
range(5).val = [datenum(2015,01,01) datenum(2015,04,01)];

fid = fopen(filename,'wt');


fprintf(fid,'Start Date,End Date,Zone,Simulation,');
for i = 1:length(vars)
    fprintf(fid,'%s,',vars{i});
end
fprintf(fid,'\n');

for i = 1:length(range)
    
    
    for j = 1:length(zones)
        
        for k = 1:length(sims)
            fprintf(fid,'%s,%s,',datestr(range(i).val(1),'dd/mm/yyyy'),datestr(range(i).val(2)-1,'dd/mm/yyyy'));
            fprintf(fid,'%s,',zones{j});
            
            fprintf(fid,'%s,',sims{k});
            
            for l = 1:length(vars)
                
                the_mean = outdata.(sims{k}).(vars{l}).(zones{j})(i);
                fprintf(fid,'%4.4f,',the_mean);
                
            end
            fprintf(fid,'\n');
        end
    end
end
                