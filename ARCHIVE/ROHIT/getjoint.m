 function [T1,T2,T3] = getjoint(Curr_joints) 

 % This funnction return three cells where T1 has all transformations from
 % left toe to right toe. T2 has all transformaations from pelvis to left
 % arm annd T3 has all transformations from pelis to right arm. All the
 % transformations are numerical. The cell contain a series 4x4
 % transformation matrices which are of datatype double. These will be much
 % easier to handle than symbolic for fast calculations.
 %
% Setting up values for DH parameters for references
q1 = Curr_joints(1); q2 = Curr_joints(2); q3 = Curr_joints(3);q4 = Curr_joints(4);q5 = Curr_joints(5);
q6 = Curr_joints(6); q7 = Curr_joints(7); q8 = Curr_joints(8);q9 = Curr_joints(9);q10 = Curr_joints(10);
q11 = Curr_joints(11); q12 = Curr_joints(12);q13 = Curr_joints(13);q14 = Curr_joints(14);q15 = Curr_joints(15);
q16 = Curr_joints(16); q17 = Curr_joints(17);q18 = Curr_joints(18);q19 = Curr_joints(19);q20 = Curr_joints(20);

d1 = .422
d2 = sqrt(.05^2+.374^2)
tq2 = atan(.05/.374)
d3 = 0.0225
d4 = sqrt(.066^2+.05^2)
tq4 = tq2+pi/2-atan(.066/.05)
tq3 = pi/2-atan(0.066/.05)
d5 = 0.089
d6 = 0.05
d7 = sqrt(.066^2+.0225^2)
tq6 = pi/2-atan(.0225/0.066)
d8 = d2
tq8 = tq2

%DH parameters for legs
d = [0,0,0,-d3,...
     0,0,0,0,...
     0,d6,0,0,...
     0,0,0];
theta = [q1,q2,q3+tq2,q4-tq4,...%1-4
        tq3,q5-pi/2,q6,q7,...%5-8
        q8,q9+tq6,pi/2-tq6,q10+tq8,...%9-12 
        q11-tq8,q12,q13];%13-15
a = [0,d1,d2,d4,...
     0,0,-d5,-d5,...
     0,-d7,0,-d8,...
     -d1,0,0];
alpha = [pi/2,0,0,0,...
         -pi/2,-pi/2,0,0,...
         pi/2,0,pi/2,0,...
         0,-pi/2,0];

% Matrix for left toe
T_base = [1,0,0,0;
          0,1,0,0;
          0,0,1,0;
          0,0,0,1] ;
      
% Transform till right toe
T_prev = T_base ;

%DH Table
DHpars = vpa([d;theta;a;alpha],3) ;
for i = 1:length(d)
    Trans          = dhtransform(DHpars(:,i));       %Generate transform from DHparams
    Temp           = vpa(T_prev*Trans,3);            %base to current frame transform
    T_prev         = Temp;
    Tbase_to_frame{i} = double(Temp) ;
    if(i == 7)
        Tpelvis = double(Temp) ;
    end
end

    T1 = Tbase_to_frame ;

% Intermediate Transformation matrix at Pelvis
iRz = [cosd(90) -sind(90) 0 0; sind(90) cosd(90) 0 0; 0 0 1 0; 0 0 0 1] ;
iTz = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1] ;
iTx = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1] ; 
iRx = [1 0 0 0; 0 cosd(0) -sind(0) 0; 0 sind(0) cosd(0) 0;0 0 0 1];

%-0.862 ,loc_t(2,:)+ 0.115

T_inter = iRz*iTz*iTx*iRx;
   
    %DH parameters for left arm
    d_l     = [0.162,0,0.1406,0,-0.245,0];
    theta_l = [q14,pi/2+q15,q16,pi/2,q19,q20+pi];
    a_l     = [-0.0125,0,-0.5276,0.2256,0.11,-0.605762];
    alpha_l = [-pi/2,pi/2,0,-pi/2,pi/2,0]; 

    T_prev = [1,0,0,0;0,1,0,0;0,0,1,0;0,0,0,1] ;

    DHpars_l = vpa([d_l;theta_l;a_l;alpha_l],3) ;
    for i = 1:length(d_l)
        Trans          = dhtransform(DHpars_l(:,i));              %Generate transform from DHparams
        Temp           = vpa(T_prev*Trans,3);                %base to current frame transform
        T_prev         = Temp;
        Tbase_to_frame_l{i} = Tpelvis*T_inter*double(Temp);
    end
    
    T2 = Tbase_to_frame_l;

    % DH Parameters for right arm

    d_r     = [0.162,0,0.1406,0,-0.245,0];
    theta_r = [q14,pi/2+q15,q16,pi/2,q17,q18];
    a_r     = [-0.0125,0,-0.5276,-0.2256,-0.11,-0.605762];
    alpha_r = [-pi/2,pi/2,0,-pi/2,pi/2,0];
    
    T_prev = [1,0,0,0;0,1,0,0;0,0,1,0;0,0,0,1] ;

    DHpars_r = vpa([d_r;theta_r;a_r;alpha_r],3) ;
    for i = 1:length(d_r)
        Trans          = dhtransform(DHpars_r(:,i));              %Generate transform from DHparams
        Temp           = vpa(T_prev*Trans,3);                %base to current frame transform
        T_prev         = Temp;
        Tbase_to_frame_r{i} = Tpelvis*T_inter*double(Temp);
    end
    T3 = Tbase_to_frame_r ;


% IGNORE THIS FOR A WHILE
%
% Tbase_pelvis = vpa(Tbase_to_frame(7),3)
% Tbase_rknee = vpa(Tbase_to_frame(12),3)
% Tbase_rtoe = vpa(Tbase_to_frame(14),3)
% 
% Tbase_l_arm = vpa(Tbase_to_frame_l{5},3) ;
% Tbase_r_arm = vpa(Tbase_to_frame_r{5},3) ;