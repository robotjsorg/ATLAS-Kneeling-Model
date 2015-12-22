function [] = CoM()
    global C;
    global q;
    global data;
    global LFootRFoot;
    global PelvisTorso;
    global TorsoLArm;
    global TorsoRArm;

%     M = 0;
%     for i = 1:length(data)
%         M = M + data(i).M;
%     end
%     M = 178.5280 ;
    
    com_x = 0; com_y = 0; com_z = 0 ;

    % Joint Names
    Joint = {'pelvis';'ltorso';'mtorso';'utorso';'lclav';'lscap';'luarm';'llarm';'lufarm';'llfarm';'lhand';'head';'hokuyolink';'rclav';'rscap';'ruarm';'rlarm';'rufarm';'rlfarm';'rhand';'luglut';'llglut';'luleg';'llleg';'ltalus';'lfoot';'ruglut';'rlglut';'ruleg';'rlleg';'rtalus';'rfoot'};

    for i=1:length(LFootRFoot)
       com_x = com_x + LFootRFoot(i).ComPos(1)*LFootRFoot(i).M ;
       com_y = com_y + LFootRFoot(i).ComPos(2)*LFootRFoot(i).M ;
       com_z = com_z + LFootRFoot(i).ComPos(3)*LFootRFoot(i).M ;
    end

    for i=1:length(PelvisTorso)
       com_x = com_x + PelvisTorso(i).ComPos(1)*PelvisTorso(i).M ;
       com_y = com_y + PelvisTorso(i).ComPos(2)*PelvisTorso(i).M ;
       com_z = com_z + PelvisTorso(i).ComPos(3)*PelvisTorso(i).M ;
    end

    for i=1:length(TorsoRArm)
       com_x = com_x + TorsoRArm(i).ComPos(1)*TorsoRArm(i).M ;
       com_y = com_y + TorsoRArm(i).ComPos(2)*TorsoRArm(i).M ;
       com_z = com_z + TorsoRArm(i).ComPos(3)*TorsoRArm(i).M ;
    end
    
    for i=1:length(TorsoLArm)
       com_x = com_x + TorsoLArm(i).ComPos(1)*TorsoLArm(i).M ;
       com_y = com_y + TorsoLArm(i).ComPos(2)*TorsoLArm(i).M ;
       com_z = com_z + TorsoLArm(i).ComPos(3)*TorsoLArm(i).M ;
    end
    C = [com_x/178.5280;com_y/178.5280;com_z/178.5280];
end

