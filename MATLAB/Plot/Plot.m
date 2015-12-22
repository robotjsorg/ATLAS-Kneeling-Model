function[] = Plot()
    global q;
    global data;
    global C;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;

    Kinematics();

    PlotATLAS();

% Trying to get 3D STL files working
%    PlotATLAS_3D();
end