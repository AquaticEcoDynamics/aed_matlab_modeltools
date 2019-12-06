clear all; close all;

addpath(genpath('tuflowfv'));

%__________________________________________________________________________

dirlist = dir(['R:\Coorong\Proc/','*.csv']);

int = 1;
for i = 1:length(dirlist)
    %__________________________________________________________________________
    
    main(int).filename = ['R:\Coorong\Proc\',dirlist(i).name];
    
    main(int).fileout = ['R:\Coorong\Proc_Out\',dirlist(i).name];
    
    main(int).matout = ['R:\Coorong\Proc_Out\',regexprep(dirlist(i).name,'.csv','.mat')];
    
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