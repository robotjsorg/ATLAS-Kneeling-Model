%% 3D Model Demo
% This is short demo that loads and renders a 3D model of a human femur. It
% showcases some of MATLAB's advanced graphics features, including lighting and
% specular reflectance.

% Copyright 2011 The MathWorks, Inc.


%% Load STL mesh
% Stereolithography (STL) files are a common format for storing mesh data. STL
% meshes are simply a collection of triangular faces. This type of model is very
% suitable for use with MATLAB's PATCH graphics object.

% Import an STL mesh, returning a PATCH-compatible face-vertex structure
fv = stlread('head.stl');
fv1 = stlread('l_clav.stl');
fv1.faces=fv1.faces+3633;
fv1.vertices=fv1.vertices+1000;
%% Making new arrays for x y z
tryface=[fv.faces;fv1.faces];
tryver=[fv.vertices;fv1.vertices];
% for i=1:1211
%     newx=fv.faces
%% Render
% The model is rendered with a PATCH graphics object. We also add some dynamic
% lighting, and adjust the material properties to change the specular
% highlighting.
% hold on
% 'Faces',tryface,'Vertices',tryver,
patch(fv,'y');
   
% 'FaceColor'      [ 1 1 1], ...
%          'EdgeColor',       [0 0 0] ,        ...
%          'FaceLighting',    'gouraud',     ...
%          'AmbientStrength', 0.15

% hold off     
%      Create two polygons by specifying x and y as two-column matrices.
%      Each column defines the coordinates for one of the polygons.

% % Add a camera light, and tone down the specular highlighting
camlight('headlight');
material('dull');
% 
% % Fix the axes scaling, and set a nice view angle
axis('image');
view([-135 35]);