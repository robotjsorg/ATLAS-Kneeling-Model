function[ T ] = Position_Kinematics( q )
	T = 0;

    % DH constants
    d1 = .4220;
    d2 = sqrt(0.0500^2+0.3740^2);
    tq2 = atan(0.0500/0.3740);
    d3 = 0.0225;
    d4 = sqrt(0.06600^2+0.0500^2);
    tq4 = tq2+pi/2-atan(0.06600/0.0500);
    tq3 = pi/2-atan(0.06600/0.0500);
    d5 = 0.0890;
    d6 = 0.0500;
    d7 = sqrt(0.066^2+0.02250^2);
    tq6 = pi/2-atan(0.02250/0.0660);
    d8 = d2;
    tq8 = tq2;

    % LFoot to RFoot
    d     = [0,0,0,-d3,0,0,0,0,0,d6,0,0,0,0,0];
    theta = [q(1),q(2),q(3)+tq2,q(4)-tq4,tq3, q(5)-pi/2,q(6),q(7),q(8),q(9)+tq6,pi/2-tq6,q(10)+tq8,q(11)-tq8,q(12),q(13)];
    a     = [0,d1,d2,d4,0,0,-d5,-d5,0,-d7,0,-d8,-d1,0,0];
    alpha = [pi/2,0,0,0,-pi/2,-pi/2,0,0,pi/2,0,pi/2,0,0,-pi/2,0];
    
    % Pelvis to LBack
    iRz     = [cosd(90) -sind(90) 0 0; sind(90) cosd(90) 0 0; 0 0 1 0; 0 0 0 1];
    iTz     = eye(4,4);
    iTx     = eye(4,4); 
    iRx     = [1 0 0 0; 0 cosd(0) -sind(0) 0; 0 sind(0) cosd(0) 0;0 0 0 1];
    T_inter = iRz*iTz*iTx*iRx;

    % Pelvis to LArm
    d_l     = [0.1620,0,0.1406,0,-0.2450,0];
    theta_l = [q(14),pi/2+q(15),q(16),pi/2,q(19),q(20)+pi];
    a_l     = [-0.0125,0,-0.2760,0.2256,0.11,-0.6058];
    alpha_l = [-pi/2,pi/2,0,-pi/2,pi/2,0];
    
    % Pelvis to RArm
    d_r     = [0.1620,0,0.1406,0,-0.2450,0];
    theta_r = [q(14),pi/2+q(15),q(16),pi/2,q(17),q(18)];
    a_r     = [-0.0125,0,-0.5276,-0.2256,-0.1100,-0.6058];
    alpha_r = [-pi/2,pi/2,0,-pi/2,pi/2,0];

    %%%%%%%%%%
    data = struct;

    DHpars = vpa([d;theta;a;alpha],3);
    T_prev = eye(4,4);
    for i = 1:length(d)
        Trans          = DH(DHpars(:,i));
        Temp           = vpa(T_prev*Trans,3);
        T_prev         = Temp;
        Tbase_to_frame = double(Temp);

        if(i == 7)
            Tpelvis = double(Temp);
        end
    end
    T1 = Tbase_to_frame;

    %%%%%%%%%%

    DHpars_l = vpa([d_l;theta_l;a_l;alpha_l],3);
    T_prev = eye(4,4);
    for i = 1:length(d_l)
        Trans            = DH(DHpars_l(:,i));
        Temp             = vpa(T_prev*Trans,3);
        T_prev           = Temp;
        Tbase_to_frame_l = Tpelvis*T_inter*double(Temp);
    end
    T2 = Tbase_to_frame_l;

    %%%%%%%%%%

    DHpars_r = vpa([d_r;theta_r;a_r;alpha_r],3);
    T_prev = eye(4,4);
    for i = 1:length(d_r)
        Trans            = DH(DHpars_r(:,i));
        Temp             = vpa(T_prev*Trans,3);
        T_prev           = Temp;
        Tbase_to_frame_r = Tpelvis*T_inter*double(Temp);
    end
    T3 = Tbase_to_frame_r;
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ T ] = DH( params )
    d     = params(1);
    theta = params(2);
    a     = params(3);
    alpha = params(4);

    Rz = [cos(theta), -sin(theta), 0, 0;
          sin(theta),  cos(theta), 0, 0;
                   0,           0, 1, 0;
                   0,           0, 0, 1];

    Tz = [1, 0, 0, 0; 
          0, 1, 0, 0; 
          0, 0, 1, d; 
          0, 0, 0, 1];

    Tx = [1, 0, 0, a;
          0, 1, 0, 0;
          0, 0, 1, 0; 
          0, 0, 0, 1];

    Rx = [1,          0,           0, 0;
          0, cos(alpha), -sin(alpha), 0;
          0, sin(alpha),  cos(alpha), 0;
          0,          0,           0, 1];

    T = Rz*Tz*Tx*Rx;
end