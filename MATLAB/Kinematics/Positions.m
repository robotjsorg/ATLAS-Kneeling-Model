function[] = Positions()
    global data;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;

    for i = 1:length(LFootRFoot)
        LFootRFoot(i).position = LFootRFoot(i).base(1:3,4);% - LFootRFoot(1).base(1:3,4);
        LFootRFoot(i).X = LFootRFoot(i).position(1);
        LFootRFoot(i).Y = LFootRFoot(i).position(2);
        LFootRFoot(i).Z = LFootRFoot(i).position(3);
        data(MapJoint(LFootRFoot(i).name)).position = LFootRFoot(i).position;
    end

    for i = 1:length(PelvisTorso)
        PelvisTorso(i).position = PelvisTorso(i).base(1:3,4);% - LFootRFoot(1).base(1:3,4);
        PelvisTorso(i).X = PelvisTorso(i).position(1);
        PelvisTorso(i).Y = PelvisTorso(i).position(2);
        PelvisTorso(i).Z = PelvisTorso(i).position(3);
        data(MapJoint(PelvisTorso(i).name)).position = PelvisTorso(i).position;
    end

    for i = 1:length(TorsoLArm)
        TorsoLArm(i).position = TorsoLArm(i).base(1:3,4);% - LFootRFoot(1).base(1:3,4);
        TorsoLArm(i).X = TorsoLArm(i).position(1);
        TorsoLArm(i).Y = TorsoLArm(i).position(2);
        TorsoLArm(i).Z = TorsoLArm(i).position(3);
        data(MapJoint(TorsoLArm(i).name)).position = TorsoLArm(i).position;
    end

    for i = 1:length(TorsoRArm)
        TorsoRArm(i).position = TorsoRArm(i).base(1:3,4);% - LFootRFoot(1).base(1:3,4);
        TorsoRArm(i).X = TorsoRArm(i).position(1);
        TorsoRArm(i).Y = TorsoRArm(i).position(2);
        TorsoRArm(i).Z = TorsoRArm(i).position(3);
        data(MapJoint(TorsoRArm(i).name)).position = TorsoRArm(i).position;
    end
end