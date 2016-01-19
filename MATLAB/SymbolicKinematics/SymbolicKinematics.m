function[] = SymbolicKinematics()
    global q;
    global data;
    global C;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;

    Data();
    SymbolicForwardKinematics();
    Positions();
    LinkCoM();
end