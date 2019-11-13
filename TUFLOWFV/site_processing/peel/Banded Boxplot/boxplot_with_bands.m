clear all; close all;

addpath(genpath('tuflowfv'));

the_directory = 'Y:\Peel Final Report\Processed_v12_joined\';

% the_var = {'WQ_DIAG_TOT_TN',...
%     'WQ_DIAG_TOT_TP',...
%     'WQ_OXY_OXY',...
%     'WQ_DIAG_PHY_TCHLA',...
%     'SAL'};
% x(1).lim = [0 300];
% x(2).lim = [0 10];
% x(3).lim = [0 400];
% x(4).lim = [0 100];
% x(5).lim = [0 60];

the_var = {'WQ_NIT_NIT',...
    'WQ_NIT_AMM',...
    'WQ_PHS_FRP',...
    'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
    'WQ_OXY_OXY',...
    'WQ_DIAG_PHY_TCHLA',...
    'SAL'};

x(1).lim = [0 100];
x(2).lim = [0 100];
x(3).lim = [0 10];
x(4).lim = [0 300];
x(5).lim = [0 10];
x(6).lim = [0 400];
x(7).lim = [0 100];
x(8).lim = [0 60];

load('F:\Cloudstor\Data_Peel\DATA\Join All Datasources\peel.mat');
%shp = shaperead('E:\Github 2018\AED_Scripts\Matlab\TFV\Polygon Region Plotting\GIS\Peel_Zones_2.shp');
shp = shaperead('E:\Github 2018\AED_Scripts\Matlab\TFV\Polygon Region Plotting\GIS\peel_polygons.shp');

col_pal_bottom = [[0.627450980392157         0.796078431372549                         1];...
                 [0.0549019607843137         0.525490196078431         0.968627450980392];...
                 [0.0509803921568627         0.403921568627451         0.968627450980392]];

bottom_edge_color = [0.0509803921568627         0.215686274509804         0.968627450980392];
dimc = [0.9 0.9 0.9]; % dimmest (lightest) color
pred_lims = [0.25,0.35,0.5,0.65,0.75];
num_lims = length(pred_lims);
nn = (num_lims+1)/2;


for bdb = 1:length(the_var)
    
    the_outdir = ['Images_4/',the_var{bdb},'/'];
    
    if ~exist(the_outdir,'dir')
        mkdir(the_outdir);
    end
    
    
    
    all_data = get_modeldata(the_directory,the_var{bdb},shp,peel);
    
    sitelist = fieldnames(all_data);
    
    for i = 1:length(sitelist)
        
        fig = figure('position',[342.333333333333          917.666666666667                      1218                       420]);
        
        if isfield(all_data.(sitelist{i}),'Field')
            
            if isfield(all_data.(sitelist{i}).Field,'date')
                fig = fillyy(all_data.(sitelist{i}).Field.date,all_data.(sitelist{i}).Field.pred_lim_ts(1,:),all_data.(sitelist{i}).Field.pred_lim_ts(2*nn-1,:),dimc,col_pal_bottom(1,:));hold on
                %fig = fillyy(data(mod).date_b,data(mod).pred_lim_ts_b(1,:),data(mod).pred_lim_ts_b(2*nn-1,:),dimc);hold on
                %             set(fig,'DisplayName',[ncfile(mod).legend,' Bottom (Range)']);
                hold on
                
                for plim_i=2:(nn-1)
                    fig2 = fillyy(all_data.(sitelist{i}).Field.date,all_data.(sitelist{i}).Field.pred_lim_ts(plim_i,:),all_data.(sitelist{i}).Field.pred_lim_ts(2*nn-plim_i,:),dimc.*0.9.^(plim_i-1),col_pal_bottom(plim_i,:));
                    %fig2 = fillyy(data(mod).date_b,data(mod).pred_lim_ts_b(plim_i,:),data(mod).pred_lim_ts_b(2*nn-plim_i,:),dimc.*0.9.^(plim_i-1));
                    set(fig2,'HandleVisibility','off');
                end
            end
            
        end
        
        
        
       % Remove years shorter than 2 months. 
        
       sample_day = 1 / (all_data.(sitelist{i}).Top.Date(2) - all_data.(sitelist{i}).Top.Date(1)); 
        
        
       min_sample = sample_day * 70;
       
       uni_years = unique(all_data.(sitelist{i}).Top.VEC(:,1));
       
       for kjk = 1:length(uni_years)
           ggg = find(all_data.(sitelist{i}).Top.VEC(:,1) == uni_years(kjk));
           if length(ggg) < min_sample
               
               all_data.(sitelist{i}).Top.Data(ggg) = NaN;
           end
       end
       
        boxplot(all_data.(sitelist{i}).Top.Data,all_data.(sitelist{i}).Top.VEC(:,1),...
            'positions',all_data.(sitelist{i}).Top.VEC(:,1),'colors','b','widths',0.1,'jitter',0.1,'symbol','', 'Whisker',0); hold on
        %         if isfield(all_data.(sitelist{i}),'Field')
        %             boxplot(all_data.(sitelist{i}).Field.Data,all_data.(sitelist{i}).Field.VEC(:,1),...
        %                 'positions',all_data.(sitelist{i}).Field.VEC(:,1) + 0.25,'colors','k','widths',0.1,'jitter',0.1,'symbol',''); hold on
        %         end
        set(gca,'xticklabels',{' '});
        
        set(gca,'xtick',[1980:05:2020],'xticklabel',num2str([1980:05:2020]'));
        
        title(regexprep(sitelist{i},'_',' '));
        
        xlim([1975 2020]);
        
        ylim(x(bdb).lim);
        
        saveas(gcf,[the_outdir,sitelist{i},'.png']);
        
        
        
        close
    end
    
    clear all_data;
    
end

create_html_for_directory('Images_4/')