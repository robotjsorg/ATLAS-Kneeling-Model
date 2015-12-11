function[] = Data()
    global data;
    data = struct;

    % Object Name
    Joint = {'pelvis';'ltorso';'mtorso';'utorso';'lclav';'lscap';'luarm';'llarm';'lufarm';'llfarm';'lhand';'head';'hokuyolink';'rclav';'rscap';'ruarm';'rlarm';'rufarm';'rlfarm';'rhand';'luglut';'llglut';'luleg';'llleg';'ltalus';'lfoot';'ruglut';'rlglut';'ruleg';'rlleg';'rtalus';'rfoot'};

    % Coordinates
    X = [0;-0.0125000000000000;-0.0125000000000000;-0.0126500000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.242100000000000;0.197500000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0;0;0.0500000000000000;0;0;0;0;0;0.0500000000000000;0;0;0];
    Y = [0;0;0;0;0.225600000000000;0.335600000000000;0.522600000000000;0.641600000000000;0.941150000000000;0.941150000000000;0.941150000000000;0;0;-0.225600000000000;-0.335600000000000;-0.522600000000000;-0.641600000000000;-0.641600000000000;-0.941150000000000;-0.941150000000000;0.0890000000000000;0.0890000000000000;0.111500000000000;0.111500000000000;0.111500000000000;0.111500000000000;-0.0890000000000000;-0.0890000000000000;-0.115000000000000;-0.111500000000000;-0.111500000000000;-0.111500000000000];
    Z = [0;0.162000000000000;0.162000000000000;0.212000000000000;0.689600000000000;0.444600000000000;0.428600000000000;0.437800000000000;0.428590000000000;0.428590000000000;0.428590000000000;0.833500000000000;0.921500000000000;0.689600000000000;0.444600000000000;0.428600000000000;0.437800000000000;0.437800000000000;0.428590000000000;0.428590000000000;0;0;-0.0660000000000000;-0.440000000000000;-0.862000000000000;-0.862000000000000;0;0;-0.0660000000000000;-0.440000000000000;-0.862000000000000;-0.862000000000000];

    % Mass
    M = [9.609,2.27,0.799,84.609,4.466,3.899,4.386,3.248,2.4798,0.648,2.6439,...
        1.41991,0.057664,4.466,3.899,4.386,3.248,2.4798,0.648,2.6439,1.959,...
        0.898,8.204,4.515,0.125,2.41,1.959,0.898,8.204,4.515,0.125,2.41];

    % Inertia
    ixx = [0.125568,0.0039092,0.000454181,1.62389,0.011,0.00319,0.00656,...
        0.00265,0.012731,0.000764,0.00411285,0.00397627,3.8183*10^(-5),...
        0.011,0.00319,0.00656,0.00265,0.012731,0.000764,0.00411285,0.00074276,...
        0.000691326,0.09,0.077,1.01674*10^(-5),0.002,0.00074276,0.000691326,...
        0.09,0.077,1.01674*10^(-5),0.002];
    ixy = [0.0008,-5.04491*10^(-08),-6.10764*10^(-5),-0.0319003,0,0,0,0,0,0,...
        -4.32806*10^(-5),-1.51324*10^(-6),4.9927*10^(-8),0,0,0,0,0,0,...
        3.03191*10^(-5),-3.79607*10^(-8),-2.24344*10^(-5),0,0,0,0,3.79607*10^(-8),...
        2.24344*10^(-5),0,0,0,0];
    ixz = [-0.000500733,-0.000342157,3.94009*10^(-5),0.0816618,0,0,0,0,0,0,...
        5.42465*10^(-9),-0.000892818,1.1003*10^(-5),0,0,0,0,0,0,2.42285*10^(-9),...
        -2.79549*10^(-5),-2.50508*10^(-6),0,-0.003,0,0,-2.79549*10^(-5),...
        2.50508*10^(-6),0,-0.003,0,0];
    iyy = [0.0972042,0.00341694,0.000483282,1.65538,0.009,0.00583,0.00358,...
        0.00446,0.002857,0.000429,0.000692818,0.00412515,4.3437*10^(-5),...
        0.009,0.00583,0.00358,0.00446,0.002857,0.000429,0.000692689,0.000688179,...
        0.00126856,0.09,0.076,8.42775*10^(-6),0.007,0.000688179,0.00126856,...
        0.09,0.076,8.42775*10^(-6),0.007];
    iyz = [-0.0005,4.87119*10^(-7),5.27463*10^(-5),0.0472154,-0.004,0,0,0,0,0,...
        8.10108*10^(-7),-6.83342*10^(-7),-9.8165*10^(-9),0.004,0,0,0,0,0,...
        -8.10011*10^(-7),-3.2735*10^(-8),0.000137862,0,0,0,0,3.2735*10^(-8),...
        -0.000137862,0,0,0,0];
    izz = [0.117936,0.00174492,0.000444215,0.577362,0.004,0.00583,0.00656,...
        0.00446,0.011948,0.000825,0.00417599,0.00353178,4.2686*10^(-5),...
        0,004,0.00583,0.00656,0.00446,0.011948,0.000825,0.00417586,0.00041242,...
        0.00106487,0.02,0.01,1.30101*10^(-5),0.008,0.00041242,0.00106487,...
        0.02,0.01,1.30101*10^(-5),0.008];

    % Populate data structure.
    for i = 1:length(Joint)
        data(i).name = Joint{i};
        data(i).m = M(i);
        data(i).ixx = ixx(i);
        data(i).ixy = ixy(i);
        data(i).ixz = ixz(i);
        data(i).iyy = iyy(i);
        data(i).iyz = iyz(i);
        data(i).izz = izz(i);
    end

    % Geometries

    % pelvis - cylinder - length 0.06, radius 0.11
    % ltorso
    % mtorso - cylinder - length 0.15, radius 0.02
    % utorso - box 0.4, 0.35, 0.5
    % l_clav - cylinder - length 0.1525, radius 0.0555
    % l_scap - cylinder - length 0.105, radius 0.057
    % l_uarm - cylinder - length 0.11, radius 0.065
    % l_larm - cylinder - length 0.04, radius 0.051
    % l_ufarm - cylinder - length 0.1, radius 0.053
    % l_lfarm - cylinder - length 0.02, radius 0.031
    % l_hand - box 0.13, 0.17,0.13
    % head - box 0.1311, 0.12, 0.0591
    % hokuyo_link - box 0.08, 0.06, 0.04238
    % r_clav - cylinder - length 0.1525, radius 0.0555
    % r_scap - cylinder - length 0.105, radius 0.057
    % r_uarm - cylinder - length 0.11, radius 0.065
    % r_larm - cylinder - length 0.04, radius 0.051
    % r_ufarm - cylinder - length 0.1, radius 0.053
    % r_lfarm - cylinder - length 0.02, radius 0.031
    % r_hand - box 0.13, 0.17, 0.13
    % l_uglut - box 0.05, 0.1, 0.1
    % l_lglut - box 0.125, 0.05, 0.08
    % l_uleg - cylinder - length 0.15, radius 0.09
    % l_lleg - cylinder - length 0.4, radius 0.07
    % l_talus - cylinder - length 0.029542, radius 0.010181
    % l_foot - box 0.227, 0.133887, 0.05
    % r_uglut - box 0.05, 0.1, 0.1
    % r_lglut - box 0.125, 0.05, 0.08
    % r_uleg - cylinder - length 0.15, radius 0.09
    % r_lleg - cylinder - length 0.4, radius 0.07
    % r_talus - cylinder - length 0.029542, radius 0.010181
    % r_foot - box 0.227, 0.133887, 0.05
end