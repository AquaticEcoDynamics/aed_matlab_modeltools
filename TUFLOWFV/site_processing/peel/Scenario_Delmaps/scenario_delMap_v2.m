clear all; close all;

basedir = 'Y:\Peel Final Report\Scenarios\Processed v12\';
outdir = 'Y:\Peel Final Report\Scenarios\DelMaps\';
scenlist = dir(basedir);

shp = shaperead('Peel_Boundary.shp');

var = 'SAL';

conv = 1;%1/86400;%32/1000;

base1 = 'run_scenario_0a';
base2 = 'run_scenario_0b';
% base_caxis = [2 10];

% del_caxis = [-2 2];
% del_clip = [-0.5 0.5];

base_caxis = [10 50];

del_caxis = [-10 10];
del_clip = [-1 1];

do_crit = 1; %Only for oxygen;

% base_caxis = [0 0.5];
% 
% del_caxis = [-0.1 0.1];
% del_clip = [-0.01 0.01];
depth = 'Bot';

themonths(1).val = [6 8];
themonths(1).year = [2016 2016];
themonths(1).lab = 'Winter';

pos(1).a = [0.00 0.55 0.25 0.4];
pos(2).a = [0.25 0.55 0.25 0.4];
pos(3).a = [0.50 0.55 0.25 0.4];
pos(4).a = [0.75 0.55 0.25 0.4];

pos(5).a = [0.00 0.1 0.25 0.4];
pos(6).a = [0.25 0.1 0.25 0.4];
pos(7).a = [0.50 0.1 0.25 0.4];
pos(8).a = [0.75 0.1 0.25 0.4];


pos(1).b = [0.05 0.55 0.2 0.2];
pos(2).b = [0.30 0.55 0.2 0.2];
pos(3).b = [0.55 0.55 0.2 0.2];
pos(4).b = [0.80 0.55 0.2 0.2];

pos(5).b = [0.05 0.1 0.2 0.2];
pos(6).b = [0.30 0.1 0.2 0.2];
pos(7).b = [0.55 0.1 0.2 0.2];
pos(8).b = [0.80 0.1 0.2 0.2];






theorder = {...
    'run_scenario_0a',...
    'run_scenario_1a',...
    'run_scenario_2a',...
    'run_scenario_3a',...
    'run_scenario_0b',...
    'run_scenario_1b',...
    'run_scenario_2b',...    
    'run_scenario_3b',...
    };

datetext = [num2str(themonths(1).year(1)),'-',num2str(themonths(1).val(1)),'_',num2str(themonths(1).year(2)),'-',num2str(themonths(1).val(2))];


[XX,YY,ZZ,nodeID,faces,cellX,cellY,Z,ID,MAT,cellArea] = tfv_get_node_from_2dm('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm');


for i = 3:length(scenlist)
    
    outdata.(scenlist(i).name) = load([basedir,scenlist(i).name,'\',var,'.mat']);
    
end

%%
if strcmpi(var,'WQ_OXY_OXY') == 0
    do_crit = 0;
end



scen = fieldnames(outdata);

figure('position',[750.333333333333                        99          1573.33333333333          1094.66666666667]);



for i = 1:length(theorder)
    
    theday = eomday(themonths(1).year(2),themonths(1).val(2));
    
    sss = find(outdata.(theorder{i}).savedata.Time >= datenum(themonths(1).year(1),themonths(1).val(1),01,00,00,00) & ...
        outdata.(theorder{i}).savedata.Time <= datenum(themonths(1).year(2),themonths(1).val(2),theday,23,59,59));
    
    if strcmpi(var,'WQ_OXY_OXY') == 1 & ...
            do_crit == 1
        delmap.raw.(theorder{i}) = calc_crit(outdata.(theorder{i}).savedata.(var).(depth)(:,sss),conv);
    else
        
        delmap.raw.(theorder{i}) = mean(outdata.(theorder{i}).savedata.(var).(depth)(:,sss),2) * conv;
        
    end
    %delmap.raw.(theorder{i})
    %subplot(2,4,i)
    axes('position',pos(i).a)
    
    tx = regexprep(theorder{i},'_',' ');
    tx = regexprep(tx,'run scenario ','');
    
    text(0.9,0.95,tx,'units','normalized','fontsize',14,'fontweight','bold');
    
    
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',delmap.raw.(theorder{i}));shading flat
    set(gca,'box','on');hold on
    
    mapshow(shp,'facecolor','none','edgecolor','k')
    
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');
    
    axis equal
    
%     map = flipud(parula);
%     
%     colormap(patFig,map);
    
    xlim([370110.057100533          416668.669836211]);
    ylim([6359765.17857549          6412339.57259274]);
    
    caxis(base_caxis);
    
    %colorbar
    
    axis off;
    
    plot_box;
    plot_box2;
    
    %____________
    
    axes('position',pos(i).b,'color',[0.7 0.7 0.7])
    text(0.6,0.95,'Murray River','units','normalized','fontsize',10,'fontweight','bold');
    
%     sss = find(theDel >= del_clip(1) & ...
%         theDel <= del_clip(2));
%     theDel(sss) = NaN;
    
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',delmap.raw.(theorder{i}));shading flat
    set(gca,'box','on');hold on
    
    mapshow(shp,'facecolor','none','edgecolor','k')
    
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');
    
    axis equal
    
%     map = flipud(parula);
%     
%     colormap(patFig,map);
    
    xlim([386576.219342587          395241.577797865]);
    ylim([6388502.80301868          6395691.43997054]);
    
    caxis(base_caxis);
    
    %colorbar
    
    axis off;
    
    plot_box2;
    
    if i == 8
        cb = colorbar('location','southoutside');
        set(cb,'position',[0.35 0.05 0.3 0.01]);
        
    end
    
    
end

if ~do_crit
    saveas(gcf,[outdir,var,'_',depth,'_',datetext,'_raw.png']);close;
else
    saveas(gcf,[outdir,'Oxy_Crit','_',depth,'_',datetext,'_raw.png']);close;
end

%%



figure('position',[750.333333333333                        99          1573.33333333333          1094.66666666667]);

newmap = blank_col(del_caxis,del_clip);
colormap(newmap);
for i = 1:length(theorder)
    
    
    theDel = delmap.raw.(theorder{i}) - delmap.raw.(base1);
    
    
    %subplot(2,4,i)
    axes('position',pos(i).a)
    
    tx = regexprep(theorder{i},'_',' ');
    tx = regexprep(tx,'run scenario ','');
    
    text(0.9,0.95,tx,'units','normalized','fontsize',14,'fontweight','bold');
    
    sss = find(theDel >= del_clip(1) & ...
        theDel <= del_clip(2));
    theDel(sss) = NaN;
    
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',theDel);shading flat
    set(gca,'box','on');hold on
    
    mapshow(shp,'facecolor','none','edgecolor','k')
    
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');
    
    axis equal
    
%     map = flipud(parula);
%     
%     colormap(patFig,map);
    
    xlim([370110.057100533          416668.669836211]);
    ylim([6359765.17857549          6412339.57259274]);
    
    caxis(del_caxis);
    
    %colorbar
    
    axis off;
    
    plot_box;
    plot_box2;
    
    %____________
    
    axes('position',pos(i).b,'color',[0.7 0.7 0.7])
    text(0.6,0.95,'Murray River','units','normalized','fontsize',10,'fontweight','bold');
    
    sss = find(theDel >= del_clip(1) & ...
        theDel <= del_clip(2));
    theDel(sss) = NaN;
    
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',theDel);shading flat
    set(gca,'box','on');hold on
    
    mapshow(shp,'facecolor','none','edgecolor','k')
    
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');
    
    axis equal
    
%     map = flipud(parula);
%     
%     colormap(patFig,map);
    
    xlim([386576.219342587          395241.577797865]);
    ylim([6388502.80301868          6395691.43997054]);
    
    caxis(del_caxis);
    
    %colorbar
    
    axis off;
    
    plot_box2;
    
    if i == 8
        cb = colorbar('location','southoutside');
        set(cb,'position',[0.35 0.05 0.3 0.01]);
        
    end
end

if ~do_crit
    saveas(gcf,[outdir,var,'_',depth,'_',datetext,'_delMap_minus_',base1,'.png']);close;
    
else
    saveas(gcf,[outdir,'Oxy_Crit','_',depth,'_',datetext,'_delMap_minus_',base1,'.png']);close;
end


%%



figure('position',[750.333333333333                        99          1573.33333333333          1094.66666666667]);

newmap = blank_col(del_caxis,del_clip);
colormap(newmap);
for i = 1:length(theorder)
    
    
    theDel = delmap.raw.(theorder{i}) - delmap.raw.(base2);
    
    
    %subplot(2,4,i)
    axes('position',pos(i).a)
    
    tx = regexprep(theorder{i},'_',' ');
    tx = regexprep(tx,'run scenario ','');
    
    text(0.9,0.95,tx,'units','normalized','fontsize',14,'fontweight','bold');
    
    sss = find(theDel >= del_clip(1) & ...
        theDel <= del_clip(2));
    theDel(sss) = NaN;
    
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',theDel);shading flat
    set(gca,'box','on');hold on
    
    mapshow(shp,'facecolor','none','edgecolor','k')
    
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');
    
    axis equal
    
%     map = flipud(parula);
%     
%     colormap(patFig,map);
    
    xlim([370110.057100533          416668.669836211]);
    ylim([6359765.17857549          6412339.57259274]);
    
    caxis(del_caxis);
    
    %colorbar
    
    axis off;
    
    plot_box;
    plot_box2;
    
    %____________
    
    axes('position',pos(i).b,'color',[0.7 0.7 0.7])
    text(0.6,0.95,'Murray River','units','normalized','fontsize',10,'fontweight','bold');
    
    sss = find(theDel >= del_clip(1) & ...
        theDel <= del_clip(2));
    theDel(sss) = NaN;
    
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',theDel);shading flat
    set(gca,'box','on');hold on
    
    mapshow(shp,'facecolor','none','edgecolor','k')
    
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');
    
    axis equal
    
%     map = flipud(parula);
%     
%     colormap(patFig,map);
    
    xlim([386576.219342587          395241.577797865]);
    ylim([6388502.80301868          6395691.43997054]);
    
    caxis(del_caxis);
    
    %colorbar
    
    axis off;
    
    plot_box2;
    
    if i == 8
        cb = colorbar('location','southoutside');
        set(cb,'position',[0.35 0.05 0.3 0.01]);
        
    end
end

if ~do_crit
    saveas(gcf,[outdir,var,'_',depth,'_',datetext,'_delMap_minus_',base2,'.png']);close;
    
else
    saveas(gcf,[outdir,'Oxy_Crit','_',depth,'_',datetext,'_delMap_minus_',base2,'.png']);close;
end











