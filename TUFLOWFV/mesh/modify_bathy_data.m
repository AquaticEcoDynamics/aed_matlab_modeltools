
fid = fopen('Peelv3_Holes_NthCorner_Sed_Oxy_Coolup_hole_clip_200m_50m_polygon_min05m_UM.2dm','rt');
fid2 = fopen('Peelv3_Holes_NthCorner_Sed_Oxy_Coolup_hole_clip_200m_50m_polygon_min05m_UM_Delta.2dm','wt');

fline = fgetl(fid);
fprintf(fid2,'%s\n',fline);

shp = shaperead('deepen.shp');

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
                ZZ = ZZ - (shp(j).Depth/4);
            end
        end

        
        fprintf(fid2,'%s %d %10.4f %10.4f %4.4f\n',str{1},nodeID,XX,YY,ZZ);
        
    else
        
        fprintf(fid2,'%s\n',fline);
    end
end

fclose(fid);
fclose(fid2);