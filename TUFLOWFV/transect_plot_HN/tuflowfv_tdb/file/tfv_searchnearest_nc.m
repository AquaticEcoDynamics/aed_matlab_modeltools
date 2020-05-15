function [pt_id,geodata,subsample] = tfv_searchnearest_nc(curt,geo)
geo_x = double(geo.cell_X);
geo_y = double(geo.cell_Y);

dtri = DelaunayTri(geo_x,geo_y);

query_points(:,1) = curt(~isnan(curt(:,1)),1);
query_points(:,2) = curt(~isnan(curt(:,2)),2);

pt_id = nearestNeighbor(dtri,query_points);

geo_face_idx3 = geo.idx3(pt_id);
geo_face_idx3
% Index Number Transfered to cell index number
geo_face_cells(1:2,1:length(geo.idx3)) = ...
    geo.face_cells(1:2,geo.idx3);

%[unique_geo_face_cells_w0,ind] = unique(geo_face_cells(:));
[unique_geo_face_cells_w0,ind] = unique(geo_face_cells(:),'stable');
unique_geo_face_cells = ...
    unique_geo_face_cells_w0(unique_geo_face_cells_w0 ~= 0);

cells_idx2 = geo.idx2(unique_geo_face_cells(1:end-1));

subsample = cells_idx2(1:4:length(cells_idx2));

geodata.X  = geo.cell_X(subsample);
geodata.Y = geo.cell_Y(subsample);
geodata.Z = geo.cell_Zb(subsample);


end %--%