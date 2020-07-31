clear all; close all;
warning off
addpath(genpath('../tuflowfv'));

ncfile = 'N:\Erie\V9_A3\erie_grandriver_75_AED_diag.nc';

polygon_file = '..\..\..\Lake-Erie-2019\matlab\modeltools\gis\erie_validation_v4.shp';

outdir = 'N:\Erie\V9_A3\erie_grandriver_75_AED_diag\';

thevars = {...
    'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
    'WQ_DIAG_TOT_TSS',...
    'WQ_DIAG_PHY_TCHLA',...
    'WQ_DIAG_MAG_TMALG',...
    };

theheaders = {...
    'TN (mg/L)',...
    'TP (mg/L)',...
    'TSS (mg/L)',...
    'TCHLA (ug/L)',...
    'TMalg',...
    };

theconv = [14/1000 31/1000 1 1 1];
shp = shaperead(polygon_file);

thepolygons = [1:1:length(shp)];%[14:25]; %

%__________________________________________________________________________


dat = tfv_readnetcdf(ncfile,'time',1);

mTime = dat.Time;

dat = tfv_readnetcdf(ncfile,'timestep',1);

% Get the cell indexes
disp('Calculating the cell indexes');
for i = thepolygons
    
    inpol = inpolygon(dat.cell_X,dat.cell_Y,shp(i).X,shp(i).Y);
    
    ttt = find(inpol == 1);
    shp(i).theID = ttt;
    
    for k = 1:length(ttt)
        ss = find(dat.idx2 == shp(i).theID(k));

        shp(i).surfIndex(k) = min(ss);
        shp(i).botIndex(k) = max(ss);
    end
     
end
disp('done !');

if ~exist(outdir,'dir')
    mkdir(outdir);
end

disp('Exporting the data');

% Open the output files
for i = thepolygons
    shp(i).fid = fopen([outdir,shp(i).Name,'.csv'],'wt');
    
    fprintf(shp(i).fid,'Date,');
    
    for j = 1:length(thevars)
        fprintf(shp(i).fid,'%s Surface,%s Bottom,',theheaders{j},theheaders{j});
    end
    fprintf(shp(i).fid,'\n');
end

for i = 1:length(mTime)
    tic
    disp(datestr(mTime(i)));
    
    dat = tfv_readnetcdf(ncfile,'timestep',i);clear functions;
    
    for j = thepolygons
        fprintf(shp(j).fid,'%s,',datestr(mTime(i),'dd/mm/yyyy HH:MM:SS'));
        %int = 1
        for k = 1:length(thevars)
%             CM(int) = mean(dat.(thevars{k})(shp(j).surfIndex) * theconv(k));
%             CM(int+1) = mean(dat.(thevars{k})(shp(j).botIndex) * theconv(k));
%             int = int + 1
            sdata = mean(dat.(thevars{k})(shp(j).surfIndex) * theconv(k));
            bdata = mean(dat.(thevars{k})(shp(j).botIndex) * theconv(k));
           fprintf(shp(j).fid,'%4.4f,%4.4f,',sdata,bdata); 
        end
%         str = compose('%4.4f',CM);
%         fprintf(shp(j).fid,'%s\n',str{:});
        
        fprintf(shp(j).fid,'\n');
    end
    toc
end
for i = thepolygons
    fclose(shp(i).fid);
end
        
    
    


    
    
    





