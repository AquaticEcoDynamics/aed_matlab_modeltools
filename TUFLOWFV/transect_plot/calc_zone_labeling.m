clear all; close all;

shp = shaperead('..\..\..\SCERM\matlab\modeltools\gis\swan_erz_only.shp');

points_file = '../../../SCERM/matlab/modeltools/gis/Canning_Transect_Pnt.shp';

pnt = shaperead(points_file);

for i = 1:length(pnt)
    sdata(i,1) = pnt(i).X;
    sdata(i,2) = pnt(i).Y;
    
    for j = 1:length(shp)
        if inpolygon(pnt(i).X,pnt(i).Y,shp(j).X,shp(j).Y)
            ID(i,1) = shp(j).Id;
        end
    end
    
end

dist(1,1) = 0;

for i = 2:length(pnt)
    
    dist(i,1) = sqrt(power((sdata(i,1) - sdata(i-1,1)),2) + power((sdata(i,2)- sdata(i-1,2)),2)) + dist(i-1,1);
    
end

dist = dist / 1000; % convert to km


uID = unique(ID);

for i = 1:length(uID)
    sss = find(ID == uID(i));
    
    midrow = sss(ceil(end/2), :);
    
    
    
    marker.Label(i) = uID(i);
    marker.Dist(i) = dist(midrow);
    marker.Start(i) = dist(sss(1));
    marker.End(i) = dist(sss(end));
end

save marker3.mat marker -mat

