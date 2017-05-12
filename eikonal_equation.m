function [ u_outside ] = eikonal_equation( u, flag, i1, j1, i2, j2 )
%EIKONAL_EQUATION
    u_outside = 1e6;
    u1 = u(i1, j1);
    u2 = u(i2, j2);

    if flag(i1, j1) == 0
        if flag(i2, j2) == 0
            perpendicular = sqrt(2 - (u1 - u2)^2);
            s = (u1 + u2 - perpendicular) * 0.5;
            if (s >= u1 && s >= u2)
                u_outside = s;
            else
                s = s + perpendicular;
                if(s >= u1 && s >= u2)
                    u_outside = s;
                end
            end
        else
            u_outside = 1 + u1;
        end
    else
        if flag(i2, j2) == 0
            u_outside = 1 + u2;
        end
    end
end

