function[FootPrint, FootOutline] = MinPolygon()

%Import global data struct with joint position data    
global LFootRFoot;
%global PelvisLArm;
%global PelvisRArm;

%Joint Sizes i.e. Foot size or knee size
FootSize = [.3048/20,.1016/20];
    
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

[m,n] = size(GPos);

%Foot Print / Knee Print
for o=1:n
FootPrint(:,:,o) = [GPos(1,o)+FootSize(1),GPos(2,o)+FootSize(2),0;GPos(1,o)-FootSize(1),GPos(2,o)+FootSize(2),0;GPos(1,o)+FootSize(1),GPos(2,o)-FootSize(2),0;GPos(1,o)-FootSize(1),GPos(2,o)-FootSize(2),0];
end

[r,t,p] = size(FootPrint)

% %Standing on One Foot
 if n == 1
 FootOutline(:,1:3) = [FootPrint(4,:,1);FootPrint(3,:,1);FootPrint(2,:,1);FootPrint(1,:,1)];
 end
% 
% %Standing on Two Feet
 if n == 2
 FootOutline(:,1:3) = [FootPrint(4,:,1);FootPrint(3,:,1);FootPrint(1,:,1);FootPrint(1,:,2);FootPrint(2,:,2);FootPrint(4,:,2);FootPrint(4,:,1)];
 end
% 
% %Standing on Two Feet and Knee
 if n == 3
 FootOutline(:,1:3) = [FootPrint(4,:,1);FootPrint(3,:,1);FootPrint(4,:,2);FootPrint(3,:,2);FootPrint(3,:,3);FootPrint(1,:,3);FootPrint(2,:,3);FootPrint(2,:,1);FootPrint(4,:,1)];
 end


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
xlabel('X');
ylabel('Y');
zlabel('Z');

end





    
    