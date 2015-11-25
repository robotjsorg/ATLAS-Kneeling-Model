global q;
global LFootRFoot;
global PelvisLArm;
global PelvisRArm;

addpath('R:\ATLAS-Kneeling-Model\MATLAB\Kinematics');
addpath('R:\ATLAS-Kneeling-Model\MATLAB\3DPlot');
run('q1.m');
run('Data.m');

LFootRFoot = struct;
PelvisRArm = struct;
UTorsoLArm = struct;

PositionKinematics( q );
Positions();

% Name the links in memory by their joints
% {'pelvis';'ltorso';'mtorso';'utorso';'lclav';'lscap';'luarm';'llarm';'lufarm';'llfarm';'lhand';'head';'hokuyolink';'rclav';'rscap';'ruarm';'rlarm';'rufarm';'rlfarm';'rhand';'luglut';'llglut';'luleg';'llleg';'ltalus';'lfoot';'ruglut';'rlglut';'ruleg';'rlleg';'rtalus';'rfoot'};

PlotATLAS();