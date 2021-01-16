function solution(x9,y9)
%SOLUTION takes in the current x (x9) and y (y9) values of a function and
%makes sure it can reach the end of the function. If it can, ifPath2 equals
%1 and the function goes on. If it can't, the move is undone in sol1.

global xr, global yr, global colors3, global ifPath2

%set color
yellow = 6;

%if it hits end
if y9 == yr && x9 == xr
    ifPath2 = 1;
    return
elseif y9 == yr && x9 == (xr+1)
    ifPath2 = 1;
    return
elseif y9 == yr && x9 == (xr-1)
    ifPath2 = 1;
    return
elseif y9 == (yr+1) && x9 == xr
    ifPath2 = 1;
    return
elseif y9 == (yr-1) && x9 == xr
    ifPath2 = 1;
    return
end

%these loop through all the different functions by calling the current
%function over and over again until all dead ends are reached
if colors3(x9+1,y9) == 1
    colors3(x9+1,y9) = yellow; %x9 = x9+1; %disp('1')
    
    solution(x9+1,y9)
end
if colors3(x9-1,y9) == 1
    colors3(x9-1,y9) = yellow; %x9 = x9-1; %disp('1')
    solution(x9-1,y9)
end
if colors3(x9,y9+1) == 1
    colors3(x9,y9+1) = yellow; %y9 = y9+1; %disp('1')
    solution(x9,y9+1)
end
if colors3(x9,y9-1) == 1
    colors3(x9,y9-1) = yellow; %y9 = y9-1; %disp('1')
    solution(x9,y9-1)
end


