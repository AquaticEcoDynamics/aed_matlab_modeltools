function [mData,mDist,mAgency] = get_line_data_for_polygon(iso,varname,sitename,linefile,sdate,edate)


zeroX = 373417.0;
zeroY = 6390556.0;



HAR = load(linefile);

if strcmpi(sitename,'Murray_River') == 1
    HAR = flipud(HAR);
end

HAR(1,4) = abs(sqrt((HAR(1,2)-zeroX) .^2 + (HAR(1,3) - zeroY).^2));

for ii = 2:length(HAR)
%    temp_d = abs(sqrt((HAR(ii+1,2)-HAR(ii,2)) .^2 + (HAR(ii+1,3) - HAR(ii,3)).^2));
    temp_d = abs(sqrt((HAR(ii,2)-zeroX) .^2 + (HAR(ii,3) - zeroY).^2));
    HAR(ii,4) = temp_d;
%     if strcmpi(sitename,'Harvey_River') == 1
%         HAR(ii+1,4) = HAR(ii,4) - temp_d;
%     else
%          HAR(ii+1,4) = HAR(ii,4) + temp_d;
%     end
end



%_________________________________________________________________
sites = fieldnames(iso.(sitename));

mData = [];
mX = [];
mY = [];

mAgency = [];



for i = 1:length(sites)
    
    
    isSurf = find(iso.(sitename).(sites{i}).(varname).Depth > -1);

    isoDate = iso.(sitename).(sites{i}).(varname).Date(isSurf);
    isoData = iso.(sitename).(sites{i}).(varname).Data(isSurf);
    isoDepth = iso.(sitename).(sites{i}).(varname).Depth(isSurf);
    
    
    
    
    
    ss = find(isoDate > sdate & isoDate < edate);
    if ~isempty(ss)
        mData = [mData;isoData(ss)];
        for k = 1:length(ss)
            mX = [mX;iso.(sitename).(sites{i}).(varname).X];
            mY = [mY;iso.(sitename).(sites{i}).(varname).Y];
            mAgency = [mAgency;{iso.(sitename).(sites{i}).(varname).Agency}];
        end
    end
    
    clear isSurf isoDate isoData isoDepth;
end

if ~isempty(mData)

Mdtri = DelaunayTri(HAR(:,2),HAR(:,3));
whos
pQP(:,1) = mX;
pQP(:,2) = mY;
mID = nearestNeighbor(Mdtri,pQP);

mDist = HAR(mID,4) / 1000;


%[mDist,ind] = sort(mDist);

%mData = mData;%(ind);
sss = find(mData >= 0);


mDist = mDist(sss);
mData = mData(sss);
else
    mDist = [];;
end