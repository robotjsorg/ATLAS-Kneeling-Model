function[] = PlotATLAS()
    global q;
    global data;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;

    % Set up.
    figure;
    hold on;
    set( gcf, 'Renderer', 'zbuffer' );
    
    scr = get(0,'ScreenSize');
    
    figPos = [ 0.0 0.0 scr(3) scr(4)];
    set( gcf, 'position', figPos );

    plotPos = [ 0.1 0.1 0.4 0.8 ];
    set( gca, 'position', plotPos );

    xlim( [-1.5 1.5] ); ylim( [-1.5 1.5] ); zlim( [-1.5 1.5] );
    xlabel('X'); ylabel('Y'); zlabel('Z');
    grid on;
    view( [1,1,1] );

    % Plot CoM
    scatter3( [LFootRFoot.ComPosX], ...
              [LFootRFoot.ComPosY], ...
              [LFootRFoot.ComPosZ], ...
              'red', 'filled', ...
              'Tag', 'LFootRFoot' );
          
    scatter3( [PelvisTorso.ComPosX], ...
              [PelvisTorso.ComPosY], ...
              [PelvisTorso.ComPosZ], ...
              'red', 'filled', ...
              'Tag', 'PelvisTorso' );          
          
    scatter3( [TorsoLArm.ComPosX], ...
              [TorsoLArm.ComPosY], ...
              [TorsoLArm.ComPosZ], ...
              'red', 'filled', ...
              'Tag', 'TorsoLArm' );
          
    scatter3( [TorsoRArm.ComPosX], ...
              [TorsoRArm.ComPosY], ...
              [TorsoRArm.ComPosZ], ...
              'red', 'filled', ...
              'Tag', 'TorsoRArm' );
    
    % Plot 2D.
    line( [LFootRFoot.X], ...
          [LFootRFoot.Y], ...
          [LFootRFoot.Z], ...
          'LineWidth', 2, ...
          'Marker',    'o', ...
          'Parent',    gca, ...
          'Tag',       'LFootRFoot' );
    line( [LFootRFoot(6).X PelvisTorso.X], ...
          [LFootRFoot(6).Y PelvisTorso.Y], ...
          [LFootRFoot(6).Z PelvisTorso.Z], ...
          'LineWidth', 2, ...
          'Marker',    'o', ...
          'Parent',    gca, ...
          'Tag',       'PelvisTorso' );
    line( [PelvisTorso(3).X TorsoLArm.X], ...
          [PelvisTorso(3).Y TorsoLArm.Y], ...
          [PelvisTorso(3).Z TorsoLArm.Z], ...
          'LineWidth', 2, ...
          'Marker',    'o', ...
          'Parent',    gca, ...
          'Tag',       'TorsoLArm' );
    line( [PelvisTorso(3).X TorsoRArm.X], ...
          [PelvisTorso(3).Y TorsoRArm.Y], ...
          [PelvisTorso(3).Z TorsoRArm.Z], ...
          'LineWidth', 2, ...
          'Marker',    'o', ...
          'Parent',    gca, ...
          'Tag',       'TorsoRArm' );

    % Plot 3D.
    
    for i = 1:length( data )
        if ~isempty( data(i).ComPos )
            F = getfield( data(i), 'F' );
            V = getfield( data(i), 'V' );
            V = loadstl( i );
            patch( 'Faces',           [F], ...
                   'Vertices',        [V], ...
                   'FaceColor',       [0.5 0.5 0.5], ...
                   'EdgeColor',       [0.5 0.5 0.5], ...
                   'FaceLighting',    'gouraud', ...
                   'AmbientStrength', 0.15, ...
                   'Parent',          gca, ...
                   'Tag',             data(i).name );
        end
    end

    % Light.
    light( 'Position', [ 3 3 3 ], 'Style', 'local' );

    % Joint limits.
    nm  = {'lfoot';'ltalus';'llleg';'luleg';'llglut';'luglut';'pelvis';'ruglut';'rlglut';'ruleg';'rlleg';'rtalus';'rfoot';'ltorso';'mtorso';'utorso';'lclav';'lscap';'rclav';'rscap'};
    min = [ -25 -52 0   -30 -92 -45 -38 -45 -92 -30  0   -52 -25 -38 -30 -12 -45 -90 -45 -90 ];
    max = [  25  28 135  30  37  10  38  10  37  30  135  28  25  38  30  30  90  90  90  90 ];

    val = cell( 1, length(q) );
    for i = 1:length( q )
        sliderPos = [ .6*figPos(3)  i*20+.1*figPos(4) 250 20 ];
        textPos =   [ .9*figPos(3)  i*20+.1*figPos(4) 50  20 ];
        valPos =    [ .85*figPos(3) i*20+.1*figPos(4) 50  20 ];

        h = uicontrol( 'style', 'slider', 'position', sliderPos, 'min', min(i), 'max', max(i), 'SliderStep', ( [1,1]/( max(i)-min(i) ) ), 'Value', q(i) );
        t = uicontrol( 'style', 'text', 'position', textPos );
        val{i} = uicontrol( 'style', 'text', 'position', valPos );
        set( t, 'string', nm{i} );
        set( val{i}, 'string', q(i) );

        eventName = strcat( 'object_', num2str(i) );
        slideListener = addlistener( h, 'ContinuousValueChange', @(eventName, event) updatePlot( i, val{i}, eventName ) );
    end
end

%%%%%%%%%%

% Update the 3D Plot.
function[] = updatePlot( i, text, eventName )
    global q;
    global data;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;

    % Update q and kinematics.
    newq = get( eventName, 'Value' );
    q(i) = newq;
    Kinematics();

    % Update the label.
    set( text, 'string', num2str( newq ) );

    % Update the plots.
    plots = get( gca, 'Children' );
    for i = 1:length( plots )
        plot = plots(i);
        if strcmp( 'scatter', get( plot, 'Type' ) )
            if strcmp( get( plot, 'Tag' ), 'LFootRFoot' )
                set( plot, 'xdata', [LFootRFoot.ComPosX] );
                set( plot, 'ydata', [LFootRFoot.ComPosY] );
                set( plot, 'zdata', [LFootRFoot.ComPosZ] );
            elseif strcmp( get( plot, 'Tag' ), 'PelvisTorso' )
                set( plot, 'xdata', [PelvisTorso.ComPosX] );
                set( plot, 'ydata', [PelvisTorso.ComPosY] );
                set( plot, 'zdata', [PelvisTorso.ComPosZ] );
            elseif strcmp( get( plot, 'Tag' ), 'TorsoLArm' )
                set( plot, 'xdata', [TorsoLArm.ComPosX] );
                set( plot, 'ydata', [TorsoLArm.ComPosY] );
                set( plot, 'zdata', [TorsoLArm.ComPosZ] );
            elseif strcmp( get( plot, 'Tag' ), 'TorsoRArm' )
                set( plot, 'xdata', [TorsoRArm.ComPosX] );
                set( plot, 'ydata', [TorsoRArm.ComPosY] );
                set( plot, 'zdata', [TorsoRArm.ComPosZ] );
            end
        elseif strcmp( 'line', get( plot , 'Type' ) ) % Update the lines.
            if strcmp( get( plot, 'Tag' ), 'LFootRFoot' )
                set( plot, 'xdata', [LFootRFoot.X] );
                set( plot, 'ydata', [LFootRFoot.Y] );
                set( plot, 'zdata', [LFootRFoot.Z] );
            elseif strcmp( get( plot, 'Tag' ), 'PelvisTorso' )
                set( plot, 'xdata', [LFootRFoot(6).X PelvisTorso.X] );
                set( plot, 'ydata', [LFootRFoot(6).Y PelvisTorso.Y] );
                set( plot, 'zdata', [LFootRFoot(6).Z PelvisTorso.Z] );
            elseif strcmp( get( plot, 'Tag' ), 'TorsoLArm' )
                set( plot, 'xdata', [PelvisTorso(3).X TorsoLArm.X] );
                set( plot, 'ydata', [PelvisTorso(3).Y TorsoLArm.Y] );
                set( plot, 'zdata', [PelvisTorso(3).Z TorsoLArm.Z] );
            elseif strcmp( get( plot, 'Tag' ), 'TorsoRArm' )
                set( plot, 'xdata', [PelvisTorso(3).X TorsoRArm.X] );
                set( plot, 'ydata', [PelvisTorso(3).Y TorsoRArm.Y] );
                set( plot, 'zdata', [PelvisTorso(3).Z TorsoRArm.Z] );
            end
        elseif strcmp( 'patch', get( plot, 'Type' ) ) % Update the patches.
            tag = get( plot, 'Tag' );
            set( plot, 'Vertices', loadstl( MapJoint( tag ) ) );
        end
    end
    drawnow;
end

function[ V ] = loadstl( i )
    global data;
    V = getfield( data(i), 'V' );
    roll = 90;
    pitch = 90;
    yaw = 90;
    xrot = [ 1 0 0; 0 cosd(roll) -sind(roll); 0 -sind(roll) cosd(roll) ];
    yrot = [ cosd(pitch) 0 sind(pitch); 0 1 0; -sind(pitch) 0 cosd(pitch) ];
    zrot = [ cosd(yaw) sind(yaw) 0; -sind(yaw) cosd(yaw) 0; 0 0 1 ];
    rot = xrot*yrot*zrot*V';
    V = rot';
    V = bsxfun( @plus, transpose( data(i).ComPos ), V );
end