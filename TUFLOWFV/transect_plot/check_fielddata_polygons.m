clear all; close all;

fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
fielddata = 'hawkesbury_all';

field = load(fielddata_matfile);
fdata = field.(fielddata);

sites = fieldnames(fdata);

shp = shaperead('fieldpolygons.shp');

def.pdates(1).value = [datenum(2017,06,01) datenum(2017,07,01)];

var = 'SAL';

for i = 1:length(sites)
    
    if isfield(fdata.(sites{i}),var)
        
        X = fdata.(sites{i}).(var).X;
        Y = fdata.(sites{i}).(var).Y;
        
        for j = 1:length(shp)
            if inpolygon(X,Y,shp(j).X,shp(j).Y)
                sss = find(fdata.(sites{i}).(var).Date >= def.pdates(1).value(1) & ...
                    fdata.(sites{i}).(var).Date <= def.pdates(1).value(2));
                
                
                if ~isempty(sss)
                    
                    disp(['Found data at site: ',sites{i}]);
                    disp(['Number of values: ',num2str(length(sss))]);
                    
                end
            end
        end
    end
end
                    
                    
                
