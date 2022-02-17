clear all;
clc;
showPlots = false;
path = uigetdir;
path = [path '\'];
addpath('internal functions1');
ft = fittype( 'b+A1/(1+(2*(x-x1)/w1)^2)+A2/(1+(2*(x-x2)/w2)^2)+A3/(1+(2*(x-x3)/w3)^2)+A4/(1+(2*(x-x4)/w4)^2)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
close
[spectrum_area, line_x, line_y, translationY, translationX] = BrillouinShiftCorrection(path, 20);

FSR_VIPA=30; %Free Spectral range of VIPA according to manufacturer
Brillouin_water=7.46; %GHz (reported Brillouin shift for water)
    
    i=1;
    while true
        try   
            tmp = double(imread([path 'Image0_' int2str(i) '.tif']));
            tmp = tmp(spectrum_area{1}(2):spectrum_area{2}(2),spectrum_area{1}(1):spectrum_area{2}(1));
            subplot(1,2,1)
            imagesc(tmp);
            line(line_x+translationX(i), line_y+translationY(i),'Color','red','LineWidth',3)
            tmp = adjustSpectralLine(tmp, line_x+translationX(i), line_y+translationY(i), 5);
            spectrum = mean(tmp)';            
            plot(spectrum);
%             b=mean(spectrum((end/2-8):(end/2+8)));
%             [p,l] = findpeaks(spectrum,'SortStr','descend');
%             pl = [l(1:4),p(1:4)];
%             pl_ad = sortrows(pl,1);
%             A1=pl_ad(1,2);
%             A2=pl_ad(2,2);
%             A3=pl_ad(3,2);
%             A4=pl_ad(4,2);
%             x1=pl_ad(1,1);
%             x2=pl_ad(2,1);
%             x3=pl_ad(3,1);
%             x4=pl_ad(4,1);
%             w=1;
%             opts.StartPoint = [A1 A2 A3 A4 b w w w w x1 x2 x3 x4];
%             opts.Robust = 'Bisquare';
%             opts.Lower = [0 0 0 0 0.7*b 0 0 0 0 0 0 (length(spectrum)/2) (length(spectrum)/2)];
%             opts.Upper = [1.3*A1 1.3*A2 1.3*A3 1.3*A4 1.5*b 1.5*(w+A1) 1.5*(w+A2) 1.5*(w+A3) 1.5*(w+A4) (length(spectrum)/2) (length(spectrum)/2) length(spectrum) length(spectrum)];  
%             x = 1:length(spectrum);
%             [res, tmp] = fit(x', spectrum, ft, opts);
            if (i==1)
                plot(spectrum);
                
                title('Select peak1, peak2, peak3, peak4 and background');
                [x,y]=ginput(5);
                if y(5)<0
                    b=0;
                else
                    b=y(5);
                end
                A1=y(1)-b;
                x1=x(1);
                A2=y(2)-b;
                x2=x(2);
                A3=y(3)-b;
                x3=x(3);
                A4=y(4)-b;
                x4=x(4);
                w=1;

                opts.Lower = 0.5* [A1 A2 A3 A4 b 0 0 0 0 x1 x2 x3 x4];
                opts.Robust = 'Bisquare';
                opts.StartPoint = [A1 A2 A3 A4 b w w w w x1 x2 x3 x4];
                opts.Upper = 1.5* [A1 A2 A3 A4 b w+A1 w+A2 w+A3 w+A4 x1 x2 x3 x4];     
            end
            
            x = 1:length(spectrum);
            [res, tmp] = fit(x', spectrum, ft, opts);
            subplot(1,2,2);
            plot(res, x', spectrum);
            pause(0.0001);   
            Brillouin_shift(i) = abs(res.x3-res.x2);
            Brillouin_width(i) = abs(res.w3-res.w2);
            i = i+1;            
        catch
            %no more files to read
            break;
        end
    end
   %%
    figure;
    pixel = 1:length(Brillouin_shift);
    subplot(1,2,1);
    plot(pixel,Brillouin_shift);
    subplot(1,2,2);
    ha = hampel(Brillouin_shift);
    plot(pixel,ha);