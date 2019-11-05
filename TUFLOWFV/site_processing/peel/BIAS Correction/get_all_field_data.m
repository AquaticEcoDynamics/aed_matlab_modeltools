function [f_date_top,f_top,f_date_bot,t_bot] = get_all_field_data(fdata,siteindex,var,conv)
f_date_top = [];
f_date_bot = [];
f_top = [];
t_bot = [];

sitenames = fieldnames(fdata);


for k = 1:length(siteindex)
    
    xdata_t = [];
    ydata_t = [];
    if isfield(fdata.(sitenames{siteindex(k)}),var)
        [xdata_t,ydata_t] = get_field_at_depth(fdata.(sitenames{siteindex(k)}).(var).Date,...
            fdata.(sitenames{siteindex(k)}).(var).Data,...
            fdata.(sitenames{siteindex(k)}).(var).Depth,...
            'Surface');
    end
    
    if ~isempty(xdata_t)
        ydata_t = ydata_t * conv;
        [xdata_d,ydata_d] = process_daily(xdata_t,ydata_t);
        
        f_date_top = [f_date_top;xdata_d];
        f_top = [f_top;ydata_d];
        
    end
    xdata_t = [];
    ydata_t = [];
    if isfield(fdata.(sitenames{siteindex(k)}),var)
        [xdata_t,ydata_t] = get_field_at_depth(fdata.(sitenames{siteindex(k)}).(var).Date,...
            fdata.(sitenames{siteindex(k)}).(var).Data,...
            fdata.(sitenames{siteindex(k)}).(var).Depth,...
            'Bottom');
    end
    
    if ~isempty(xdata_t)
        ydata_t = ydata_t * conv;
        [xdata_d,ydata_d] = process_daily(xdata_t,ydata_t);
        
        f_date_bot = [f_date_bot;xdata_d];
        t_bot = [t_bot;ydata_d];
        
    end
    
end
