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


for i=1:15
    Tleft_frame{i} = getjoint(Curr_joints,1,i) ;
end

for i =1:5
    Tleft_frame_larm{i} = getjoint(Curr_joints,2,i) ;
end


for i =1:5
    Tleft_frame_rarm{i} = getjoint(Curr_joints,3,i) ;
end