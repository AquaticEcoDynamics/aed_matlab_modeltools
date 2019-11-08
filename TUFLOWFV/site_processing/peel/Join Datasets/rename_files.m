clear all; close all;

findir = 'Y:\Peel Final Report\Processed_v11_joined\';

dirlist = dir(findir);

for i = 3:length(dirlist)
    
    vars = dir([findir,dirlist(i).name,'/','*.mat']);
    
    disp(dirlist(i).name);
    
  for j = 1:length(vars)
    strchx = strsplit(vars(j).name,'.');    
    
    if strcmpi(strchx{end},'mat') == 1 & ...
            strcmpi(strchx{end-1},'mat') == 1
        
    newname = [findir,dirlist(i).name,'/',strchx{1},'.',strchx{2}];
    
    
    
    movefile([findir,dirlist(i).name,'/',vars(j).name],newname);
    
    end
  end
        
        
end