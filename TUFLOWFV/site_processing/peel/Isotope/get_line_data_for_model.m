function [mData,mDist] = get_line_data_for_model(Adata,mTime,tdat,sitename,linefile,sdate,edate)


zeroX = 373417.0;
zeroY = 6390556.0;


HAR = load(linefile);

if strcmpi(sitename,'Murray_River') == 1
    HAR = flipud(HAR);
end

HAR(1,4) = abs(sqrt((HAR(1,2)-zeroX) .^2 + (HAR(1,3) - zeroY).^2));
for ii = 1:length(HAR)
    temp_d = abs(sqrt((HAR(ii,2)-zeroX) .^2 + (HAR(ii,3) - zeroY).^2));
    HAR(ii,4) = temp_d;
%     temp_d = abs(sqrt((HAR(ii+1,2)-HAR(ii,2)) .^2 + (HAR(ii+1,3) - HAR(ii,3)).^2));
%     if strcmpi(sitename,'Harvey_River') == 1
%         HAR(ii+1,4) = HAR(ii,4) - temp_d;
%     else
%          HAR(ii+1,4) = HAR(ii,4) + temp_d;
%     end
end



cX = tdat.cell_X;
cY = tdat.cell_Y;
dtri = DelaunayTri(double(cX),double(cY));

query_points(:,1) = HAR(:,2);
query_points(:,2) = HAR(:,3);
pt_id = nearestNeighbor(dtri,query_points);


mData = Adata(pt_id);
mDist(:,1) = HAR(:,4) / 1000;









end

