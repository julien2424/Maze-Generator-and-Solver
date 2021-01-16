
clear; close all

% units refer to number of squares that are always white
width = 12;
height = 12;
% use as map(x,y)
map = zeros(2*width+1,2*height+1);

global colors
global colors2
global truePath
truePath = zeros(2*width+1,2*height+1);
% generate map, making which paths to travel to and start/end
% coordinates
[horz,vert, Start, End] = prims(width, height);
% just messed around until it looked good
if width<15||height<15
    figure('position', [500, 500, 100*width, 100*height-100]);
else
    figure('position', [500, 500, 70*width, 70*height-200]);
end            
xlim = [1, 2*width+1]; ylim = [1, 2*height+1];
axis off;
% go through each pixel
for ii = 1:2*width+1
    for jj = 1:2*height+1
        % made a grid of x by y white squares with 8 black squares
        % surrounding each, but packed tightly so that two adjacent
        % white squares only had 1 black square in between them
        if rem(ii,2)==0&& 0==rem(jj,2)
            psquare(ii,jj,'w');
            map(ii,jj) = 1;
        else
            psquare(ii,jj,'k');
        end
    end
end
sx = Start(1); sy = Start(2);
ex = End(1); ey = End(2);
% make all the used vertical paths white
for ii = 1:width            % verticals
    for jj = 1:height-1      
        if vert(jj,ii)
            psquare(ii*2,jj*2+1,'w');
            map(ii*2,jj*2+1) = 1;
        end
    end
end
% make all the used horizontal paths white
for ii = 1:width-1            
    for jj = 1:height
        if horz(jj,ii)
            psquare(ii*2+1,jj*2,'w');
            map(ii*2+1,jj*2) = 1;
        end
    end
end
%make starting and ending points green and red
psquare(sx*2,sy*2,'g');
map(sx*2,sy*2) = 2;
psquare(ex*2,ey*2,'r');
map(ex*2,ey*2) = 3;

initialMap = map;


% MAZE SOLVER CODE

%display the matrix for maze before it's solved
colors2 = colors;
disp('BEFORE')
disp(colors2)

%initiate global variables
global y1,global x1,global yr,global xr
global yellow,global ind

%coordinates for starting point
%GREEN IS STARTING
[x1,y1] = find(colors2 == 2);

%coordinates for end point
%BROWN IS ENDING
[xr,yr] = find(colors2 == 3);

%set color for path
yellow = 4; 

%for loop so the path doesn't go on forever if it doesnt hit goal
for ii = 1:10000
    
    %if the path lands on or right next to end point
    if y1 == yr && x1 == xr
        break
    elseif y1 == yr && x1 == (xr+1)
        break
    elseif y1 == yr && x1 == (xr-1)
        break
    elseif y1 == (yr+1) && x1 == xr
        break
    elseif y1 == (yr-1) && x1 == xr
        break
    end
    
    %distances from end square
    v1 = abs(x1 + 1 - xr) + abs(y1-yr) + .000004;
    v2 = abs(y1 + 1 - yr) + abs(x1-xr) + .000003;
    v3 = abs(x1 - 1 - xr) + abs(y1-yr) + .000002;
    v4 = abs(y1 - 1 - yr) + abs(x1-xr) + .000001;
    
    %distance array
    tA = [v1,v2,v3,v4];
    %ordered distance array, use ind for order of function in sol1
    [num,ind] = sort(tA);
    
    %call sol1 to make path 1 at a time
	sol1

end

subplot(1,2,1), axis off
title('Before: Initial Generated Map','FontSize',25);
%make axis
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
axis equal
for colorX = 1:width*2+1
    for colorY = 1:height*2+1
        if map(colorX,colorY) == 0
            psquare(colorX,colorY,'k');
        elseif map(colorX,colorY) == 1
            psquare(colorX,colorY,'w');
        elseif map(colorX,colorY) == 2
            psquare(colorX,colorY,'g');
        elseif map(colorX,colorY) == 3
            psquare(colorX,colorY,'r');
        end
    end
end
%lot solved maze

subplot(1,2,2), axis off
%make axis
title('After: Solved Map','FontSize',25);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
axis equal
for colorX = 1:width*2+1
    for colorY = 1:height*2+1
        if colors2(colorX,colorY) == 0
            psquare(colorX,colorY,'k');
        elseif colors2(colorX,colorY) == 1
            psquare(colorX,colorY,'w');
        elseif colors2(colorX,colorY) == 2
            psquare(colorX,colorY,'g');
        elseif colors2(colorX,colorY) == 3
            psquare(colorX,colorY,'r');
        elseif colors2(colorX,colorY) == 4
            psquare(colorX,colorY,'y');
        end
        if truePath(colorX,colorY)==1
            psquare(colorX,colorY,'y',true);
        end
    end
end

%display final array
disp('AFTER'),disp(colors2)





