function[] = PlotATLAS()
    global q;
    global plot1;
    global plot2;
    global plot3;
    global plot4;

    points = updatePoints();

    Atlasfig = figure;
    plot1.output = line( points(1,1:13), points(2,1:13), points(3,1:13), 'LineWidth', 2 );
    plot2.output = line( points(1,[6,14:16]), points(2,[6,14:16]), points(3,[6,14:16]), 'LineWidth', 2 );
    plot3.output = line( points(1,16:18), points(2,16:18), points(3,16:18), 'LineWidth', 2 );
    plot4.output = line( points(1,[16,19:20]), points(2,[16,19:20]), points(3,[16,19:20]), 'LineWidth', 2 );
    set(plot1.output, 'Marker', 'o');
    set(plot2.output, 'Marker', 'o');
    set(plot3.output, 'Marker', 'o');
    set(plot4.output, 'Marker', 'o');

    figPos = [ 0.0 0.0 1000.0 500.0 ];
    set( Atlasfig, 'position', figPos );

    plotPos = [ 0.1 0.1 0.4 0.8 ];
    set( gca, 'position', plotPos );

    xlim([-1.5 1.5]); ylim([-1.5 1.5]); zlim([-1.5 1.5]);
    xlabel('X'); ylabel('Y'); zlabel('Z');
    grid on;
    view([4,4,4]);
    
    min = [ -25 -52 0   -30 -92 -45 -38 -45 -92 -30  0   -52 -25 -38 -30 -12 -45 -90 -45 -90 ];
    max = [  25  28 135  30  37  10  38  10  37  30  135  28  25  38  30  30  90  90  90  90 ];
    
    numberOfJoints = length(q);
    for i = 1:numberOfJoints
        sliderPos = [ .6*figPos(3)  i*20+.1*figPos(4) 250 20 ];
        textPos =   [ .9*figPos(3)  i*20+.1*figPos(4) 50  20 ];
        valPos =    [ .85*figPos(3) i*20+.1*figPos(4) 50  20 ];
        h = uicontrol( 'style', 'slider', 'position', sliderPos, 'min', min(i), 'max', max(i), 'SliderStep', [1/360,1/360], 'Value', q(i) );
        t = uicontrol( 'style', 'text', 'position', textPos );
        plot1.val{i} = uicontrol( 'style', 'text', 'position', valPos );
        set( t, 'string', strcat( 'joint q', num2str(i) ) );
        set( plot1.val{i}, 'string', q(i) );
        eventName = strcat( 'object_', num2str(i) );
        plot1.slideListener = addlistener( h, 'ContinuousValueChange', @(eventName, event) updatePlot( i, plot1.val{i}, eventName ) );
    end
end

% Update the 3D Plot.
function[] = updatePlot( i, text, eventName )
    global q;
    global plot1;
    global plot2;
    global plot3;
    global plot4;

    newq = get( eventName, 'Value' );
    q(i) = newq*pi/180;

    PositionKinematics();
    Positions();

    points = updatePoints();

    set(text,'string',num2str(newq));
    set(plot1.output,'xdata',points(1,1:13));
    set(plot1.output,'ydata',points(2,1:13));
    set(plot1.output,'zdata',points(3,1:13));
    set(plot2.output,'xdata',points(1,[6,14:16]));
    set(plot2.output,'ydata',points(2,[6,14:16]));
    set(plot2.output,'zdata',points(3,[6,14:16]));
    set(plot3.output,'xdata',points(1,16:18));
    set(plot3.output,'ydata',points(2,16:18));
    set(plot3.output,'zdata',points(3,16:18));
    set(plot4.output,'xdata',points(1,[16,19:20]));
    set(plot4.output,'ydata',points(2,[16,19:20]));
    set(plot4.output,'zdata',points(3,[16,19:20]));
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