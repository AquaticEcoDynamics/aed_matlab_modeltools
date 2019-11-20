clear all; close all;

basedir = 'Y:\Peel Final Report\Scenarios\Processed v12\';
outdir = 'Y:\Peel Final Report\Scenarios\DelMaps\';
scenlist = dir(basedir);

shp = shaperead('Peel_Boundary.shp');

var = 'WQ_DIAG_TOT_TP';

conv = 31/1000;

base = 'run_scenario_0b';

base_caxis = [0 0.5];

del_caxis = [-0.1 0.1];
del_clip = [-0.01 0.01];
depth = 'Bot';

% themonths(1).val = [6 8];
% themonths(1).year = 2016;
% themonths(1).lab = 'Winter';

themonths(1).val = [6 8];
themonths(1).year = [2016 2016];
themonths(1).lab = 'Winter';

theorder = {...
    'run_scenario_0a',...
    'run_scenario_1a',...
    'run_scenario_2a',...
    'run_scenario_3a',...
    'run_scenario_0b',...
    'run_scenario_1b',...
    'run_scenario_2b',...    
    'run_scenario_0b',...
    };

[XX,YY,ZZ,nodeID,faces,cellX,cellY,Z,ID,MAT,cellArea] = tfv_get_node_from_2dm('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm');


for i = 3:length(scenlist)
    
    outdata.(scenlist(i).name) = load([basedir,scenlist(i).name,'\',var,'.mat']);
    
end



%scen = fieldnames(outdata);

figure('position',[1                        41                      2560          1327.33333333333]);



for i = 1:length(theorder)
    
    theday = eomday(themonths(1).year(2),themonths(1).val(2));
    
    sss = find(outdata.(theorder{i}).savedata.Time >= datenum(themonths(1).year(1),themonths(1).val(1),01,00,00,00) & ...
        outdata.(theorder{i}).savedata.Time <= datenum(themonths(1).year(2),themonths(1).val(2),theday,23,59,59));
    
    delmap.raw.(theorder{i}) = mean(outdata.(theorder{i}).savedata.(var).(depth)(:,sss),2) * conv;
    
    subplot(2,4,i)
    title(regexprep(theorder{i},'_',' '));
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',delmap.raw.(theorder{i}));shading flat
    mapshow(shp,'facecolor','none','edgecolor','k');
    
    
    set(gca,'box','on');
    
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');
    
    axis equal
    
    xlim([368614.578725285          399653.653882403]);
    ylim([6371224.56816705          6406274.16417855]);
    
    caxis(base_caxis);
    
    colorbar
    
    axis off;
    
end

saveas(gcf,[outdir,var,'_',depth,'_raw.png']);close;

figure('position',[1                        41                      2560          1327.33333333333]);



for i = 1:length(theorder)
    
    
    theDel = delmap.raw.(theorder{i}) - delmap.raw.(base);
    
    
    subplot(2,4,i)
    title(regexprep(theorder{i},'_',' '));
    
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
    
    xlim([368614.578725285          399653.653882403]);
    ylim([6371224.56816705          6406274.16417855]);
    
    caxis(del_caxis);
    
    colorbar
    
    axis off;
    
end

saveas(gcf,[outdir,var,'_',depth,'_delMap_minus_',base,'.png']);close;















