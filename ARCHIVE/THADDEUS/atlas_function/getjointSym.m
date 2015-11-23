 function [T1,T2,T3] = getjointSym() 

syms q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 q11 q12 q13 q14 q15 q16 q17 q18 q19 q20

d1 = .422;
d2 = sqrt(.05^2+.374^2);
tq2 = atan(.05/.374);
d3 = 0.0225;
d4 = sqrt(.066^2+.05^2);
tq4 = tq2+pi/2-atan(.066/.05);
tq3 = pi/2-atan(0.066/.05);
d5 = 0.089;
d6 = 0.05;
d7 = sqrt(.066^2+.0225^2);
tq6 = pi/2-atan(.0225/0.066);
d8 = d2;
tq8 = tq2;

%DH parameters for legs
d       = [0,0,0,-d3,0,0,0,0,0,d6,0,0,0,0,0];
theta   = [q1,q2,q3+tq2,q4-tq4,tq3,q5-pi/2,q6,q7,q8,q9+tq6,pi/2-tq6,q10+tq8,q11-tq8,q12,q13];
a       = [0,d1,d2,d4,0,0,-d5,-d5,0,-d7,0,-d8,d1,0,0];
alpha   = [pi/2,0,0,0,-pi/2,-pi/2,0,0,pi/2,0,pi/2,0,0,-pi/2,0];

% Matrix for left toe
T_base = [1,0,0,0;
          0,1,0,0;
          0,0,1,0;
          0,0,0,1] ;
      
% Transform till right toe

%For loop to construct each transformation matrix from sequential frames,
%as well as the overall transform from base to tip.
T_prev = T_base ;

%DH Table
DHpars = [d;theta;a;alpha] ;
for i = 1:length(d)
    Trans{i}          = dhtransform(DHpars(:,i));              %Generate transform from DHparams
    Tbase_to_frame{i} = T_prev*Trans{i};                %base to current frame transform
    T_prev            = Tbase_to_frame{i};
    jointPoint(:,i)   = Tbase_to_frame{i}*[0;0;0;1];
end

    T1 = Tbase_to_frame ;
   
Tpelvis = Tbase_to_frame{7} ;

% Intermediate Transformation matrix at Pelvis
iRz = [cosd(90) -sind(90) 0 0; sind(90) cosd(90) 0 0; 0 0 1 0; 0 0 0 1] ;
iTz = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1] ;
iTx = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1] ; 
iRx = [1 0 0 0; 0 cosd(0) -sind(0) 0; 0 sind(0) cosd(0) 0;0 0 0 1];

T_inter = iRz*iTz*iTx*iRx;
   
    %DH parameters for left arm
    d_l     = [0.162,0,0.1406,0,-0.245,0];
    theta_l = [q14,pi/2+q15,q16,pi/2,q19,q20+pi];
    a_l     = [-0.0125,0,-0.5276,0.2256,0.11,-0.605762];
    alpha_l = [-pi/2,pi/2,0,-pi/2,pi/2,0]; 

    T_prev = Tpelvis*T_inter ;

    DHpars_l = [d_l;theta_l;a_l;alpha_l] ;
    for i = 1:length(d_l)
        Trans{i}          = dhtransform(DHpars_l(:,i));              %Generate transform from DHparams
        Tbase_to_frame_l{i} = T_prev*Trans{i};                %base to current frame transform
        T_prev            = Tbase_to_frame_l{i};
        jointPoint(:,i)   = Tbase_to_frame_l{i}*[0;0;0;1];
    end
    
    T2 = Tbase_to_frame_l;

    % DH Parameters for right arm

    d_r     = [0.162,0,0.1406,0,-0.245,0];
    theta_r = [q14,pi/2+q15,q16,pi/2,q17,q18];
    a_r     = [-0.0125,0,-0.5276,-0.2256,-0.11,-0.605762];
    alpha_r = [-pi/2,pi/2,0,-pi/2,pi/2,0];
    T_prev = Tpelvis*T_inter ;

    DHpars_r = [d_r;theta_r;a_r;alpha_r] ;
    for i = 1:length(d_r)
        Trans{i}          = dhtransform(DHpars_r(:,i));              %Generate transform from DHparams
        Tbase_to_frame_r{i} = T_prev*Trans{i};              %base to current frame transform
        T_prev            = Tbase_to_frame_r{i};
        jointPoint(:,i)   = Tbase_to_frame_r{i}*[0;0;0;1];
    end
    T3 = Tbase_to_frame_r ;


%Save the outputs 
save('T1symbolic.mat','T1')
save('T2symbolic.mat','T2')
save('T3symbolic.mat','T3')
    
% IGNORE THIS FOR A WHILE
%
% Tbase_pelvis = (Tbase_to_frame(7),3)
% Tbase_rknee = (Tbase_to_frame(12),3)
% Tbase_rtoe = (Tbase_to_frame(14),3)
% 
% Tbase_l_arm = (Tbase_to_frame_l{5},3) ;
% Tbase_r_arm = (Tbase_to_frame_r{5},3) ;