%ATLAS DH Parameters


%JointAngle = [q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15,q16,q17,q18,q19,q20];

%%StandingPose
jointAngles = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

%%Kneeling Pose
%jointAngles = [0,-90,90,0,0,0,0,0,0,90,-90,0,0,0,0,0,-90,0,90,0];

% Setting up values for DH parameters for references
d1 = .422
d2 = sqrt(.05^2+.374^2)
tq2 = atan(.05/.374)*180/pi
d3 = 0.0225
d4 = sqrt(.066^2+.05^2)
tq4 = tq2+90-atan(.066/.05)*180/pi
tq3 = 90-atan(0.066/.05)*180/pi
d5 = 0.089
d6 = 0.05
d7 = sqrt(.066^2+.0225^2)
tq6 = 90-atan(.0225/0.066)*180/pi
d8 = d2
tq8 = tq2

%input joint angles
%JointAngle = [q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13];
jointAngle = jointAngles(1:13);%[0,0,0,0,0,0,0,0,0,0,0,0,0];

%DH parameters for legs
d = [0,0,0,-d3,...
     0,0,0,0,...
     0,d6,0,0,...
     0,0,0];
theta = [jointAngle(1),jointAngle(2),jointAngle(3)+tq2,jointAngle(4)-tq4,...%1-4
        tq3,jointAngle(5)-90,jointAngle(6),jointAngle(7),...%5-8
        jointAngle(8),jointAngle(9)+tq6,90-tq6,jointAngle(10)+tq8,...%9-12 
        jointAngle(11)-tq8,jointAngle(12),jointAngle(13)];%13-15
a = [0,d1,d2,d4,...
     0,0,-d5,-d5,...
     0,-d7,0,-d8,...
     -d1,0,0];
alpha = [90,0,0,0,...
         -90,-90,0,0,...
         90,0,90,0,...
         0,-90,0];

%DH Table
DHpars = [d',theta',a',alpha'];

%Define a constant identity matrix needed for the for loop
Tbase_to_frame_prev = [1,0,0,0;0,1,0,0;0,0,1,0;0,0,0,1];
%For loop to construct each transformation matrix from sequential frames,
%as well as the overall transform from base to tip
for i = 1:length(d)
    Trans{i} = DHparams(DHpars(i,:));           %Generate transform from DHparams
    Tbase_to_frame{i} = Tbase_to_frame_prev*Trans{i};  %base to current frame transform
    Tbase_to_frame_prev = Tbase_to_frame{i};
    jointPoint(:,i) = Tbase_to_frame{i}*[0;0;0;1];
end

%Transforms from toe to toe, toe to pelvis, and toe to knee
TLtoe2Rtoe = Tbase_to_frame{length(d)};
TLtoe2Pelvis = Tbase_to_frame{7};
TLtoe2Rknee = Tbase_to_frame{12};


%% Intermediate Transformation matrix at Pelvis


iRz = [cosd(90) -sind(90) 0 0; sind(90) cosd(90) 0 0; 0 0 1 0; 0 0 0 1] ;
iTz = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1] ;
iTx = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1] ; 
iRx = [1 0 0 0; 0 cosd(0) -sind(0) 0; 0 sind(0) cosd(0) 0;0 0 0 1];

InterTrans = iRz*iTz*iTx*iRx;

%% DH parameters for Right Arm
q1 = jointAngles(14);
q2 = jointAngles(15);
q3 = jointAngles(16);
q4 = jointAngles(17);
q5 = jointAngles(18);

%links = ['pelvis';'ltorso';'mtorso';'r_clav';'r_scap';'arm'];

%masses = [9.609;2.27;.799;4.46;3.899;12.75];

d =     [.162,0,.1406,0,-.245,0];
theta = [q1,90+q2,q3,90,q4,q5];
a =     [-.0125,0,-.5276,-.2256,-.11,-.605762];
alpha = [-90,90,0,-90,90,0];

    numberOfJoints = length(d);
    
    % Create a matrix to store T0(X) base frame transforms
    T0X = cell(1, numberOfJoints);
    
    % Create a matrix to store T(X)(X+1) frame transforms
    TXX = cell(1, numberOfJoints);
    
    % Create a matrix to store p end effector vectors
    P = cell(1, numberOfJoints);
    
    % Create matrices for 3D plot
    xR = zeros(1, numberOfJoints+1);
    yR = zeros(1, numberOfJoints+1);
    zR = zeros(1, numberOfJoints+1);

    for i = 1:numberOfJoints

        Rz = [cosd(theta(1,i)) -sind(theta(1,i)) 0 0; sind(theta(1,i)) cosd(theta(1,i)) 0 0; 0 0 1 0; 0 0 0 1] ;
        Tz = [1 0 0 0; 0 1 0 0; 0 0 1 d(1,i); 0 0 0 1] ;
        Tx = [1 0 0 a(i); 0 1 0 0; 0 0 1 0; 0 0 0 1] ; 
        Rx = [1 0 0 0; 0 cosd(alpha(1,i)) -sind(alpha(1,i)) 0; 0 sind(alpha(1,i)) cosd(alpha(1,i)) 0;0 0 0 1];

        p0 = [0; 0; 0; 1];

        TXX{1,i} = mat2cell(Rz*Tz*Tx*Rx,4);

        if(i==1)
            T0X{1,i} = TXX{1,i};
        elseif (i>1)
            T0X{1,i} = mat2cell(cell2mat(T0X{1,i-1})*cell2mat(TXX{1,i}),4);
        end
        
        P{1,i} = mat2cell(cell2mat(T0X{1,i})*p0,4,1);
 
        p = cell2mat(P{1,i});
        xR(1,i+1) = p(1);
        yR(1,i+1) = p(2);
        zR(1,i+1) = p(3);

    end


TLToe2RShoulder = TLtoe2Pelvis*InterTrans*cell2mat(T0X{1,6}); 


%% DH parameters for Left Arm
q1 = jointAngles(14);
q2 = jointAngles(15);
q3 = jointAngles(16);
q4 = jointAngles(19);
q5 = jointAngles(20);

%links = ['pelvis';'ltorso';'mtorso';'r_clav';'r_scap';'arm'];

%masses = [9.609;2.27;.799;4.46;3.899;12.75];

d =     [.162,0,.1406,0,-.245,0];
theta = [q1,90+q2,q3,90,q4,q5+180];
a =     [-.0125,0,-.5276,.2256,.11,-.605762];
alpha = [-90,90,0,-90,90,0];

    numberOfJoints = length(d);
    
    % Create a matrix to store T0(X) base frame transforms
    T0LX = cell(1, numberOfJoints);
    
    % Create a matrix to store T(X)(X+1) frame transforms
    TXLX = cell(1, numberOfJoints);
    
    % Create a matrix to store p end effector vectors
    P = cell(1, numberOfJoints);
    
    % Create matrices for 3D plot
    xL = zeros(1, numberOfJoints+1);
    yL = zeros(1, numberOfJoints+1);
    zL = zeros(1, numberOfJoints+1);

    for i = 1:numberOfJoints

        Rz = [cosd(theta(1,i)) -sind(theta(1,i)) 0 0; sind(theta(1,i)) cosd(theta(1,i)) 0 0; 0 0 1 0; 0 0 0 1] ;
        Tz = [1 0 0 0; 0 1 0 0; 0 0 1 d(1,i); 0 0 0 1] ;
        Tx = [1 0 0 a(i); 0 1 0 0; 0 0 1 0; 0 0 0 1] ; 
        Rx = [1 0 0 0; 0 cosd(alpha(1,i)) -sind(alpha(1,i)) 0; 0 sind(alpha(1,i)) cosd(alpha(1,i)) 0;0 0 0 1];

        p0 = [0; 0; 0; 1];

        TXLX{1,i} = mat2cell(Rz*Tz*Tx*Rx,4);

        if(i==1)
            T0LX{1,i} = TXLX{1,i};
        elseif (i>1)
            T0LX{1,i} = mat2cell(cell2mat(T0LX{1,i-1})*cell2mat(TXLX{1,i}),4);
        end
        
        P{1,i} = mat2cell(cell2mat(T0LX{1,i})*p0,4,1);
 
        p = cell2mat(P{1,i});
        xL(1,i+1) = p(1);
        yL(1,i+1) = p(2);
        zL(1,i+1) = p(3);

    end


TLToe2LShoulder = TLtoe2Pelvis*InterTrans*cell2mat(T0LX{1,6}); 


%% Combine DH Positions For Ploting
%Reorient the positions to have the pelvis at 0,0,0 for drawing purposes
Z = jointPoint(1,:)-.862; X = jointPoint(3,:); Y = -jointPoint(2,:)+.1115;
Ps = [X',Y',Z'];
last = 15;
figure()
scatter3(X(1:last),Y(1:last),Z(1:last))
hold on
plot3(X(1:last),Y(1:last),Z(1:last))
plot3(xR'+ X(7),yR'+ Y(7),zR'+ Z(7),'-o');
plot3(xL'+ X(7),yL'+ Y(7),zL'+ Z(7),'-o');
%axis([-1,1,-1,1,-1,1])
axis equal;


