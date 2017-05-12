function [ x_points, y_points ] = create_neighborhood_mask( radius )
%CREATE_NEIGHBORHOOD_MASK
    x_points = [];
    y_points = [];

    for i=-radius:radius
        h = floor(sqrt(radius.^2 - i.^2));
        for j=-h:h
            x_points(end+1) = i;
            y_points(end+1) = j;
        end
    end
end

