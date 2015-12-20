function [] = CoM()

    %Import global data struct with joint position data  
    global C;
    global q ;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;

    com_x = 0; com_y = 0; com_z = 0 ;
    
    % Link Mass
    M = [9.609, 2.27, 0.799, 84.609, 4.466, 3.899, 4.386, 3.248, 2.4798, 0.648, 2.6439,...
         1.41991, 0.057664, 4.466, 3.899, 4.386, 3.248, 2.4798, 0.648, 2.6439, 1.959,...
         0.898, 8.204, 4.515, 0.125, 2.41, 1.959, 0.898, 8.204, 4.515, 0.125, 2.41];

    % Joint Names
    Joint = {'pelvis';'ltorso';'mtorso';'utorso';'lclav';'lscap';'luarm';'llarm';'lufarm';'llfarm';'lhand';'head';'hokuyolink';'rclav';'rscap';'ruarm';'rlarm';'rufarm';'rlfarm';'rhand';'luglut';'llglut';'luleg';'llleg';'ltalus';'lfoot';'ruglut';'rlglut';'ruleg';'rlleg';'rtalus';'rfoot'};
    
    for i=1:length(LFootRFoot)
       com_x = com_x + LFootRFoot(i).ComPos(1)*LFootRFoot(i).mass ;
       com_y = com_y + LFootRFoot(i).ComPos(2)*LFootRFoot(i).mass ;
       com_z = com_z + LFootRFoot(i).ComPos(3)*LFootRFoot(i).mass ;
    end
    
    for i=1:length(PelvisTorso)
       com_x = com_x + PelvisTorso(i).ComPos(1)*PelvisTorso(i).mass ;
       com_y = com_y + PelvisTorso(i).ComPos(2)*PelvisTorso(i).mass ;
       com_z = com_z + PelvisTorso(i).ComPos(3)*PelvisTorso(i).mass ;
    end
    
    for i=1:length(TorsoRArm)
       com_x = com_x + TorsoRArm(i).ComPos(1)*TorsoRArm(i).mass ;
       com_y = com_y + TorsoRArm(i).ComPos(2)*TorsoRArm(i).mass ;
       com_z = com_z + TorsoRArm(i).ComPos(3)*TorsoRArm(i).mass ;
    end
    
    for i=1:length(TorsoLArm)
       com_x = com_x + TorsoLArm(i).ComPos(1)*TorsoLArm(i).mass ;
       com_y = com_y + TorsoLArm(i).ComPos(2)*TorsoLArm(i).mass ;
       com_z = com_z + TorsoLArm(i).ComPos(3)*TorsoLArm(i).mass ;
    end
    C = [com_x/sum(M);com_y/sum(M);com_z/sum(M)] 
    
end

