function [ spectrum_area, line_x, line_y, translationY, translationX, nReferences] = BrillouinShiftCorrection(path_references, linewidth)
%BrillouinShiftCorrection 
%   INPUTS:
%       path_references the path containg the reference images e.g. 'C:\Users\bcarl\Desktop\mouse2\images\'
%       linewidth should be big enough to include 2 lines of noise that
%           will be averaged for determining a threshold
%   OUTPUTS:
%       spectrum area is the rectangle containing the spectrum
%       line_x and line_y are vectors of 2 elements containing the coordinates
%           of endpoints of spectral line
%       translation is a vector indicating how many pixels the spectral line
%           should be moved (in x and y coordinates or the orginal frame) to have to best
%           signal
    if ~exist('linewidth','var')
        linewidth = 20; %pixels
    end

    %Draw the rectangular spectral area for the first reference image
    im1 = double(imread([path_references 'Image8_1.tif']));  
    imagesc(im1);
    title('Select the rectangular area where the spectrum is. (Double-click on rectangle when done)');
    tmp = imrect();
    setColor(tmp,'red');
    tmp = round(wait(tmp));
    spectrum_area = {[tmp(1) tmp(2)] [tmp(1)+tmp(3) tmp(2)+tmp(4)]};%[x1 y1] [x2 y2]
    im1 = im1(spectrum_area{1}(2):spectrum_area{2}(2),spectrum_area{1}(1):spectrum_area{2}(1));

    %Draw the spectral line for the first reference image
     imagesc(im1);
    title('Draw the spectral line. (Double-click on the line when done)');
    tmp = imline();
    setColor(tmp,'red');
    tmp = wait(tmp);
    line_x = [tmp(1,1) tmp(2,1)];
    line_y = [tmp(1,2) tmp(2,2)];

    im1 = adjustSpectralLine(im1, line_x, line_y, linewidth);
    
    %the angle that the spectral line forms with the horizontal
    angle = atan( (line_y(2)-line_y(1))/(line_x(2)-line_x(1)) );

    %thresholding
    noise = double([im1(1,:) im1(end,:)]);
    threshold = mean(noise)+2*std(noise);
    im1 = im1-threshold;
    im1 (im1<0) = 0;

%     fftsize = 256;
%     tmp  = sinc(  ((1:fftsize)-fftsize/2) *pi/fftsize );
%     sinc_window = repmat(tmp, fftsize, 1).*repmat(tmp', 1, fftsize);
% 
%     im1 = padarray(double(im1), (fftsize-size(im1))/2, 1);
%     im1_fft = fft2(im1.*sinc_window);
    
    translationY(1)=0;
    translationX(1)=0;
    i=1;
    while true
        try
            im = double(imread([path_references 'Image8_' int2str(i+1) '.tif']));         
            im = im(spectrum_area{1}(2):spectrum_area{2}(2),spectrum_area{1}(1):spectrum_area{2}(1));

            im = adjustSpectralLine(im, line_x, line_y, linewidth);

            %thresholding
            im = im-threshold;
            im (im<0) = 0;
            
            [corr, transCorr] = subPixelCorrelationY(im1, im, 3, 1);
            [~, tmp] = max(corr);
            tY = transCorr(tmp);     
            
            [corr, transCorr] = subPixelCorrelationX(im1, im, 15, 1);
            [~, tmp] = max(corr);
            tX = transCorr(tmp);  
            
            translationX(i+1) = -tX*cos(angle)+tY*sin(angle);
            translationY(i+1) = -tX*sin(angle)-tY*cos(angle);
            
            imagesc(im);
            title(['dX=' int2str(translationX(i+1)) 'dY=' int2str(translationY(i+1))]);
            pause(0.01);
            
                     
%             im = padarray(double(im), (fftsize-size(im))/2, 1);
%             im_fft_conj = conj(fft2(im.*sinc_window));
%             R = (im1_fft.*im_fft_conj)/abs(im1_fft.*im_fft_conj);


            i = i+1;

        catch
            break
        end
    end
    nReferences = i;
end


function [corr, translation] = subPixelCorrelationY(im1, im2, range, step)
%return a cross correlation between im2 and im1 along the y direction in
%the pixel range [-range +range] and with the specified step. Return a
%vector that has the zero delay at the center
%For subpixel traslation it uses imtranslate %NB subpixel translation seems
%not to give any improvement... maybe it is better if one uses bicubic
%interpolation?
    
    r= round(range/step);
    translation = step*(-r:r);
    corr = zeros(1,length(translation));
    for i = 1:length(translation)
        corr(i) = sum(sum(im1.*imtranslate(im2, [0 translation(i)])));
    end

end

function [corr, translation] = subPixelCorrelationX(im1, im2, range, step)
%as subPixelCorrelationY
    
    r= round(range/step);
    translation = step*(-r:r);
    corr = zeros(1,length(translation));
    for i = 1:length(translation)
        corr(i) = sum(sum(im1.*imtranslate(im2, [translation(i) 0])));
    end

end