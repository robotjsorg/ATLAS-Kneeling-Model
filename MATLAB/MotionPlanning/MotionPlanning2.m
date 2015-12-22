function[qmatrix] = MotionPlanning()
    global q;
    global data;
    global C;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;
    global newq;
    
    run('q1.m');
    run('q2.m');

    figure;
    set(gcf,'Renderer','zbuffer');

    figPos = [ 0.0 0.0 1200.0 600.0 ];
    set( gcf, 'position', figPos );

    plotPos = [ 0.1 0.1 0.4 0.8 ];
    set( gca, 'position', plotPos );

    xlim( [-2 2] ); ylim( [-2 2] ); zlim( [-2 2] );
    xlabel('X'); ylabel('Y'); zlabel('Z');
    grid on;
    view( [1,1,1] );

    % Plot 2D.
    line( [LFootRFoot.Z], ...
          -[LFootRFoot.Y], ...
          [LFootRFoot.X], ...
          'LineWidth', 2, ...
          'Marker',    'o', ...
          'Parent',    gca, ...
          'Tag',       'LFootRFoot' );
    line( [LFootRFoot(6).Z PelvisTorso.Z], ...
          -[LFootRFoot(6).Y PelvisTorso.Y], ...
          [LFootRFoot(6).X PelvisTorso.X], ...
          'LineWidth', 2, ...
          'Marker',    'o', ...
          'Parent',    gca, ...
          'Tag',       'PelvisTorso' );
    line( [PelvisTorso(3).Z TorsoLArm.Z], ...
          -[PelvisTorso(3).Y TorsoLArm.Y], ...
          [PelvisTorso(3).X TorsoLArm.X], ...
          'LineWidth', 2, ...
          'Marker',    'o', ...
          'Parent',    gca, ...
          'Tag',       'TorsoLArm' );
    line( [PelvisTorso(3).Z TorsoRArm.Z], ...
          -[PelvisTorso(3).Y TorsoRArm.Y], ...
          [PelvisTorso(3).X TorsoRArm.X], ...
          'LineWidth', 2, ...
          'Marker',    'o', ...
          'Parent',    gca, ...
          'Tag',       'TorsoRArm' );
      
    for k = 1:2
        if(k==1) % forward motion
           delta = newq - q ; 
           l=1;
        else    % reverse motion
           delta = q - newq ; 
           l=1;
        end

        tstart = 0 ;
        TimeStep = 1;

        % loop to calculate trajectory
        for i = 1:length(delta)
            while(~(delta(i)==0))
                syms t0 a0 a1 a2 a3 ;
                coeff = [a0; a1; a2; a3];     % coeff for motion in Y

                constraints_q =[q(i); 0;  newq(i); 0];
                temp = [1, t0, t0^2, t0^3] ; % preparaing time base matrix 
                temp_vel = [0, 1, 2*t0, 3*t0^2 ];   
                temp_acc = [0, 0, 2, 6*t0]; 
                
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
                    q(i) = vpa(subs(temp*A,t0,t),5);     % x_pos at time td  
                    
                    if(k==1) % forward motion
                       QFset(l,:) = q(1,:);
                       QvFset(l,:) = vpa(subs(temp_vel*A,t0,t),5);
                       QaFset(l,:) = vpa(subs(temp_acc*A,t0,t),5);
                       l = l+1;
                    else    % reverse motion
                       QRset(l,:) = q(1,:);
                       QvRset(l,:) = vpa(subs(temp_vel*A,t0,t),5);
                       QaRset(l,:) = vpa(subs(temp_acc*A,t0,t),5);
                       l = l+1;
                    end

                    DeltaAnimate();
                end
                delta = newq - q;
            end
        end
    end
    qmatrix = 0;
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
                set( plot, 'xdata', [LFootRFoot.Z] );
                set( plot, 'ydata', -[LFootRFoot.Y] );
                set( plot, 'zdata', [LFootRFoot.X] );
            elseif strcmp( get( plot, 'Tag' ), 'PelvisTorso' )
                set( plot, 'xdata', [LFootRFoot(6).Z PelvisTorso.Z] );
                set( plot, 'ydata', -[LFootRFoot(6).Y PelvisTorso.Y] );
                set( plot, 'zdata', [LFootRFoot(6).X PelvisTorso.X] );
            elseif strcmp( get( plot, 'Tag' ), 'TorsoLArm' )
                set( plot, 'xdata', [PelvisTorso(3).Z TorsoLArm.Z] );
                set( plot, 'ydata', -[PelvisTorso(3).Y TorsoLArm.Y] );
                set( plot, 'zdata', [PelvisTorso(3).X TorsoLArm.X] );
            elseif strcmp( get( plot, 'Tag' ), 'TorsoRArm' )
                set( plot, 'xdata', [PelvisTorso(3).Z TorsoRArm.Z] );
                set( plot, 'ydata', -[PelvisTorso(3).Y TorsoRArm.Y] );
                set( plot, 'zdata', [PelvisTorso(3).X TorsoRArm.X] );
            end
        end
    end
    drawnow;

end