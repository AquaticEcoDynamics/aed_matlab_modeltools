clear all; close all;

ncfile(1).name = ['C:\Users\00065525\Scratch/SCERM8_2019_2020_cld_rmv_scl_ALL.nc'];% change this to the nc file loc

data = tfv_readnetcdf(ncfile(1).name,'names',{'layerface_Z';'NL';'SAL';'D'});
[iX,iY] = size(data.SAL);
data.cell_mid(1:iX,1:iY) = NaN;

[cell,tim] = size(data.layerface_Z);
int = 1;
all_cells = 1;
for i = 1:length(data.NL)
    num_cells = data.NL(i);
    for k = 1:num_cells
        data.cell_mid(all_cells,:) = (data.layerface_Z(int,:) + data.layerface_Z(int+1,:)) / 2;
        int = int + 1;
        all_cells = all_cells + 1;
    end
    int = int + 1;
   
end
    