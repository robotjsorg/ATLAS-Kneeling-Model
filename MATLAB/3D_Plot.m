load('q1.m');
load('Data.m')
load('Kinematics/Position_Kinematics.m');
load('Kinematics/Positions.m');
load('Kinematics/Link_Centers_of_Masses.m');
load('3D_Plot/Center_of_Mass');
load('3D_Plot/Minimum_Footprint_Polygon');
load('3D_Plot/Plot_ATLAS.m');
load('3D_Plot/Plot_Center_of_Mass.m');
load('3D_Plot/Plot_Minimum_Footprint_Polygon.m');

T = Position_Kinematics( q );
Positions = Positions( T );
Link_Centers_of_Masses = Link_Centers_of_Masses( Positions );
Center_of_Mass = Center_of_Mass( Link_Centers_of_Masses );
Minimum_Footprint_Polygon = Minimum_Footprint_Polygon( Positions );

% Put figure code here? Or in Plot_ATLAS file?

Plot_ATLAS( Positions );
Plot_Center_of_Mass( Link_Centers_of_Masses );
Plot_Minimum_Footprint_Polygon( Minimum_Footprint_Polygon );