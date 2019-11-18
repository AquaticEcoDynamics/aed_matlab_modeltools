clear all; close all;

basedir = 'Y:\Peel Final Report\Scenarios\Processed v12\';

scenlist = dir(basedir);

var = 'WQ_DIAG_PHY_TCHLA';

conv = 1;%31/1000;

base = 'run_scenario_0b';

base_caxis = [0 100];
del_caxis = [-10 10];

depth = 'Bot';

% themonths(1).val = [6 8];
% themonths(1).year = 2016;
% themonths(1).lab = 'Winter';

themonths(1).val = [12 2];
themonths(1).year = [2016 2017];
themonths(1).lab = 'Winter';

[XX,YY,ZZ,nodeID,faces,cellX,cellY,Z,ID,MAT,cellArea] = tfv_get_node_from_2dm('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm');


for i = 3:length(scenlist)
    
    outdata.(scenlist(i).name) = load([basedir,scenlist(i).name,'\',var,'.mat']);
    
end



scen = fieldnames(outdata);

figure('position',[1                        41                      2560          1327.33333333333]);



for i = 1:length(scen)
    
    theday = eomday(themonths(1).year(2),themonths(1).val(2));
    
    sss = find(outdata.(scen{i}).savedata.Time >= datenum(themonths(1).year(1),themonths(1).val(1),01,00,00,00) & ...
        outdata.(scen{i}).savedata.Time <= datenum(themonths(1).year(2),themonths(1).val(2),theday,23,59,59));
    
    delmap.raw.(scen{i}) = mean(outdata.(scen{i}).savedata.(var).(depth)(:,sss),2) * conv;
    
    subplot(2,4,i)
    title(regexprep(scen{i},'_',' '));
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',delmap.raw.(scen{i}));shading flat
    set(gca,'box','on');
    
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');
    
    axis equal
    
    xlim([368428.182749982          393903.974955901]);
    ylim([6369883.62051471          6411496.05933824]);
    
    caxis(base_caxis);
    
    colorbar
    
    axis off;
    
end

saveas(gcf,[var,'_',depth,'_raw.png']);close;

figure('position',[1                        41                      2560          1327.33333333333]);



for i = 1:length(scen)
    
    
    theDel = delmap.raw.(scen{i}) - delmap.raw.(base);
    
    
    subplot(2,4,i)
    title(regexprep(scen{i},'_',' '));
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',theDel);shading flat
    set(gca,'box','on');
    
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');
    
    axis equal
    
%     map = flipud(parula);
%     
%     colormap(patFig,map);
    
    xlim([368428.182749982          393903.974955901]);
    ylim([6369883.62051471          6411496.05933824]);
    
    caxis(del_caxis);
    
    colorbar
    
    axis off;
    
end

saveas(gcf,[var,'_',depth,'_delMap_minus_',base,'.png']);close;















