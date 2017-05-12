    function [ image ] = inpaint_point( image, u, flag, indeces_i, indeces_j, i, j )
%INPAINT_POINT
    Ia = 0;
    norm = 0;
    
    Jx = 0; Jy = 0;

    grad_x = gradient_x(u, flag, i, j);
    grad_y = gradient_y(u, flag, i, j);

    for k=1:size(indeces_j, 2)
        ib = i+indeces_i(k);
        jb = j+indeces_j(k);
        
        if flag(ib, jb) == 0 % KNOWN POINT
            rx = i - ib;
            ry = j - jb;
            
            geometric_dst = 1 / ((rx^2 + ry^2) * sqrt(rx^2 + ry^2));
            levelset_dst = 1 / (1 + abs(u(ib, jb) - u(i, j)));
            direction = abs(rx * grad_x + ry * grad_y);
            weight = geometric_dst * levelset_dst * direction + 1e-6;
            Ia = Ia + weight * image(ib, jb, :);
            norm = norm + weight;
            
            gradx_img = gradient_x(image, flag, ib, jb) + 1e-6;
			grady_img = gradient_y(image, flag, ib, jb) + 1e-6;
            
            Jx = Jx - weight * gradx_img * rx;
			Jy = Jy - weight * grady_img * ry;
        end
    end
%     image(i, j, :) = Ia/norm;
    image(i, j, :) = Ia / norm + (Jx + Jy) / sqrt(double(Jx^2 + Jy^2));
end

