function[XCM,YCM,ZCM] = CoM()

%Import global data struct with joint position data    
global LFootRFoot;
global PelvisLArm;
global PelvisRArm;

% Joint Names
Joint = {'pelvis';'ltorso';'mtorso';'utorso';'lclav';'lscap';'luarm';'llarm';'lufarm';'llfarm';'lhand';'head';'hokuyolink';'rclav';'rscap';'ruarm';'rlarm';'rufarm';'rlfarm';'rhand';'luglut';'llglut';'luleg';'llleg';'ltalus';'lfoot';'ruglut';'rlglut';'ruleg';'rlleg';'rtalus';'rfoot'};

% Link Mass
M = [9.609,2.27,0.799,84.609,4.466,3.899,4.386,3.248,2.4798,0.648,2.6439,...
    1.41991,0.057664,4.466,3.899,4.386,3.248,2.4798,0.648,2.6439,1.959,...
    0.898,8.204,4.515,0.125,2.41,1.959,0.898,8.204,4.515,0.125,2.41];
%Masses must be rearranged to fit the way the DH tables are set up.
%LFootToRFoot
MassLFTRF = [M(26),M(25),M(24),M(23),M(22),M(21),M(1),M(27),M(28),M(29),M(30),M(31),M(32)]';

%PelvisLArm 
MassPLA = [M(1),M(2),M(3),M(4),M(5),M(6)+M(7)+M(8)+M(9)+M(10)+M(11)]';

%PelvisRArm 
MassPRA = [M(1),M(2),M(3),M(4),M(14),M(15)+M(16)+M(17)+M(18)+M(19)+M(20)]';

%Find CM of overall ATLAS Robot

XCM = 0;
YCM = 0;
ZCM = 0;

for i = 1:13

%X Axis

XCM = XCM + LFootRFoot(i).position(1)*MassLFTRF(i);

%Y Axis

YCM = YCM + LFootRFoot(i).position(2)*MassLFTRF(i);

%Z Axis

ZCM = ZCM + LFootRFoot(i).position(3)*MassLFTRF(i);

end

for i = 2:6

%X Axis

XCM = XCM + PelvisLArm(i).position(1)*MassPLA(i);

%Y Axis

YCM = YCM + PelvisLArm(i).position(2)*MassPLA(i);

%Z Axis

ZCM = ZCM + PelvisLArm(i).position(3)*MassPLA(i);

end

for i = 5:6

%X Axis

XCM = XCM + PelvisRArm(i).position(1)*MassPRA (i);

%Y Axis

YCM = YCM + PelvisRArm(i).position(2)*MassPRA (i);

%Z Axis

ZCM = ZCM + PelvisRArm(i).position(3)*MassPRA (i);

end

%Divide by total mass to find CM XYZ coordinates
TotalMass = sum(MassLFTRF)+ sum(MassPLA(2:6)) + sum(MassPRA(5:6));

XCM = XCM/TotalMass;
YCM = YCM/TotalMass;
ZCM = ZCM/TotalMass;

end

