function  psquare(x,y,c, true)
% Plots a filled unit square with the bottom left corner (x,y) and color c.

global colors



% if c == 0 
%     c = 'k';
% elseif c == 1
%     c = 'w';
% elseif c == 2
%     c = 'g';
% elseif c == 3
%     c = 'r';
% elseif c == 4
%     c = 'y';
% else
%     h=0;
% end

if x == 1 && y == 1
    colors = zeros(11,11);
end
if nargin==4
    patch([x+0.25 x+0.75 x+0.75 x+0.25], [y+0.2 y+0.2 y+0.8 y+.8], 'w','LineStyle','none');
else
    patch([x x+1 x+1 x], [y y y+1 y+1], c,'LineStyle','none');
end
if c == 'k'
    colors(x,y) = 0;
elseif c == 'w'
    colors(x,y) = 1;
elseif c == 'g'
    colors(x,y) = 2;
elseif c == 'r'
    colors(x,y) = 3;
end


