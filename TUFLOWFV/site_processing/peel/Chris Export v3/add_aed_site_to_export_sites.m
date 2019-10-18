clear all; close all;

addpath(genpath('Functions'))

load Export_Locations.mat;

aed = shaperead('..\..\..\Matlab\TFV\Polygon Region Plotting\GIS\peel_polygons.shp');

for i = 1:length(shp)
    iszone = 0;
    
    [ GEOM, INER, CPMO ] = polygeom(shp(i).X(~isnan(shp(i).X)),shp(i).Y(~isnan(shp(i).X)));
    
    
    for j = 1:length(aed)
        if inpolygon(GEOM(2),GEOM(3),aed(j).X,aed(j).Y)
            shp(i).AED_Name = aed(j).Name;
            iszone = 1;
        end
    end
    if iszone == 0
        shp(i).AED_Name = 'Harvey North';
    end
    S(i).X = GEOM(2);
    S(i).Y = GEOM(3);
    S(i).Name = shp(i).AED_Name;
    S(i).Geometry = 'Point';
end
        



save Export_Locations.mat shp -mat;
% 
% for i = 1:length(shp)
%     S(i).X = shp(i).X;
%     S(i).Y = shp(i).Y;
%     S(i).Geometry = shp(i).Geometry;
%     S(i).AED_Name = shp(i).AED_Name;
%     S(i).Name = shp(i).Name;
% end
 %shapewrite(S,'chx.shp');