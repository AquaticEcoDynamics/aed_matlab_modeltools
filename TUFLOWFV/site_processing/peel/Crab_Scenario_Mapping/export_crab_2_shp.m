clear all; close all;

base = load('data_base_crabHSI.mat');
scnA = load('data_scen2a_crabHSI.mat');
scnB = load('data_scen2b_crabHSI.mat');

date(1).range = [datenum(2016,04,01) datenum(2016,07,01)];
date(2).range = [datenum(2016,07,01) datenum(2016,10,01)];
date(3).range = [datenum(2016,10,01) datenum(2017,01,01)];
date(4).range = [datenum(2017,01,01) datenum(2017,04,01)];

tags = {'Apr';'Jul';'Oct';'Jan'};

%CI == Larve
%CI2 == adult

for i = 1:length(date)
    
    sss = find(base.mdates >= date(i).range(1) & ...
        base.mdates < date(i).range(2));
    
    ttt = find(scnA.mdates >= date(i).range(1) & ...
        scnA.mdates < date(i).range(2));
    
    uuu = find(scnA.mdates >= date(i).range(1) & ...
        scnA.mdates < date(i).range(2));

    
    out.base.(tags{i}) = double(mean(base.CI(:,sss),2));
    out.scnA.(tags{i}) = double(mean(scnA.CI(:,ttt),2));
    out.scnB.(tags{i}) = double(mean(scnB.CI(:,uuu),2));

    out2.base.(tags{i}) = double(mean(base.CI2(:,sss),2));
    out2.scnA.(tags{i}) = double(mean(scnA.CI2(:,ttt),2));
    out2.scnB.(tags{i}) = double(mean(scnB.CI2(:,uuu),2));
    
    
    
    out.fake.(tags{i})(1:length(out.scnB.(tags{i})),1) = 0.99;
    out.fake.(tags{i})(1,1) = 0;
end


    

convert_2dm_to_shp('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm','Larval_Base.shp',...
    [tags{1}],out.base.(tags{1}),...
    [tags{2}],out.base.(tags{2}),...
    [tags{3}],out.base.(tags{1}),...
    [tags{4}],out.base.(tags{4}));

convert_2dm_to_shp('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm','Larval_scenA.shp',...
    [tags{1}],out.scnA.(tags{1}),...
    [tags{2}],out.scnA.(tags{2}),...
    [tags{3}],out.scnA.(tags{1}),...
    [tags{4}],out.scnA.(tags{4}));

convert_2dm_to_shp('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm','Larval_scenB.shp',...
    [tags{1}],out.scnB.(tags{1}),...
    [tags{2}],out.scnB.(tags{2}),...
    [tags{3}],out.scnB.(tags{1}),...
    [tags{4}],out.scnB.(tags{4}));

convert_2dm_to_shp('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm','Larval_Fake.shp',...
    [tags{1}],out.fake.(tags{1}),...
    [tags{2}],out.fake.(tags{2}),...
    [tags{3}],out.fake.(tags{1}),...
    [tags{4}],out.fake.(tags{4}));


convert_2dm_to_shp('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm','Adult_Base.shp',...
    [tags{1}],out2.base.(tags{1}),...
    [tags{2}],out2.base.(tags{2}),...
    [tags{3}],out2.base.(tags{1}),...
    [tags{4}],out2.base.(tags{4}));

convert_2dm_to_shp('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm','Adult_scenA.shp',...
    [tags{1}],out2.scnA.(tags{1}),...
    [tags{2}],out2.scnA.(tags{2}),...
    [tags{3}],out2.scnA.(tags{1}),...
    [tags{4}],out2.scnA.(tags{4}));

convert_2dm_to_shp('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm','Adult_scenB.shp',...
    [tags{1}],out2.scnB.(tags{1}),...
    [tags{2}],out2.scnB.(tags{2}),...
    [tags{3}],out2.scnB.(tags{1}),...
    [tags{4}],out2.scnB.(tags{4}));

convert_2dm_to_shp('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm','Adult_Fake.shp',...
    [tags{1}],out.fake.(tags{1}),...
    [tags{2}],out.fake.(tags{2}),...
    [tags{3}],out.fake.(tags{1}),...
    [tags{4}],out.fake.(tags{4}));










% ncfile = 'T:\PEEL\NEWER/run_2016_2018.nc'; 
% 
% dat = tfv_readnetcdf(ncfile,'timestep',1);
% 
% 
% vert(:,1) = dat.node_X;
% vert(:,2) = dat.node_Y;
% 
% faces = dat.cell_node';
% 
% %--% Fix the triangles
% faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);
% 
% figure
% 
% patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',out.base.Jan);shading flat
% caxis([0 0.4]);
% axis equal
% title('Base')
% colorbar;
% figure
% 
% patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',out.scnB.Jan);shading flat
% caxis([0 0.4]);
% axis equal
% title('Scenario B')
% colorbar;