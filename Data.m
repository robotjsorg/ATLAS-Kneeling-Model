clc; clear all;

LinkName = {'pelvis';'ltorso';'mtorso';'utorso';'lclav';'lscap';'luarm';'llarm';'lufarm';'llfarm';'lhand';'head';'hokuyolink';'rclav';'rscap';'ruarm';'rlarm';'rufarm';'rlfarm';'rhand';'luglut';'llglut';'luleg';'llleg';'ltalus';'lfoot';'ruglut';'rlglut';'ruleg';'rlleg';'rtalus';'rfoot'};
X = [0;-0.0125000000000000;-0.0125000000000000;-0.0126500000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.242100000000000;0.197500000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0.128100000000000;0;0;0.0500000000000000;0;0;0;0;0;0.0500000000000000;0;0;0];
Y = [0;0;0;0;0.225600000000000;0.335600000000000;0.522600000000000;0.641600000000000;0.941150000000000;0.941150000000000;0.941150000000000;0;0;-0.225600000000000;-0.335600000000000;-0.522600000000000;-0.641600000000000;-0.641600000000000;-0.941150000000000;-0.941150000000000;0.0890000000000000;0.0890000000000000;0.111500000000000;0.111500000000000;0.111500000000000;0.111500000000000;-0.0890000000000000;-0.0890000000000000;-0.115000000000000;-0.111500000000000;-0.111500000000000;-0.111500000000000];
Z = [0;0.162000000000000;0.162000000000000;0.212000000000000;0.689600000000000;0.444600000000000;0.428600000000000;0.437800000000000;0.428590000000000;0.428590000000000;0.428590000000000;0.833500000000000;0.921500000000000;0.689600000000000;0.444600000000000;0.428600000000000;0.437800000000000;0.437800000000000;0.428590000000000;0.428590000000000;0;0;-0.0660000000000000;-0.440000000000000;-0.862000000000000;-0.862000000000000;0;0;-0.0660000000000000;-0.440000000000000;-0.862000000000000;-0.862000000000000];


% Use points as shown above?
default = false;

% Sort data into required models.
% Left toe to right toe.
% thePointsNeeded = [ 26, 25, 24, 23, 22, 21, 1, 27, 28, 29, 30, 31, 32 ];

% % %          0    0.1115   -0.8620
% % %          0    0.1115   -0.8620
% % %          0    0.1115   -0.4400
% % %     0.0500    0.1115   -0.0660
% % %          0    0.0890         0
% % %          0    0.0890         0
% % %          0         0         0
% % %          0   -0.0890         0
% % %          0   -0.0890         0
% % %     0.0500   -0.1150   -0.0660
% % %          0   -0.1115   -0.4400
% % %          0   -0.1115   -0.8620
% % %          0   -0.1115   -0.8620

% Left toe to right heel.
% thePointsNeeded = [ 26, 25, 24, 23, 22, 21, 1, 27, 28, 29, 30, 31 ];

% Left toe to right knee.
thePointsNeeded = [ 26, 25, 24, 23, 22, 21, 1, 27, 28, 29, 30 ];

% Left toe to pelvis.
% thePointsNeeded = [ 26, 25, 24, 23, 22, 21, 1 ];

% Pelvis to left arm.
% thePointsNeeded = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ];

% Pelvis to right arm.
% thePointsNeeded = [ 1, 2, 3, 4, 13, 14, 15, 16, 17, 18, 19, 20 ];

% Filter the points.
if( not( default ) )
    newLinkName = cell(1,length( thePointsNeeded ));
    newX = zeros( 1, length( thePointsNeeded ) );
    newY = zeros( 1, length( thePointsNeeded ) );
    newZ = zeros( 1, length( thePointsNeeded ) );

    for i = 1:length( thePointsNeeded )
        newLinkName{i} = LinkName{ thePointsNeeded(i) };
        newX(i) = X( thePointsNeeded(i) );
        newY(i) = Y( thePointsNeeded(i) );
        newZ(i) = Z( thePointsNeeded(i) );
    end
end

if( default )
    newLinkName = LinkName;
    newX = X;
    newY = Y;
    newZ = Z;
end

% Plot all the points.
figure;
scatter3( X, Y, Z, 'o' );
line( newX, newY, newZ, 'LineWidth', 2 );
axis equal;

% Label each point.
lastPoint = [ 100; 100; 100 ];
counter = 0;
for i = 1:length( newLinkName )
    thisPoint = [ newX(i); newY(i); newZ(i) ];

    % If the new frame is on top of the old one.
    if ( abs( thisPoint(1) - lastPoint(1) ) < 0.001 ) && ( abs( thisPoint(2) - lastPoint(2) ) < 0.001 ) && ( abs( thisPoint(3) - lastPoint(3) ) < 0.001 )
        % Then display the label a bit higher than the last label.
        counter = counter + 1;
        text( newX(i), newY(i)-0.03, newZ(i)-0.02*counter, newLinkName(i), 'FontSize', 8 );
        text( newX(i), newY(i)-0.03+0.02, newZ(i)-0.02*counter, num2str(i-1), 'FontSize', 6 );

    % If the new frame is not on top of the old one.
    else
        % Just put the label at the new frame.
        counter = 0;
        text( newX(i), newY(i)-0.03, newZ(i), newLinkName(i), 'FontSize', 8 );
        text( newX(i), newY(i)-0.03+0.02, newZ(i), num2str(i-1), 'FontSize', 6 );
    end

    % Also display the frame axes.
    % NEEDS TO BE UPDATED WITH ROLL, PITCH, AND YAW!
    line( [ thisPoint(1) newX(i)+0.05 ], [ thisPoint(2) newY(i) ], [ thisPoint(3) newZ(i) ], 'Color', 'Red' );
    line( [ thisPoint(1) newX(i) ], [ thisPoint(2) newY(i)+0.05 ], [ thisPoint(3) newZ(i) ], 'Color', 'Green' );
    line( [ thisPoint(1) newX(i) ], [ thisPoint(2) newY(i) ], [ thisPoint(3) newZ(i)+0.05 ], 'Color', 'Magenta' );
    
    % Set the new frame to be the old frame before looping again.
    lastPoint = thisPoint;
end

displayTable = zeros( length( newLinkName ), 3);

for i = 1:length(displayTable)
    
    displayTable(i, 1) = newX(i);
    displayTable(i, 2) = newY(i);
    displayTable(i, 3) = newZ(i);
end

display(displayTable);