function StepScan(mTimer,~,terminate,index, handles,pauseInterval,xcount,ycount,xstep,ystep,tolerance,path,isGray,bound)
global frame;
persistent i j count xOriginPos yOriginPos selfPause;
if terminate
    set(handles.inputCal,'String',num2str(str2double(index) + 1));
    set(handles.textIndexI,'String','0');
    set(handles.textIndexJ,'String','0'); 
    set(handles.textCount,'String','0');
    set(handles.buttonScanStart,'Enable','on');
    set(handles.buttonScanPause,'Enable','off');
    set(handles.buttonScanResume,'Enable','off');
    set(handles.buttonScanCal,'Enable','off');
    stop(mTimer);
    delete(mTimer);
    clear global scan_timer;
    clear i j count xOriginPos yOriginPos;
    fprintf('SCAN Interrupted\n');
    return
end
if isempty(count)
    count = 1;
    set(handles.textCount,'String',num2str(count));
end
if isempty(i)
    i = 1;
    set(handles.textIndexI,'String',num2str(i));
end
if isempty(j)
    j = 1;
    set(handles.textIndexJ,'String',num2str(j));
end

if isempty(selfPause)
    selfPause = 1;
else
    if pauseInterval > 1 && mod(count,pauseInterval) == 0
        stop(mTimer);
        clear selfPause;
        sound(sin(0.5*pi*25*(1:8000)/100));
        set(handles.buttonScanPause,'Enable','off');
        set(handles.buttonScanResume,'Enable','on');
        set(handles.buttonScanCal,'Enable','on');
        return
    end
end
    

filename=[path,'\',index,'_',num2str(j),'_',num2str(i),'.tif'];


[pos,~] = QueryPos;
xpos = str2double(pos(1));
ypos = str2double(pos(2));
if isempty(xOriginPos)
    xOriginPos = xpos;
end
if isempty(yOriginPos)
    yOriginPos = ypos;
end
set(handles.inputXPos, 'String', pos(1));
set(handles.inputYPos, 'String', pos(2));

if abs(xOriginPos + xstep * (i - 1) - xpos) > tolerance || abs(yOriginPos + ystep * (j - 1) - ypos) > tolerance
    stop(mTimer);
    pause(0.36);
    SetPos('xy', [xOriginPos + xstep * (i - 1), yOriginPos + ystep * (j - 1)]);
%    set(handles.buttonScanResume,'Enable','on');
%    set(handles.buttonScanPause,'Enable','off');
%    fprintf('Table movement cannot keep up, scan paused...\n');
    pause(0.36);
    start(mTimer);
    return
end

if (j > ycount)
    set(handles.inputCal,'String',num2str(str2double(index) + 1));
    set(handles.textIndexI,'String','0');
    set(handles.textIndexJ,'String','0'); 
    set(handles.textCount,'String','0');
    set(handles.buttonScanStart,'Enable','on');
    set(handles.buttonScanPause,'Enable','off');
    set(handles.buttonScanResume,'Enable','off');
    set(handles.buttonScanCal,'Enable','off');
    stop(mTimer);
    delete(mTimer);
    clear global scan_timer;
    clear i j count xOriginPos yOriginPos;
    fprintf('SCAN COMPLETE\n');
    return
end

if isGray
    frame_adj = imadjust(frame,[0 bound],[0 1]);
else
    frame_adj = frame;
end
imwrite(frame_adj,filename,'tif');


count = count + 1;
set(handles.textCount,'String',num2str(count));
if (mod(j,2) == 1)
    if (i < xcount)
        %SetPos('x', xOriginPos + xstep * i);
        MovPos('x', xstep);
        i = i + 1;
        set(handles.textIndexI,'String',num2str(i));
        return
    end
    %SetPos('y', yOriginPos + ystep * j);
    MovPos('y', ystep);
    j = j + 1;
    set(handles.textIndexJ,'String',num2str(j));
else
    if (i > 1)
        %SetPos('x', xOriginPos + xstep * (i - 2));
        MovPos('x', -xstep);
        i = i - 1;
        set(handles.textIndexI,'String',num2str(i));
        return
    end
    %SetPos('y', yOriginPos + ystep * j);
    MovPos('y', ystep);
    j = j + 1;
    set(handles.textIndexJ,'String',num2str(j));
end

return