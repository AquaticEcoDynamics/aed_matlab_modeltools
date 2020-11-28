%[InFile,InDir] = uigetfile('./*.nc',...
%    'Choose the NetCDF file you want to copy');
%OutDir = uigetdir('D:\TUFLOWFV\',...
%    'Choose the output directory');

InFile = '/Volumes/AED/Hawkesbury/HN_Cal_v6_A2sc_2013/output/HN_Cal_2013_2014_3D_wq_WQ.nc'
OutDir = '/Volumes/AED/Hawkesbury/HN_Cal_v6_A2sc_2013/output/'

OutFile = ['SelectedOnly_',InFile];
OutFile = '/Volumes/AED/Hawkesbury/HN_Cal_v6_A2sc_2013/output/HN_Cal_v6_A2sc_2013_SelectedOnly_HN_Cal_2013_2014_3D_wq_WQ.nc'

vars = {'ResTime';'cell_Nvert';'cell_node';'NL';'idx2';'idx3';'cell_X';...
    'cell_Y';'cell_Zb';'cell_A';'node_X';'node_Y';'node_Zb';'layerface_Z';...
    'stat';'H';'D';'SAL';'TEMP';'WQ_DIAG_TOT_TN';'WQ_DIAG_TOT_TP';'WQ_DIAG_PHY_TCHLA';'WQ_DIAG_TOT_TSS'};

%% Copy an existing netcdf (omit height)
netcdf_copy([InFile],[OutFile], 'variables',vars);


InFile = '/Volumes/AED/Hawkesbury/HN_ScenTest_v6_A2sc_2013/output/HN_Cal_2013_2014_3D_wq_WQ.nc'
OutDir = '/Volumes/AED/Hawkesbury/HN_ScenTest_v6_A2sc_2013/output/'

OutFile = ['SelectedOnly_',InFile];
OutFile = '/Volumes/AED/Hawkesbury/HN_ScenTest_v6_A2sc_2013/output/HN_ScenTest_v6_A2sc_2013_SelectedOnly_HN_Cal_2013_2014_3D_wq_WQ.nc'

vars = {'ResTime';'cell_Nvert';'cell_node';'NL';'idx2';'idx3';'cell_X';...
    'cell_Y';'cell_Zb';'cell_A';'node_X';'node_Y';'node_Zb';'layerface_Z';...
    'stat';'H';'D';'SAL';'TEMP';'WQ_DIAG_TOT_TN';'WQ_DIAG_TOT_TP';'WQ_DIAG_PHY_TCHLA';'WQ_DIAG_TOT_TSS'};

%% Copy an existing netcdf (omit height)
netcdf_copy([InFile],[OutFile], 'variables',vars);