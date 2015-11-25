function[] = Positions()
    global LFootRFoot;
    global PelvisRArm;
    global UTorsoLArm;

    for i = 1:length(LFootRFoot)
        LFootRFoot(i).position = LFootRFoot(i).base(1:3,4);
    end

    for i = 1:length(PelvisRArm)
        PelvisRArm(i).position = PelvisRArm(i).base(1:3,4);
    end

    for i = 1:length(UTorsoLArm)
        UTorsoLArm(i).position = UTorsoLArm(i).base(1:3,4);
    end
end