function[] = Positions()
    global LFootRFoot;
    global PelvisRArm;
    global UTorsoLArm;

    numberOfJoints = length(LFootRFoot);
    for i = 1:numberOfJoints
        LFootRFoot(i).position = LFootRFoot(i).base(1:3,4);
    end

    numberOfJoints = length(PelvisRArm);
    for i = 1:numberOfJoints
        PelvisRArm(i).position = PelvisRArm(i).base(1:3,4);
    end

    numberOfJoints = length(UTorsoLArm);
    for i = 1:numberOfJoints
        UTorsoLArm(i).position = UTorsoLArm(i).base(1:3,4);
    end
end