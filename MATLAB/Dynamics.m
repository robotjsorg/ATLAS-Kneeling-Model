addpath('R:\ATLAS-Kneeling-Model\MATLAB\Kinematics');
addpath('R:\ATLAS-Kneeling-Model\MATLAB\Dynamics');

run('q1.m');
run('Data.m');

TimeIncrement = 1;

T = PositionKinematics( q );
% Positions = Positions( T );
% LinkCentersofMasses = LinkCentersofMasses( Positions );
% AngularVelocities = AngularVelocities( q(1,:), q(2,:), TimeIncrement );
% AngularAccelerations = AngularAccelerations( q(1,:), q(2,:), TimeIncrement );
% ForwardRecursion = ForwardRecursion( T, AngularVelocities, AngularAccelerations );
% Radii = Radii( LinkCentersofMasses, Positions );
% BackwardRecursion = BackwardRecursion( ForwardRecursion, Radii, Inertia );
% Torques = Torques( BackwardRecursion );
% Pressure = Pressure( Torques );
% 
% display( Torques );
% display( Pressure );