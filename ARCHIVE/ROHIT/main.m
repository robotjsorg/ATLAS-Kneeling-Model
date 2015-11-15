% This is a test function to check getjoint.m ERIC and THADDEUS, could you
% take a look at the plot and help me where its going wrong. I've used the
% DH tables you guys made. Me and JOE tried debugging it but couldn't find the mistake; somehow something
% pushes the hip joints above instead of below. I'm going to work on
% symbolic functions from pelvis and then to derive jacobians and take a
% break from this.

Init_joints = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] ;
Final_joints = [0,-90,90,0,0,0,0,0,0,90,-90,0,0,0,0,0,-90,0,90,0] ;

Curr_joints = Init_jonts

[Tleft_frame,Tleft_frame_larm,Tleft_frame_rarm] = getjoint(Curr_joints) ;
for i=1:15
    T = Tleft_frame{i}
    loc(:,i) = T(:,4) ;
end

for i =1:6
    T = Tleft_frame_larm{i}
    loc_left(:,i) = T(:,4) ;
end
for i =1:6
    T = Tleft_frame_rarm{i}
    loc_right(:,i) = T(:,4) ;
end
   
loc_t = horzcat(loc,loc_left,loc_right) ;

figure()
scatter3(loc_t(1,:) ,loc_t(2,:), loc_t(3,:), 'filled' ) ;
hold on 
plot3(loc_t(1,:) ,loc_t(2,:), loc_t(3,:)) ;
axis equal