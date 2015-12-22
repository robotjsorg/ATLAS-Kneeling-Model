clc; clear all; close all;
addpath(genpath('R:/MATLAB'));

global data LFootRFoot PelvisTorso TorsoLArm TorsoRArm;
global q qd;
run('qs.m');

SymbolicKinematics();
Dynamics();