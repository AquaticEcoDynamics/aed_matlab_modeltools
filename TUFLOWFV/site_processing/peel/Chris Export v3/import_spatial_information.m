clear all; close all;

filename = 'Spreadsheets/Info on polygons and model outputs for Matt and Brendan_March 2019.xlsx';

sheetname = 'Site or region shape files';

[snum,sstr] = xlsread(filename,sheetname,'A3:E124');
inc = 1;
for i = 1:length(sstr)

    if ~isempty(sstr{i,4})
        lat_spt_1 = strsplit(sstr{i,4},'°');
        lat_spt_1 = regexprep(lat_spt_1,' ','');
        lat_hour(inc) = str2num(lat_spt_1{1});
        tt = strsplit(lat_spt_1{2},'''');
        lat_min(inc) = str2num(tt{1});
        
        lon_spt_1 = strsplit(sstr{i,5},'°');
        lon_spt_1 = regexprep(lon_spt_1,' ','');
        lon_hour(inc) = str2num(lon_spt_1{1});
        tt = strsplit(lon_spt_1{2},'''');
        lon_min(inc) = str2num(tt{1});
        
        site_id(inc) = sstr(i,2);
       
        
        Lat(inc)=dm2degrees([lat_hour(inc) lat_min(inc)]); %convert into degrees 
        Lon(inc)=dm2degrees([lon_hour(inc) lon_min(inc)]); %convert into degrees 
        
        
        
        
        
        [x(inc),y(inc),utmzone] = deg2utm(Lat(inc)*-1,Lon(inc));
        
        
        
        S(inc).X = x(inc);
        S(inc).Y = y(inc);
        S(inc).Name = site_id{inc};
        S(inc).Geometry = 'Point';
        S(inc).ID = inc;
        
        if inc < 67
            S(inc).Radius = 100;
            S(inc).Depth = 1.5;
        else
            S(inc).Radius = 250;
            S(inc).Depth = 100;
        end
            
        
        
        inc = inc + 1;
        
        
        
        
    end
    
end

shapewrite(S,'Export_Locations.shp');
