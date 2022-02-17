function [image, nX, nY, nZ] = ReconstructImage(array, x,y,z) 
   

    nX = numel(unique(x)); dX = max(x)/(nX-1);
    nY = numel(unique(y)); dY = max(y)/(nY-1);
    nZ = numel(unique(z)); dZ = max(z)/(nZ-1);


    is3D = nX>1 && nY>1 && nZ>1;

    [~, indices] = sortrows([x y z]);

    image = array(indices);
    image = reshape(image, nZ, nY, nX);

    if ~is3D
        image = squeeze(image);
        [nY, nX] = size(image);
    end
end

