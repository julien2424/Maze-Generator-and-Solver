function sol1
%SOL1 uses the colors2 matrix from the maze genrated in generateMap and
%tries to make a path using the shortest distance

global y1,global x1,global ind
global fun1,global fun2,global fun3,global fun4


%make shortest path 'is1' and so on
fun1 = strcat('is',num2str(ind(1)));
fun2 = strcat('is',num2str(ind(2)));
fun3 = strcat('is',num2str(ind(3)));
fun4 = strcat('is',num2str(ind(4)));

%get original values before any functions called
orx = x1;ory = y1;

%evaluate shortest one
eval(fun1)

%if it doesn't work, eval second
if x1 == orx && y1 == ory
    eval(fun2)
elseif x1 ~= orx || y1 ~= ory
    return
end

%if it doesn't work, eval third
if x1 == orx && y1 == ory
    eval(fun3)
elseif x1 ~= orx || y1 ~= ory
    return
end

%if it doesn't work, eval fourth
if x1 == orx && y1 == ory
    eval(fun4)
elseif x1 ~= orx || y1 ~= ory
    return
end

%shortest path
function is1
global colors2,global x1,global y1,global yellow,global colors3,global ifPath2
global truePath
%if the spot is white
if colors2(x1+1,y1) == 1
    
    %move to white spot and make it yellow
    colors2(x1+1,y1) = yellow; x1 = x1+1; %disp('1')
    colors3 = colors2;
    truePath(x1,y1) = 1;
    %call solution to make sure it reaches end
    solution(x1,y1);
    
    %if it doesn't reach end undo so it can eval next function
    if ifPath2 ~= 1
        truePath(x1,y1) = 0;
        x1 = x1-1;
        return
    end
    
    %reset ifPath2
    ifPath2 = 0;
end

%second shortest path
function is2
global colors2,global x1,global y1,global yellow,global colors3,global ifPath2
global truePath
%if the spot is white
if colors2(x1,y1+1) == 1
    
    %move to white spot and make it yellow
    colors2(x1,y1+1) = yellow; y1 = y1+1; %disp('2')
    colors3 = colors2;
    truePath(x1,y1) = 1;
    %call solution to make sure it reaches end
    solution(x1,y1);
    
    %if it doesn't reach end undo so it can eval next function
    if ifPath2 ~= 1
        truePath(x1,y1) = 0;
        y1 = y1-1;
        return
    end
    
    %reset ifPath2
    ifPath2 = 0;
end

%third shortest path
function is3
global colors2,global x1,global y1,global yellow,global colors3,global ifPath2
global truePath
%if the spot is white
if colors2(x1-1,y1) == 1
    
    %move to white spot and make it yellow
    colors2(x1-1,y1) = yellow; x1 = x1-1; %disp('2')
    colors3 = colors2;
    truePath(x1,y1) = 1;
    %call solution to make sure it reaches end
    solution(x1,y1);
    
    %if it doesn't reach end undo so it can eval next function
    if ifPath2 ~= 1
        truePath(x1,y1) = 0;
        x1 = x1+1;
        return
    end
    
    %reset ifPath2
    ifPath2 = 0;
end

%fourth shortest path
function is4
global colors2,global x1,global y1,global yellow,global colors3,global ifPath2
global truePath
%if the spot is white
if colors2(x1,y1-1) == 1
    
    %move to white spot and make it yellow
    colors2(x1,y1-1) = yellow; y1 = y1-1; %disp('1')
    colors3 = colors2;
    truePath(x1,y1) = 1;
    %call solution to make sure it reaches end
    solution(x1,y1);
    
    %if it doesn't reach end undo so it can eval next function
    if ifPath2 ~= 1
        truePath(x1,y1) = 0;
        y1 = y1+1;
        return
    end
    
    %reset ifPath2
    ifPath2 = 0;
end
