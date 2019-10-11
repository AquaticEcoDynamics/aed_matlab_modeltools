
fid = fopen('001_RM_Wetlands_LL_Coorong_MZ.2dm','rt');
fid2 = fopen('001_RM_Wetlands_LL_Coorong_MZ_Narrung.2dm','wt');

fline = fgetl(fid);
fprintf(fid2,'%s\n',fline);

shp = shaperead('gis/nurrung.shp');

while ~feof(fid)
    fline = fgetl(fid);
    
    str = strsplit(fline);
    
    if strcmpi(str{1},'ND') == 1
        nodeID = str2double(str{2});
        XX = str2double(str{3});
        YY = str2double(str{4});
        ZZ = str2double(str{5});
        
        for j = 1:length(shp)
            inpol = inpolygon(XX,YY,shp(j).X,shp(j).Y);
            if inpol
                
                
                
                ZZ = ZZ - (shp(j).Depth/1);
                
                if ZZ > 1
                    ZZ = ZZ - (shp(j).Depth/1);
                end
                
                if ZZ > 0.3
                    ZZ = ZZ - (shp(j).Depth/1);
                end
                
            end
        end

        
        fprintf(fid2,'%s %d %10.4f %10.4f %4.4f\n',str{1},nodeID,XX,YY,ZZ);
        
    else
        
        fprintf(fid2,'%s\n',fline);
    end
end

fclose(fid);
fclose(fid2);