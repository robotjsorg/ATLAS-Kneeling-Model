function [roll,pitch,yaw] = rpy_angles(T)

    roll = atan(T(2,1),T(1,1));
    pitch = atan(-T(3,1),norm([T(3,2) T(3,3)]));
    yaw = atan(T(3,2),T(3,3));

end