clear all; close all;

%addpath(genpath('Functions'));

%dirlist = dir(['../Historical/','*.nc']);
dirlist = dir(['Y:\Peel Final Report\Processed_v12_joined/']);
outdir_base = 'Y:\Peel Final Report/Regional v12/';
for bdb = 3:length(dirlist)
    

    outdir = [outdir_base,dirlist(bdb).name,'/'];

    disp(dirlist(bdb).name);
    mkdir(outdir);
    
    shp = shaperead('E:\Github 2018\AED_Scripts\Matlab\TFV\Polygon Region Plotting\GIS\peel_polygons.shp');

    %shp = S;
    
    data = load(['Y:\Peel Final Report\Processed_v12_joined/',dirlist(bdb).name,'/','cell_A.mat']);
    
    Time = data.savedata.Time;
    
    %______________________________________________________________
    
    
    
    
    for i = 1:length(shp)
        
        

        inpol = inpolygon(data.savedata.X,data.savedata.Y,shp(i).X,shp(i).Y);
        %    inpol = find(dist <= shp(i).Radius);
        
        ttt = find(inpol == 1);
        fsite(i).theID = ttt;
        fsite(i).Name = shp(i).Name;
        
        
    end
%     vars = {...
%         'WQ_NIT_AMM',...
%         };
    
    vars_all = dir(['Y:\Peel Final Report\Processed_v12_joined/',dirlist(bdb).name,'/','*mat']);
%    
    for gg = 1:length(vars_all)
        vars{gg} = regexprep(vars_all(gg).name,'.mat','');
    end
    
    
    
    for i = 1:length(vars)
        disp(['Importing ',vars{i}]);
        
        
        %mod = tfv_readnetcdf(ncfile,'names',vars(i));clear functions;
        data = load(['Y:\Peel Final Report\Processed_v12_joined/',dirlist(bdb).name,'/',vars{i},'.mat']);
        for j = 1:length(shp)
            savedata = [];
            
            findir = [outdir,shp(j).Name,'/'];
            if ~exist(findir,'dir')
                mkdir(findir);
            end
            %if ~exists([findir,vars{i},'.mat'],'file')
            
            savedata.X = data.savedata.X(fsite(j).theID);
            savedata.Y = data.savedata.Y(fsite(j).theID);
            
            
            switch vars{i}
                case 'H'
                    savedata.(vars{i}) = data.savedata.(vars{i})(fsite(j).theID,:);
                case 'D'
                    savedata.(vars{i}) = data.savedata.(vars{i})(fsite(j).theID,:);
                case 'cell_A'
                    savedata.(vars{i}) = data.savedata.(vars{i})(fsite(j).theID);
                otherwise
                    savedata.(vars{i}).Top =  data.savedata.(vars{i}).Top(fsite(j).theID,:);
                    savedata.(vars{i}).Bot = data.savedata.(vars{i}).Bot(fsite(j).theID,:);
            end
            
            
%             if strcmpi(vars{i},'H') == 1 | strcmpi(vars{i},'D') == 1 | strcmpi(vars{i},'cell_A') == 1
%                 savedata.(vars{i}) = mod.(vars{i})(fsite(j).theID,:);
%             else
%                 for k = 1:length(fsite(j).theID)
%                     
%                     ss = find(data.idx2 == fsite(j).theID(k));
%                     
%                     surfIndex = min(ss);
%                     botIndex = max(ss);
%                     savedata.(vars{i}).Top(k,:) = mod.(vars{i})(surfIndex,:);
%                     savedata.(vars{i}).Bot(k,:) = mod.(vars{i})(botIndex,:);
%                 end
%             end
            
            savedata.Time = Time;
            
            save([findir,vars{i},'.mat'],'savedata','-mat','-v7.3');
            clear savedata;
            % end
        end
        clear data
    end
    
    % end
end


