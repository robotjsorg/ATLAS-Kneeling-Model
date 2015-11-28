function[] = PositionKinematics()
   
    global q;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;

    % DH constants
    d1 = .4220;
    d2 = sqrt(0.0500^2+0.3740^2);
    tq2 = atan(0.0500/0.3740);
    d3 = 0.0225;
    d4 = sqrt(0.06600^2+0.0500^2);
    tq4 = tq2+pi/2-atan(0.06600/0.0500);
    tq3 = pi/2-atan(0.06600/0.0500);
    d5 = 0.0890;
    d6 = 0.0500;
    d7 = sqrt(0.066^2+0.02250^2);
    tq6 = pi/2-atan(0.02250/0.0660);
    d8 = d2;
    tq8 = tq2;

    % LFoot to RFoot
    d     = [0,0,0,-d3,0,0,0,0,0,d6,0,0,0,0,0];
    theta = [q(1),q(2),q(3)+tq2,q(4)-tq4,tq3,q(5)-pi/2,q(6),q(7),q(8),q(9)+tq6,pi/2-tq6,q(10)+tq8,q(11)-tq8,q(12),q(13)];
    a     = [0,d1,d2,d4,0,0,-d5,-d5,0,-d7,0,-d8,-d1,0,0];
    alpha = [pi/2,0,0,0,-pi/2,-pi/2,0,0,pi/2,0,pi/2,0,0,-pi/2,0];
    
    % Torso
    dt     = [0.1620,0,0.1406,];
    thetat = [q(14),pi/2+q(15),q(16)];
    at     = [-0.0125,0,-0.5276,];
    alphat = [-pi/2,pi/2,0];
    
    % UTorso to RArm
    dr     = [0,-0.245,0];
    thetar = [pi/2,q(17),q(18)];
    ar     = [-0.2256,-0.11,-0.605762];
    alphar = [-pi/2,pi/2,0]; 
    
    % UTorso to LArm
    dl     = [0,-0.245,0];
    thetal = [pi/2,q(19),q(20)+pi];
    al     = [0.2256,0.11,-0.605762];
    alphal = [-pi/2,pi/2,0]; 

    %%%%%%%%%%
    
    % LFootRFoot
    j = 1;
    for i = 1:length(d)
      if i == 1
            LFootRFoot(j).step = DH([d(i);theta(i);a(i);alpha(i)]);
            LFootRFoot(j).base = LFootRFoot(j).step;
      elseif ((i == 5) || (i == 10))
            temp = DH([d(i);theta(i);a(i);alpha(i)]);
            i=i+1 ;
            LFootRFoot(j).step = temp*DH([d(i);theta(i);a(i);alpha(i)]);
            LFootRFoot(j).base = LFootRFoot(j-1).base*LFootRFoot(j).step; 
            j=j-1;
      elseif((i~=6)&&(i~=11))
            LFootRFoot(j).step = DH([d(i);theta(i);a(i);alpha(i)]);        
            LFootRFoot(j).base = LFootRFoot(j-1).base*LFootRFoot(j).step; 
      end
        
        if i == 7
            pT = LFootRFoot(j).base;
        end
        j=j+1 ;
    end

    %%%%%%%%%%
    
    % Pelvis inter transform
    iRz = [cosd(90) -sind(90) 0 0; sind(90) cosd(90) 0 0; 0 0 1 0; 0 0 0 1] ;
    iTz = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1] ;
    iTx = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1] ; 
    iRx = [1 0 0 0; 0 cosd(0) -sind(0) 0; 0 sind(0) cosd(0) 0;0 0 0 1];
    iT = iRz*iTz*iTx*iRx;

    %%%%%%%%%%
    
    % PelvisTorso

    for i = 1:length(dt)
        PelvisTorso(i).step = DH([dt(i);thetat(i);at(i);alphat(i)]);
        if i == 1
            PelvisTorso(i).base = pT*iT*PelvisTorso(i).step;
        else
            PelvisTorso(i).base = PelvisTorso(i-1).base*PelvisTorso(i).step;  
        end
    end

    %%%%%%%%%%

    % UTorso to LArm

    for i = 1:length(dl)
        if i == 1
            InterLArm = PelvisTorso(3).base*DH([dl(i);thetal(i);al(i);alphal(i)]);
        elseif i == 2
            TorsoLArm(i-1).step = InterLArm*DH([dr(i);thetar(i);ar(i);alphar(i)]);
            TorsoLArm(i-1).base = TorsoLArm(i-1).step;  
        else
            TorsoLArm(i-1).step = DH([dl(i);thetal(i);al(i);alphal(i)]);
            TorsoLArm(i-1).base = TorsoLArm(i-2).base*TorsoLArm(i-1).step;  
        end
    end

    % UTorso to RArm

    for i = 1:length(dr)
        if i == 1
            InterRArm = PelvisTorso(3).base*DH([dr(i);thetar(i);ar(i);alphar(i)]);
        elseif i == 2
            TorsoRArm(i-1).step = InterRArm*DH([dr(i);thetar(i);ar(i);alphar(i)]);
            TorsoRArm(i-1).base = TorsoRArm(i-1).step;  
        else
            TorsoRArm(i-1).step = DH([dr(i);thetar(i);ar(i);alphar(i)]);
            TorsoRArm(i-1).base = TorsoRArm(i-2).base*TorsoRArm(i-1).step;  
        end
    end
    
end
    
%%%%%%%%%%

function [ T ] = DH( params )
    d     = params(1);
    theta = params(2);
    a     = params(3);
    alpha = params(4);

    Rz = [cos(theta), -sin(theta), 0, 0;
          sin(theta),  cos(theta), 0, 0;
                   0,           0, 1, 0;
                   0,           0, 0, 1];

    Tz = [1, 0, 0, 0; 
          0, 1, 0, 0; 
          0, 0, 1, d; 
          0, 0, 0, 1];

    Tx = [1, 0, 0, a;
          0, 1, 0, 0;
          0, 0, 1, 0; 
          0, 0, 0, 1];

    Rx = [1,          0,           0, 0;
          0, cos(alpha), -sin(alpha), 0;
          0, sin(alpha),  cos(alpha), 0;
          0,          0,           0, 1];

    T = Rz*Tz*Tx*Rx;
end