function create_random_fishballs

addpath(genpath('functions'));

[~,~,~,~,~,X,Y,Z,ID] = tfv_get_node_from_2dm('../GEO/RM_Wetlands_v1_MZ_Wetland.2dm');

% 15 minute intervals for 3 days

datearray = datenum(2009,01,01,00,00,00):15/(60*24):datenum(2009,01,03,00,00,00);

rand_array(1:length(datearray),1) = NaN;

for i = 1:length(datearray)
    [s,ind] = datasample(ID,1);
    
    if Z(ind) > 1
        islow = 0;
        while ~islow
            [s,ind] = datasample(ID,1);
            if Z(ind) < 1
                islow = 1;
            end
        end
    end
    
    rand_array(i,1) = s;
    
end 

outdir = 'PTM/';

if ~exist(outdir,'dir')
    mkdir(outdir);
end




% BC file creation
for i = 1:length(rand_array)
    disp(num2str(i));
    
    fileID = [outdir,'f',num2str(i),'.csv'];
    
    xarray(1,1) = datearray(i) - 1000;
    xarray(2,1) = datearray(i) - (10/(60*24));
    xarray(3,1) = datearray(i);%
    xarray(4,1) = datearray(i) + (10/(60*24));
    xarray(5,1) = datearray(i) + 1000;
    
    yarray = [0 0 1 0 0];
    
    fid = fopen(fileID,'wt');
    
    fprintf(fid,'ISOTime,fb\n');

    for j = 1:length(xarray)
        fprintf(fid,'%s,%i\n',datestr(xarray(j),'dd/mm/yyyy HH:MM:SS'),yarray(j));
    end
    fclose(fid);
end

% Include file creation.

fid = fopen('PTMinclude_RM.fvptm','wt');


fprintf(fid,'!TIME COMMANDS\n');
fprintf(fid,'!_________________________________________________________________\n');

fprintf(fid,'lagrangian timestep == 60.0   ! seconds\n');
fprintf(fid,'eulerian timestep == 60.0     ! seconds\n');

fprintf(fid,'!PARTICLE GROUP COMMANDS\n');
fprintf(fid,'!_________________________________________________________________\n');

fprintf(fid,'Nscalar == 1\n');

fprintf(fid,'group == fb\n');
fprintf(fid,'!initial scalar mass == 1.0\n');
  fprintf(fid,'initial scalar mass == 0.2\n');
  fprintf(fid,'settling model == none \n');
  fprintf(fid,'settling parameters == 0.00\n');
  fprintf(fid,'horizontal dispersion model == constant\n');
  fprintf(fid,'horizontal dispersion parameters == 1.0\n');
  fprintf(fid,'vertical dispersion model == none!HD model \n');
  fprintf(fid,'vertical dispersion parameters == 1.0\n');
  fprintf(fid,'erosion model == none \n');
  fprintf(fid,'erosion parameters == 0.02, 0.2, 1.0\n');
  fprintf(fid,'deposition model == none \n');
  fprintf(fid,'deposition parameters == 0.2\n');
fprintf(fid,'end group\n');


fprintf(fid,'!MATERIAL SPECS COMMANDS\n');
fprintf(fid,'!_________________________________________________________________\n');

fprintf(fid,'material == 1\n');
  fprintf(fid,'ks == 0.001\n');
  fprintf(fid,'Nlayer == 1\n');
  fprintf(fid,'layer == 1\n');
    fprintf(fid,'rhodry == 800.\n');
  fprintf(fid,'end layer\n');
fprintf(fid,'end material\n');

fprintf(fid,'!INITIAL CONDITION COMMANDS\n');
fprintf(fid,'!_________________________________________________________________\n');
fprintf(fid,'!restart file == ../input/log/corner_ptm_005_ptm.rst\n');

fprintf(fid,'!BOUNDARY CONDITION COMMANDS\n');
fprintf(fid,'!_________________________________________________________________\n');






% Actual code...............




for i = 1:length(rand_array)
    filename = ['PTM\f',num2str(i),'.csv'];
    fprintf(fid,'\n');
    fprintf(fid,'bc == ptm_source, %8.4f,%8.4f,0. , %s\n',X(rand_array(i)),Y(rand_array(i)),filename);
    fprintf(fid,'bc groups == fb\n');
    fprintf(fid,'bc header == ISOTime,fb\n');
    fprintf(fid,'end bc\n');
    fprintf(fid,'\n');
end

fprintf(fid,'output dir == ../Output_PTM/ \n');

fprintf(fid,'output == ptm_netcdf \n');
  fprintf(fid,'output groups == fb \n');
  fprintf(fid,'output interval == 300 \n');
  fprintf(fid,'output compression == 1 \n');
fprintf(fid,'end output \n');











fclose(fid);

end

function [XX,YY,ZZ,nodeID,faces,X,Y,Z,ID,MAT,A] = tfv_get_node_from_2dm(filename)


fid = fopen(filename,'rt');

fline = fgetl(fid);
fline = fgetl(fid);
fline = fgetl(fid);
fline = fgetl(fid);


str = strsplit(fline);

inc = 1;

switch str{1}
    case 'E4Q'
        for ii = 1:4
            faces(ii,inc) = str2double(str{ii + 2});
        end
    case 'E3T'
        for ii = 1:3
            faces(ii,inc) = str2double(str{ii + 2});
        end
        faces(4,inc) = str2double(str{3});
    otherwise
end

MAT(inc) = str2double(str{end});

inc = inc + 1;
fline = fgetl(fid);
str = strsplit(fline);
while strcmpi(str{1},'ND') == 0
    switch str{1}
        case 'E4Q'
            for ii = 1:4
                faces(ii,inc) = str2double(str{ii + 2});
            end
        case 'E3T'
            for ii = 1:3
                faces(ii,inc) = str2double(str{ii + 2});
            end
            faces(4,inc) = str2double(str{3});
        otherwise
    end
    MAT(inc) = str2double(str{end});
    
    inc = inc + 1;
    fline = fgetl(fid);
    str = strsplit(fline);
    
end

inc = 1;

nodeID(inc,1) = str2double(str{2});
XX(inc,1) = str2double(str{3});
YY(inc,1) = str2double(str{4});
ZZ(inc,1) = str2double(str{5});
inc = 2;
fline = fgetl(fid);
str = strsplit(fline);

while strcmpi(str{1},'ND') == 1
    nodeID(inc,1) = str2double(str{2});
    XX(inc,1) = str2double(str{3});
    YY(inc,1) = str2double(str{4});
    ZZ(inc,1) = str2double(str{5});

    inc = inc + 1;
    fline = fgetl(fid);
    str = strsplit(fline);
    
end

fclose(fid);

X(1:length(faces),1) = NaN;
Y(1:length(faces),1) = NaN;
ID(1:length(faces),1) = NaN;
Z(1:length(faces),1) = NaN;

for ii = 1:length(faces)
    gg = polygeom(XX(faces(:,ii)),YY(faces(:,ii)));
    
    X(ii) = gg(2);
    Y(ii) = gg(3);
    Z(ii) = mean(ZZ(faces(:,ii)));
    ID(ii) = ii;
    A(ii) = gg(1);
end



end

function [ geom, iner, cpmo ] = polygeom( x, y )
%POLYGEOM Geometry of a planar polygon
%
%   POLYGEOM( X, Y ) returns area, X centroid,
%   Y centroid and perimeter for the planar polygon
%   specified by vertices in vectors X and Y.
%
%   [ GEOM, INER, CPMO ] = POLYGEOM( X, Y ) returns
%   area, centroid, perimeter and area moments of
%   inertia for the polygon.
%   GEOM = [ area   X_cen  Y_cen  perimeter ]
%   INER = [ Ixx    Iyy    Ixy    Iuu    Ivv    Iuv ]
%     u,v are centroidal axes parallel to x,y axes.
%   CPMO = [ I1     ang1   I2     ang2   J ]
%     I1,I2 are centroidal principal moments about axes
%         at angles ang1,ang2.
%     ang1 and ang2 are in radians.
%     J is centroidal polar moment.  J = I1 + I2 = Iuu + Ivv

% H.J. Sommer III - 02.05.14 - tested under MATLAB v5.2
%
% sample data
% x = [ 2.000  0.500  4.830  6.330 ]';
% y = [ 4.000  6.598  9.098  6.500 ]';
% 3x5 test rectangle with long axis at 30 degrees
% area=15, x_cen=3.415, y_cen=6.549, perimeter=16
% Ixx=659.561, Iyy=201.173, Ixy=344.117
% Iuu=16.249, Ivv=26.247, Iuv=8.660
% I1=11.249, ang1=30deg, I2=31.247, ang2=120deg, J=42.496
%
% H.J. Sommer III, Ph.D., Professor of Mechanical Engineering, 337 Leonhard Bldg
% The Pennsylvania State University, University Park, PA  16802
% (814)863-8997  FAX (814)865-9693  hjs1@psu.edu  www.me.psu.edu/sommer/

% begin function POLYGEOM

% check if inputs are same size
if ~isequal( size(x), size(y) ),
    error( 'X and Y must be the same size');
end

% number of vertices
[ x, ns ] = shiftdim( x );
[ y, ns ] = shiftdim( y );
[ n, c ] = size( x );

% temporarily shift data to mean of vertices for improved accuracy
xm = mean(x);
ym = mean(y);
x = x - xm*ones(n,1);
y = y - ym*ones(n,1);

% delta x and delta y
dx = x( [ 2:n 1 ] ) - x;
dy = y( [ 2:n 1 ] ) - y;

% summations for CW boundary integrals
A = sum( y.*dx - x.*dy )/2;
Axc = sum( 6*x.*y.*dx -3*x.*x.*dy +3*y.*dx.*dx +dx.*dx.*dy )/12;
Ayc = sum( 3*y.*y.*dx -6*x.*y.*dy -3*x.*dy.*dy -dx.*dy.*dy )/12;
Ixx = sum( 2*y.*y.*y.*dx -6*x.*y.*y.*dy -6*x.*y.*dy.*dy ...
    -2*x.*dy.*dy.*dy -2*y.*dx.*dy.*dy -dx.*dy.*dy.*dy )/12;
Iyy = sum( 6*x.*x.*y.*dx -2*x.*x.*x.*dy +6*x.*y.*dx.*dx ...
    +2*y.*dx.*dx.*dx +2*x.*dx.*dx.*dy +dx.*dx.*dx.*dy )/12;
Ixy = sum( 6*x.*y.*y.*dx -6*x.*x.*y.*dy +3*y.*y.*dx.*dx ...
    -3*x.*x.*dy.*dy +2*y.*dx.*dx.*dy -2*x.*dx.*dy.*dy )/24;
P = sum( sqrt( dx.*dx +dy.*dy ) );

% check for CCW versus CW boundary
if A < 0,
    A = -A;
    Axc = -Axc;
    Ayc = -Ayc;
    Ixx = -Ixx;
    Iyy = -Iyy;
    Ixy = -Ixy;
end

% centroidal moments
xc = Axc / A;
yc = Ayc / A;
Iuu = Ixx - A*yc*yc;
Ivv = Iyy - A*xc*xc;
Iuv = Ixy - A*xc*yc;
J = Iuu + Ivv;

% replace mean of vertices
x_cen = xc + xm;
y_cen = yc + ym;
Ixx = Iuu + A*y_cen*y_cen;
Iyy = Ivv + A*x_cen*x_cen;
Ixy = Iuv + A*x_cen*y_cen;

% principal moments and orientation
I = [ Iuu  -Iuv ;
    -Iuv   Ivv ];
[ eig_vec, eig_val ] = eig(I);
I1 = eig_val(1,1);
I2 = eig_val(2,2);
ang1 = atan2( eig_vec(2,1), eig_vec(1,1) );
ang2 = atan2( eig_vec(2,2), eig_vec(1,2) );

% return values
geom = [ A  x_cen  y_cen  P ];
iner = [ Ixx  Iyy  Ixy  Iuu  Ivv  Iuv ];
cpmo = [ I1  ang1  I2  ang2  J ];

% end of function POLYGEOM
end


        