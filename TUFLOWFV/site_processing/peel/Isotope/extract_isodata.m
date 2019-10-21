function extract_isodata(varname)

load peel.mat;


sites = fieldnames(peel);

shp = shaperead('SHP/Iso_Zones.shp');

aDates = [];

for i = 1:length(shp)
    
    loc = regexprep(shp(i).Name,' ','_');
    
    for j = 1:length(sites)
        
        if isfield(peel.(sites{j}),varname)
            
            if inpolygon(peel.(sites{j}).(varname).X,peel.(sites{j}).(varname).Y,shp(i).X,shp(i).Y)
            
                iso.(loc).(sites{j}).(varname) = peel.(sites{j}).(varname);
                
                aDates = [aDates;peel.(sites{j}).(varname).Date];
                
            end
            
        end
    end
end

save iso.mat iso -mat;