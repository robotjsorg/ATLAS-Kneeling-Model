function[] = Positions()
    global LFootRFoot;
    global PelvisLArm;
    global PelvisRArm;

    numberOfJoints = length(LFootRFoot);
    for i = 1:numberOfJoints
        LFootRFoot(i).position = LFootRFoot(i).base(1:3,4);
    end

    numberOfJoints = length(PelvisLArm);
    for i = 1:numberOfJoints
        PelvisLArm(i).position = PelvisLArm(i).base(1:3,4);
    end

    numberOfJoints = length(PelvisRArm);
    for i = 1:numberOfJoints
        PelvisRArm(i).position = PelvisRArm(i).base(1:3,4);
    end
end