function mData = get_scatter_for_polygon(iso,varname,sitename,sdate,edate)

%gDate = datenum(2017,06,01);

sites = fieldnames(iso.(sitename));

mData = [];

for i = 1:length(sites)
    ss = find(iso.(sitename).(sites{i}).(varname).Date > sdate & iso.(sitename).(sites{i}).(varname).Date < edate);
    if ~isempty(ss)
        mData = [mData;iso.(sitename).(sites{i}).(varname).Data(ss)];
    end
end