function StepScan(mTimer,~,uiHandles,interval,xcount,ycount,xstep,ystep,tolerance)
global vid;
global tmp;
global tmp_1;
addpath('internal functions');
linewidth = 15;
line_x = [tmp_1(1,1) tmp_1(2,1)];
line_y = [tmp_1(1,2) tmp_1(2,2)];
persistent i j xlastpos;
if isempty(i)
    i = 1;
end
if isempty(j)
    j = 0;
end

pos = QueryPos;
xpos = str2double(pos(1));
ypos = str2double(pos(2));
if isempty(xlastpos)
    xlastpos = xpos;
end
set(uiHandles.inputXPos, 'String', pos(1));
set(uiHandles.inputYPos, 'String', pos(2));
if ((xstep - tolerance <= abs(xpos - xlastpos)) && (abs(xpos - xlastpos) <= xstep + tolerance)) || (xpos - xlastpos == 0)
    xlastpos = xpos;
else
    fprintf('Table movement cannot keep up! Try increasing the interval!\n');
    stop(mTimer);
    delete(mTimer);
    return
end

if (j < ycount)
    if (i < xcount)
        if (mod(j,2) == 0)
            SetPos('x',xpos + xstep);
        else
            SetPos('x',xpos - xstep);
        end
        % capture camera�
        preview(vid);
        frame=getsnapshot(vid);
        axes(uiHandles.axes2);
        set(uiHandles.axes2, 'Units', 'pixels', 'Position', [12, 138, 144*tmp(3)/tmp(4),144]);
        imshow(frame);
        c = adjustSpectralLine(frame, line_x, line_y, linewidth);
        spectrum = mean(c)'; 
        axes(uiHandles.axes3);
        plot(spectrum);title('Dynamic Intensity Curve');
        drawnow;
        start(vid);
        stoppreview(vid);
        filename=['F:\matlab control\fast_',num2str(j),'_',num2str(i),'.tif'];
        imwrite(getdata(vid), filename,'tif');
        stop(vid);
        i = i + 1;
        return
    end
    SetPos('y',ypos + ystep);
    % capture camera�
    preview(vid);
    frame=getsnapshot(vid);
    axes(uiHandles.axes2);
    set(uiHandles.axes2, 'Units', 'pixels', 'Position', [12, 138, 144*tmp(3)/tmp(4),144]);
    imshow(frame);
    c = adjustSpectralLine(frame, line_x, line_y, linewidth);
    spectrum = mean(c)'; 
    axes(uiHandles.axes3);
    plot(spectrum);title('Dynamic Intensity Curve');
    drawnow;
    start(vid);
    stoppreview(vid);
    filename=['F:\matlab control\fast_',num2str(j),'_',num2str(i),'.tif'];
    imwrite(getdata(vid), filename,'tif');
    stop(vid);
    j = j + 1;
    i = 1;
    return
end
stop(mTimer);
delete(mTimer);
clear i j xlastpos;
fprintf('SCAN COMPLETE\n')
stoppreview(vid);
return