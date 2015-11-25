addpath('R:\ATLAS-Kneeling-Model\MATLAB\Kinematics');
addpath('R:\ATLAS-Kneeling-Model\MATLAB\3DPlot');

global q;
global LFootRFoot;
global PelvisLArm;
global PelvisRArm;

run('q1.m');
% run('Data.m');

LFootRFoot = struct;
PelvisLArm = struct;
PelvisRArm = struct;

PositionKinematics( q );
Positions();

% LinkCentersofMasses = LinkCentersofMasses( Positions );
% CenterofMass = CenterofMass( LinkCentersofMasses );
% MinimumFootprintPolygon = MinimumFootprintPolygon( Positions );

PlotATLAS();
% PlotCenterofMass( LinkCentersofMasses );
% PlotMinimumFootprintPolygon( MinimumFootprintPolygon );