clear all; close all;

load export_juv.mat;
load export_adult.mat;


adult = export(:,3);
juv = export_juv(:,4);

convert_2dm_to_shp('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm','Adult',adult,'Juv',juv);
