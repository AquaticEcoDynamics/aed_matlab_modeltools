function [data] = convertCAEDYM2AEDphyto(cd_input)

% function function [data] = convertCAEDYM2AEDphyto(cd_input)
%
% Convert Phytoplankton parameters from a CAEDYM input file to AED2
% phyto_params namelist format.
%
% Inputs:
%		cd_input     : input for a CAEDYM run including configuration
%		information and parameter values
%
% Outputs
%		data : a matlab structure that contains both parameter names and
%		values in AED units for phytoplankton groups
%
% Uses:
%
% Written by L. Bruce 9th December 2015
%

% Conversion of units from mgX/L to mmolX/m3.
% Note that in CAEDYM DO is in mg O2 where all others are in mg X
DOconv = 1/32*1000;
Cconv = 1/12*1000;
Nconv = 1/14*1000;
Pconv = 1/31*1000;
Siconv = 1/28.1*1000;

%-------------------------------------------------------------------------%
%General parameters-------------------------------------------------------%
%-------------------------------------------------------------------------%

%Phytoplankton names
data.p_name = {'DINOF','CYANO','NODUL','CHLOR','CRYPT','MDIAT','FDIAT'};

%Sedimentation rate (m/d)
if isfield(cd_input.Phyto.const,'ws')
    data.w_p = cd_input.Phyto.const.ws * 86400; %Convert from m/s to m/day;
end

%Carbon to chlorophyll ratio (mg C/mg chla)
if isfield(cd_input.BioCon.const,'Ycc')
    data.Ycc = cd_input.BioCon.const.Ycc(1:7);
end

%-------------------------------------------------------------------------%
%Growth parameters-------------------------------------------------------%
%-------------------------------------------------------------------------%

%Phyto max growth rate @20C (/day)
if isfield(cd_input.Phyto.const,'Pmax')
    data.R_growth = cd_input.Phyto.const.Pmax;
end

%Specifies temperature limitation function of growth
data.fT_Method = ones(7,1);

%Arrenhius temperature scaling for growth function
if isfield(cd_input.BioCon.const,'vT')
    data.theta_growth = cd_input.BioCon.const.vT(1:7);
end
%Standard temperature
if isfield(cd_input.BioCon.const,'Tsta')
    data.T_std = cd_input.BioCon.const.Tsta(1:7);
end
%Optimum temperature
if isfield(cd_input.BioCon.const,'Topt')
    data.T_opt = cd_input.BioCon.const.Topt(1:7);
end
%Maximum temperature
if isfield(cd_input.BioCon.const,'Tmax')
    data.T_max = cd_input.BioCon.const.Tmax(1:7);
end

%-------------------------------------------------------------------------%
%Light parameters-------------------------------------------------------%
%-------------------------------------------------------------------------%

%Type of light response function
if isfield(cd_input.BioCon.const,'algt')
    data.lightModel = cd_input.BioCon.const.algt(1:7);
end

%Half saturation constant for light limitation of growth (microE/m^2/s)
if isfield(cd_input.BioCon.const,'IK')
    data.I_K = cd_input.BioCon.const.IK(1:7);
end

%Saturating light intensity  (microE/m^2/s)
if isfield(cd_input.BioCon.const,'Ist')
    data.I_S = cd_input.BioCon.const.Ist(1:7);
end

%Specific attenuation coefficient  ((mmol C m^3^-1)^1 m^-1)
if isfield(cd_input.Phyto.const,'Kep')
    data.KePHY = cd_input.Phyto.const.Kep ./ data.Ycc;
end

%-------------------------------------------------------------------------%
%Respiration parameters---------------------------------------------------%
%-------------------------------------------------------------------------%

%Phytoplankton respiration/metabolic loss rate @ 20 (degC)
if isfield(cd_input.Phyto.const,'kr')
    data.R_resp = cd_input.Phyto.const.kr;
end

%Arrhenius temperature scaling factor for respiration
if isfield(cd_input.Phyto.const,'vR')
    data.theta_resp = cd_input.Phyto.const.vR;
end

%Fraction of metabolic loss that is true respiration
if isfield(cd_input.Phyto.const,'fres')
    data.k_fres = cd_input.Phyto.const.fres;
end

%Fraction of metabolic loss that is DOM
if isfield(cd_input.Phyto.const,'fdom')
    data.k_fdom = cd_input.Phyto.const.fdom;
end

%-------------------------------------------------------------------------%
%Salinity parameters------------------------------------------------------%
%-------------------------------------------------------------------------%

%Type of salinity limitation function
if isfield(cd_input.Phyto.const,'phsal')
    data.salTol = cd_input.Phyto.const.phsal;
end

%Salinity limitation value at maximum salinity S_maxsp
if isfield(cd_input.BioCon.const,'Bep')
    data.S_bep = cd_input.BioCon.const.Bep(1:7);
end

%Maximum salinity (g/kg)
if isfield(cd_input.Phyto.const,'maxSP')
    data.S_maxsp = cd_input.Phyto.const.maxSP;
end

%Optimal salinity (g/kg)
if isfield(cd_input.BioCon.const,'Sop')
    data.S_opt = cd_input.BioCon.const.Sop(1:7);
end

%-------------------------------------------------------------------------%
%Nitrogen parameters------------------------------------------------------%
%-------------------------------------------------------------------------%

%Simulate DIN uptake (0 = false, 1 = true)
%data.simDINUptake = zeros(7,1);
%if isfield(cd_input.Nitro.const,'alpN')
%    data.simDINUptake = cd_input.Nitro.const.alpN;
%end

%Nitrogen concentraion below which uptake is 0 (mmol N/m^3)
if isfield(cd_input.BioCon.const,'No')
    data.N_o = cd_input.BioCon.const.No(1:7) * Nconv;
end

%Half-saturation concentration of nitrogen (mmol N/m^3)
if isfield(cd_input.BioCon.const,'KN')
    data.K_N = cd_input.BioCon.const.KN(1:7) * Nconv;
end

%Constant internal nitrogen concentration (mmol N/ mmol C)
if isfield(cd_input.Phyto.const,'INcon')
    data.X_ncon = cd_input.Phyto.const.INcon(1:7)./data.Ycc * Nconv / Cconv;
end

%Minimum internal nitrogen concentration (mmol N/ mmol C)
if isfield(cd_input.BioCon.const,'INmin')
    data.X_nmin = cd_input.BioCon.const.INmin(1:7)./data.Ycc * Nconv / Cconv;
end

%Maximum internal nitrogen concentration (mmol N/ mmol C)
if isfield(cd_input.BioCon.const,'INmax')
    data.X_nmax = cd_input.BioCon.const.INmax(1:7)./data.Ycc * Nconv / Cconv;
end

%Maximum nitrogen uptake rate(mmol N/m^3/d)
if isfield(cd_input.BioCon.const,'UNmax')
    data.R_nuptake = cd_input.BioCon.const.UNmax(1:7)./data.Ycc * Nconv / Cconv;
end

%Growth rate reduction under maximum nitrogen fixation (/day)
if isfield(cd_input.Phyto.const,'NFixationRate')
    data.k_nfix = cd_input.Phyto.const.NFixationRate;
end

%Nitrogen fixation rate (mmol N/mmol C/day)
if isfield(cd_input.Phyto.const,'gthRedNFix')
    data.R_nfix = cd_input.Phyto.const.gthRedNFix./data.Ycc * Nconv / Cconv;
end

%-------------------------------------------------------------------------%
%Phosphorus parameters-------------------------------------------------%
%-------------------------------------------------------------------------%

%Simulate DIP uptake (0 = false, 1 = true)
%data.simDIPUptake = zeros(7,1);
%if isfield(cd_input.Phos.const,'alpP')
%    data.simDIPUptake = cd_input.Phos.const.alpP;
%end

%Phosphorus concentraion below which uptake is 0 (mmol P/m^3)
if isfield(cd_input.BioCon.const,'Po')
    data.P_o = cd_input.BioCon.const.Po(1:7) * Pconv;
end

%Half-saturation concentration of Phosphorus (mmol P/m^3)
if isfield(cd_input.BioCon.const,'KP')
    data.K_P = cd_input.BioCon.const.KP(1:7) * Pconv;
end

%Constant internal phosphorus concentration (mmol P/ mmol C)
if isfield(cd_input.Phyto.const,'IPcon')
    data.X_pcon = cd_input.Phyto.const.IPcon(1:7)./data.Ycc * Pconv / Cconv;
end

%Minimum internal phosphorus concentration (mmol P/ mmol C)
if isfield(cd_input.BioCon.const,'IPmin')
    data.X_pmin = cd_input.BioCon.const.IPmin(1:7)./data.Ycc * Pconv / Cconv;
end

%Maximum internal phosphorus concentration (mmol P/ mmol C)
if isfield(cd_input.BioCon.const,'IPmax')
    data.X_pmax = cd_input.BioCon.const.IPmax(1:7)./data.Ycc * Pconv / Cconv;
end

%Maximum phosphorus uptake rate(mmol P/m^3/d)
if isfield(cd_input.BioCon.const,'UPmax')
    data.R_puptake = cd_input.BioCon.const.UPmax(1:7)./data.Ycc * Pconv / Cconv;
end

%-------------------------------------------------------------------------%
%Silica parameters--------------------------------------------------------%
%-------------------------------------------------------------------------%

%Simulate Si uptake (0 = false, 1 = true)
data.simSiUptake = zeros(7,1);
if isfield(cd_input.Phyto.const,'Sicon')
    data.simSiUptake(cd_input.Phyto.const.Sicon>0) = 1;
end

%Silica concentraion below which uptake is 0 (mmol Si/m^3)
if isfield(cd_input.Phyto.const,'Sio')
    data.Si_o = cd_input.Phyto.const.Sio * Siconv;
end

%Half-saturation concentration of silica (mmol Si/m^3)
if isfield(cd_input.Phyto.const,'KSi')
    data.K_Si = cd_input.Phyto.const.KSi * Siconv;
end

%Constant internal silica concentration (mmol Si/ mmol C)
if isfield(cd_input.Phyto.const,'Sicon')
    data.X_sicon = cd_input.Phyto.const.Sicon(1:7)./data.Ycc * Siconv / Cconv;
end
