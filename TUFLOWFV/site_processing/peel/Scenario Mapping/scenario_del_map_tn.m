clear all; close all;

addpath(genpath('functions'));



dat2 = tfv_readnetcdf('H:\Peel_Scenarios\run_scenario_0b.nc','timestep',1);

timeperiod = [datenum(2016,01,01) datenum(2016,10,01)];

varname = 'WQ_DIAG_TOT_TN';
cax = [0 0.2];
factor = 14/1000;
depth = 'Top';
savename = ['del',varname,'_',depth,'_',datestr(timeperiod(1),'yyyymmdd'),'_',datestr(timeperiod(2),'yyyymmdd'),'.png'];

B0 = load(['H:\Peel Export\Matfiles_All\run_scenario_0b\',varname,'.mat']);
B1 = load(['H:\Peel Export\Matfiles_All\run_scenario_1b\',varname,'.mat']);
B2 = load(['H:\Peel Export\Matfiles_All\run_scenario_2b\',varname,'.mat']);
B3 = load(['H:\Peel Export\Matfiles_All\run_scenario_3b\',varname,'.mat']);


vert(:,1) = dat2.node_X;
vert(:,2) = dat2.node_Y;

faces = dat2.cell_node';

%--% Fix the triangles
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);

%_____________

B0.ind = find(B0.savedata.Time >= timeperiod(1) & B0.savedata.Time < timeperiod(2));
B1.ind = find(B1.savedata.Time >= timeperiod(1) & B1.savedata.Time < timeperiod(2));
B2.ind = find(B2.savedata.Time >= timeperiod(1) & B2.savedata.Time < timeperiod(2));
B3.ind = find(B3.savedata.Time >= timeperiod(1) & B3.savedata.Time < timeperiod(2));


for i = 1:length(B0.ind)
    oxy1(:,i) = B0.savedata.(varname).(depth)(:,B0.ind(i)) - B1.savedata.(varname).(depth)(:,B1.ind(i));
    oxy2(:,i) = B0.savedata.(varname).(depth)(:,B0.ind(i)) - B2.savedata.(varname).(depth)(:,B2.ind(i));
    oxy3(:,i) = B0.savedata.(varname).(depth)(:,B0.ind(i)) - B3.savedata.(varname).(depth)(:,B3.ind(i));
    
end
oxy1 = oxy1 * factor;
oxy2 = oxy2 * factor;
oxy3 = oxy3 * factor;

oxymean1 = mean(oxy1,2);
oxymean2 = mean(oxy2,2);
oxymean3 = mean(oxy3,2);

figure('position',[414         145        1238         845])

axes('position',[0 0 0.33 1])

patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',oxymean1);shading flat
set(gca,'box','on');

set(findobj(gca,'type','surface'),...
    'FaceLighting','phong',...
    'AmbientStrength',.3,'DiffuseStrength',.8,...
    'SpecularStrength',.9,'SpecularExponent',25,...
    'BackFaceLighting','unlit');
axis off;
axis equal;

xlim([371652.892561983          391074.380165289]);
ylim([6370269.73684211          6420651.31578947]);

caxis(cax);
cb = colorbar;
set(cb,'position',[0.3 0.1 0.01 0.3]);
title(cb,'mg/L','fontsize',10);
text(0.05,0.8,'Scenario 1B','fontsize',10,'units','normalized');

axes('position',[0.33 0 0.33 1])

patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',oxymean2);shading flat
set(gca,'box','on');

set(findobj(gca,'type','surface'),...
    'FaceLighting','phong',...
    'AmbientStrength',.3,'DiffuseStrength',.8,...
    'SpecularStrength',.9,'SpecularExponent',25,...
    'BackFaceLighting','unlit');
axis off;
axis equal;

xlim([371652.892561983          391074.380165289]);
ylim([6370269.73684211          6420651.31578947]);

caxis(cax);

cb = colorbar;
set(cb,'position',[0.6 0.1 0.01 0.3]);
title(cb,'mg/L','fontsize',10);
text(0.05,0.8,'Scenario 2B','fontsize',10,'units','normalized');

axes('position',[0.66 0 0.33 1])

patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',oxymean3);shading flat
set(gca,'box','on');

set(findobj(gca,'type','surface'),...
    'FaceLighting','phong',...
    'AmbientStrength',.3,'DiffuseStrength',.8,...
    'SpecularStrength',.9,'SpecularExponent',25,...
    'BackFaceLighting','unlit');

axis off;
axis equal;
xlim([371652.892561983          391074.380165289]);
ylim([6370269.73684211          6420651.31578947]);

caxis(cax);
cb = colorbar;
set(cb,'position',[0.9 0.1 0.01 0.3]);
title(cb,'mg/L','fontsize',10);


text(0.05,0.8,'Scenario 3B','fontsize',10,'units','normalized');

saveas(gcf,savename);