function edged_image = edge_detect(input_gray, method)
%EDGE_DETECT Calculate edge detection of the image.
%   Specify edge detection method
    switch method
        case 'Laplace'
            mask = [0 1 0; 1 -4 1; 0 1 0];
            edged_image = conv2(input_gray, mask, 'same');
            
        case 'LoG'
            % Kernel Gaussian dan Laplacian
            gaussian = fspecial('gaussian', 3, 0.5);
            laplacian = [0 1 0; 1 -4 1; 0 1 0];
            log_mask = conv2(gaussian, laplacian, 'same');
            edged_image = conv2(input_gray, log_mask, 'same');
            
        case 'Sobel'
            gx = [-1 0 1; -2 0 2; -1 0 1];
            gy = gx';
            sx = conv2(input_gray, gx, 'same');
            sy = conv2(input_gray, gy, 'same');
            edged_image = sqrt(sx.^2 + sy.^2);
            
        case 'Prewitt'
            gx = [-1 0 1; -1 0 1; -1 0 1];
            gy = gx';
            sx = conv2(input_gray, gx, 'same');
            sy = conv2(input_gray, gy, 'same');
            edged_image = sqrt(sx.^2 + sy.^2);
            
        case 'Roberts'
            gx = [1 0; 0 -1];
            gy = [0 1; -1 0];
            sx = conv2(input_gray, gx, 'same');
            sy = conv2(input_gray, gy, 'same');
            edged_image = sqrt(sx.^2 + sy.^2);
            
        case 'Canny'
            edged_image = edge(input_gray, 'canny');

        otherwise
            error('Unknown edge detection method');
    end
    edged_image = uint8(edged_image);
end
