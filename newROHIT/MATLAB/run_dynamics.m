clc; clear all; close all;

addpath('R:/MATLAB/Dynamics');

global q;
global data;

run('q1.m');

TimeStep = 1;
Dynamics( TimeStep );