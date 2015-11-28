function[] = Positions()
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;
    
    for i = 1:length(LFootRFoot)
        LFootRFoot(i).position = LFootRFoot(i).base(1:3,4) - LFootRFoot(6).base(1:3,4);
    end

    for i = 1:length(PelvisTorso)
        PelvisTorso(i).position = PelvisTorso(i).base(1:3,4) - LFootRFoot(6).base(1:3,4);
    end

    for i = 1:length(TorsoLArm)
        TorsoLArm(i).position = TorsoLArm(i).base(1:3,4) - LFootRFoot(6).base(1:3,4);
    end
    
    for i = 1:length(TorsoRArm)
        TorsoRArm(i).position = TorsoRArm(i).base(1:3,4) - LFootRFoot(6).base(1:3,4);
    end
end