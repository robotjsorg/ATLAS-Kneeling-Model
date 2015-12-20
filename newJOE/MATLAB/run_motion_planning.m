clc; clear all; close all;
addpath(genpath('R:/MATLAB'));

global q;
run('q1.m');
q1 = q;


TimeStep = 1;
MotionPlanning( TimeStep );