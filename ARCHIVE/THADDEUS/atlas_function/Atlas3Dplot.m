global q T1 T2 T3 lt1 lt2 lt3 totalLength
T1 = load('T1symbolic.mat');
T2 = load('T2symbolic.mat');
T3 = load('T3symbolic.mat');
lt1 = length(T1.T1);
lt2 = length(T2.T2);
lt3 = length(T3.T3);
totalLength = lt1+lt2+lt3;

minAngle = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
maxAngle = [360,360,360,360,360,360,360,360,360,360,360,360,360,360,360,360,360,360,360,360];
angleStep = [1/360,1/360];

q = zeros(1,20);
xstart = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
Atlasfig = figure(1);
%points = zeros(3,totalLength);
Atlasplot.output = plot(xstart,q);
%Atlasplot.output = scatter3(points(1,:),points(2,:),points(3,:));
%plotAtlas(Atlasplot,q)
%Atlasaxes = axes('position',[0,0,100,100]);
figureSize = [0 0 1000 500];
set(Atlasfig,'position', figureSize);
plotPos = [.1 .1 .4 .8];
set(gca,'position',plotPos);
numJoints = 20;

for i = 1:numJoints
    sliderPos = [.6*figureSize(3) i*20+.1*figureSize(4) 250 20];
    textPos = [.9*figureSize(3) i*20+.1*figureSize(4) 50 20];
    valPos = [.85*figureSize(3) i*20+.1*figureSize(4) 50 20];
    h{i} = uicontrol('style','slider','position',sliderPos,'min',minAngle(i),'max',maxAngle(i),'SliderStep',angleStep);
    t{i} = uicontrol('style','text','position',textPos);
    Atlasplot.val{i} = uicontrol('style','text','position',valPos);
    set(t{i},'string',strcat('joint q',num2str(i)));
    set(Atlasplot.val{i},'string','0');
    eventName = strcat('object_',num2str(i));
    Atlasplot.slideListener = addlistener(h{i},'ContinuousValueChange',@(eventName, event) makeplot(i,Atlasplot.val{i},plotPos,eventName, event,Atlasplot));
end

function makeplot(qValue,text,plotPos,eventName,event,Atlasplot)
global q 
newq = get(eventName,'Value');
q(qValue) = newq;
set(gca,'position',plotPos);
set(text,'string',num2str(newq));
%plotAtlas(Atlasplot,q);
set(Atlasplot.output,'ydata',q);
drawnow;