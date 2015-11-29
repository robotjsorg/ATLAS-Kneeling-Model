addpath('R:\ATLAS Kneeling Model\MATLAB\Kinematics');
addpath('R:\ATLAS Kneeling Model\MATLAB\Dynamics');

global q;
global LFootRFoot;
global PelvisRArm;
global UTorsoLArm;

run('q1.m');
% run('Data.m');

LFootRFoot = struct;
PelvisRArm = struct;
UTorsoLArm = struct;

TimeIncrement = 1;

PositionKinematics( q );
Positions;
LinkCentersofMasses();
AngularVelocities();
AngularAccelerations();
ForwardRecursion();
Radii();
BackwardRecursion();
Torques();
Pressure();