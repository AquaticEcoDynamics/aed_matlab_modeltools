clear all; close all;

file2dm = 'Woods_v2.2dm';
% Height interval for the final calculation
Height_int = 0.1; %(in m)
% Cell size for the interpolated grid
cell_x = 20; %(in m)
cell_y = 20; %(in m)

% Clips out cells from the inpterolated grid that are too far from the
% closest X,Y.
cell_clip_distance = 2*cell_x;


%__ Import the xyz info.

fid = fopen(file2dm,'rt');

inc = 1;
X = [];
Y = [];
Z = [];

while ~feof(fid)
    sLine = fgetl(fid);
    
    sptLine = strsplit(sLine,' ');
    
    if strcmpi(sptLine{1},'ND') == 1
        X(inc,1) = str2num(sptLine{3});
        Y(inc,1) = str2num(sptLine{4});
        Z(inc,1) = str2num(sptLine{5});
        inc = inc + 1;
    end
end

fclose(fid);

% Creating 20m grid cells.
X_array = [min(X):cell_x:max(X)];
Y_array = [min(Y):cell_y:max(Y)];

[XX,YY] = meshgrid(X_array,Y_array);

F = scatteredInterpolant(X,Y,Z,'linear','none');

ZZ = F(XX,YY);



%_ Clip the exterior

pnt(:,1) = XX(:);
pnt(:,2) = YY(:);


dtri = DelaunayTri(X,Y);

pt_id = nearestNeighbor(dtri,pnt);

for i = 1:length(pt_id)
    
    dist = sqrt((XX(i)-X(pt_id(i))) .^2 + (YY(i) - Y(pt_id(i))).^2);
    
    if abs(dist) > cell_clip_distance
        ZZ(i) = NaN;
    end
end

pcolor(XX,YY,ZZ);shading flat
hold on;
scatter(X,Y,'.k');
scatter(XX(i),YY(i),'r');

save bathy.mat XX YY ZZ -mat;

%_ Now for the bathy calculation

A= [];
H = [];
V = [];

min_H = min(min(ZZ));
max_H = max(max(ZZ));

H_array = 16:Height_int:18;

for i = 1:length(H_array)
    
    sss = find(ZZ <= H_array(i));
    A(i) = 0;
    H(i) = H_array(i);
    V(i) = 0;
    
    if ~isempty(sss)
        
        for j = 1:length(sss)
            
            
            cell_depth = H_array(i) - ZZ(sss(j));
            cell_area = cell_x*cell_y;
            cell_vol = cell_depth * cell_area;
            
            A(i) = A(i) + cell_area;
            V(i) = V(i) + cell_vol;
            
        end
    end
end

figure
plot(H,A);

fid = fopen('HAV.txt','wt');

fprintf(fid,'A = ');

for i = 1:length(A)
    fprintf(fid,'%d,',A(i));
end
fprintf(fid,'\n');
fprintf(fid,'H = ');

for i = 1:length(H)
    fprintf(fid,'%4.4f,',H(i));
end
fprintf(fid,'\n');

fprintf(fid,'V = ');

for i = 1:length(V)
    fprintf(fid,'%d,',V(i));
end
fprintf(fid,'\n');


fprintf(fid,'base_elev  = %4.4f,\n',H(1));
fprintf(fid,'crest_elev = %4.4f,\n',H(end));
fprintf(fid,'bsn_len    = %4.4f,\n',abs(max(Y) - min(Y)));
fprintf(fid,'bsn_wid    = %4.4f,\n',abs(max(X) - min(X)));
fprintf(fid,'bsn_vals   = %d,\n',length(H));

fclose(fid);



            
            
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
    
    
    
    
    














