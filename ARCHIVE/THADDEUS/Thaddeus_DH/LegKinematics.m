%Leg Kinematics
clear all
close all
clc

thetaRightLeg = [0,0,0,0,0,0,0];
thetaLeftLeg = [0,0,0,0,0,0,0];

[Tl, pL] = KinLeftLeg(thetaLeftLeg);
[Tr, pR] = KinRightLeg(thetaRightLeg);

xL = pL(1,:);  yL = pL(2,:);  zL = pL(3,:);
xR = pR(1,:);  yR = pR(2,:);  zR = pR(3,:);

last = 7;
figure()
scatter3(0,0,0,'ko')
hold on
scatter3(xL(1:last),yL(1:last),zL(1:last),'bo')
scatter3(xR(1:last),yR(1:last),zR(1:last),'ro')
plot3([0,xL(1:last)],[0,yL(1:last)],[0,zL(1:last)],'b-')
plot3([0,xR(1:last)],[0,yR(1:last)],[0,zR(1:last)],'r-')
xlabel('X axis'); ylabel('Y axis'); zlabel('Z axis');
legend('Pelvis','Left Leg','Right Leg')

