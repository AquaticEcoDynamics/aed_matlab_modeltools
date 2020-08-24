clear all; close all;
warning off
addpath(genpath('../tuflowfv'));

dirlist = dir(['N:\SCERM\SCERM_v6_A3\Output_plt\','*.nc']);

%thedirs = [1 2 3 4 6 7 9 10]
thedirs = [3 4 7]
for bb = thedirs%1:length(dirlist)
    
    
    ncfile = ['N:\SCERM\SCERM_v6_A3\Output_plt\',dirlist(bb).name];
    
    folder = regexprep(dirlist(bb).name,'.nc','');
    
    %polygon_file = '..\..\..\Lake-Erie-2019\matlab\modeltools\gis\erie_validation_v4.shp';
    polygon_file = '..\..\..\SCERM\matlab\modeltools\gis\swan_erz_only.shp';
    
    outdir = ['N:\SCERM\SCERM_v6_A3\Export_v2\',folder,'\'];
    
    thevars = {...
        'WQ_NIT_NIT',...
        'WQ_NIT_AMM',...
        'WQ_PHS_FRP',...
        'WQ_DIAG_PHY_TCHLA',...
        'WQ_DIAG_TOT_TURBIDITY',...
        'TEMP',...
        'SAL',...
        'WQ_DIAG_TOT_TN',...
        'WQ_DIAG_TOT_TP',...
        'WQ_OXY_OXY',...
        };
    
    theheaders = {...
        'NIT (mg/L)',...
        'AMM (mg/L)',...
        'FRP (mg/L)',...
        'TCHLA (ug/L)',...
        'Turbidity (NTU)',...
        'Temperature (C)',...
        'Salinity (psu)',...
        'TN (mg/L)',...
        'TP (mg/L)',...
        'Oxygen (mg/L)',...
        };
    
    theconv = [14/1000 14/1000 31/1000 1 1 1 1 14/1000 31/1000 32/1000];
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
            fprintf(shp(i).fid,'%s Surface MIN,%s Surface MEAN,%s Surface MEDIAN,%s Surface MAX,%s Bottom MIN,%s Bottom MEAN,%s Bottom MEDIAN,%s Bottom MAX,',...
                theheaders{j},theheaders{j},theheaders{j},theheaders{j},...
                theheaders{j},theheaders{j},theheaders{j},theheaders{j});
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
                sdata_min = min(dat.(thevars{k})(shp(j).surfIndex) * theconv(k));
                sdata_mean = mean(dat.(thevars{k})(shp(j).surfIndex) * theconv(k));
                sdata_median = median(dat.(thevars{k})(shp(j).surfIndex) * theconv(k));
                sdata_max = max(dat.(thevars{k})(shp(j).surfIndex) * theconv(k));
                bdata_min = min(dat.(thevars{k})(shp(j).botIndex) * theconv(k));
                bdata_mean = mean(dat.(thevars{k})(shp(j).botIndex) * theconv(k));
                bdata_median = median(dat.(thevars{k})(shp(j).botIndex) * theconv(k));
                bdata_max = max(dat.(thevars{k})(shp(j).botIndex) * theconv(k));

                fprintf(shp(j).fid,'%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,',...
                    sdata_min,sdata_mean,sdata_median,sdata_max,...
                    bdata_min,bdata_mean,bdata_median,bdata_max);
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
    
    
    
end









