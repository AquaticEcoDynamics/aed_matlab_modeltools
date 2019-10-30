clear all; close all;

addpath(genpath('Functions'));



ncfile = 'Z:\PEEL\2016_Local\run_2016_2018.nc';
%ncfile = 'Z:\Busch\Studysites\Peel\2018_Modelling\Peel_WQ_Model_v5_2016_2017_3D_Murray\Output\sim_2016_2017_Open.nc';
outdir = 'Y:\Peel Final Report\Budget_v11\run_2016_2018\';
if exist(outdir,'dir')
    mkdir(outdir);
end
disp(ncfile);


v_all = tfv_infonetcdf(ncfile);
%vars = v_all(23:end);
vars = v_all([20 21 23:end]);
%outdir = 'I:\Peel\Matfiles/Peel_WQ_Model_v5_2016_2017_3D_Murray/';

%load Export_Locations.mat;
shp = shaperead('GIS/Regions.shp');
%shp = shp_A(4);

data = tfv_readnetcdf(ncfile,'names',{'idx2';'idx3';'cell_X';'cell_Y';'cell_A';'NL';'layerface_Z';'cell_Zb'});clear functions;
names = tfv_infonetcdf(ncfile);
mdata = tfv_readnetcdf(ncfile,'time',1);clear functions;
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


for i = 1:length(vars)
    
    if sum(strcmpi(names,vars{i})) == 1
        
        disp(['Importing ',vars{i}]);
        
        
        mod = tfv_readnetcdf(ncfile,'names',vars(i));clear functions;
        tic
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
                    
                    cell_num = fsite(j).theID(k);
                    cell_Area = data.cell_A(cell_num);
                    num_layers = data.NL(cell_num);
                    startlayer = sum(data.NL(1:cell_num-1))+cell_num;
                    endlayer = startlayer + num_layers;
                    layer_depths = data.layerface_Z(startlayer:endlayer,:);
                    
                    
                    for l = 1:length(ss)
                        
                        vol(l,:) = (layer_depths(l,:) - layer_depths(l+1,:)) * cell_Area;
                        mass(l,:) = vol(l) * mod.(vars{i})(ss(l),:);
                        
                    end
                    savedata.(vars{i}).Column(k,:) = sum(mass,1);
                    savedata.(vars{i}).Area(k) = cell_Area;
                    
                    clear vol mass;
                end
            end
            
            savedata.Time = Time;
            
            save([findir,vars{i},'.mat'],'savedata','-mat','-v7.3');
            clear savedata;
            % end
        end
        toc
    end
end

% end



