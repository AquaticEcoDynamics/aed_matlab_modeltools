function [xdata,ydata] = get_fielddata(peel,shp,var,the_site)

for i = 1:length(shp)
    
    if strcmpi(regexprep(shp(i).Name,' ','_'),the_site) == 1
        the_ID = i;
    end
end

xdata = [];
ydata = [];

% load('E:\Github 2018\AED_Scripts\Matlab\TFV\Polygon Region Plotting\Matfiles\peel.mat');
% 
% shp = shaperead('E:\Github 2018\AED_Scripts\Matlab\TFV\Polygon Region Plotting\GIS\Peel_Zones_2.shp');
% 
% var = 'WQ_OXY_OXY';

sites = fieldnames(peel);

for i = 1:length(sites)
    
    if isfield(peel.(sites{i}),var)
        
        if inpolygon(peel.(sites{i}).(var).X,peel.(sites{i}).(var).Y,shp(the_ID).X,shp(the_ID).Y)
            
            xd = peel.(sites{i}).(var).Date;
            yd = peel.(sites{i}).(var).Data;
            zd = peel.(sites{i}).(var).Depth;
            
            sss = find(zd > -1);
            
            xdata = [xdata;xd(sss)];
            ydata = [ydata;yd(sss)];
        end
    end
end
            
            
        
        