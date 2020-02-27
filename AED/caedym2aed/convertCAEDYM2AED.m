function [data] = convertCAEDYM2AED(cd_input)

% function function [data] = convertCAEDYM2AED(cd_input)
%
% Convert parameters from a CAEDYM input file to AED2 namelist format.
%
% Inputs:
%		cd_input     : input for a CAEDYM run including configuration
%		information and parameter values
%
% Outputs
%		data : a matlab structure that contains both parameter names and
%		values in AED units
%
% Uses:
%
% Written by L. Bruce 8th December 2015
%

% Conversion of units from mgX/L to mmolX/m3.
% Note that in CAEDYM DO is in mg O2 where all others are in mg X
DOconv = 1/32*1000;
Cconv = 1/12*1000;
Nconv = 1/14*1000;
Pconv = 1/31*1000;

%-------------------------------------------------------------------------%
%General parameters-------------------------------------------------------%
%-------------------------------------------------------------------------%

%Base PAR extinction
if isfield(cd_input.General.const,'base_PARext')
    data.nml.base_par_extinction = cd_input.General.const.base_PARext;
end

%-------------------------------------------------------------------------%
%AED2 Models--------------------------------------------------------------%
%-------------------------------------------------------------------------%

%Base model list
data.nml.aed_models = {'aed2_tracer', ...
                      'aed2_oxygen', ...
                      'aed2_nitrogen', ...
                      'aed2_phosphorus', ...
                      'aed2_organic_matter'};
                  
%Additional AED2 models from optional CAEDYM list
%Phytoplankton
if isfield(cd_input,'Phyto')
    data.nml.aed_models{length(data.nml.aed_models)+1} = 'aed2_phytoplankton';
end
%Zooplankton
if isfield(cd_input,'Zoop')
    data.nml.aed_models{length(data.nml.aed_models)+1} = 'aed2_zooplankton';
end

%-------------------------------------------------------------------------%
%AED2 Oxygen--------------------------------------------------------------%
%-------------------------------------------------------------------------%

%Sediment flux
if isfield(cd_input.Sediment.const,'rSOs') %Flux rate
    data.nml.Fsed_oxy = -1 * cd_input.Sediment.const.rSOs * DOconv;
end
if isfield(cd_input.Sediment.const,'KSOs') %1/2 Saturation constant
    data.nml.Ksed_oxy = cd_input.Sediment.const.KSOs * DOconv;
end
if isfield(cd_input.Sediment.const,'Thetased') %Temperature multiplier
    data.nml.theta_sed_oxy = cd_input.Sediment.const.Thetased;
end

%-------------------------------------------------------------------------%
%AED2 Nitrogen------------------------------------------------------------%
%-------------------------------------------------------------------------%

%Nitrification/Denitrification
if isfield(cd_input.DO.const,'koNH') %Rate
    data.nml.Rnitrif = cd_input.DO.const.koNH;
end
%if isfield(cd_input.Nitro.const,'koN2') %Rate
%    data.nml.Rdenit = cd_input.Nitro.const.koN2;
%end
if isfield(cd_input.DO.const,'KOn') %1/2 Saturation constant
    data.nml.Knitrif = cd_input.DO.const.KOn * DOconv;
end
%if isfield(cd_input.Nitro.const,'KN2') %1/2 Saturation constant
%    data.nml.Kdenit = cd_input.Nitro.const.KN2 * DOconv;
%end
if isfield(cd_input.DO.const,'vON') %Temperature multiplier
    data.nml.theta_nitrif = cd_input.DO.const.vON;
end
%if isfield(cd_input.Nitro.const,'vN2') %Temperature multiplier
%    data.nml.theta_denit = cd_input.Nitro.const.vN2;
%end

%Sediment flux
if isfield(cd_input.Sediment.const,'SmpNH4') %Flux rate
    data.nml.Fsed_amm = cd_input.Sediment.const.SmpNH4 * Nconv;
end
if isfield(cd_input.Sediment.const,'SmpNO3') %Flux rate
    data.nml.Fsed_nit = cd_input.Sediment.const.SmpNO3 * Nconv;
end
if isfield(cd_input.Sediment.const,'KDOS-NH4') %1/2 Saturation constant
    data.nml.Ksed_amm = cd_input.Sediment.const.KDOS-NH4 * DOconv;
end
if isfield(cd_input.Sediment.const,'KDOS-NO3') %1/2 Saturation constant
    data.nml.Ksed_nit = cd_input.Sediment.const.KDOS-NO3 * DOconv;
end
if isfield(cd_input.Sediment.const,'Thetased') %Temperature multiplier
    data.nml.theta_sed_amm = cd_input.Sediment.const.Thetased;
end
if isfield(cd_input.Sediment.const,'Thetased') %Temperature multiplier
    data.nml.theta_sed_nit = cd_input.Sediment.const.Thetased;
end

%-------------------------------------------------------------------------%
%AED2 Phosphorus----------------------------------------------------------%
%-------------------------------------------------------------------------%

%Adsorption/desorption
if isfield(cd_input.CNP.const,'Kad1PO4') %Rate
    data.nml.Kpo4p = cd_input.CNP.const.Kad1PO4;
end

%Sediment flux
if isfield(cd_input.Sediment.const,'SmpPO4') %Flux rate
    data.nml.Fsed_frp = cd_input.Sediment.const.SmpPO4 * Pconv;
end
if isfield(cd_input.Sediment.const,'KOxS-PO4') %1/2 Saturation constant
    data.nml.Ksed_frp = cd_input.Sediment.const.KOxS-PO4 * DOconv;
end
if isfield(cd_input.Sediment.const,'Thetased') %Temperature multiplier
    data.nml.theta_sed_frp = cd_input.Sediment.const.Thetased;
end

%-------------------------------------------------------------------------%
%AED2 Organic Matter------------------------------------------------------%
%-------------------------------------------------------------------------%

%Mineralisation
%POM Labile
if isfield(cd_input.CNP.const,'POC1max') %Rate
    data.nml.Rpoc_miner = cd_input.CNP.const.POCmax(1);
end
if isfield(cd_input.CNP.const,'PON1max') %Rate
    data.nml.Rpon_miner = cd_input.CNP.const.PONmax(1);
end
if isfield(cd_input.CNP.const,'POP1max') %Rate
    data.nml.Rpop_miner = cd_input.CNP.const.POPmax(1);
end
%DOM Labile
if isfield(cd_input.CNP.const,'DOC1max') %Rate
    data.nml.Rdoc_miner = cd_input.CNP.const.DOCmax(1);
end
if isfield(cd_input.CNP.const,'DON1max') %Rate
    data.nml.Rdon_miner = cd_input.CNP.const.DONmax(1);
end
if isfield(cd_input.CNP.const,'DOP1max') %Rate
    data.nml.Rdop_miner = cd_input.CNP.const.DOPmax(1);
end
%DOM Refractory
if isfield(cd_input.CNP.const,'DOC2max') %Rate
    data.nml.Rdocr_miner = cd_input.CNP.const.DOCmax(2);
end
if isfield(cd_input.CNP.const,'DON2max') %Rate
    data.nml.Rdonr_miner = cd_input.CNP.const.DONmax(2);
end
if isfield(cd_input.CNP.const,'DOP2max') %Rate
    data.nml.Rdopr_miner = cd_input.CNP.const.DOPmax(2);
end

%Attenuation coefficients
if isfield(cd_input.CNP.const,'KeDOC') %Rate
    data.nml.KeDOMR = cd_input.CNP.const.KeDOC(2) /83.3;  %(mmol/m3)/(mg/L)
end
if isfield(cd_input.CNP.const,'KePOC') %Rate
    data.nml.KeCPOM = cd_input.CNP.const.KePOC(1) /83.3;  %(mmol/m3)/(mg/L)
end

%Sediment flux
if isfield(cd_input.Sediment.const,'SmpdocL') %Flux rate
    data.nml.Fsed_doc = cd_input.Sediment.const.SmpdocL * Cconv;
end
if isfield(cd_input.Sediment.const,'SmpdonL') %Flux rate
    data.nml.Fsed_don = cd_input.Sediment.const.SmpdonL * Nconv;
end
if isfield(cd_input.Sediment.const,'SmpdopL') %Flux rate
    data.nml.Fsed_dop = cd_input.Sediment.const.SmpdopL * Pconv;
end
if isfield(cd_input.Sediment.const,'KDOS-doc') %1/2 Saturation constant
    data.nml.Ksed_doc = cd_input.Sediment.const.KDOS-doc * DOconv;
end
if isfield(cd_input.Sediment.const,'KDOS-don') %1/2 Saturation constant
    data.nml.Ksed_don = cd_input.Sediment.const.KDOS-don * DOconv;
end
if isfield(cd_input.Sediment.const,'KDOS-dop') %1/2 Saturation constant
    data.nml.Ksed_dop = cd_input.Sediment.const.KDOS-dop * DOconv;
end
if isfield(cd_input.Sediment.const,'Thetased') %Temperature multiplier
    data.nml.theta_sed_doc = cd_input.Sediment.const.Thetased;
end
if isfield(cd_input.Sediment.const,'Thetased') %Temperature multiplier
    data.nml.theta_sed_don = cd_input.Sediment.const.Thetased;
end
if isfield(cd_input.Sediment.const,'Thetased') %Temperature multiplier
    data.nml.theta_sed_dop = cd_input.Sediment.const.Thetased;
end

%-------------------------------------------------------------------------%
%AED2 Phytoplankton-------------------------------------------------------%
%-------------------------------------------------------------------------%

if isfield(cd_input,'Phyto')
    %Configuration
    data.nml.num_phytos = length(cd_input.Phyto.conf);
    data.nml.the_phytos = num2str(cd_input.Phyto.conf(1));
    for ii = 2:data.nml.num_phytos
        data.nml.the_phytos = [data.nml.the_phytos,',',num2str(cd_input.Phyto.conf(ii))];
    end
    
    %Phytoplankton constants
    data.phyto = convertCAEDYM2AEDphyto(cd_input);
    
end %If simulating phytoplankton
end %function