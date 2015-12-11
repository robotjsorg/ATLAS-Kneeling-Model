clc; clear all; close all;

global q;
run('q1.m');

Kinematics();

tri = struct;

nm = {'pelvis';'ltorso';'mtorso';'utorso';'lclav';'lscap';'luarm';'llarm';'luarm';'llarm';'lhand';'head';'rclav';'rscap';'ruarm';'rlarm';'ruarm';'rlarm';'rhand';'luglut';'llglut';'luleg';'llleg';'ltalus';'lfoot';'ruglut';'rlglut';'ruleg';'rlleg';'rtalus';'rfoot'};

for i = 1:length(nm)
    fv = stlread( strcat( nm{i}, '.stl' ) );
    verts = fv.vertices;
    if mod(i,3) == 0
        tri(i/3).x1 = verts(i,1);
        tri(i/3).y1 = verts(i,2);
        tri(i/3).z1 = verts(i,3);
        tri(i/3).x2 = verts(1+i,1);
        tri(i/3).y2 = verts(1+i,2);
        tri(i/3).z2 = verts(1+i,3);
        tri(i/3).x3 = verts(3+i,1);
        tri(i/3).y3 = verts(3+i,2);
        tri(i/3).z3 = verts(3+i,3);
    end

    currentVolume = 0;
    totalVolume = currentVolume;
    xCenter = 0; yCenter = 0; zCenter = 0;

    for j = 0:length(tri)
        currentVolume = (tri(j).x1*tri(j).y2*tri(j).z3 - tri(j).x1*tri(j).y3*tri(j).z2 - tri(j).x2*tri(j).y1*tri(j).z3 + tri(j).x2*tri(j).y3*tri(j).z1 + tri(j).x3*tri(j).y1*tri(j).z2 - tri(j).x3*tri(j).y2*tri(j).z1) / 6;
        xCenter = ((tri(j).x1 + tri(j).x2 + tri(j).x3) / 4) * currentVolume;
        yCenter = ((tri(j).y1 + tri(j).y2 + tri(j).y3) / 4) * currentVolume;
        zCenter = ((tri(j).z1 + tri(j).z2 + tri(j).z3) / 4) * currentVolume;
        totalVolume = totalVolume + currentVolume;
    end

end
