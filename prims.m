function [horz,vert, Start, End] = prims(x,y)
%Uses x width and y height to generate starting and ending coordinates,
%while also saving 2D arrays of horizontal paths and vertical paths that
%are used. Uses Prim's algorithm to start with a grid, then adds paths to
%the tree.
A = zeros(x,y);
rng('shuffle');
% assign the paths random weights
ver = rand(y-1,x);
hor = rand(y,x-1);
% these keep track of whether each path is used or not.
vert = zeros(y-1,x);
horz = zeros(y,x-1);
% starting and ending coordinates
sx =  floor(rand(1)*x)+1; sy = floor(rand(1)*y)+1;
ex =  floor(rand(1)*x)+1; ey = floor(rand(1)*y)+1;
while ex==sx&&ey==sy %makes sure that the maze doesn't start and end at the same place
    ex =  floor(rand(1)*x)+1; ey = floor(rand(1)*y)+1;
end
% output starting and ending coordinates
Start = [sx,sy]; 
End = [ex,ey];
% cx and cy are current x and current y
cx = sx; cy = sy;
%A checks if the point has already been visited
A(sx, sy) = 1;
% total of all the points travelled to
total = 1; 
% queue up all the paths that can be traveled to
%1: x, 2: y, 3: weight, 4: horizontal if -1, vertical if +1, 5: path x
%index, 6: path y index
q = nan(6,100000); qIn = 1; 
%     fprintf('\n\ncx: ');fprintf(num2str(cx));
%     fprintf('\ncy: ');fprintf(num2str(cy));

% stop when we've reached a total of all the points in the grid
while total<x*y
    % we just got to a new point
    % add all the new paths we now have access to into the queue
    if cx>1 &&  ~A(cx-1,cy)
        q(3,qIn) = hor(cy,cx-1); q(4,qIn) = -1;
        q(5,qIn) = cx-1; q(6,qIn) = cy;
        q(1,qIn) = cx-1; q(2,qIn) = cy; qIn = qIn+1;
    end
    if cx <x && ~A(cx+1,cy)
        q(3,qIn) = hor(cy,cx);q(4,qIn) = -1;
        q(5,qIn) = cx; q(6,qIn) = cy;
        q(1,qIn) = cx+1; q(2,qIn) = cy;qIn = qIn+1;
    end
    if cy>1 && ~A(cx,cy-1)
        q(3,qIn) = ver(cy-1,cx);q(4,qIn) = 1;
        q(5,qIn) = cx; q(6,qIn) = cy-1;
        q(1,qIn) = cx; q(2,qIn) = cy-1;qIn = qIn+1;
    end
    if cy <y && ~A(cx,cy+1)
        q(3,qIn) = ver(cy,cx);q(4,qIn) = 1;
        q(5,qIn) = cx; q(6,qIn) = cy;
        q(1,qIn) = cx; q(2,qIn) = cy+1;qIn = qIn+1;
    end
    
    % find smallest in queue to point untravelled
    min = 100000000000; % big min so its almost always replaced
    iimin = -1; % index of min, gives error if none is found
                % (there should always be a min before the while loop
                % terminates
    for ii = 1 : qIn
        % if weight is less than min AND the point hasn't been travelled
        % to
        if q(3,ii) < min && ~A(q(1,ii),q(2,ii))
            min = q(3,ii);
            iimin = ii;
        end
    end
    % bunch of debugging prints
%         fprintf('\niimin: '); fprintf(num2str(iimin));
%         fprintf('\n Total: '); fprintf(num2str(total));
%         fprintf('\n qIn: ');fprintf(num2str(qIn));
% 
%         fprintf('\n tx: ');fprintf(num2str(q(1,iimin)));
%         fprintf('\n ty: ');fprintf(num2str(q(2,iimin)));

    % USE that path with minimum weight to a point not travelled to
    if q(4,iimin)<0 % if horizontal path, set = 1 to mark that its used
        horz(q(6,iimin),q(5,iimin)) = 1;
    else % if vertical path, set to 1 to mark its been used
        vert(q(6,iimin),q(5,iimin)) = 1;
    end
    
    % tx and ty are coordinates of the new point travelled to
    tx = q(1,iimin); ty = q(2,iimin);
    
    % say that point has been travelled to
    A(tx, ty) = 1;
    % update current x and y
    cx = tx; cy = ty;
    % added 1 to the total of points travelled to
    total = total+1;
%         fprintf('\n\ncx: ');fprintf(num2str(cx));
%         fprintf('\ncy: ');fprintf(num2str(cy));

end

% more debugging stuff

% fprintf('\n\n');
% for ii = 1: y
%     for jj = 1:x-1
%         fprintf(num2str(horz(ii,jj)));      
%     end
%     fprintf('\n'); 
% end
% fprintf('\n'); 
% for ii = 1: y-1
%     for jj = 1:x
%         fprintf(num2str(vert(ii,jj)));
%         fprintf('\n'); 
%         
%     end
% end


end
