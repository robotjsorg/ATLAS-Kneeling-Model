function [ TransLL, jointPoint, Pelvis2lToe ] = KinLeftLeg( jointAngles )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    q = [0.089,0.0867870958,0.3773436762,0.422];
    
    DHpars = [0,jointAngles(1),q(1),0;
          0,jointAngles(2),0,-90;
          0,jointAngles(3)-90,-q(2),-90;
          0,jointAngles(4),-q(3),0;
          0,jointAngles(5),-q(4),0;
          0,jointAngles(6),0,90;
          0,jointAngles(7),0,0];
      
            %altered points
            Pelvis2lToe = [0                   0                   0;
                   0.089000000000000   0                     0;
                   0.089000000000000   0                     0;
                   0.089000000000000  0   -0.0867870958;
                   0.089000000000000  0  -0.0867870958-0.3773436762;
                   0.089000000000000  0  -0.0867870958-0.3773436762-0.422;
                   0.089000000000000  0  -0.0867870958-0.3773436762-0.422;
                   0.089000000000000  0  -0.0867870958-0.3773436762-0.422]; %extra point for the toe
%       Pelvis2lToe = [0                   0                   0;
%                    0   0.089000000000000                   0;
%                    0   0.089000000000000                   0;
%    0.050000000000000   0.111500000000000  -0.066000000000000;
%                    0   0.111500000000000  -0.440000000000000;
%                    0   0.111500000000000  -0.862000000000000;
%                    0   0.111500000000000  -0.862000000000000;
%                    0  -0.111500000000000  -0.862000000000000]; %extra point for the toe
      
%Define a constant identity matrix needed for the for loop
Tbase_to_frame_prev = [1,0,0,0;0,1,0,0;0,0,1,0;0,0,0,1];
%For loop to construct each transformation matrix from sequential frames,
%as well as the overall transform from base to tip
for i = 1:7
    Trans{i} = DHparams(DHpars(i,:));           %Generate transform from DHparams
    Tbase_to_frame{i} = Tbase_to_frame_prev*Trans{i};  %base to current frame transform
    Tbase_to_frame_prev = Tbase_to_frame{i};
    jointPoint(:,i) = Tbase_to_frame{i}*[0;0;0;1];
end

TransLL = Tbase_to_frame{7};


end

