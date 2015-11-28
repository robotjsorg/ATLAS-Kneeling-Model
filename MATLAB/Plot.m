addpath('R:\MATLAB\Kinematics');
addpath('R:\MATLAB\3DPlot');

global q;
global LFootRFoot;
global PelvisTorso;
global TorsoLArm;
global TorsoRArm;

run('q1.m');
run('Data.m');

LFootRFoot = struct;
PelvisTorso = struct;
TorsoLArm = struct;
TorsoRArm = struct;

PositionKinematics();
Positions();
LinkCentersofMasses();

PlotATLAS();
PlotCenterofMass();
PlotMinimumFootprintPolygon();