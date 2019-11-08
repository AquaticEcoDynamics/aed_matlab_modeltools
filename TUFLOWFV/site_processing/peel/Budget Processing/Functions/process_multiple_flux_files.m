clear all; close all;

addpath(genpath('tuflowfv'));

%__________________________________________________________________________

dirlist = dir(['T:\Fluxes/']);

int = 1;
for i = 3:length(dirlist)
    %__________________________________________________________________________
    
    main(int).filename = ['T:\Fluxes\',dirlist(i).name];
    
    main(int).fileout = ['T:\Flux_v12\',dirlist(i).name];
    
    main(int).matout = ['T:\Flux_v12\',regexprep(dirlist(i).name,'.csv','.mat')];
    
    int = int + 1;
end
% %__________________________________________________________________________


%__________________________________________________________________________


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