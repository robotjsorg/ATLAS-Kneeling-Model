function[q] = MotionPlanning(newq)
    global q;
    global data;
    global C;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;
    
     figure;
    set(gcf,'Renderer','zbuffer');

    figPos = [ 0.0 0.0 1200.0 600.0 ];
    set( gcf, 'position', figPos );

    plotPos = [ 0.1 0.1 0.4 0.8 ];
    set( gca, 'position', plotPos );

    xlim( [-1.5 1.5] ); ylim( [-1.5 1.5] ); zlim( [-1.5 1.5] );
    xlabel('X'); ylabel('Y'); zlabel('Z');
    grid on;
    view( [1,1,1] );

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


    %Dynamics( TimeStep );
    delta = newq - q ; 
    tstart = 0 ;
    TimeStep = 0.1;
    
    
    % loop to calculate trajectory
    for i = 1:length(delta)
        while(~(delta(i)==0))
            syms t0 a0 a1 a2 a3 ;
            coeff = [a0; a1; a2; a3];     % coeff for motion in Y
           
            constraints_q =[q(i); 0;  newq(i); 0];
            temp = [1, t0, t0^2, t0^3] ; % preparaing time base matrix 
            temp_vel = [0, 1, 2*t0, 3*t0^2 ];
            tend = 5;
            time(1,:) = subs(temp,t0,tstart);
            time(2,:) = subs(temp_vel,t0,tstart);
            time(3,:) = subs(temp,t0,tend);
            time(4,:) = subs(temp_vel,t0,tend);

            % Solving for X and Y coeff
            [a0,a1,a2,a3] = solve(time*coeff==constraints_q,[a0,a1,a2,a3]);
            A = [a0;a1;a2;a3];

            for j = 0:(tend-tstart)/TimeStep
                t = tstart+j*TimeStep ;              % i'th time-step 
                q(i) = vpa(subs(temp*A,t0,t),5);    % x_pos at time td    
                DeltaAnimate();
            end
            delta = newq - q;
        end
    end
end


% Update the Plot.
function[] = DeltaAnimate()
    global q;
    global data;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;
    

    Kinematics();

 % Update the plots.
    plots = get( gca, 'Children' );
    for i = 1:length( plots )
        plot = plots(i);
        if strcmp( 'line', get( plot , 'Type' ) ) % Update the lines.
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
            fv = stlread( strcat( tag, '.stl' ) );
            pos = data( MapJoint( tag ) ).position;
            set( plots(i), 'Vertices', bsxfun( @plus, transpose( pos ), fv.vertices ) );
        end
    end
    drawnow;

end