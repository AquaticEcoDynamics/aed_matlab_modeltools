clear all; close all;

load Export_Locations.mat;
shp = S;


maindir = 'Matfiles/Peel_WQ_Model_v5_2016_2017_3D_Murray/';
outdir = 'Spreadsheets/Peel_WQ_Model_v5_2016_2017_3D_Murray/';

for i = 1:length(shp)
    
    if ~exist([outdir,shp(i).Name,'/'],'dir')
        mkdir([outdir,shp(i).Name,'/']);
    end
    
    
    
    load([maindir,shp(i).Name,'/D.mat']);
    
    DD = savedata;
    
    load([maindir,shp(i).Name,'/TEMP.mat']);
    
    TT = savedata;
    
    load([maindir,shp(i).Name,'/SAL.mat']);
    
    SS = savedata;
    
    load([maindir,shp(i).Name,'/WQ_OXY_OXY.mat']);
    
    OO = savedata;
    
    load([maindir,shp(i).Name,'/WQ_TRC_RET.mat']);
    
    RT = savedata;
    
    
    load([maindir,shp(i).Name,'/WQ_NIT_AMM.mat']);
    
    AM = savedata;
    
    if ~isempty(DD.D)
        
        
        if ~isempty(shp(i).Dates)
            
            for k = 1:length(shp(i).Dates)
                
                sss = find(DD.Time >= (shp(i).Dates(k)-30) & DD.Time < (shp(i).Dates(k) + 1));
                
                if ~isempty(sss)
                    
                    
                    fid = fopen([outdir,shp(i).Name,'/',datestr(shp(i).Dates(k),'yyyymmdd'),'.csv'],'wt');
                    
                    fprintf(fid,'Time,Number of Cells,Max Depth,Min Depth,Ave Depth,Temp (Bottom), Temp (Top), Salinity (Bottom), Salinity (Top),Oxygen (Bottom),Oxygen (top),Age (Bottom),Age (top),NH4 (Bottom),NH4 (top)\n');
                    
                    
                    for j = 1:length(sss)
                        
                        
                        gg = find(DD.D(:,sss(j)) <= shp(i).Depth);
                        if ~isempty(gg)
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).Time(j) = DD.Time(sss(j));
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).NumCells(j) = length(DD.D(:,sss(j)));
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).MaxDepth(j) = max(DD.D(:,sss(j)));
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).MinDepth(j) = min(DD.D(:,sss(j)));
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).AveDepth(j) = mean(DD.D(:,sss(j)));
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).Temp_Bottom(j) = mean(TT.TEMP.Bot(gg,sss(j)));
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).Temp_Surface(j) = mean(TT.TEMP.Top(gg,sss(j)));
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).Salinity_Bottom(j) = mean(SS.SAL.Bot(gg,sss(j)));
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).Salinity_Surface(j) = mean(SS.SAL.Top(gg,sss(j)));
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).Oxygen_Bottom(j) = mean(OO.WQ_OXY_OXY.Bot(gg,sss(j))) * 32/1000;
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).Oxygen_Surface(j) = mean(OO.WQ_OXY_OXY.Top(gg,sss(j))) * 32/1000;
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).RET_Bottom(j) = mean(RT.WQ_TRC_RET.Bot(gg,sss(j))) * 1/86400;
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).RET_Surface(j) = mean(RT.WQ_TRC_RET.Top(gg,sss(j))) * 1/86400;
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).AMM_Bottom(j) = mean(AM.WQ_NIT_AMM.Bot(gg,sss(j))) * 14/1000;
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).AMM_Surface(j) = mean(AM.WQ_NIT_AMM.Top(gg,sss(j))) * 14/1000;
                            
                            
                            
                            
                        else
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).Time(j) = DD.Time(sss(j));
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).NumCells(j) = length(DD.D(:,sss(j)));
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).MaxDepth(j) = max(DD.D(:,sss(j)));
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).MinDepth(j) = min(DD.D(:,sss(j)));
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).AveDepth(j) = mean(DD.D(:,sss(j)));
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).Temp_Bottom(j) = NaN;
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).Temp_Surface(j) = NaN;
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).Salinity_Bottom(j) = NaN;
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).Salinity_Surface(j) = NaN;
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).Oxygen_Bottom(j) = NaN;
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).Oxygen_Surface(j) = NaN;
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).RET_Bottom(j) = NaN;
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).RET_Surface(j) = NaN;
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).AMM_Bottom(j) = NaN;
                            sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(k),'yyyymmdd')]).AMM_Surface(j) = NaN;
                            
                            
                            
                        end
                        
                        
                        
                        
                        if ~isempty(gg)
                            fprintf(fid,'%s,%d,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f\n',...
                                datestr(DD.Time(sss(j)),'dd/mm/yyyy HH:MM:SS'),...
                                length(DD.D(:,sss(j))),...
                                max(DD.D(:,sss(j))),...
                                min(DD.D(:,sss(j))),...
                                mean(DD.D(:,sss(j))),...
                                mean(TT.TEMP.Bot(gg,sss(j))),...
                                mean(TT.TEMP.Top(gg,sss(j))),...
                                mean(SS.SAL.Bot(gg,sss(j))),...
                                mean(SS.SAL.Top(gg,sss(j))),...
                                mean(OO.WQ_OXY_OXY.Bot(gg,sss(j))) * 32/1000,...
                                mean(OO.WQ_OXY_OXY.Top(gg,sss(j))) * 32/1000,...
                                mean(RT.WQ_TRC_RET.Bot(gg,sss(j))) * 1/86400,...
                                mean(RT.WQ_TRC_RET.Top(gg,sss(j))) * 1/86400,...                                
                                mean(AM.WQ_NIT_AMM.Bot(gg,sss(j))) * 14/1000,...
                                mean(AM.WQ_NIT_AMM.Top(gg,sss(j))) * 14/1000);
                        else
                            fprintf(fid,'%s,%d,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f\n',...
                                datestr(DD.Time(sss(j)),'dd/mm/yyyy HH:MM:SS'),...
                                length(DD.D(:,sss(j))),...
                                max(DD.D(:,sss(j))),...
                                min(DD.D(:,sss(j))),...
                                mean(DD.D(:,sss(j))),...
                                NaN,...
                                NaN,...
                                NaN,...
                                NaN,...
                                NaN,...
                                NaN,...
                                NaN,...
                                NaN,...
                                NaN,...
                                NaN);
                        end
                        
                    end
                    
                    fclose(fid);
                    
                end
            end
        end
    end
    
    
end


for i = 1:length(shp)
    
    
    fid = fopen([outdir,'/',shp(i).Name,'/Summary.csv'],'wt');
    
    headers_str = ['Sampling Date,Num of Timesteps,Min Temp (Bottom),Mean Temp (Bottom),Max Temp (Bottom),Min Temp (Surface),Mean Temp (Surface),Max Temp (Surface),',...
        'Min Salinity (Bottom),Mean Salinity (Bottom),Max Salinity (Bottom),Min Salinity (Surface),Mean Salinity (Surface),Max Salinity (surface),',...
        'Min Oxygen (Bottom),Mean Oxygen (Bottom),Max Oxygen (Bottom),Min Oxygen (Surface),Mean Oxygen (Surface),Max Oxygen (surface),',...
        'Oxygen Timesteps below 4 (Bottom),Oxygen Timesteps below 4 (Surface),',...
        'Min Retention (Bottom),Mean Retention (Bottom),Max Retention (Bottom),Min Retention (Surface),Mean Retention (Surface),Max Retention (surface),',...
        'Min NH4 (Bottom),Mean NH4 (Bottom),Max NH4 (Bottom),Min NH4 (Surface),Mean NH4 (Surface),Max NH4 (surface)'];
    
    fprintf(fid,'%s\n',headers_str);
    
    for j = 1:length(shp(i).Dates)
        fprintf(fid,'%s,',datestr(shp(i).Dates(j),'yyyymmdd'));
        
        if isfield(sdata,shp(i).Name) & ...
            isfield(sdata.(shp(i).Name),['m',datestr(shp(i).Dates(j),'yyyymmdd')])
            
            fprintf(fid,'%d,',length(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Time));
            fprintf(fid,'%4.4f,',min(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Temp_Bottom...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Temp_Bottom))));
            fprintf(fid,'%4.4f,',mean(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Temp_Bottom...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Temp_Bottom)))); 
            fprintf(fid,'%4.4f,',max(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Temp_Bottom...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Temp_Bottom))));
            
             fprintf(fid,'%4.4f,',min(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Temp_Surface...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Temp_Surface))));
            fprintf(fid,'%4.4f,',mean(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Temp_Surface...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Temp_Surface)))); 
            fprintf(fid,'%4.4f,',max(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Temp_Surface...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Temp_Surface))));           
            
              fprintf(fid,'%4.4f,',min(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Salinity_Bottom...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Salinity_Bottom))));
            fprintf(fid,'%4.4f,',mean(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Salinity_Bottom...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Salinity_Bottom)))); 
            fprintf(fid,'%4.4f,',max(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Salinity_Bottom...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Salinity_Bottom))));
            
             fprintf(fid,'%4.4f,',min(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Salinity_Surface...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Salinity_Surface))));
            fprintf(fid,'%4.4f,',mean(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Salinity_Surface...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Salinity_Surface)))); 
            fprintf(fid,'%4.4f,',max(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Salinity_Surface...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Salinity_Surface))));            
            
               fprintf(fid,'%4.4f,',min(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Oxygen_Bottom...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Oxygen_Bottom))));
            fprintf(fid,'%4.4f,',mean(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Oxygen_Bottom...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Oxygen_Bottom)))); 
            fprintf(fid,'%4.4f,',max(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Oxygen_Bottom...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Oxygen_Bottom))));
            
             fprintf(fid,'%4.4f,',min(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Oxygen_Surface...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Oxygen_Surface))));
            fprintf(fid,'%4.4f,',mean(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Oxygen_Surface...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Oxygen_Surface)))); 
            fprintf(fid,'%4.4f,',max(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Oxygen_Surface...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Oxygen_Surface))));  
            
            sss = find(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Oxygen_Bottom < 4);
            ttt = find(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).Oxygen_Surface < 4);
            
            if ~isempty(sss)
                fprintf(fid,'%d,',length(sss));
            else
                fprintf(fid,' ,');
            end
            if ~isempty(ttt)
                fprintf(fid,'%d',length(ttt));
            else
                fprintf(fid,' ,');
            end
            
            fprintf(fid,'%4.4f,',min(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).RET_Bottom...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).RET_Bottom))));
            fprintf(fid,'%4.4f,',mean(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).RET_Bottom...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).RET_Bottom)))); 
            fprintf(fid,'%4.4f,',max(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).RET_Bottom...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).RET_Bottom))));
            
            
             fprintf(fid,'%4.4f,',min(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).RET_Surface...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).RET_Surface))));
            fprintf(fid,'%4.4f,',mean(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).RET_Surface...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).RET_Surface)))); 
            fprintf(fid,'%4.4f,',max(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).RET_Surface...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).RET_Surface))));  
            
            
             fprintf(fid,'%4.4f,',min(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).AMM_Bottom...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).AMM_Bottom))));
            fprintf(fid,'%4.4f,',mean(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).AMM_Bottom...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).AMM_Bottom)))); 
            fprintf(fid,'%4.4f,',max(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).AMM_Bottom...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).AMM_Bottom))));             

            fprintf(fid,'%4.4f,',min(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).AMM_Surface...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).AMM_Surface))));
            fprintf(fid,'%4.4f,',mean(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).AMM_Surface...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).AMM_Surface)))); 
            fprintf(fid,'%4.4f,',max(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).AMM_Surface...
                (~isnan(sdata.(shp(i).Name).(['m',datestr(shp(i).Dates(j),'yyyymmdd')]).AMM_Surface))));
            
            
        end
        fprintf(fid,'\n');
    end
    
    fclose(fid);
end
            
            
            
            
            
            
        
        
    
    
    










