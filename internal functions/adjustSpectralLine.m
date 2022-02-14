
function res = adjustSpectralLine(image, line_x, line_y, linewidth)
% returns an image that contains only the horizontal spectral line
%takes a spectral image, rotates it to make spectral line horizontal and
%remove every pixel outside the line.
%N.B. coordinates of the line can be non-integer: interpolation is used
%anyway

%%%%%%%%     rotate the image around the center of the line    %%%%%%%%%

%First translate to center the line
xTrasl = (size(image,2) - (line_x(1) + line_x(2)));
yTrasl = (size(image,1) - (line_y(1) + line_y(2)));
res = imtranslate(image, [xTrasl yTrasl],'OutputView','full','FillValues',0);

%then rotate around the center
angle = 180/pi*atan( (line_y(2)-line_y(1))/(line_x(2)-line_x(1)) );
res = imrotate(res, angle, 'bilinear');

%then remove everything that is outside the line
linelength = sqrt( (line_y(2)-line_y(1))^2 +  (line_x(2)-line_x(1))^2 );
warning('off','all');
res = res(  round((end-linewidth)/2) : round((end+linewidth)/2) ,  round((end-linelength)/2) : round((end+linelength))/2 );
warning('on','all');

%make sure that sizes are a even number
% [rows, columns] = size(res);
% if mod(rows,2)~=0
%     res(1,:)=[];
% end
% if mod(columns,2)~=0
%     res(:,1)=[];
% end

end
