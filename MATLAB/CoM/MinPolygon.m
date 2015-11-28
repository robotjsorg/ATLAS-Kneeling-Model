function[FootPrint, FootOutline] = MinPolygon()

%Import global data struct with joint position data    
global LFootRFoot;
global PelvisLArm;
global PelvisRArm;

%Joint Sizes i.e. Foot size or knee size
FootSize = [.3048/20,.1016/20];
KneeSize = [.3048/20,.1016/20];
    
%Determine what joints are on ground plane
%Ground plane is assumed to be z = 0 +/- .001 m

j = 1;
for i = 1:13
if LFootRFoot(i).position(3) < .001 && LFootRFoot(i).position(3) > -.001
    GroundedJointsFoot(i) = 1;
    GPos(:,j) = LFootRFoot(i).position(:);
    j = j+1;
else
    GroundedJointsFoot(i) = 0;
end
end

for i = 1:6
if PelvisLArm(i).position(3) < .001 && PelvisLArm(i).position(3) > -.001
    GroundedJointsLArm(i) = 1;
    GPos(:,j) = PelvisLArm(i).position(:);
    j = j+1;
else
    GroundedJointsLArm(i) = 0;
end
end

for i = 1:6
if PelvisRArm(i).position(3) < .001 && PelvisRArm(i).position(3) > -.001
    GroundedJointsRArm(i) = 1;
    GPos(:,j) = PelvisRArm(i).position(:);
    j = j+1;
else
    GroundedJointsRArm(i) = 0;
end
end


[m,n] = size(GPos);

%Foot Print / Knee Print
for o=1:n
FootPrint(:,:,o) = [GPos(1,o)+FootSize(1),GPos(2,o)+FootSize(2),0;GPos(1,o)-FootSize(1),GPos(2,o)+FootSize(2),0;GPos(1,o)+FootSize(1),GPos(2,o)-FootSize(2),0;GPos(1,o)-FootSize(1),GPos(2,o)-FootSize(2),0];
end
[r,t,p] = size(FootPrint)


FootOutline(:,1:3) = [FootPrint(4,:,1);FootPrint(3,:,1);FootPrint(1,:,1);FootPrint(1,:,2);FootPrint(2,:,2);FootPrint(4,:,2);FootPrint(4,:,1)];
%FootOutline = [FootPrint(:,1,1),

%Plot points that are on ground plane
figure;
hold on;
for o=1:p
    for k=1:r
    plot3(FootPrint(k,1,o),FootPrint(k,2,o),FootPrint(k,3,o),'o');
    end
end

plot3(FootOutline(:,1),FootOutline(:,2),FootOutline(:,3),'-r');

end





    
    