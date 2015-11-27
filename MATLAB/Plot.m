addpath('R:\ATLAS Kneeling Model\MATLAB\Kinematics');
addpath('R:\ATLAS Kneeling Model\MATLAB\3DPlot');

global q;
global LFootRFoot;
global PelvisLArm;
global PelvisRArm;

run('q1.m');
run('Data.m');

LFootRFoot = struct;
PelvisRArm = struct;
UTorsoLArm = struct;

PositionKinematics( q );
Positions();
LinkCentersofMasses();

PlotATLAS();
PlotCenterOfMass();
PlotMinimumFootprintPolygon();