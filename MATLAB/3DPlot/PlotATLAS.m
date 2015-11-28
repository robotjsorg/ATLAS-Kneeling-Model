function[] = PlotATLAS()
    global q;

    points = updatePoints();

    Atlasfig = figure(1);
    Atlasplot.output = line( points(3,:), -points(2,:), points(1,:), 'LineWidth', 2 );
    set( Atlasplot.output, 'Marker', 'o' );

    figPos = [0 0 1000 500];
    set( Atlasfig, 'position', figPos );

    plotPos = [.1 .1 .4 .8];
    set( gca, 'position', plotPos );

    xlim([-1 2]); ylim([-1 2]); zlim([-1 2]);
    xlabel('X'); ylabel('Y'); zlabel('Z');
    grid on;

    % min = [ -25 -52 0   -30 -92 -45 -45 -45 -45 -45 -45 -45 -45 -45 -45 -45 -45 -45 -45 -45 ];
    % max = [  25  28 135  30  37  10  45  45  45  45  45  45  45  45  45  45  45  45  45  45 ];

    numberOfJoints = length(q);
    for i = 1:numberOfJoints
        sliderPos = [ .6*figPos(3)  i*20+.1*figPos(4) 250 20 ];
        textPos =   [ .9*figPos(3)  i*20+.1*figPos(4) 50  20 ];
        valPos =    [ .85*figPos(3) i*20+.1*figPos(4) 50  20 ];
        h = uicontrol( 'style', 'slider', 'position', sliderPos, 'min', 0, 'max', 30, 'SliderStep', [1/360,1/360], 'Value', q(i) );
        t = uicontrol( 'style', 'text', 'position', textPos );
        Atlasplot.val{i} = uicontrol( 'style', 'text', 'position', valPos );
        set( t, 'string', strcat( 'joint q', num2str(i) ) );
        set( Atlasplot.val{i}, 'string', q(i) );
        eventName = strcat( 'object_', num2str(i) );
        Atlasplot.slideListener = addlistener( h, 'ContinuousValueChange', @(eventName, event) updatePlot( i, Atlasplot.val{i}, eventName, Atlasplot ) );
    end
end

% Update the 3D Plot.
function[] = updatePlot( i, text, eventName, Atlasplot )
    global q;

    newq = get(eventName,'Value');
    q(i) = newq*pi/180;

    PositionKinematics();
    Positions();

    points = updatePoints();

    set(text,'string',num2str(newq));
    set(Atlasplot.output,'xdata',points(3,:));
    set(Atlasplot.output,'ydata',-points(2,:));
    set(Atlasplot.output,'zdata',points(1,:));
    drawnow;
end

% Update the points
function[ points ] = updatePoints()
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;

    numberOfJoints = length(LFootRFoot);
    points1 = zeros(3, numberOfJoints);
    for i = 1:numberOfJoints
        points1(:,i) = LFootRFoot(i).position;
    end
    
    numberOfJoints = length(PelvisTorso);
    points2 = zeros(3, numberOfJoints);
    for i = 1:numberOfJoints
        points2(:,i) = PelvisTorso(i).position;
    end
    
    numberOfJoints = length(TorsoLArm);
    points3 = zeros(3, numberOfJoints);
    for i = 1:numberOfJoints
        points3(:,i) = TorsoLArm(i).position;
    end
    
    numberOfJoints = length(TorsoRArm);
    points4 = zeros(3, numberOfJoints);
    for i = 1:numberOfJoints
        points4(:,i) = TorsoRArm(i).position;
    end
    
    points = [ points1 points2 points3 points4 ];
end