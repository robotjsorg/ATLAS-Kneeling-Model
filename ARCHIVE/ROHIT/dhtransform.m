function [ Trans ] = dhtransform( params )
% DHtrans implements the DH parameters and outputs the transformation
% matrix created by those parameters.
% Input - a 4 element vector corresponding to [d, theta, a, alpha]
% Ouptut - the 4x4 homogeneous transformation matrix associated with the
% given DH parameters. 
% This is a copy of the other DHparams function, with the difference that it
% contains the functions for sin and cos in radians.

% Extract the DH parameters from the input vector
d     = params(1);
theta = params(2);
a     = params(3);
alpha = params(4);

% Transform for aligning previous x with common normal
Rotz = [cos(theta), -sin(theta), 0, 0;
        sin(theta),  cos(theta), 0, 0;
                0,            0, 1, 0;
                0,            0, 0, 1];
            
% Transform for translating along z
Transz = [1, 0, 0, 0; 
          0, 1, 0, 0; 
          0, 0, 1, d; 
          0, 0, 0, 1];
      
% Transform for translating along x (common normal)
Transx = [1, 0, 0, a;
          0, 1, 0, 0;
          0, 0, 1, 0; 
          0, 0, 0, 1];
      
% Tranform for rotation about x to align previous z with new z axis
Rotx = [1,          0,           0, 0;
        0, cos(alpha), -sin(alpha), 0;
        0, sin(alpha),  cos(alpha), 0;
        0,          0,           0, 1];

%Calculate the net 4x4 homogeneous transformation matrix
Trans = simplify(Rotz*Transz*Transx*Rotx));

end

