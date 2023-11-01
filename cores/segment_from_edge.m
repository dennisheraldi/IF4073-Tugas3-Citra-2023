function segmented_image = segment_from_edge(orig_img, edged_image, thresh_method)
    % transformasi edged image ke binary
    % pilihan thresh = "Otsu" atau "Adaptif"
    im = imbinarize(edged_image, 'adaptive');
    if thresh_method == "Otsu"
        im = imbinarize(edged_image, graythresh(edged_image));
    end
    
    % membuat segmentation mask
    % menutup pixel hasil deteksi tepi
    im = imclose(im, strel("square", 3));
    im = bwmorph(im, 'bridge');
    % figure, imshow(im);

    % membersihkan pixel tepi
    im = imclearborder(im);
    % figure, imshow(im);
 
    % mengisi region hasil penutupan
    im = bwmorph(im, 'bridge');
    im = imfill(im, 'holes');
    % figure, imshow(im);

    % membuat filter bukaan
    im = imopen(im, strel(ones(3,3)));
    % figure, imshow(im);

    % menghapus bagian yang terbuka sebesar threshold
    % menentukan besar threshold sesuai dengan metode pilihan
    im = bwareaopen(im, 1500);

    % membuat mask
    segment_mask = uint8(im);
    
    segmented_image = orig_img .* segment_mask;
end
