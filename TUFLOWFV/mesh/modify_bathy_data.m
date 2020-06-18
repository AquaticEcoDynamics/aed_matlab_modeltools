
fid = fopen('Tweed_v002_wetland_ns_clipped_smooth_edited_1m.2dm ','rt');
fid2 = fopen('Tweed_v002_wetland_ns_clipped_smooth_edited_1m_deep.2dm ','wt');

fline = fgetl(fid);
fprintf(fid2,'%s\n',fline);

shp = shaperead('Tweed_deep.shp');

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
                ZZ = ZZ *2;
            end
        end

        
        fprintf(fid2,'%s %d %10.4f %10.4f %4.4f\n',str{1},nodeID,XX,YY,ZZ);
        
    else
        
        fprintf(fid2,'%s\n',fline);
    end
end

fclose(fid);
fclose(fid2);