function StepScan(mTimer,~,uiHandles,~,xcount,ycount,xstep,ystep,tolerance)
global vid;
persistent i j xlastpos;
if isempty(i)
    i = 1;
    set(uiHandles.textIndexI,'String',num2str(i));
end
if isempty(j)
    j = 1;
    set(uiHandles.textIndexJ,'String',num2str(j));
end

index = get(uiHandles.inputCal, 'String');

path = get(uiHandles.inputSaveLocation,'String');
filename=[path,'\',index,'_',num2str(j),'_',num2str(i),'.tif'];


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
    clear global scan_timer;
    return
end

if (j > ycount)
    set(uiHandles.inputCal,'String',num2str(str2double(index) + 1));
    set(uiHandles.textIndexI,'String','0');
    set(uiHandles.textIndexJ,'String','0');
    stop(mTimer);
    delete(mTimer);
    clear global scan_timer;
    clear i j xlastpos;
    fprintf('SCAN COMPLETE\n')
    return
end

frame=getsnapshot(vid);
% bound = str2double(get(uiHandles.inputIntensityHigherBound,'String'));
% frame = imadjust(frame,[0 bound],[0 1]);
imwrite(frame,filename,'tif');

if (mod(j,2) == 1)
    if (i < xcount)
        SetPos('x',xpos + xstep);
        i = i + 1;
        return
    end
    SetPos('y',ypos + ystep);
    j = j + 1;
else
    if (i > 1)
        SetPos('x',xpos - xstep);
        i = i - 1;
        return
    end
    SetPos('y',ypos + ystep);
    j = j + 1;
end

set(uiHandles.textIndexI,'String',num2str(i));
set(uiHandles.textIndexJ,'String',num2str(j));
return