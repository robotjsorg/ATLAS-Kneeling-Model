clc; clear all; close all;
addpath(genpath('R:/MATLAB'));

global q qd;
global LFootRFoot;
run('qs.m');

TimeStep = 1;
Dynamics( TimeStep );