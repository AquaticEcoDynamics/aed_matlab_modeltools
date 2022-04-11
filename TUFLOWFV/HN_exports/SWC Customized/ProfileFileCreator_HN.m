% create_profile_file.m
%
% This script takes coordinates and writes a profile .nc file with all the
% model ouput data at that location. This information is passed to various
% timeseries visualisation scripts for quick and efficent plotting
%
% Usage: 
% Input a TUFLOW FV results file and list of coordinates and names to
% generate the profile file. Please ensure that coordinated used are in the
% same projection as the TUFLOW FV model. 
%
% SDE 2018

clear
close
ncfile = {...
'HN_Cal_2013_2016_3D_wq_Baseline_WQ.nc',...
'HN_Cal_2013_2016_3D_wq_Background_WQ.nc',...
'HN_Cal_2013_2016_3D_wq_Impact_WQ.nc',...
};
% ------------------- User Input ------------------
%WorkDir = '/Projects/Cattai/HN_CC_Cal_v1_A5_Scenarios/output';    % Update to the folder that contains the result .nc files
%cd(WorkDir);

% Directory where all necessary TUFLOW MATLAB scripts are, such as netcdf_get_var
SupportingScriptsDir = '../../HN_exports';
addpath(genpath(SupportingScriptsDir));

%NumFiles = inputdlg('Enter the number of files you want create profile points for','Number of Files');
NumFiles = 1;%str2double(NumFiles{1,1});

%cd('N:\Asset Knowledge\Manage Projects\2 Current\20037702\3_Data\Scripts\SWC Customized');
%[XYFile,XYPath] = uigetfile('*.csv','Choose the Profile Coordinate File');
%XY = readtable([XYPath XYFile],'delimiter',',');

XY = readtable('/Projects2/busch_github/aed_matlab_modeltools/TUFLOWFV/HN_exports/SWC Customized/ProfileCoordinates_HN_ScenarioComparison.csv','delimiter',',');

for bb = 1:length(ncfile)

%cd(WorkDir);

	for iFiles = 1:NumFiles
		%[ResFile,ResPath] = uigetfile('*.nc','Choose result file to process');
		ResFile = ncfile{bb};
		ResPath = '/Projects2/Cattai/HN_CC_Cal_v1_A7_Scenarios/output/'
		tfv_res_files{iFiles,1} = [ResPath ResFile];
	end

	output_sites = [XY.X,XY.Y];

	site_names = XY.Name;

	%suffix = inputdlg('Any suffix for output file?','SUFFIX');
	suffix = ['HN'];

	% ----------------- Generate Profiles ----------------
	for i=1:size(tfv_res_files,1)
		tfv_resfile = tfv_res_files{i,1};
		% create a meaningful output name
		out_name = strrep(tfv_resfile,'.nc','_PROFILES.nc');
		if size(suffix,2)>0
			out_name = strrep(out_name,'_PROFILES.nc',['_',suffix,'_PROFILES.nc']);
		end

		% call the profile generation script
		fv_create_profiles(tfv_resfile,out_name,output_sites,site_names);
	end
end