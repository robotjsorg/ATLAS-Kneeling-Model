function[] = LinkCoM()
    global data;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;

    M = [9.609, 2.27, 0.799, 84.609, 4.466, 3.899, 4.386, 3.248, 2.4798, 0.648, 2.6439,...
        1.41991, 0.057664, 4.466, 3.899, 4.386, 3.248, 2.4798, 0.648, 2.6439, 1.959,...
        0.898, 8.204, 4.515, 0.125, 2.41, 1.959, 0.898, 8.204, 4.515, 0.125, 2.41];

    %LFootToRFoot

    MassofElements = [M(26),M(25),M(24),M(23),M(22),M(21),M(1),M(27),M(28),M(29),M(30),M(31),M(32)];

    LFootRFoot(1).ComPos = LFootRFoot(1).position ;
    LFootRFoot(2).ComPos = LFootRFoot(1).position ;
    LFootRFoot(3).ComPos = (LFootRFoot(1).position + LFootRFoot(2).position)/2;
    LFootRFoot(4).ComPos = (LFootRFoot(2).position + LFootRFoot(3).position)/2;
    LFootRFoot(5).ComPos = (LFootRFoot(3).position + LFootRFoot(4).position)/2;
    LFootRFoot(6).ComPos = (LFootRFoot(5).position + LFootRFoot(6).position)/2;
    LFootRFoot(7).ComPos = LFootRFoot(6).position ;
    LFootRFoot(8).ComPos = (LFootRFoot(6).position + LFootRFoot(7).position)/2;
    LFootRFoot(9).ComPos = (LFootRFoot(8).position + LFootRFoot(9).position)/2;
    LFootRFoot(10).ComPos =(LFootRFoot(9).position + LFootRFoot(10).position)/2;
    LFootRFoot(11).ComPos = (LFootRFoot(10).position + LFootRFoot(11).position)/2;
    LFootRFoot(12).ComPos = LFootRFoot(12).position ;
    LFootRFoot(13).ComPos = LFootRFoot(13).position ;
    
    for i = 1:length(LFootRFoot)
        LFootRFoot(i).mass = MassofElements(i);
        LFootRFoot(i).ComPosX = LFootRFoot(i).ComPos(1,1);
        LFootRFoot(i).ComPosY = LFootRFoot(i).ComPos(2,1);
        LFootRFoot(i).ComPosZ = LFootRFoot(i).ComPos(3,1);
        if ~strcmp(LFootRFoot(i).name,'')
                data(MapJoint(LFootRFoot(i).name)).ComPos = LFootRFoot(i).ComPos;
        end
    end
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
        
        PelvisTorso(i).ComPosX = PelvisTorso(i).ComPos(1,1);
        PelvisTorso(i).ComPosY = PelvisTorso(i).ComPos(2,1);
        PelvisTorso(i).ComPosZ = PelvisTorso(i).ComPos(3,1);
        
        if ~strcmp(PelvisTorso(i).name,'')
                data(MapJoint(PelvisTorso(i).name)).ComPos = PelvisTorso(i).ComPos;
        end
    end

    %%%%%%%%%%%%%%%%%%%

    % TorsoLArm 

    MassofElements =  [M(14),M(15)+M(16)+M(17)+M(18)+M(19)+M(20)];

    for i = 1:length(TorsoLArm)
        TorsoLArm(i).mass = MassofElements(i) ;
        if i == 1
            TorsoLArm(i).ComPos = (data(5).position + TorsoLArm(i).position)/2 ;
        else
            TorsoLArm(i).ComPos = (TorsoLArm(i-1).position + TorsoLArm(i).position)/2 ;
        end
        
        TorsoLArm(i).ComPosX = TorsoLArm(i).ComPos(1,1);
        TorsoLArm(i).ComPosY = TorsoLArm(i).ComPos(2,1);
        TorsoLArm(i).ComPosZ = TorsoLArm(i).ComPos(3,1);
        
         if ~strcmp(TorsoLArm(i).name,'')
                data(MapJoint(TorsoLArm(i).name)).ComPos = TorsoLArm(i).ComPos;
        end
   end

    %%%%%%%%%%%%%%%%%%%

    % TorsoRArm 

    MassofElements = [M(5),M(6)+M(7)+M(8)+M(9)+M(10)+M(11)]; 

    for i = 1:length(TorsoRArm)
        TorsoRArm(i).mass = MassofElements(i) ;
        if i == 1
            TorsoRArm(i).ComPos = (data(14).position + TorsoRArm(i).position)/2 ;
        else
            TorsoRArm(i).ComPos = (TorsoRArm(i-1).position + TorsoRArm(i).position)/2 ;
        end
        
        TorsoRArm(i).ComPosX = TorsoRArm(i).ComPos(1,1);
        TorsoRArm(i).ComPosY = TorsoRArm(i).ComPos(2,1);
        TorsoRArm(i).ComPosZ = TorsoRArm(i).ComPos(3,1);
        
        if ~strcmp(TorsoRArm(i).name,'')
                data(MapJoint(TorsoRArm(i).name)).ComPos = TorsoRArm(i).ComPos;
        end
    end
end