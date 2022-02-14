function [RawSpectraFilenames, x,y,z, nX,nY,nZ ] = getRawSpectraFilenames(path)
    files = dir([path 'spectrum*x*y*z*.tif']);
    

    for i=length(files):-1:1

        n = files(i).name;
        RawSpectraFilenames{i} = [path n];

        res = textscan(n, 'spectrum%dx%fy%fz%f');
        index(i)=res{1};x(i)=res{2};y(i)=res{3};z(i)=res{4};  

      
    end
    
    %make sure the files are ordered by index
    [~, order] = sort(index);
    RawSpectraFilenames = RawSpectraFilenames(order);
    x=x(order)';y=y(order)';z=z(order)';

    nX = numel(unique(x)); dX = max(x)/(nX-1);
    nY = numel(unique(y)); dY = max(y)/(nY-1);
    nZ = numel(unique(z)); dZ = max(z)/(nZ-1);
end

