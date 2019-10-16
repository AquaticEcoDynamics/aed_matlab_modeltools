clear all; close all;

addpath(genpath('tuflowfv'));

%__________________________________________________________________________

%__________________________________________________________________________

main(1).filename = 'K:\Lowerlakes-CEW-Results\lower_lakes_FLUX.csv';

main(1).fileout = 'K:\Lowerlakes-CEW-Results\Flux_File.csv';

main(1).matout = 'K:\Lowerlakes-CEW-Results\Flux.mat';

main(2).filename = 'K:\Lowerlakes-CEW-Results\lower_lakes_noCEW_FLUX.csv';

main(2).fileout = 'K:\Lowerlakes-CEW-Results\Flux_File_noCEW.csv';

main(2).matout = 'K:\Lowerlakes-CEW-Results\Flux_noCEW.mat';

main(3).filename = 'K:\Lowerlakes-CEW-Results\lower_lakes_noEWater_FLUX.csv';

main(3).fileout = 'K:\Lowerlakes-CEW-Results\Flux_File_noEWater.csv';

main(3).matout = 'K:\Lowerlakes-CEW-Results\Flux_noEWater.mat';

% %__________________________________________________________________________
%main(2).filename = 'Z:\Busch\Studysites\Lowerlakes\CEWH_2018\v006_CEW_2015_2018_noCEW_newAED2\Output\lower_lakes_FLUX.csv';
%
%main(2).fileout = 'Z:\Busch\Studysites\Lowerlakes\CEWH_2018\v006_CEW_2015_2018_noCEW_newAED2\Output\Flux_File.csv';
%
%main(2).matout = 'Z:\Busch\Studysites\Lowerlakes\CEWH_2018\v006_CEW_2015_2018_noCEW_newAED2\Output\Flux.mat';
%% 
%% %__________________________________________________________________________
%% 
%main(3).filename = 'Z:\Busch\Studysites\Lowerlakes\CEWH_2018\v006_CEW_2015_2018_noALL_newAED2\Output\lower_lakes_FLUX.csv';
%
%main(3).fileout = 'Z:\Busch\Studysites\Lowerlakes\CEWH_2018\v006_CEW_2015_2018_noALL_newAED2\Output\Flux_File.csv';
%
%main(3).matout = 'Z:\Busch\Studysites\Lowerlakes\CEWH_2018\v006_CEW_2015_2018_noALL_newAED2\Output\Flux.mat';

%__________________________________________________________________________
% main(4).filename = 'D:\Studysites\Lowerlakes\CEWH_2016\v6_Simulations\CEW_2015_2016_Obs_no_Offtake_v6_Met_v2\Output\lower_lakes_FLUX.csv';
% 
% main(4).fileout = 'D:\Studysites\Lowerlakes\CEWH_2016\v6_Simulations\CEW_2015_2016_Obs_no_Offtake_v6_Met_v2\Output\Flux_File.csv';
% 
% main(4).matout = 'D:\Studysites\Lowerlakes\CEWH_2016\v6_Simulations\CEW_2015_2016_Obs_no_Offtake_v6_Met_v2\Output\Flux.mat';
% 
% % %__________________________________________________________________________
% 
% main(5).filename = 'D:\Studysites\Lowerlakes\CEWH_2016\v6_Simulations\CEW_2015_2016_Obs_FRP_SEDFLUX_v6_Met_v2\Output\lower_lakes_FLUX.csv';
% 
% main(5).fileout = 'D:\Studysites\Lowerlakes\CEWH_2016\v6_Simulations\CEW_2015_2016_Obs_FRP_SEDFLUX_v6_Met_v2\Output\Flux_File.csv';
% 
% main(5).matout = 'D:\Studysites\Lowerlakes\CEWH_2016\v6_Simulations\CEW_2015_2016_Obs_FRP_SEDFLUX_v6_Met_v2\Output\Flux.mat';

% %__________________________________________________________________________


%__________________________________________________________________________

%__________________________________________________________________________


wqfile = 'Flux Order WQ 1.xlsx';

nodefile = 'Flux_Nodestrings.xlsx';

%__________________________________________________________________________

disp('Running processing in Parrallel: Dont cancel...');

for i = 1:length(main)
    
    
    %tfv_preprocess_fluxfile(main(i).filename,main(i).fileout);
    
    tfv_process_fluxfile(main(i).filename,main(i).matout,wqfile,nodefile);
    
    
    
    
    
    
    
    
    
end