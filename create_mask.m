function [ mask ] = create_mask( height, width, type )
%CREATE_MASK
mask = zeros(height, width, 'uint8');
switch type
    case 'vertical'
        n_lines = 5;
        line_width = 3;
        spacing = floor(width/n_lines);
        for i=15:height-15
            for l=1:n_lines
                for j=(l-1)*spacing+floor(spacing/2):(l-1)*spacing+floor(spacing/2)+line_width
                    mask(i, j) = 1;
                end
            end
        end
end


end

