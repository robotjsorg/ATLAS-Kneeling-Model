function[] = plotAtlas( Atlasplot, q )
global T1 T2 T3 lt1 lt2 lt3 totalLength

p = [0;0;0;1];
points = zeros(4,totalLength);
qs = {'q1','q2','q3','q4','q5','q6','q7','q8','q9','q10','q11','q12',...
      'q13','q14','q15','q16','q17','q18','q19','q20'};
for i = 1:lt1
    transform = eval(subs(T1.T1{i},qs,q));
    points(:,i) = transform*p;
end

for i = 1:lt2
    transform = eval(subs(T2.T2{i},qs,q));
    points(:,i+lt1) = transform*p;
end
    
for i = 1:lt3
    transform = eval(subs(T3.T3{i},qs,q));
    points(:,i+lt1+lt2) = transform*p;
end

points = points(1:3,:);

set(Atlasplot.output,'xdata',points(1,:))
set(Atlasplot.output,'ydata',points(2,:))
set(Atlasplot.output,'zdata',points(3,:))

end