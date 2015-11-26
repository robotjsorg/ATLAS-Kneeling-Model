function[] = PlotATLAS()
    global q;
    
    points = updatePoints();

    Atlasfig = figure(1);
    Atlasplot.output = line( points(1,:), points(2,:), points(3,:), 'LineWidth', 2 );
    set( Atlasplot.output, 'Marker', 'o' );

    figPos = [0 0 1000 500];
    set( Atlasfig, 'position', figPos );
    plotPos = [.1 .1 .4 .8];
    axisLimits = [-1 2];

    set( gca, 'position', plotPos );
    set( gca, 'xlim', axisLimits );
    set( gca, 'ylim', axisLimits );
    set( gca, 'zlim', axisLimits );

    numberOfJoints = length( points(1,:) ) - 3
    for i = 1:numberOfJoints
        sliderPos = [.6*figPos(3) i*20+.1*figPos(4) 250 20];
        textPos = [.9*figPos(3) i*20+.1*figPos(4) 50 20];
        valPos = [.85*figPos(3) i*20+.1*figPos(4) 50 20];
        h = uicontrol( 'style', 'slider', 'position', sliderPos, 'min', 0, 'max', 360, 'SliderStep', [1/360,1/360], 'Value', q(i) );
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
    q(i) = newq;
    
    PositionKinematics( q );
    Positions();
    
    points = updatePoints();

    set(text,'string',num2str(newq));
    set(Atlasplot.output,'xdata',points(1,:));
    set(Atlasplot.output,'ydata',points(2,:));
    set(Atlasplot.output,'zdata',points(3,:));
    drawnow;
end

% Update the points
function[ points ] = updatePoints()
    global LFootRFoot;
    global PelvisRArm;
    global UTorsoLArm;

    numberOfJoints = length(LFootRFoot);
    points1 = zeros(3, numberOfJoints);
    for i = 1:numberOfJoints
        points1(:,i) = LFootRFoot(i).position;
    end
    
    numberOfJoints = length(PelvisRArm);
    points2 = zeros(3, numberOfJoints);
    for i = 1:numberOfJoints
        points2(:,i) = PelvisRArm(i).position;
    end
    
    numberOfJoints = length(UTorsoLArm);
    points3 = zeros(3, numberOfJoints);
    for i = 1:numberOfJoints
        points3(:,i) = UTorsoLArm(i).position;
    end
    
    points = [ points1 points2 points3 ];
end