clear all; close all;

load('Y:\Peel Final Report\FCI\fci_2016.mat');

outdir = 'Y:\Peel Final Report\FCI\';

shp = shaperead('Peel_Boundary.shp');

var = 'pred_fci';

conv = 1;%1/86400;%32/1000;

base_caxis = [1 6];

thedates = datenum(2016,08:01:15,01,12,00,00);

site = 'run_2016';

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


%%


[XX,YY,ZZ,nodeID,faces,cellX,cellY,Z,ID,MAT,cellArea] = tfv_get_node_from_2dm('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm');


% for k = 1:length(out)
%     mtime(k) = out(k).time;
% end

%%

cmap = zeros(5, 3);
cmap =   [[0, 153, 0]/255; ...   % Blue for 1
          [102,255, 102]/255; ...       % Black for 2
          [255,255, 51]/255; ...       % Green for 3
          [255, 128, 0]/255; ... % Gray for 4
          [255,0, 0]/255; ...   % Brown for 5
    ];

figure('position',[750.333333333333                        99          1573.33333333333          1094.66666666667]);



for i = 1:length(thedates)
    
    [~,the_ind] = min(abs(fci.(site).mtime - thedates(i)));
    
    
    delmap = fci.(site).(var)(:,the_ind);
    
    
    %delmap.raw.(theorder{i})
    %subplot(2,4,i)
    axes('position',pos(i).a)
    
    tx = datestr(mtime(the_ind),'dd mmm');
    
    text(0.75,0.95,tx,'units','normalized','fontsize',14,'fontweight','bold');
    
    
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',delmap);shading flat
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
    
    patFig = patch('faces',faces','vertices',[XX YY],'FaceVertexCData',delmap);shading flat
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

saveas(gcf,[outdir,var,'_raw.png']);%close;











