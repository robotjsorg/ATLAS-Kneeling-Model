load('q1.m');
load('Data.m')
load('Kinematics/Position_Kinematics.m');
load('Kinematics/Positions.m');
load('Kinematics/Link_Centers_of_Masses.m');
load('Dynamics/Angular_Velocities.m');
load('Dynamics/Angular_Accelerations.m');
load('Dynamics/Forward_Recursion.m');
load('Dynamics/Radii.m');
load('Dynamics/Backward_Recursion.m');
load('Dynamics/Torques.m');
load('Dynamics/Pressure.m');

Time_Increment = 1;

T = Position_Kinematics( q );
Positions = Positions( T );
Link_Centers_of_Masses = Link_Centers_of_Masses( Positions );
Angular_Velocities = Angular_Velocities( q(1,:), q(2,:), Time_Increment );
Angular_Accelerations = Angular_Accelerations( q(1,:), q(2,:), Time_Increment );
Forward_Recursion = Forward_Recursion( T, Angular_Velocities, Angular_Accelerations );
Radii = Radii( Link_Centers_of_Masses, Positions );
Backward_Recursion = Backward_Recursion( Forward_Recursion, Radii, Inertia );
Torques = Torques( Backward_Recursion );
Pressure = Pressure( Torques );

display( Torques );
display( Pressure );