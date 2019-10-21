function data = get_scatter_for_polygon_model(Adata,mTime,tdat,sitename)

cX = tdat.cell_X;
cY = tdat.cell_Y;

sitename = regexprep(sitename,'_',' ');

shp = shaperead('SHP/Iso_Zones.shp');

inpol = [];
for i = 1:length(shp)
    if strcmpi(shp(i).Name,sitename) == 1
        inpol = inpolygon(cX,cY,shp(i).X,shp(i).Y);
    end
end

if isempty(inpol)
    stop;
end

data = Adata(inpol);