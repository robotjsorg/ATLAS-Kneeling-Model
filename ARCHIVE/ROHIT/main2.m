% init statements

% dh table
% symbolic transforms and jacobians except values for q
% tranforms and jacobians for right knee, right toe, left arm, right arm, pelvis

% COM data for all
% Moment of  Inertia data for all

% initial and final config
% plot whole body

% update transformations with inital position values
% generate path of q values to end position

Curr_joints = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] ; 
%should there be a function from generate path to get this

Init_joints = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] ;
Final_joints = [0,-90,90,0,0,0,0,0,0,90,-90,0,0,0,0,0,-90,0,90,0] ;


    [T_frame,Tframe_larm,Tframe_rarm] = gettransform() ;
for i=1:15
    T = T_frame{i}
end

for i =1:6
    T = Tframe_larm{i}
end
for i =1:6
    T = Tframe_rarm{i}
end

