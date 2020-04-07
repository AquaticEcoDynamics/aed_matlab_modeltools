clear all; close all;

pnt = shaperead('../../../Hawkesbury/gis/Transectpnt_HN_100.shp');

for i = 1:length(pnt)
    data(i,1) = pnt(i).X;
    data(i,2) = pnt(i).Y;
end

dist(1,1) = 0;

for i = 2:length(pnt)
    
    dist(i,1) = sqrt(power((data(i,1) - data(i-1,1)),2) + power((data(i,2)- data(i-1,2)),2)) + dist(i-1,1);
    
end
    

% convert to km


dist = dist / 1000;

export_int = [10:10:260];

for i = 1:length(export_int)
    
    [~,int ] = min(abs(dist - export_int(i)));
    
    S(i).Geometry = 'Point';
    S(i).X = data(int,1);
    S(i).Y = data(int,2);
    S(i).Dist = [num2str(round(dist(int,1))),'km'];
    
end
shapewrite(S,'Distance_Markers_10km.shp')