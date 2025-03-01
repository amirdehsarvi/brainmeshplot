clc; close all; clear;

brain_flat = imread('Screen Shot 2022-09-07 at 11.40.53.png');  % Input Image
brain_gs = rgb2gray(brain_flat);    % Grayscale Image

% Create Mesh Grid
x = 0:size(brain_gs,2)-1;
y = 0:size(brain_gs,1)-1;
[X,Y] = meshgrid(x,y);

% Filter
M = stdfilt(brain_gs);

% Create Mesh Canopy
meshCanopy(brain_gs,M)

figure;
% Create Surf
z = surf(brain_gs,'edgecolor','none');
%optional
colormap(jet)
