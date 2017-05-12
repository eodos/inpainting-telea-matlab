function [ image ] = inpaint( image, mask, radius )
%INPAINT
    % Create patch mask
    [indeces_i, indeces_j] = create_neighborhood_mask(radius);

    % Dilate mask
    flag = zeros(size(image, 1), size(image, 2), 'uint8');
    for i=2:size(image, 1)-1
        for j=2:size(image, 2)-1
            if mask(i, j) ~= 0
                flag(i,j) = 1;
                flag(i+1,j) = 1;
                flag(i-1,j) = 1;
                flag(i,j+1) = 1;
                flag(i,j-1) = 1;
            end
        end
    end

    flag = flag .* 2 - cast(bitxor(mask, flag), 'uint8');
    u = (flag == 2) .* 1e6;

    % Values for flag:
    % 2: inside
    % 1: contour
    % 0: outside

    % HEAP 
    [points_x, points_y] = find(flag == 1);
    % h = MinHeap([]);
    % for i=1:length(points_x)
    %     h.InsertKey(points_x(i)*size(image,2)+points_y(i));
    % end

    % Algorithm
    c = 1; 
    % I use while to reevaluate the length of the array on every iteration
    while c ~= length(points_x)+1
    % while ~h.IsEmpty()
    %     point = h.ExtractMin();
    %     i = floor(point/size(image,2));
    %     j = point - i*size(image,2);

        i = points_x(c);
        j = points_y(c);

        flag(i, j) = 0; % KNOWN

        neighbors_x = [i+1, i-1, i, i];
        neighbors_y = [j, j, j+1, j-1];

        for p=1:length(neighbors_x)
           ib = neighbors_x(p);
           jb = neighbors_y(p);
           if flag(ib, jb) ~= 0 % NOT KNOWN
               u(ib, jb) = min([eikonal_equation(u, flag, ib, jb-1, ib-1, jb), ...
                                eikonal_equation(u, flag, ib, jb+1, ib-1, jb), ...
                                eikonal_equation(u, flag, ib, jb-1, ib+1, jb), ...
                                eikonal_equation(u, flag, ib, jb+1, ib+1, jb)]);
               if flag(ib, jb) == 2 % UNKNOWN
                   flag(ib, jb) = 1; % BAND
                   % Add points to heap
                   points_x(end+1) = ib;
                   points_y(end+1) = jb;
    %                h.InsertKey(ib*size(image,2)+jb);
                   image = inpaint_point(image, u, flag, indeces_i, indeces_j, ib, jb);
               end
           end
        end
        c = c + 1;
    end
end

