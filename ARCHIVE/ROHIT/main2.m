% this is test funtion for gettransform.m

% tranforms and jacobians for right knee, right toe, left arm, right arm, pelvis
%

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

