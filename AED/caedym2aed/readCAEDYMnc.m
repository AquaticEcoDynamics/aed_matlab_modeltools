function [data] = readCAEDYMnc(filename)
% function [data] = readCAEDYMnc(filename)
%
% Inputs:
%		filename   :  the CAEDYM.nc netcdf input file containing
%		configuration info and parameters
% Outputs
%		data    : a matlab structure that contains the data from the
%		variables and parameters in CAEDYM.nc.
%
% Uses: netcdf, ncinfo, names_netcdf
%
% Written by L. Bruce 8th December 2015
%

%CAEDYM configuration variables
cd_models = {'Phyto','Zoop','JF','Fish','Seagrass','Macroalgae',...
                  'Clams','Invert','Paths'};
                  %'Clams','Invert','ChmComp','PPComp','Paths'}; not
                  %include PPComp and ChmComp as models
cd_conf_vars = [];
for ii = 1:length(cd_models)
    cd_conf_vars{ii} = ['caedymConfig',cd_models{ii}];
end

%-------------------------------------------------------------------------%
%Open file and extract config info----------------------------------------%
%-------------------------------------------------------------------------%


%Open file and create netcdf file identifier ncid
ncid = netcdf.open(filename,'nc_nowrite');

%Extract information from netcdf file
finfo = ncinfo(filename);

%Extract list of variable names
cd_var_names = {finfo.Variables.Name}';

%Extract CAEDYM configuration information
for ii = 1:length(cd_models)
      varid = netcdf.inqVarID(ncid,cd_conf_vars{ii});
      conf_data = netcdf.getVar(ncid,varid);
      %Remove zeros i.e. groups not simulated
      conf_data = conf_data(conf_data > 0);
      %If model is simulated add configuration information to data
      if ~isempty(conf_data > 0)
          data.(cd_models{ii}).conf = conf_data;
      end
end
%Optional models simualted in CAEDYM
cd_models = fieldnames(data);

%Add models simulated to default models
cd_model_names = {'General','Sediment','DO','Nitro','Phos','OrgComp','CNP','BioCon'};
for ii = 1:length(cd_models)
    cd_model_names{8+ii} = cd_models{ii};
end

%-------------------------------------------------------------------------%
%Read in CAEDYM parameters for each model simulated-----------------------%
%-------------------------------------------------------------------------%

for mod_i = 1:length(cd_model_names)
    mod_name = cd_model_names{mod_i};
    %Check is a constant or parameter for this model
    for ii = 1:length(cd_var_names)
        %Check long enough to be a constant for model mod_i
        if length(cd_var_names{ii}) > 11+length(mod_name)
        if strcmp(cd_var_names{ii}(7:11),'Const')
            if strcmp(cd_var_names{ii}(12:11+length(mod_name)),mod_name)
                varid = netcdf.inqVarID(ncid,cd_var_names{ii});
                var_data = netcdf.getVar(ncid,varid);
                data.(mod_name).const.(cd_var_names{ii}(12+length(mod_name):end)) = var_data;
            end
        end
        end
    end
end

netcdf.close(ncid)