function circlesth(x,y,r,n,c)
theta = linspace(0,2*pi,n);
x1 = x + r * sin(theta);
y1 = y + r * cos(theta);
plot(x,y, 'o', 'MarkerFaceColor', 'w', 'Markersize', 6)
hold on
axis ([0 100 0 100]);
switch c
    case 'red'
        plot(x1,y1, 'r');
        h=fill(x1,y1,'r');
    case 'blue'
        plot(x1,y1, 'b');
        h=fill(x1,y1,'b');
    case 'green'
        plot(x1,y1, 'g');
        h=fill(x1,y1,'g');
    case 'black'
        plot(x1,y1,'k');
        h = fill(x1,y1,'k')
end
axis equal