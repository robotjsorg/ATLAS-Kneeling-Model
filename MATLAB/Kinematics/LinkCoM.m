function[] = LinkCoM()
    global data;
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

    MassofElements = [M(26),M(25),M(24),M(23),0,M(22),M(21),M(1),M(27),M(28),0,M(29),M(30),M(31),M(32)];

    for i = 1:length(LFootRFoot)
        LFootRFoot(i).mass = MassofElements(i);
    end

    LFootRFoot(1).ComPos = LFootRFoot(1).position ;
    LFootRFoot(2).ComPos = LFootRFoot(1).position ;
    LFootRFoot(3).ComPos = (LFootRFoot(1).position + LFootRFoot(2).position)/2;
    LFootRFoot(4).ComPos = (LFootRFoot(2).position + LFootRFoot(3).position)/2;
    LFootRFoot(5).ComPos = [0;0;0];
    LFootRFoot(6).ComPos = (LFootRFoot(3).position + LFootRFoot(4).position)/2;
    LFootRFoot(7).ComPos = (LFootRFoot(6).position + LFootRFoot(7).position)/2;
    LFootRFoot(8).ComPos = LFootRFoot(7).position ;
    LFootRFoot(9).ComPos = (LFootRFoot(7).position + LFootRFoot(8).position)/2;
    LFootRFoot(10).ComPos = (LFootRFoot(9).position + LFootRFoot(10).position)/2;
    LFootRFoot(11).ComPos = [0;0;0];
    LFootRFoot(12).ComPos =(LFootRFoot(9).position + LFootRFoot(10).position)/2;
    LFootRFoot(13).ComPos = (LFootRFoot(12).position + LFootRFoot(13).position)/2;
    LFootRFoot(14).ComPos = LFootRFoot(14).position ;
    LFootRFoot(15).ComPos = LFootRFoot(15).position ;


    %%%%%%%%%%%%%%%%%%%

    % PelvisTorso

    MassofElements = [M(2),M(3),M(4)] ;

    for i = 1:length(PelvisTorso);
        PelvisTorso(i).mass = MassofElements(i) ;
        if i == 1
            PelvisTorso(i).ComPos = (LFootRFoot(6).position + PelvisTorso(i).position)/2;
        else
            PelvisTorso(i).ComPos = (PelvisTorso(i-1).position + PelvisTorso(i).position)/2 ;
        end
    end

    %%%%%%%%%%%%%%%%%%%

    % TorsoLArm 

    MassofElements =  [0,M(14),M(15)+M(16)+M(17)+M(18)+M(19)+M(20)];

    for i = 1:length(TorsoLArm)
        TorsoLArm(i).mass = MassofElements(i) ;
        TorsoLArm(i).ComPos = TorsoLArm(i).position;
    end

    %%%%%%%%%%%%%%%%%%%

    % TorsoRArm 

    MassofElements = [0,M(5),M(6)+M(7)+M(8)+M(9)+M(10)+M(11)]; 

    for i = 1:length(TorsoRArm)
        TorsoRArm(i).mass = MassofElements(i) ;
        TorsoRArm(i).ComPos = TorsoRArm(i).position;
    end

end

