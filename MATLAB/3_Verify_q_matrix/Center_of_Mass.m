function [ mass_center ] = Center_of_Mass( Leg_Transforms,Rarm_Transforms,Larm_Transforms )

MASS=[9.609,2.27,0.799,84.609,4.466,3.899,4.386,3.248,2.4798,0.648,2.6439,...
    1.41991,0.057664,4.466,3.899,4.386,3.248,2.4798,0.648,2.6439,1.959,...
    0.898,8.204,4.515,0.125,2.41,1.959,0.898,8.204,4.515,0.125,2.41];

total_Mass = sum(MASS);
n = length(MASS);
Points_center_mass = zeros(n,3);

%Define the transforms to pull from the three input sets of transforms
NTrans = zeros(1,n);
NTrans(1:11) = [0,0,0,0,0,0,0,0,0,0,0];
NTrans(12:20) = [0,0,0,0,0,0,0,0,0];
NTrans(21:32) = [4,3,2,1,1,1,7,9,11,12,15,15];

%Define the transforms that will be used for each point

for i = 1:n
    if i <= 11
        Transform{i} = Larm_Transform{Ntrans(i)};
    elseif i <= 20
        Transform{i} = Rarm_Tranform{Ntrans(i)};
    elseif i >20
        Transform{i} = Leg_Transform{Ntrans(i)};
    end
end

Positions = [0,0,0; %pelvis
             0,0,0; %ltorso
             0,0,0; %mtorso
             0,0,0; %utorso
             0,0,0; %lclav 5
             0,0,0; %lscap
             0,0,0; %luarm
             0,0,0; %llarm
             0,0,0; %lufarm
             0,0,0; %llfarm 10
             0,0,0; %lhand
             0,0,0; %head
             0,0,0; %hokuyolink
             0,0,0; %rclav
             0,0,0; %rscap 15
             0,0,0; %ruarm
             0,0,0; %rlarm
             0,0,0; %rufarm
             0,0,0; %rlfarm
             0,0,0; %rhand 20
             0,0,0; %luglut
             0,0,0; %llglut
             0,0,0; %luleg
             0,0,0; %llleg
             0,0,0; %ltalus 25
             0,0,0; %lfoot
             0,0,0; %ruglut
             0,0,0; %rlglut
             0,0,0; %ruleg
             0,0,0; %rlleg 30
             0,0,0; %rtalus
             0,0,0]; %rfoot
    
    %Calculate the points of mass based on the current orientation of the
    %ATLAS Robot
    for i = 1:n
        Points_center_mass(n,3) = Transforms{n}*Positions(n,3)';
    end
    
    mass_center = zeros(1,3);
    for i = 1:n
        mass_center = Points_center_mass(n,3)*MASS(n)/total_Mass + mass_center;
    end
        
	return mass_center;
end