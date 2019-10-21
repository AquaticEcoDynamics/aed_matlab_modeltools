clear all; close all;

S = shaperead('Export_Locations.shp');

[snum,sstr] = xlsread('Spreadsheets/All fish samples and dates_Matt and Brendan_18th March 2019.xlsx','All nearshore samples and dates','A2:H2000');

mdates = datenum(snum(:,3),snum(:,1),snum(:,2));

sites = sstr(:,5);
for i = 1:length(S)
    S(i).Dates = [];
end
for i = 1:length(S)
    ss = find(strcmpi(S(i).Name,sites)==1);
    
    if ~isempty(ss)
        S(i).Dates = [S(i).Dates;mdates(ss)];
    end
end

clear sites mdates

[snum,sstr] = xlsread('Spreadsheets/All fish samples and dates_Matt and Brendan_18th March 2019.xlsx','All offshore samples and dates','A2:H2000');

mdates = datenum(snum(:,3),snum(:,1),snum(:,2));
sites = sstr(:,5);

for i = 1:length(S)
    ss = find(strcmpi(S(i).Name,sites)==1);
    
    if ~isempty(ss)
        S(i).Dates = [S(i).Dates;mdates(ss)];
    end
end

clear ss

for i = 1:length(S)
    
    %rectangle('Position',[S(i).X-S(i).Radius, S(i).Y-S(i).Radius, S(i).Radius, S(i).Radius],'Curvature',[1,1]);
    
    th = 0:pi/50:2*pi;
    xunit = S(i).Radius * cos(th) + S(i).X;
    yunit = S(i).Radius * sin(th) + S(i).Y;

    shp(i).X = xunit;
    shp(i).Y = yunit;
    shp(i).Geometry = 'Polygon';
    shp(i).Radius = S(i).Radius;
    shp(i).Dates = S(i).Dates;
    shp(i).Name = S(i).Name;
    shp(i).ID = S(i).ID;
    shp(i).Depth = S(i).Depth;
    
    
    
end

new = shaperead('Zones.shp');

[snum,sstr] = xlsread('Spreadsheets/sites_polygon_matching.xlsx','A2:B1000');
allzones = sstr(:,2);
allsites = sstr(:,1);
for i = 1:length(new)
    zonename = new(i).Name;
    
    ss = find(strcmpi(allzones,zonename) == 1);
    
    adates = [];
    
    for j = 1:length(ss)
        
        for k = 1:length(shp)
            
            if strcmpi(shp(k).Name,allsites(ss(j))) == 1
                adates = [adates;shp(k).Dates];
            end
        end
    end
    
    new(i).Dates = unique(adates);
    
    clear adates;
end
    

inc = length(shp)+1;

for i = 1:length(new)
    shp(inc).X = new(i).X;
    shp(inc).Y = new(i).Y;
    shp(inc).ID = inc;
    shp(inc).Name = new(i).Name;
    shp(inc).Dates = new(i).Dates;
    shp(inc).Geometry = 'Polygon';
    shp(inc).Depth = 100;
    inc = inc + 1;
end
    


        
        
    
   
    
    







%shapewrite(ss,'Export_Locations_Dates.shp');

save Export_Locations.mat shp -mat;


