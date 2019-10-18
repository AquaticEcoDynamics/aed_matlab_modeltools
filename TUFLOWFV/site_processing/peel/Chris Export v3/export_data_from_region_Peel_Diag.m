clear all; close all;

addpath(genpath('Functions'));

dirlist = dir(['J:\Reruns\NCfiles/Diag2/','*.nc']);

for bdb = 1:length(dirlist)
    
    ncfile = ['J:\Reruns\NCfiles/Diag2/',dirlist(bdb).name];
    %ncfile = 'Z:\Busch\Studysites\Peel\2018_Modelling\Peel_WQ_Model_v5_2016_2017_3D_Murray\Output\sim_2016_2017_Open.nc';
    outdir = ['../Matfiles_Chris_v4/',regexprep(dirlist(bdb).name,'.nc',''),'/'];
    %     if exist(outdir,'dir')
    %
    %     else
    disp(ncfile);
    mkdir(outdir);
    %outdir = 'I:\Peel\Matfiles/Peel_WQ_Model_v5_2016_2017_3D_Murray/';
    
    load Export_Locations.mat;
    %shp = S;
    
    data = tfv_readnetcdf(ncfile,'names',{'idx2';'idx3';'cell_X';'cell_Y';'cell_A'});
    
    mdata = tfv_readnetcdf(ncfile,'time',1);
    Time = mdata.Time;
    %sites = {'Currency Creek';'Lake Albert WLR';'Lake Alex Middle'};
    
    %______________________________________________________________
    
    
    
    
    for i = 1:length(shp)
        
        
        %     for j = 1:length(data.cell_X)
        %
        %         dist(j) = sqrt(power(abs(data.cell_X(j)-shp(i).X),2) + power(abs(data.cell_Y(j)-shp(i).Y),2));
        %
        %     end
        inpol = inpolygon(data.cell_X,data.cell_Y,shp(i).X,shp(i).Y);
        %    inpol = find(dist <= shp(i).Radius);
        
        ttt = find(inpol == 1);
        fsite(i).theID = ttt;
        fsite(i).Name = shp(i).Name;
        
        
    end
    
    
    vars = {...
%         'cell_A',...
%         'V_x',...
%         'V_y',...
%         'H',...
%         'D',...
%         'SAL',...
%         'TEMP',...
%         'WQ_OXY_OXY',...
%         'WQ_TRC_AGE',...
%         'WQ_NIT_AMM',...
%         'WQ_NIT_NIT',...
%         'WQ_PHS_FRP',...
%         'WQ_PHS_FRP_ADS',...
%         'WQ_OGM_DOC',...
%         'WQ_OGM_POC',...
%         'WQ_OGM_DON',...
%         'WQ_OGM_PON',...
%         'WQ_OGM_DOP',...
%         'WQ_OGM_POP',...
%         'WQ_PHY_GRN',...
        'WQ_DIAG_MAG_HSI',...
        'WQ_DIAG_PHY_BPP',...
        'WQ_DIAG_TOT_TN',...
        'WQ_DIAG_TOT_TP',...
        'WQ_DIAG_TOT_TURBIDITY',...
        'WQ_DIAG_TOT_LIGHT',...
        'WQ_DIAG_MAG_TMALG',...
        'WQ_DIAG_PHY_TCHLA',...
        'WQ_DIAG_TOT_TOC',...
        %
        %     'WQ_DIAG_SDF_FSED_OXY',...
        %     'WQ_DIAG_OXY_SED_OXY',...
        %     'WQ_DIAG_PHY_GPP',...
        %
        %     'WQ_DIAG_TOT_PAR',...
        %     'WQ_DIAG_TOT_UV',...
        %     'WQ_DIAG_TOT_EXTC',...
        };
    
    for i = 1:length(vars)
        disp(['Importing ',vars{i}]);
        
        
        mod = tfv_readnetcdf(ncfile,'names',vars(i));
        
        for j = 1:length(shp)
            savedata = [];
            
            findir = [outdir,shp(j).Name,'/'];
            if ~exist(findir,'dir')
                mkdir(findir);
            end
            %if ~exists([findir,vars{i},'.mat'],'file')
            
            savedata.X = data.cell_X(fsite(j).theID);
            savedata.Y = data.cell_Y(fsite(j).theID);
            
            if strcmpi(vars{i},'H') == 1 | strcmpi(vars{i},'D') == 1 | strcmpi(vars{i},'cell_A') == 1
                savedata.(vars{i}) = mod.(vars{i})(fsite(j).theID,:);
            else
                for k = 1:length(fsite(j).theID)
                    
                    ss = find(data.idx2 == fsite(j).theID(k));
                    
                    surfIndex = min(ss);
                    botIndex = max(ss);
                    savedata.(vars{i}).Top(k,:) = mod.(vars{i})(surfIndex,:);
                    savedata.(vars{i}).Bot(k,:) = mod.(vars{i})(botIndex,:);
                end
            end
            
            savedata.Time = Time;
            
            save([findir,vars{i},'.mat'],'savedata','-mat','-v7.3');
            clear savedata;
            % end
        end
        
    end
    
    % end
end


