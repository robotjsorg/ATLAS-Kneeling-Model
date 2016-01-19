function[] = PlotATLAS()
    global q;
    global val;
    global data;
    global C;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;
    global plotPoly;
    global plotRobot;
    global MinPolyOutline;

    % Set up.
    figure;
    set( gcf, 'Renderer', 'zbuffer' );
    
    scr = get(0,'ScreenSize');
    
    figPos = [ 0.0 0.0 scr(3) scr(4)];
    set( gcf, 'position', figPos );

    plotPoly = subplot(2,1,1);
    plotPos = [ 0.6 0.68 0.3 0.25 ];
    set( plotPoly, 'position',plotPos );
    xlabel('X'); ylabel('Y'); zlabel('Z');
    
    plotRobot = subplot(2,1,2);
    plotPos = [ 0.1 0.1 0.4 0.7 ];
    set( plotRobot, 'position', plotPos );
    
    xlim( [-2 2] ); ylim( [-2 2] ); zlim( [-2 2] );
    xlabel('X'); ylabel('Y'); zlabel('Z');
    grid on;
    view( [1,1,1] );
    
    % Create Legend
    L_width = 450;    L_height = 30;
    L_top = 400;
    columnname = {'Objects','Representation','Color'};
    columnformat = {'char','char','char'};
    %Added spaces to manually center elements
    d = {'ATLAS joints', '                    O', '                  blue'; ...
         'ATLAS ligaments', '                _____', '                  blue'; ...
         'ATLAS Center of Mass', '                    *', '                 black'; ...
         'Minimum Polygon', '            O and ____', '                  red'};
    L_table = uitable('Data',d, ...
                      'ColumnName',columnname, ...
                      'ColumnFormat',columnformat, ...
                      'ColumnEditable',[false false false], ...
                      'ColumnWidth', {.4*L_width,.3*L_width,.295*L_width}, ...
                      'RowName',[], ...
                      'Position', [.1*figPos(3), 0.85*figPos(4)-L_height*3, L_width, L_height*3.2]);
    
    %Create TITLES
    %Create overall title
    plotTitle = uicontrol('style','text');
    set(plotTitle,'String','Interactive ATLAS 3D Plot',...
        'Position',[.1*figPos(3), 0.9*figPos(4), L_width, L_height],...
        'FontSize', 20,'FontWeight', 'bold');
    %Create minpolygon title
    plotTitle = uicontrol('style','text');
    set(plotTitle,'String','Minimum Polygon Plot',...
        'Position',[.66*figPos(3), 0.9*figPos(4), L_width/2, L_height*2/3],...
        'FontSize', 12,'FontWeight', 'bold');
    %Create sliders title
    plotTitle = uicontrol('style','text');
    set(plotTitle,'String','Slider Controls for Joint Angles',...
        'Position',[.6*figPos(3), 0.55*figPos(4), 250, L_height*2/3],...
        'FontSize', 12,'FontWeight', 'bold');
    plotTitle = uicontrol('style','text');
    set(plotTitle,'String','Name',...
        'Position',[.8*figPos(3), 0.55*figPos(4), 50, L_height*2/3],...
        'FontSize', 12,'FontWeight', 'bold');
    plotTitle = uicontrol('style','text');
    set(plotTitle,'String','Angle',...
        'Position',[.75*figPos(3), 0.55*figPos(4), 50, L_height*2/3],...
        'FontSize', 12,'FontWeight', 'bold');
    
    % Reset
    reset = uicontrol('Style', 'pushbutton', 'String', 'Reset',...
        'Position', [.65*figPos(3), 0.1*figPos(4) 120 50],...
        'Style','pushbutton',...
        'String','Reset Plot/Sliders',...
        'FontSize', 10, ...
        'Callback',@resetButton_Callback);

    % Plot 2D.
    line( [LFootRFoot.X], ...
          [LFootRFoot.Y], ...
          [LFootRFoot.Z], ...
          'LineWidth', 2, ...
          'Marker',    'o', ...
          'Parent',    plotRobot, ...
          'Tag',       'LFootRFoot' );
    line(  [LFootRFoot(6).Z PelvisTorso.X], ...
           [LFootRFoot(6).Y PelvisTorso.Y], ...
           [LFootRFoot(6).X PelvisTorso.Z], ...
          'LineWidth', 2, ...
          'Marker',    'o', ...
          'Parent',    plotRobot, ...
          'Tag',       'PelvisTorso' );
    line(  [PelvisTorso(3).X TorsoLArm.X], ...
           [PelvisTorso(3).Y TorsoLArm.Y], ...
           [PelvisTorso(3).Z TorsoLArm.Z], ...
          'LineWidth', 2, ...
          'Marker',    'o', ...
          'Parent',    plotRobot, ...
          'Tag',       'TorsoLArm' );
    line(  [PelvisTorso(3).X TorsoRArm.X], ...
           [PelvisTorso(3).Y TorsoRArm.Y], ...
           [PelvisTorso(3).Z TorsoRArm.Z], ...
          'LineWidth', 2, ...
          'Marker',    'o', ...
          'Parent',    plotRobot, ...
          'Tag',       'TorsoRArm' );
    line( C(1), C(2), C(3),...
          'LineWidth', 2, ...
          'Marker',   '*', ...
          'Color',   [0 0 0], ...
          'Parent',   plotRobot, ...
          'Tag',      'CoM');
    line( MinPolyOutline.X, MinPolyOutline.Y, MinPolyOutline.Z, ...
          'LineWidth', .1, ...
          'Marker',   'o', ...
          'Color',   [1,0,0], ...
          'Parent',   plotPoly, ...
          'Tag',      'Polygon');
    line( C(1), C(2), 0, ...
         'LineWidth', 2, ...
         'Marker',   '*', ...
         'Color',   [0,0,0], ...
         'Parent',   plotPoly, ...
         'Tag',     'CoMPoly');

    % Plot 3D.
    for i = 1:length( data )
        if ~( strcmp( data(i).name, 'head' ) || strcmp( data(i).name, 'hokuyolink' ) || strcmp( data(i).name, 'llfarm' ) || strcmp( data(i).name, 'rlfarm' ) )
            data(i).name
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
    nm    = {'lfoot';'ltalus';'llleg';'luleg';'llglut';'luglut';'pelvis';'ruglut';'rlglut';'ruleg';'rlleg';'rtalus';'rfoot';'ltorso';'mtorso';'utorso';'lclav';'lscap';'rclav';'rscap'};
    % updated limits as per our model   
    min = [ -25 0 -135 -30 -92 -45 -38 -10 -37 -90  0  -90  -25 -38 -30 -12 -90 -90 -45 -90 ];
    max = [  25 90   0  30  37  10  38  45  92  30  135  0   25  38  30  30  45  90  90  90 ];

    val = cell( 1, length(q) );
    for i = 1:length( q )
        sliderPos = [ .6*figPos(3)  i*20+.15*figPos(4) 250 20 ];
        textPos =   [ .8*figPos(3)  i*20+.15*figPos(4) 50  20 ];
        valPos =    [ .75*figPos(3) i*20+.15*figPos(4) 50  20 ];

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
    global val
    global data;
    global C;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;
    global plotPoly;
    global plotRobot;
    global MinPolyOutline;

    % Update q and kinematics.
    if eventName == 'Reset'
        % update values and labels
        for i = 1:length(q)
            q(i) = 0;
            set( val{i}, 'string', num2str( 0 ) );
        end
    else
        newq = round(get( eventName, 'Value' ));
        q(i) = newq;
        % Update the label.
        set( text, 'string', num2str( newq ) );
    end

    Kinematics();

    % Update the Robot plot.
    plots = get( plotRobot, 'Children' );
    for i = 1:length( plots )
        plot = plots(i);
        if strcmp( 'line', get( plot , 'Type' ) ) % Update the lines.
            if strcmp( get( plot, 'Tag' ), 'LFootRFoot' )
                set( plot, 'xdata',  [LFootRFoot.X] );
                set( plot, 'ydata',  [LFootRFoot.Y] );
                set( plot, 'zdata',  [LFootRFoot.Z] );
            elseif strcmp( get( plot, 'Tag' ), 'PelvisTorso' )
                set( plot, 'xdata',  [LFootRFoot(6).X PelvisTorso.X] );
                set( plot, 'ydata',  [LFootRFoot(6).Y PelvisTorso.Y] );
                set( plot, 'zdata',  [LFootRFoot(6).Z PelvisTorso.Z] );
            elseif strcmp( get( plot, 'Tag' ), 'TorsoLArm' )
                set( plot, 'xdata',  [PelvisTorso(3).X TorsoLArm.X] );
                set( plot, 'ydata',  [PelvisTorso(3).Y TorsoLArm.Y] );
                set( plot, 'zdata',  [PelvisTorso(3).Z TorsoLArm.Z] );
            elseif strcmp( get( plot, 'Tag' ), 'TorsoRArm' )
                set( plot, 'xdata',  [PelvisTorso(3).X TorsoRArm.X] );
                set( plot, 'ydata',  [PelvisTorso(3).Y TorsoRArm.Y] );
                set( plot, 'zdata',  [PelvisTorso(3).Z TorsoRArm.Z] );
            elseif strcmp( get( plot, 'Tag' ), 'CoM' )
                set( plot, 'xdata',  C(1) );
                set( plot, 'ydata',  C(2) );
                set( plot, 'zdata',  C(3) );
            end
        elseif strcmp( 'patch', get( plot, 'Type' ) ) % Update the patches.
            tag = get( plot, 'Tag' );
            fv = stlread( strcat( tag, '.stl' ) );
            pos = data( MapJoint( tag ) ).position ;
%             fv.vertices = data( MapJoint(tag) ).base(1:3,1:3)*fv.vertices' ;
%             fv.vertices = fv.vertices' ;
            set( plots(i), 'Vertices', bsxfun( @plus, transpose( pos ), fv.vertices ) );
        end
    end

    plots = get( plotPoly, 'Children' );
    for i = 1:length( plots )
        plot = plots(i);
        if strcmp( 'line', get( plot , 'Type' ) ) % Update the lines.
            if strcmp( get( plot, 'Tag' ), 'Polygon')
                set( plot, 'xdata', MinPolyOutline.X );
                set( plot, 'ydata', MinPolyOutline.Y );
                set( plot, 'zdata', MinPolyOutline.Z );
            elseif strcmp( get( plot, 'Tag' ), 'CoMPoly')
                set( plot, 'xdata', C(1) );
                set( plot, 'ydata', C(2) );
                set( plot, 'zdata', 0 );
            end
        end
    end
    drawnow;
end

%%%%%%%%%%

function resetButton_Callback( hObject, eventdata, handles )
    % hObject    handle to pushbutton1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global q;

    eventName = 'object_1';
    updatePlot( 0, 'Value', 'Reset' )
end

%%%%%%%%%%

function[ V ] = loadstl( i )
    global data;
    V = getfield( data(i), 'V' );
%     roll = 90;
%     pitch = 90;
%     yaw = 90;
%     xrot = [ 1 0 0; 0 cosd(roll) -sind(roll); 0 -sind(roll) cosd(roll) ];
%     yrot = [ cosd(pitch) 0 sind(pitch); 0 1 0; -sind(pitch) 0 cosd(pitch) ];
%     zrot = [ cosd(yaw) sind(yaw) 0; -sind(yaw) cosd(yaw) 0; 0 0 1 ];
%     rot = xrot*yrot*zrot*V';
%     V = rot';
    V = bsxfun( @plus, transpose( data(i).ComPos ), V );
end