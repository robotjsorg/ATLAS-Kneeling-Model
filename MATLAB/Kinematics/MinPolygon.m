function [] = MinPolygon()

%Import global data struct with joint position data    
global LFootRFoot;
global MinPolyOutline;

% r_foot - box 0.227, 0.133887, 0.05

%Joint Sizes i.e. Foot size or knee size
%FootSize = [.3048/20,.1016/20];
FootSize = [.227,.133887];
FootSizeDiff = FootSize./2;
%Determine what joints are on ground plane
%Ground plane is assumed to be z = 0 +/- .001 m

%Only check the foot and knee joints
lfoot = 1;
rfoot = 13;
lknee = 2;
rknee = 10;

jointIndexes = [lfoot, rfoot, lknee, rknee];
GroundedJoints = zeros(1,4);
ground = .005;
j = 0;
for i = 1:length(jointIndexes)
    joint = jointIndexes(i);
    cJointPos = LFootRFoot(joint).position;
    if cJointPos(1) < ground && cJointPos(1) > -ground
        GoundedJoints(i) = 1;
        botLeftJoint(j+1,:) = [cJointPos(3)-FootSizeDiff(1), cJointPos(2) - FootSizeDiff(2)];
        botRightJoint(j+1,:) = [cJointPos(3)+FootSizeDiff(1), cJointPos(2) - FootSizeDiff(2)];
        topLeftJoint(j+1,:) = [cJointPos(3)-FootSizeDiff(1), cJointPos(2) + FootSizeDiff(2)];
        topRightJoint(j+1,:) = [cJointPos(3)+FootSizeDiff(1), cJointPos(2) + FootSizeDiff(2)];
        FootOutline(j*4+1:(j+1)*4,1) = [botLeftJoint(j+1,1),botRightJoint(j+1,1),topLeftJoint(j+1,1),topRightJoint(j+1,1)]';
        FootOutline(j*4+1:(j+1)*4,2) = [botLeftJoint(j+1,2),botRightJoint(j+1,2),topLeftJoint(j+1,2),topRightJoint(j+1,2)]';
        FootOutline(j*4+1:(j+1)*4,3) = [0,0,0,0]';
        j = j+1;
    end
end

%Reorder the FootOutline to make it a smooth plot
% [xl,yl] = size(FootOutline)
% minx = min(FootOutline(:,1));
% miny = min(FootOutline(:,2));
% maxx = max(FootOutline(:,1));
% maxy = max(FootOutline(:,2));
% for i = 1:xl
%     x = FootOutline(i,1);
%     y = FootOutline(i,2);
%     if x == minx && y == miny
%         PolyFrame(1,:) = [x,y,0];
%     elseif x == minx && y == maxy
%         PolyFrame(2,:) = [x,y,0];
%     elseif x == maxx && y == maxy
%         PolyFrame(3,:) = [x,y,0];
%     elseif x == maxx && y == miny
%         PolyFrame(4,:) = [x,y,0];
%     end
% end
%         
% j = 1;
% for i = 1:13
% if LFootRFoot(i).position(1) < .001 && LFootRFoot(i).position(1) > -.001
%     GroundedJointsFoot(i) = 1;
%     GPos(:,j) = LFootRFoot(i).position(:);
%     j = j+1;
% else
%     GroundedJointsFoot(i) = 0;
% end
% end
% 
% [m,n] = size(GPos);
% 
% %Foot Print / Knee Print
% for o=1:n
% FootPrint(:,:,o) = [GPos(1,o)+FootSize(1),GPos(2,o)+FootSize(2),0;GPos(1,o)-FootSize(1),GPos(2,o)+FootSize(2),0;GPos(1,o)+FootSize(1),GPos(2,o)-FootSize(2),0;GPos(1,o)-FootSize(1),GPos(2,o)-FootSize(2),0];
% end
% 
% [r,t,p] = size(FootPrint);
% 
% % %Standing on One Foot
%  if n == 1
%  FootOutline(:,1:3) = [FootPrint(4,:,1);FootPrint(3,:,1);FootPrint(2,:,1);FootPrint(1,:,1)];
%  
% % %Standing on Two Feet
%  elseif n == 2
%  FootOutline(:,1:3) = [FootPrint(4,:,1);FootPrint(3,:,1);FootPrint(1,:,1);FootPrint(1,:,2);FootPrint(2,:,2);FootPrint(4,:,2);FootPrint(4,:,1)];
% % %Standing on Two Feet and Knee
%  elseif n == 3
%  FootOutline(:,1:3) = [FootPrint(4,:,1);FootPrint(3,:,1);FootPrint(4,:,2);FootPrint(3,:,2);FootPrint(3,:,3);FootPrint(1,:,3);FootPrint(2,:,3);FootPrint(2,:,1);FootPrint(4,:,1)];
%  else
%      FootOutline(:,1:3) = [0,0,0];
%  end


 


%Plot points that are on ground plane
% figure;
% hold on;
% for o=1:p
%     for k=1:r
%     plot3(FootPrint(k,1,o),FootPrint(k,2,o),FootPrint(k,3,o),'o');
%     end
% end
% 
% plot3(FootOutline(:,1),FootOutline(:,2),FootOutline(:,3),'-r');
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% 
MinPolyOutline.X = FootOutline(:,1);
MinPolyOutline.Y = FootOutline(:,2);
MinPolyOutline.Z = FootOutline(:,3);

end    