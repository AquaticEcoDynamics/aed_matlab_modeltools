function [all_data] = get_modeldata(the_directory,the_var,shp,peel)

dirlist = dir(the_directory);


for i = 1:length(shp)
    all_data.(regexprep(shp(i).Name,' ','_')).Top.Date = [];
    all_data.(regexprep(shp(i).Name,' ','_')).Top.Data = [];
    
    all_data.(regexprep(shp(i).Name,' ','_')).Bot.Date = [];
    all_data.(regexprep(shp(i).Name,' ','_')).Bot.Data = [];
end


for i = 3:length(dirlist)
    
    sitelist = dir([the_directory,dirlist(i).name,'/']);
    
    for j = 3:length(sitelist)
        
        load([the_directory,dirlist(i).name,'/',sitelist(j).name,'/',the_var,'.mat']);
        
        tdata = median(savedata.(the_var).Top,1);
        bdata = median(savedata.(the_var).Bot,1);
        
        sss = find(tdata < 1000);
        
        all_data.(regexprep(sitelist(j).name,' ','_')).Top.Date = [all_data.(regexprep(sitelist(j).name,' ','_')).Top.Date;savedata.Time(sss)];
        all_data.(regexprep(sitelist(j).name,' ','_')).Top.Data = [all_data.(regexprep(sitelist(j).name,' ','_')).Top.Data;tdata(sss)'];
        
        sss = find(bdata < 1000);
        all_data.(regexprep(sitelist(j).name,' ','_')).Bot.Date = [all_data.(regexprep(sitelist(j).name,' ','_')).Bot.Date;savedata.Time(sss)];
        all_data.(regexprep(sitelist(j).name,' ','_')).Bot.Data = [all_data.(regexprep(sitelist(j).name,' ','_')).Bot.Data;bdata(sss)'];
        
        
        
    end
    
end




sitelist = fieldnames(all_data);

pred_lims = [0.25,0.35,0.5,0.65,0.75];
num_lims = length(pred_lims);
nn = (num_lims+1)/2;


for i = 1:length(sitelist)
    
    [all_data.(sitelist{i}).Top.Date,ind] = unique(all_data.(sitelist{i}).Top.Date);
    all_data.(sitelist{i}).Top.Data = all_data.(sitelist{i}).Top.Data(ind);
    all_data.(sitelist{i}).Top.VEC = datevec(all_data.(sitelist{i}).Top.Date);
    
    [all_data.(sitelist{i}).Bot.Date,ind] = unique(all_data.(sitelist{i}).Bot.Date);
    all_data.(sitelist{i}).Bot.Data = all_data.(sitelist{i}).Bot.Data(ind);
    all_data.(sitelist{i}).Bot.VEC = datevec(all_data.(sitelist{i}).Bot.Date);
    
    
    [xdata,ydata] = get_fielddata(peel,shp,the_var,sitelist{i});
    
    if ~isempty(xdata)
        all_data.(sitelist{i}).Field.Date = xdata;
        all_data.(sitelist{i}).Field.Data = ydata;
        all_data.(sitelist{i}).Field.VEC = datevec(xdata);
        
        
        u_years = unique(all_data.(sitelist{i}).Field.VEC(:,1));
        
        inc = 1;
        for iii = 1:length(u_years)
            
            tt = find(all_data.(sitelist{i}).Field.VEC(:,1) == u_years(iii));
            
            xd = all_data.(sitelist{i}).Field.Data(tt);
            
            if length(xd) > 3
                if sum(isnan(xd)) < length(xd)
                    xd(isnan(xd)) = mean(xd(~isnan(xd)));
                    all_data.(sitelist{i}).Field.pred_lim_ts(:,inc) = plims(xd,pred_lims);
                    all_data.(sitelist{i}).Field.date(inc,1) = u_years(iii);
                    inc = inc + 1;
                end
            end
            
        end
    end
end