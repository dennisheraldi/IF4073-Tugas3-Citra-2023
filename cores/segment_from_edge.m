function segmented_image = segment_from_edge(orig_img, edged_image, thresh)
    % transformasi edged image ke binary
    im = imbinarize(edged_image, graythresh(edged_image));
    % membuat segmentation mask

    % menutup pixel hasil deteksi tepi
    im = imclose(im, strel("square", 3));
    im = bwmorph(im, 'bridge');
    figure, imshow(im);

    % membersihkan pixel tepi
    im = imclearborder(im);
    figure, imshow(im);
 
    % mengisi region hasil penutupan
    im = bwmorph(im, 'bridge');
    im = imfill(im, 'holes');
    figure, imshow(im);

    % membuat filter bukaan
    im = imopen(im, strel(ones(3,3)));
    figure, imshow(im);

    % menghapus bagian yang terbuka sebesar threshold
    im = bwareaopen(im, thresh);

    % membuat mask
    segment_mask = uint8(im);
    
    segmented_image = orig_img .* segment_mask;
    % if size(orig_img,3) == 3 
    %     r = orig_img(:,:,1) .* segment_mask;
    %     g = orig_img(:,:,2) .* segment_mask;
    %     b = orig_img(:,:,3) .* segment_mask;
    %     segmented_image = cat(3,r,g,b);
    % else
    %     segmented_image(:,:) = orig_img(:,:) .* segment_mask;
    % end
end