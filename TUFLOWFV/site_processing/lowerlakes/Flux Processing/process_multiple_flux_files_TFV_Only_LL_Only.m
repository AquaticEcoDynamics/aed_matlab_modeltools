clear all; close all;

addpath(genpath('tuflowfv'));

%__________________________________________________________________________


%__________________________________________________________________________

main(1).filename = 'D:\Studysites\Lowerlakes\032_obs_LL_Only_TFV\Output\lower_lakes_FLUX.csv';

main(1).fileout = 'D:\Studysites\Lowerlakes\032_obs_LL_Only_TFV\Output\Flux_File.csv';

main(1).matout = 'D:\Studysites\Lowerlakes\032_obs_LL_Only_TFV\Output\Flux.mat';

%__________________________________________________________________________
% main(2).filename = 'D:\Studysites\Lowerlakes\020_noCEW_AED2_WS20_SC_Flow_off\Output\lower_lakes_FLUX.csv';
% 
% main(2).fileout = 'D:\Studysites\Lowerlakes\020_noCEW_AED2_WS20_SC_Flow_off\Output\Flux_File.csv';
% 
% main(2).matout = 'D:\Studysites\Lowerlakes\020_noCEW_AED2_WS20_SC_Flow_off\Output\Flux.mat';
% 
% % %__________________________________________________________________________
% 
% main(3).filename = 'D:\Studysites\Lowerlakes\020_noAll_AED2_WS20_SC_Flow_off\Output\lower_lakes_FLUX.csv';
% 
% main(3).fileout = 'D:\Studysites\Lowerlakes\020_noAll_AED2_WS20_SC_Flow_off\Output\Flux_File.csv';
% 
% main(3).matout = 'D:\Studysites\Lowerlakes\020_noAll_AED2_WS20_SC_Flow_off\Output\Flux.mat';

% %__________________________________________________________________________

%__________________________________________________________________________

%__________________________________________________________________________


wqfile = 'Flux Order WQ 1_tfv.xlsx';

nodefile = 'Flux_Nodestrings_LL.xlsx';

%__________________________________________________________________________

disp('Running processing in Parrallel: Dont cancel...');

parfor i = 1:length(main)
    
    
    %tfv_preprocess_fluxfile(main(i).filename,main(i).fileout);
    
    tfv_process_fluxfile(main(i).filename,main(i).matout,wqfile,nodefile);
end