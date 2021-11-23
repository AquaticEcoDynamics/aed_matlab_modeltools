function cell_depths = calc_cell_depths(cell_depths,layerface,NL)
int = 1;
all_cells = 1;
for i = 1:length(NL)
    num_cells = NL(i);
    for k = 1:num_cells
        cell_depths(all_cells,:) = (layerface(int,:) + layerface(int+1,:)) / 2;
        int = int + 1;
        all_cells = all_cells + 1;
    end
    int = int + 1;
   
end
