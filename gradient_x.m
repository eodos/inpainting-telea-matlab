function [ grad ] = gradient_x( image, flag, i, j )
%GRADIENT_X
    if flag(i+1, j) ~= 2 
        if flag(i-1, j) ~= 2 
            grad = (image(i+1, j) - image(i-1, j))/2;

        else
            grad = image(i+1, j) - image(i, j);
        end
    else
        if flag(i-1, j) ~= 2 
            grad = image(i, j) - image(i-1, j);
        else
            grad = 0;
        end
    end
end

