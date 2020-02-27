function newAEDphytopars(nml,conf)
%
%This function takes the initial aed_phyto_pars.nml from nml folder and creates a new
%aed_phyto_pars.nml with parameters taken from MATLAB structure nml
%
% Note that aed_phyto_pars_init.nml must have the same number of
% phytoplankton groups as the nml structure

% ii = line number in phytoplankton parameter file
% phy_i = phytoplankton group number
% par_i = phytoplankton parameters number

%-------------------------------------------------------------------------%
%First take initial aed2.nml file from nml and insert parameters----%
%-------------------------------------------------------------------------%
%
%Open AED name list file
fid = fopen([conf.paths.working_dir,'nml\aed2_phyto_pars_init.nml'],'r');

%Phytoplankton parameter list of variables
par_names = {'p_name','p_initial','p0','w_p','Ycc','R_growth','fT_Method', ...
             'theta_growth','T_std','T_opt','T_max','lightModel','I_K', ...
             'I_S','KePHY','f_pr','R_resp','theta_resp','k_fres','k_fdom', ...
             'salTol','S_bep','S_maxsp','S_opt','simDINUptake', ...
             'simDONUptake','simNFixation','simINDynamics','N_o','K_N', ...
             'X_ncon','X_nmin','X_nmax','R_nuptake','k_nfix','R_nfix', ...
             'simDIPUptake','simIPDynamics','P_0','K_P','X_pcon','X_pmin', ...
             'X_pmax','R_puptake','simSiUptake','Si_0','K_Si','X_sicon'};



%Loop through line by line until reach first parameter line
ii=1;
while 1
    tline = fgetl(fid);
    if isempty(tline)
        nml.txt{ii} = tline;
        ii = ii + 1;
        continue
    end
    if (strcmp(tline(1:2),'pd')), break, end %end of header information
    nml.txt{ii} = tline;
    ii = ii + 1;
    continue
end

%First phytoplankton group includes 'pd ='
nml.txt{ii} = 'pd =';

%Loop through 7 phytoplankton groups and get parameters
for phy_i = 1:7
    %Remove spaces and tabs
    tline_cmp = regexprep(tline,'\s','');
    tline_cmp = regexprep(tline_cmp,'\t','');
    equal_i = strfind(tline_cmp,'=');
    %Split line into list of phytoplankton parameter values
    if phy_i == 1
        phy_pars = regexp(tline_cmp(equal_i+1:end),',','split');
    else
        phy_pars = regexp(tline_cmp,',','split');
    end
    phy_pars_new = phy_pars;

    %Loop through each parameter to check if have replacement value from nml
    %input structure
    for par_i = 1:length(par_names)
        if isfield(nml,par_names{par_i})
            phy_pars_new{par_i} = nml.(par_names{par_i})(phy_i);
        end
    end

    %Create new parameter line with updated parameters
    nml_txt = [];
    for par_i = 1:length(par_names)
        temp_var = phy_pars_new{par_i};
        if iscell(temp_var)
            if ischar(cell2mat(temp_var))
                 nml_txt = [nml_txt,'''',cell2mat(temp_var),'''',',  '];
            else
                 nml_txt = [nml_txt,cell2mat(temp_var),',  '];
            end
        elseif isnumeric(temp_var)
            nml_txt = [nml_txt,num2str(temp_var),',  '];
        else
            nml_txt = [nml_txt,temp_var,',  '];
        end
    end %Loop through phytoplankton parameters
    nml.txt{ii} = [nml.txt{ii} nml_txt];
    ii = ii + 1;
    tline = fgetl(fid);
    nml.txt{ii} = '    ';
end %Loop through phytoplankton groups
nml.txt{ii} = tline;

fclose(fid);

%-------------------------------------------------------------------------%
%Write new aed_phyto_pars.nml AED2 phyto parameter name list file --------%
%-------------------------------------------------------------------------%
%Open new AED2 phyto parameter name list file
fid = fopen([conf.paths.working_dir,'nml/aed2_phyto_pars_new.nml'],'w');
for ii = 1:length(nml.txt)
    fprintf(fid,'%s\n',nml.txt{ii});
end
fclose(fid);
