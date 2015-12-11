function[] = Kinematics()
    global q;
    global data;
    global C;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;

    Data();
    ForwardKinematics();
    Positions();
    % LinkCoM();
    % CoM();
end