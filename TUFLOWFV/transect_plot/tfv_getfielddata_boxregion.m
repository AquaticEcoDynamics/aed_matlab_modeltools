function [fielddata,fielddist] = tfv_getfielddata_boxregion(fdata,shp,def,isSurf,varname,mtime)

% dusplicated processing in model data bit. Should be replaced.
for i = 1:length(shp)
    sdata(i,1) = shp(i).X;
    sdata(i,2) = shp(i).Y;
end

dist(1,1) = 0;

for i = 2:length(shp)
    
    dist(i,1) = sqrt(power((sdata(i,1) - sdata(i-1,1)),2) + power((sdata(i,2)- sdata(i-1,2)),2)) + dist(i-1,1);
    
end

dist = dist / 1000; % convert to km


maxdist = max(dist);
mindist = 0;

thePolygons = [mindist:(def.binradius)*2:maxdist];


for i = 1:length(thePolygons)
    
    [~,ind] = min(abs(dist - thePolygons(i)));
    
    T = nsidedpoly(360,'Center',[shp(ind).X shp(ind).Y],'Radius',(def.binradius*1000));
    
    pol(i).X = T.Vertices(:,1);
    pol(i).Y = T.Vertices(:,2);
    pol(i).Dist = dist(ind);
    
end

sites = fieldnames(fdata);

fielddata = [];
fielddist = [];


for j = 1:length(pol)
    
    for i = 1:length(sites)
        
        if isfield(fdata.(sites{i}),varname)
            
            fX = fdata.(sites{i}).(varname).X;
            fY = fdata.(sites{i}).(varname).Y;
            
            fDat = fdata.(sites{i}).(varname).Data;
            fDate = fdata.(sites{i}).(varname).Date;
            fDepth = fdata.(sites{i}).(varname).Depth;
            
            if inpolygon(fX,fY,pol(j).X,pol(j).Y)
                
                cdata = [];
                cdist = [];
                
                sss = find(fDate >= mtime(1) & fDate <= mtime(2));
                
                if ~isempty(sss)
                    
                    if isSurf
                        ttt = find(fDepth(sss) >= -2);
                    else
                        ttt = find(fDepth(sss) < -2);
                    end
                    
                    cdata = tfv_Unit_Conversion(fDat(sss(ttt)),varname);
                    cdist(1:length(ttt),1) = pol(j).Dist;
                    
                    fielddata = [fielddata;cdata];
                    fielddist = [fielddist;cdist];
                end
            end
        end
    end
end   
    
    
