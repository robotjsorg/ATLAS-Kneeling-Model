clc; clear all; close all;

addpath('R:/MATLAB/MotionPlanning');

global q;
global data;

run('q1.m');

TimeStep = 1;
MotionPlanning( TimeStep );