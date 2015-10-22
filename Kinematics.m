%% ATLAS Kneeling Model
%%% DH Tables

clc; clear all;

    % Test import of XML frame data from DRC Sim.
    % THIS IS THROWING AN ERROR! DOMNode = xmlread(data);
   
    % Both legs
    d =     [-15,0,0,0,0,0,0,0,0,0,0,0,0,15];
    theta = [0,0,0,0,0,-90,0,0,0,-90,0,0,0,0];
    a =     [0,0,45,55,0,0,-10,-10,0,0,55,45,0,0];
    alpha = [0,90,0,0,-90,-90,0,0,90,-90,0,0,90,0];
    
    numberOfLinks = length(d);
    data = struct;
    
    % Create matrices for 3D plot
    x = zeros(1, numberOfLinks+1);
    y = zeros(1, numberOfLinks+1);
    z = zeros(1, numberOfLinks+1);

    % Create transform matrix to next linkage and transform matrix from
    % base. Create p vector.
    for i = 1:numberOfLinks
        % Rotate about z-axis.
        Rz = [cos(theta(1,i)) -sin(theta(1,i)) 0 0; sin(theta(1,i)) cos(theta(1,i)) 0 0; 0 0 1 0; 0 0 0 1];
        % Translate along z-axis.
        Tz = [1 0 0 0; 0 1 0 0; 0 0 1 d(1,i); 0 0 0 1];
        % Translate along x-axis.
        Tx = [1 0 0 a(i); 0 1 0 0; 0 0 1 0; 0 0 0 1]; 
        % Rotate about x-axis.
        Rx = [1 0 0 0; 0 cos(alpha(1,i)) -sin(alpha(1,i)) 0; 0 sin(alpha(1,i)) cos(alpha(1,i)) 0; 0 0 0 1];

        % Calculate transform matrix to next linkage.
        data(i).stepTransform = Rz*Tz*Tx*Rx;

        % If it is the first step transform (0 to 1), then the base frame
        % transform matrix is the same. Otherwise, calculate the new base
        % frame transform matrix from the previos one, and the new
        % transform matrix to next linkage.
        if(i==1)
            data(i).baseTransform = data(i).stepTransform;
        elseif (i>1)
            data(i).baseTransform = data(i-1).baseTransform*data(i).stepTransform;
        end
        
        % Zero vector.
        p0 = [0; 0; 0; 1];
        % Calculate the p-vector of the current linakge.
        data(i).p = data(i).baseTransform*p0;
        
        p = data(i).p;
        x(1,i+1) = p(1);
        y(1,i+1) = p(2);
        z(1,i+1) = p(3);
    end

    figure;
    scatter3(x,y,z,'filled');
    line(x,y,z);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    axis equal;