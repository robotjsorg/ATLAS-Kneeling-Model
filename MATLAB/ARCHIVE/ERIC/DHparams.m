function [ Trans ] = DHparams( params )
%DHparams implements the DH parameters and outputs the transformation
%matrix created by those parameters
% Input - a 4 element vector corresponding to [d, theta, a, alpha]
% Ouptut - the 4x4 homogeneous transformation matrix associated with the
% given DH parameters

% Extract the DH parameters from the input vector
d = params(1);
theta = params(2);
a = params(3);
alpha = params(4);

%Transform for aligning previous x with common normal
Rotz = [cosd(theta), -sind(theta), 0, 0;
        sind(theta), cosd(theta), 0, 0;
        0, 0, 1, 0;
        0, 0, 0, 1];
%Transform for translating along z
Transz = [1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 1, d; 0, 0, 0, 1];
%Transform for translating along x (common normal)
Transx = [1, 0, 0, a; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1];
%Tranform for rotation about x to align previous z with new z axis
Rotx = [1, 0, 0, 0;
        0, cosd(alpha), -sind(alpha), 0;
        0, sind(alpha), cosd(alpha), 0;
        0, 0, 0, 1];
    
%Calculate the net 4x4 homogeneous transformation matrix
Trans = Rotz*Transz*Transx*Rotx;

end

