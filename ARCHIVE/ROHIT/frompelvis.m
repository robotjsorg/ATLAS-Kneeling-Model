% this function gets transform from pelvis and considers each limb as an end
% effector.
%
% WORK IN PROGRESS

% function [T1,T2,T3,T4] = frompelvis(Ttoetotoe_frame,Tlarm_frame,Trarm_frame)


% IGNORE THIS FOR A WHILE
%
% Tbase_pelvis = vpa(Tbase_to_frame(7),3)
% Tbase_rknee = vpa(Tbase_to_frame(12),3)
% Tbase_rtoe = vpa(Tbase_to_frame(14),3)
% 
% Tbase_l_arm = vpa(Tbase_to_frame_l{5},3) ;
% Tbase_r_arm = vpa(Tbase_to_frame_r{5},3) ;

[T_frame,Tframe_larm,Tframe_rarm] = gettransform() ;
<<<<<<< HEAD

T_init = [1 0 0 0 ; 0 1 0 0 ; 0 0 1 0; 0 0 0 1] ;   % for init

% Intermediate Transformation matrix at Pelvis
iRz = [cosd(90) -sind(90) 0 0; sind(90) cosd(90) 0 0; 0 0 1 0; 0 0 0 1] ;
iTz = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1] ;
iTx = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1] ; 
iRx = [1 0 0 0; 0 cosd(0) -sind(0) 0; 0 sind(0) cosd(0) 0;0 0 0 1];

    T_inter = iRz*iTz*iTx*iRx;

    temp = T_init ;
    for i=1:7
        temp = temp*T_frame{i} ;
        Tpelvis_ltoe = vpa(temp,3) ;
    end

=======

T_init = [1 0 0 0 ; 0 1 0 0 ; 0 0 1 0; 0 0 0 1] ;   % for init

% Intermediate Transformation matrix at Pelvis
iRz = [cosd(90) -sind(90) 0 0; sind(90) cosd(90) 0 0; 0 0 1 0; 0 0 0 1] ;
iTz = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1] ;
iTx = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1] ; 
iRx = [1 0 0 0; 0 cosd(0) -sind(0) 0; 0 sind(0) cosd(0) 0;0 0 0 1];

    T_inter = iRz*iTz*iTx*iRx;

    temp = T_init ;
    for i=1:7
        temp = temp*T_frame{i} ;
        Tpelvis_ltoe = vpa(temp,3) ;
    end

>>>>>>> master
    temp = T_init ;
    for i=8:15
        temp = temp*T_frame{i} ;
        Trtoe_pelvis = vpa(temp,3) ;
    end
    
     temp = T_init*T_inter ;
    for i=1:6
        temp = temp*Tframe_larm{i} ;
        Tlarm_pelvis = vpa(temp,3)
    end
    
    temp = T_init ;
    for i=1:6
        temp = temp*Tframe_rarm{i} ;
        Trarm_pelvis = vpa(temp,3) ;
    end
    
