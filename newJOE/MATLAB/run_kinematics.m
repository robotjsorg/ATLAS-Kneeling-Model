clc; clear all; close all;
addpath(genpath('R:/MATLAB'));

global data LFootRFoot PelvisTorso TorsoLArm TorsoRArm;

global q;
global data;
run('q1.m');

Kinematics();

openvar('data');