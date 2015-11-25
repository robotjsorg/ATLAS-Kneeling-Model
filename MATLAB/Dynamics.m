currentFolder = pwd;
addpath(currentFolder + '\Kinematics');
addpath(currentFolder + '\Dynamics');

global q;
global LFootRFoot;
global PelvisLArm;
global PelvisRArm;

run('q1.m');
run('Data.m');

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