function[] = Kinematics()
    global q;
    global data;
    global C;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;
    global MinPolyOutline;

    Data();
    ForwardKinematics();
    Positions();
    LinkCoM();
    CoM();
    MinPolygon();
end