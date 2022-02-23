function StepScan(mTimer,~,uiHandles,~,xcount,ycount,xstep,ystep,tolerance)
global frame;
persistent i j count xlastpos;
if isempty(count)
    count = 1;
    set(uiHandles.textCount,'String',num2str(count));
end
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
filename=[path,'\',index,'_',num2str(j),'_',num2str(i),'_#',num2str(count),'.tif'];


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
    set(uiHandles.textCount,'String','0');
    set(uiHandles.buttonScanStart,'Enable','on');
    set(uiHandles.buttonScanPause,'Enable','off');
    set(uiHandles.buttonScanResume,'Enable','off');
    set(uiHandles.buttonScanCal,'Enable','off');
    stop(mTimer);
    delete(mTimer);
    clear global scan_timer;
    clear i j count xlastpos;
    fprintf('SCAN COMPLETE\n')
    
    return
end

if get(uiHandles.checkboxApplyGrayscale,'Value')
    bound = str2double(get(uiHandles.inputIntensityHigherBound,'String'));
    frame_adj = imadjust(frame,[0 bound],[0 1]);
else
    frame_adj = frame;
end
imwrite(frame_adj,filename,'tif');


count = count + 1;
set(uiHandles.textCount,'String',num2str(count));
if (mod(j,2) == 1)
    if (i < xcount)
        SetPos('x',xpos + xstep);
        i = i + 1;
        set(uiHandles.textIndexI,'String',num2str(i));
        return
    end
    SetPos('y',ypos + ystep);
    j = j + 1;
    set(uiHandles.textIndexJ,'String',num2str(j));
else
    if (i > 1)
        SetPos('x',xpos - xstep);
        i = i - 1;
        set(uiHandles.textIndexI,'String',num2str(i));
        return
    end
    SetPos('y',ypos + ystep);
    j = j + 1;
    set(uiHandles.textIndexJ,'String',num2str(j));
end

return