function [ grad ] = gradient_y( image, flag, i, j )
%GRADIENT_Y
    if flag(i, j+1) ~= 2 
        if flag(i, j-1) ~= 2 
            grad = (image(i, j+1) - image(i, j-1))/2;

        else
            grad = image(i, j+1) - image(i, j);
        end
    else
        if flag(i, j-1) ~= 2 
            grad = image(i, j) - image(i, j-1);
        else
            grad = 0;
        end
    end
end

