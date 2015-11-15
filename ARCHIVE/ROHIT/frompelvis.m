% this function gets transform from pelvis and considers each limb as an end
% effector.

% WORK IN PROGRESS

function [T1,T2,T3,T4] = frompelvis(Ttoetotoe_frame,Tlarm_frame,Trarm_frame)


% IGNORE THIS FOR A WHILE
%
% Tbase_pelvis = vpa(Tbase_to_frame(7),3)
% Tbase_rknee = vpa(Tbase_to_frame(12),3)
% Tbase_rtoe = vpa(Tbase_to_frame(14),3)
% 
% Tbase_l_arm = vpa(Tbase_to_frame_l{5},3) ;
% Tbase_r_arm = vpa(Tbase_to_frame_r{5},3) ;

Tpelvis = [1 0 0 0 ; 0 1 0 0 ; 0 0 1 0; 0 0 0 1] ;   % for init

for i=1:7
    Tpelvis = Tpelvis*Ttoetotoe{i} ;
end
