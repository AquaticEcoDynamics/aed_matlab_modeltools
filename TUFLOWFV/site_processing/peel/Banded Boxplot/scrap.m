clear all; close all;

the_directory = 'J:\Matfiles_Main_2\';

the_var = {'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
    'WQ_OXY_OXY',...
    'WQ_DIAG_PHY_TCHLA',...
    'SAL'};
x(1).lim = [0 200];
x(2).lim = [0 10];
x(3).lim = [0 400];
x(4).lim = [0 100];
x(5).lim = [0 60];

load('E:\Github 2018\AED_Scripts\Matlab\TFV\Polygon Region Plotting\Matfiles\peel.mat');
shp = shaperead('E:\Github 2018\AED_Scripts\Matlab\TFV\Polygon Region Plotting\GIS\Peel_Zones_2.shp');



for bdb = 1:length(the_var)
    
    the_outdir = ['Images/',the_var{bdb},'/'];
    
    if ~exist(the_outdir,'dir')
        mkdir(the_outdir);
    end
    
    dirlist = dir(the_directory);
    
    
    for i = 1:length(shp)
        all_data.(shp(i).Name).Top.Date = [];
        all_data.(shp(i).Name).Top.Data = [];
        
        all_data.(shp(i).Name).Bot.Date = [];
        all_data.(shp(i).Name).Bot.Data = [];
    end
    
    
    for i = 3:19%length(dirlst)
        
        sitelist = dir([the_directory,dirlist(i).name,'/']);
        
        for j = 3:length(sitelist)
            
            load([the_directory,dirlist(i).name,'/',sitelist(j).name,'/',the_var{bdb},'.mat']);
            
            tdata = median(savedata.(the_var{bdb}).Top,1);
            bdata = median(savedata.(the_var{bdb}).Bot,1);
            
            sss = find(tdata < 1000);
            
            all_data.(sitelist(j).name).Top.Date = [all_data.(sitelist(j).name).Top.Date;savedata.Time(sss)];
            all_data.(sitelist(j).name).Top.Data = [all_data.(sitelist(j).name).Top.Data;tdata(sss)'];
            
            sss = find(bdata < 1000);
            all_data.(sitelist(j).name).Bot.Date = [all_data.(sitelist(j).name).Bot.Date;savedata.Time(sss)];
            all_data.(sitelist(j).name).Bot.Data = [all_data.(sitelist(j).name).Bot.Data;bdata(sss)'];
            
           
           
        end
        
    end
    
    
    
    
    sitelist = fieldnames(all_data);
    
    for i = 1:length(sitelist)
        
        [all_data.(sitelist{i}).Top.Date,ind] = unique(all_data.(sitelist{i}).Top.Date);
        all_data.(sitelist{i}).Top.Data = all_data.(sitelist{i}).Top.Data(ind);
        all_data.(sitelist{i}).Top.VEC = datevec(all_data.(sitelist{i}).Top.Date);
        
        [all_data.(sitelist{i}).Bot.Date,ind] = unique(all_data.(sitelist{i}).Bot.Date);
        all_data.(sitelist{i}).Bot.Data = all_data.(sitelist{i}).Bot.Data(ind);
        all_data.(sitelist{i}).Bot.VEC = datevec(all_data.(sitelist{i}).Bot.Date);
        
        
        [xdata,ydata] = get_fielddata(peel,shp,the_var{bdb},sitelist{i});
        
        if ~isempty(xdata)
            all_data.(sitelist{i}).Field.Date = xdata;
            all_data.(sitelist{i}).Field.Data = ydata;
            all_data.(sitelist{i}).Field.VEC = datevec(xdata);
        end

    end
    
    
    for i = 1:length(sitelist)
        
        fig = figure('position',[342.333333333333          917.666666666667                      1218                       420]);
        
        boxplot(all_data.(sitelist{i}).Top.Data,all_data.(sitelist{i}).Top.VEC(:,1),...
            'positions',all_data.(sitelist{i}).Top.VEC(:,1),'colors','b','widths',0.1,'jitter',0.1,'symbol',''); hold on
        if ~isempty(xdata)
            boxplot(all_data.(sitelist{i}).Field.Data,all_data.(sitelist{i}).Field.VEC(:,1),...
                'positions',all_data.(sitelist{i}).Field.VEC(:,1) + 0.25,'colors','k','widths',0.1,'jitter',0.1,'symbol',''); hold on
        end
        set(gca,'xticklabels',{' '});
        
        set(gca,'xtick',[1980:05:2015],'xticklabel',num2str([1980:05:2015]'));
        
        title(regexprep(sitelist{i},'_',' '));
        
        xlim([1975 2015]);
        
        ylim(x(bdb).lim);
        
        saveas(gcf,[the_outdir,sitelist{i},'.png']);
        
        
        
        close
    end
    
    clear all_data;
    
end

create_html_for_directory('Images/')

















