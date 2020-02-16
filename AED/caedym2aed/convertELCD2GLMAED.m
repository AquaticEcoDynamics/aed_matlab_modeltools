%function [data] = convertELCD2GLMAED(conf_file)

% function function [data] = convertELCD2GLMAED(conf_file)
%
% Generate a GLM AED simulation using input files from an ELCOM-CAEDYM
% simulation.
%
% Inputs:
%		conf_file     : name list file listing names of all ELCD input
%		files
%
% Outputs
%		data : a matlab structure that contains configuration data used to
%		run the GLM AED simulation
%
% Uses:
%       readELCDconfig.m
%       getGLMnml.m
%       newGLMnml.m
%       readCAEDYMparams.m
%       newAEDnml.m
%       writeGLMmet.m
%		writeGLMinflow.m
%       writeGLMoutflow.m
%
% Written by L. Bruce 8th December 2015
%

%Clean up
clear all
close all

%-------------------------------------------------------------------------%
%Read in configuration name list file-------------------------------------%
%-------------------------------------------------------------------------%

conf_file = 'C:\Louise\GLM\Sites\Erie\Models\ELCD\ELCOM\Erie_ELCD_config.nml';
conf = readELCDconfig(conf_file);
%Working directory for TUFLOW AED set up
conf.paths.working_dir = [conf.paths.base_dir,conf.paths.working_dir];

%-------------------------------------------------------------------------%
%Convert from TUFLOW FV grid----------------------------------------------%
%-------------------------------------------------------------------------%

file_2dm = 'C:\Louise\GLM\Sites\Erie\Models\TFV\tfv_erie_v1_oxy_trc1\Geo\Erie_v1.2dm';
file_HA = 'C:\Louise\GLM\Sites\Erie\Models\GLM\nml\HA.txt';

tfv_2dm2GLM_HA(file_2dm,1.0,file_HA)


%-------------------------------------------------------------------------%
%Read in CAEDYM nc file required for AED parameters-----------------------%
%-------------------------------------------------------------------------%

%CAEDYM nc input file ----------------------------------------------------%
cd_input = readCAEDYMnc([conf.paths.base_dir,conf.paths.CAEDYM_dir,'CAEDYM.nc']);

%CAEDYM models simulated
cd_models = fields(cd_input);

%-------------------------------------------------------------------------%
%Convert CAEDYM config and parameters to AED -----------------------------%
%-------------------------------------------------------------------------%

%Convert CAEDYM to AED
 aed2 = convertCAEDYM2AED(cd_input);
 
 %Write new AED config and parameter files
 newAEDnml(aed2.nml,conf)
 
%-------------------------------------------------------------------------%
%Convert CAEDYM phytoplankton parameters to AED -----------------------------%
%-------------------------------------------------------------------------%

%If simulating phytoplankton write new AED phyto_params nml file
if isfield(cd_input,'Phyto')
    %Convert CAEDYM to AED
    aed2.phyto = convertCAEDYM2AEDphyto(cd_input);
 
    %Write new AED phytoplankton parameter files
     newAEDphytopars(aed2.phyto,conf)
 end