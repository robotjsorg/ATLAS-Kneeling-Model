clc; clear all; close all;
addpath(genpath('R:/MATLAB'));

global q;
run('q1.m');

TimeStep = 1;
Dynamics( TimeStep );