function[] = LinkCentersofMasses()
   
    %Import global data struct with joint position data  

    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;

    % Joint Names
    Joint = {'pelvis';'ltorso';'mtorso';'utorso';'lclav';'lscap';'luarm';'llarm';'lufarm';'llfarm';'lhand';'head';'hokuyolink';'rclav';'rscap';'ruarm';'rlarm';'rufarm';'rlfarm';'rhand';'luglut';'llglut';'luleg';'llleg';'ltalus';'lfoot';'ruglut';'rlglut';'ruleg';'rlleg';'rtalus';'rfoot'};

    % Link Mass
    M = [9.609, 2.27, 0.799, 84.609, 4.466, 3.899, 4.386, 3.248, 2.4798, 0.648, 2.6439,...
        1.41991, 0.057664, 4.466, 3.899, 4.386, 3.248, 2.4798, 0.648, 2.6439, 1.959,...
        0.898, 8.204, 4.515, 0.125, 2.41, 1.959, 0.898, 8.204, 4.515, 0.125, 2.41];
    %Masses must be rearranged to fit the way the DH tables are set up.
   
    %%%%%%%%%%%%%%%%%%%

    %LFootToRFoot

    numberOfJoints = length(LFootRFoot) ;
    MassofElements = [M(26),M(25),M(24),M(23),M(22),M(21),M(1),M(27),M(28),M(29),M(30),M(31),M(32)];

    for i = 1:numberOfJoints
    LFootRFoot(i).mass = MassofElements(i) ;
        if i == 1
            LFootRFoot(i).ComPos = LFootRFoot(i).position/2 ;
        else   
            LFootRFoot(i).ComPos = (LFootRFoot(i-1).position + LFootRFoot(i).position)/2 ;
        end
    end


    %%%%%%%%%%%%%%%%%%%

    % PelvisTorso

    numberOfJoints = length(PelvisTorso) ;
    MassofElements = [M(2),M(3),M(4)] ;

    for i = 1:numberOfJoints
        PelvisTorso(i).mass = MassofElements(i) ;
        if i == 1
            PelvisTorso(i).ComPos = (LFootRFoot(6).position + PelvisTorso(i).position)/2;
        else
            PelvisTorso(i).ComPos = (PelvisTorso(i-1).position + PelvisTorso(i).position)/2 ;
        end
    end

    %%%%%%%%%%%%%%%%%%%

    % TOrsoLArm 

    numberOfJoints = length(TorsoLArm);
    MassofElements =  [M(14),M(15)+M(16)+M(17)+M(18)+M(19)+M(20)];

    for i = 1:numberOfJoints
        TorsoLArm(i).mass = MassofElements(i) ;
        if i == 1
            TorsoLArm(i).ComPos = (PelvisTorso(3).position + TorsoLArm(i).position)/2 ;
        else
            TorsoLArm(i).ComPos = (TorsoLArm(i-1).position + TorsoLArm(i).position)/2 ;
        end
    end

    %%%%%%%%%%%%%%%%%%%

    % TorsoRArm 

    numberOfJoints = length(TorsoRArm);
    MassofElements = [M(5),M(6)+M(7)+M(8)+M(9)+M(10)+M(11)];

    for i = 1:numberOfJoints
        TorsoRArm(i).mass = MassofElements(i) ;
        if i == 1
            TorsoRArm(i).ComPos = (PelvisTorso(3).position + TorsoLArm(i).position)/2 ;
        else
            TorsoRArm(i).ComPos = (TorsoRArm(i-1).position + TorsoRArm(i).position)/2 ;
        end
    end

end

